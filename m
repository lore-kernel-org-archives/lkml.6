Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5ACC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A1D20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A1D20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966675AbeFRI2h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:28:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966650AbeFRI22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:28:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 102B5D6C;
        Mon, 18 Jun 2018 08:28:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 279/279] ARM: fix kill( ,SIGFPE) breakage
Date:   Mon, 18 Jun 2018 10:14:24 +0200
Message-Id: <20180618080620.210669072@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 92d44a42af81e850a038c38278ff4f434b2871df ]

Commit 7771c6645700 ("signal/arm: Document conflicts with SI_USER and
SIGFPE") broke the siginfo structure for userspace triggered signals,
causing the strace testsuite to regress.  Fix this by eliminating
the FPE_FIXME definition (which is at the root of the breakage) and
use FPE_FLTINV instead for the case where the hardware appears to be
reporting nonsense.

Fixes: 7771c6645700 ("signal/arm: Document conflicts with SI_USER and SIGFPE")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/uapi/asm/siginfo.h |   13 -------------
 arch/arm/vfp/vfpmodule.c            |    2 +-
 2 files changed, 1 insertion(+), 14 deletions(-)
 delete mode 100644 arch/arm/include/uapi/asm/siginfo.h

--- a/arch/arm/include/uapi/asm/siginfo.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __ASM_SIGINFO_H
-#define __ASM_SIGINFO_H
-
-#include <asm-generic/siginfo.h>
-
-/*
- * SIGFPE si_codes
- */
-#ifdef __KERNEL__
-#define FPE_FIXME	0	/* Broken dup of SI_USER */
-#endif /* __KERNEL__ */
-
-#endif
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -257,7 +257,7 @@ static void vfp_raise_exceptions(u32 exc
 
 	if (exceptions == VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		vfp_raise_sigfpe(FPE_FIXME, regs);
+		vfp_raise_sigfpe(FPE_FLTINV, regs);
 		return;
 	}
 


