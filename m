Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930BDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585C221019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nTpPEZwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfAVOL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:11:26 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:6832 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfAVOL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:11:26 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43kVhX00P7z9txr6;
        Tue, 22 Jan 2019 15:11:24 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=nTpPEZwT; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zhtzneba4Vpq; Tue, 22 Jan 2019 15:11:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43kVhW63V1z9txqy;
        Tue, 22 Jan 2019 15:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548166283; bh=6110LLEqf4G05msAr+SZpF4QsEdZoJ4DswJy9q14JXg=;
        h=From:Subject:To:Cc:Date:From;
        b=nTpPEZwTQpS1UJNahNvwo4XqhpqqluyKVSAT1RscUVh9NqjsCjcRevTTF8ULQv0By
         LsCbsxFKFLf4wOZsBBM0JIEZjwSagCLAZqY9EKE8lDe5m9T4Rx7cbfGSZGKFcVEsZt
         Oeck1cPXBh/blHGMELa1azdBSE1pyzbaqmE0WOdk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D44E8B7E9;
        Tue, 22 Jan 2019 15:11:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id K3CCEtzvmRl8; Tue, 22 Jan 2019 15:11:25 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 144B18B7E7;
        Tue, 22 Jan 2019 15:11:25 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9641971893; Tue, 22 Jan 2019 14:11:24 +0000 (UTC)
Message-Id: <1c804764d38fb084b420b12ca13e8c1b2dea075e.1548166189.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/traps: fix recoverability of machine check handling
 on book3s/32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 22 Jan 2019 14:11:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like book3s/32 doesn't set RI on machine check, so
checking RI before calling die() will always be fatal
allthought this is not an issue in most cases.

Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
Fixes: daf00ae71dad ("powerpc/traps: restore recoverability of machine_check interrupts")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/traps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 64936b60d521..c740f8bfccc9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -763,15 +763,15 @@ void machine_check_exception(struct pt_regs *regs)
 	if (check_io_access(regs))
 		goto bail;
 
-	/* Must die if the interrupt is not recoverable */
-	if (!(regs->msr & MSR_RI))
-		nmi_panic(regs, "Unrecoverable Machine check");
-
 	if (!nested)
 		nmi_exit();
 
 	die("Machine check", regs, SIGBUS);
 
+	/* Must die if the interrupt is not recoverable */
+	if (!(regs->msr & MSR_RI))
+		nmi_panic(regs, "Unrecoverable Machine check");
+
 	return;
 
 bail:
-- 
2.13.3

