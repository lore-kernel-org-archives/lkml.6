Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEF2C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFC120895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFC120895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJMQws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:52:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12748 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbeJMQws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:52:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42XJwd4y0Gz9ttFt;
        Sat, 13 Oct 2018 11:16:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xl_QyuytFTXF; Sat, 13 Oct 2018 11:16:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42XJwd4P8Qz9ttFr;
        Sat, 13 Oct 2018 11:16:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E454B8B782;
        Sat, 13 Oct 2018 11:16:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id E8m8eOxeGacV; Sat, 13 Oct 2018 11:16:22 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A195C8B74B;
        Sat, 13 Oct 2018 11:16:22 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 605656F2BD; Sat, 13 Oct 2018 09:16:22 +0000 (UTC)
Message-Id: <f79824d5da910441ede885fa32a25083c4cc9359.1539422122.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/traps: restore recoverability of machine_check
 interrupts
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 13 Oct 2018 09:16:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b96672dd840f ("powerpc: Machine check interrupt is a non-
maskable interrupt") added a call to nmi_enter() at the beginning of
machine check restart exception handler. Due to that, in_interrupt()
always returns true regardless of the state before entering the
exception, and die() panics even when the system was not already in
interrupt.

This patch calls nmi_exit() before calling die() in order to restore
the interrupt state we had before calling nmi_enter()

Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/traps.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index fd58749b4d6b..4f880c2a6e4c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -765,12 +765,17 @@ void machine_check_exception(struct pt_regs *regs)
 	if (check_io_access(regs))
 		goto bail;
 
-	die("Machine check", regs, SIGBUS);
-
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
 		nmi_panic(regs, "Unrecoverable Machine check");
 
+	if (!nested)
+		nmi_exit();
+
+	die("Machine check", regs, SIGBUS);
+
+	return;
+
 bail:
 	if (!nested)
 		nmi_exit();
-- 
2.13.3

