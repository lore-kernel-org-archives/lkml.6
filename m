Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D9ECDE47
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0F220862
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOfyKhby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0F220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbeKDXH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730564AbeKDXH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ECAF20870;
        Sun,  4 Nov 2018 13:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339572;
        bh=p4OmevdiQqEbL/2wWemV6iFyL8/u5E5TpXjPNB6XXPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOfyKhbykgV0+l1QIm4Bu4qwz6gJiPaR+o706OPJmFB18HuEKks8UBMZZHDYBXQ3E
         QxqCKI/uu5fJuwi6BlH+52tV5t1XafJ8fOG3pCmWck03F8cI1izg+1Q09M8aU5REaC
         INBK9Lg/YpeZTOqWzvpFKMs82XTEm5oBIV6fYL0k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 08/45] powerpc/traps: restore recoverability of machine_check interrupts
Date:   Sun,  4 Nov 2018 08:52:03 -0500
Message-Id: <20181104135240.88431-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135240.88431-1-sashal@kernel.org>
References: <20181104135240.88431-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit daf00ae71dad8aa05965713c62558aeebf2df48e ]

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
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/traps.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0e17dcb48720..6bfcb5a506af 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -736,12 +736,17 @@ void machine_check_exception(struct pt_regs *regs)
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
2.17.1

