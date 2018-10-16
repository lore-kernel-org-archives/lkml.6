Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC78C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313C12089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="plSPXPan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313C12089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbeJQBNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJQBNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:13:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD8532089E;
        Tue, 16 Oct 2018 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710516;
        bh=qvN4lXxpB43Pj+NJ47bACUWs4lQY5tqLWRrfDDIP2Q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plSPXPano7Sc8FJG2MVGKCZ8jvo9eYZEAWvjZQYRQSL3NAG4XHWFrvrFovrDCm0Pf
         S5EWy64reV95hkeTN5EXmNNrl3IZu5H10VgGmCjHm5mgakzljHoHt3bRJjpn9Qg04n
         1DLOYpXKHnraefRzx/I9hxdMdA8TICcwK/6fY+yg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>
Subject: [PATCH 4.14 104/109] ARM: vfp: use __copy_from_user() when restoring VFP state
Date:   Tue, 16 Oct 2018 19:06:12 +0200
Message-Id: <20181016170530.643315120@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 42019fc50dfadb219f9e6ddf4c354f3837057d80 upstream.

__get_user_error() is used as a fast accessor to make copying structure
members in the signal handling path as efficient as possible.  However,
with software PAN and the recent Spectre variant 1, the efficiency is
reduced as these are no longer fast accessors.

In the case of software PAN, it has to switch the domain register around
each access, and with Spectre variant 1, it would have to repeat the
access_ok() check for each access.

Use __copy_from_user() rather than __get_user_err() for individual
members when restoring VFP state.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/thread_info.h |    4 ++--
 arch/arm/kernel/signal.c           |   20 ++++++++------------
 arch/arm/vfp/vfpmodule.c           |   17 +++++++----------
 3 files changed, 17 insertions(+), 24 deletions(-)

--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -126,8 +126,8 @@ struct user_vfp_exc;
 
 extern int vfp_preserve_user_clear_hwstate(struct user_vfp __user *,
 					   struct user_vfp_exc __user *);
-extern int vfp_restore_user_hwstate(struct user_vfp __user *,
-				    struct user_vfp_exc __user *);
+extern int vfp_restore_user_hwstate(struct user_vfp *,
+				    struct user_vfp_exc *);
 #endif
 
 /*
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -149,22 +149,18 @@ static int preserve_vfp_context(struct v
 
 static int restore_vfp_context(char __user **auxp)
 {
-	struct vfp_sigframe __user *frame =
-		(struct vfp_sigframe __user *)*auxp;
-	unsigned long magic;
-	unsigned long size;
-	int err = 0;
-
-	__get_user_error(magic, &frame->magic, err);
-	__get_user_error(size, &frame->size, err);
+	struct vfp_sigframe frame;
+	int err;
 
+	err = __copy_from_user(&frame, *auxp, sizeof(frame));
 	if (err)
-		return -EFAULT;
-	if (magic != VFP_MAGIC || size != VFP_STORAGE_SIZE)
+		return err;
+
+	if (frame.magic != VFP_MAGIC || frame.size != VFP_STORAGE_SIZE)
 		return -EINVAL;
 
-	*auxp += size;
-	return vfp_restore_user_hwstate(&frame->ufp, &frame->ufp_exc);
+	*auxp += sizeof(frame);
+	return vfp_restore_user_hwstate(&frame.ufp, &frame.ufp_exc);
 }
 
 #endif
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -597,13 +597,11 @@ int vfp_preserve_user_clear_hwstate(stru
 }
 
 /* Sanitise and restore the current VFP state from the provided structures. */
-int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
-			     struct user_vfp_exc __user *ufp_exc)
+int vfp_restore_user_hwstate(struct user_vfp *ufp, struct user_vfp_exc *ufp_exc)
 {
 	struct thread_info *thread = current_thread_info();
 	struct vfp_hard_struct *hwstate = &thread->vfpstate.hard;
 	unsigned long fpexc;
-	int err = 0;
 
 	/* Disable VFP to avoid corrupting the new thread state. */
 	vfp_flush_hwstate(thread);
@@ -612,17 +610,16 @@ int vfp_restore_user_hwstate(struct user
 	 * Copy the floating point registers. There can be unused
 	 * registers see asm/hwcap.h for details.
 	 */
-	err |= __copy_from_user(&hwstate->fpregs, &ufp->fpregs,
-				sizeof(hwstate->fpregs));
+	memcpy(&hwstate->fpregs, &ufp->fpregs, sizeof(hwstate->fpregs));
 	/*
 	 * Copy the status and control register.
 	 */
-	__get_user_error(hwstate->fpscr, &ufp->fpscr, err);
+	hwstate->fpscr = ufp->fpscr;
 
 	/*
 	 * Sanitise and restore the exception registers.
 	 */
-	__get_user_error(fpexc, &ufp_exc->fpexc, err);
+	fpexc = ufp_exc->fpexc;
 
 	/* Ensure the VFP is enabled. */
 	fpexc |= FPEXC_EN;
@@ -631,10 +628,10 @@ int vfp_restore_user_hwstate(struct user
 	fpexc &= ~(FPEXC_EX | FPEXC_FP2V);
 	hwstate->fpexc = fpexc;
 
-	__get_user_error(hwstate->fpinst, &ufp_exc->fpinst, err);
-	__get_user_error(hwstate->fpinst2, &ufp_exc->fpinst2, err);
+	hwstate->fpinst = ufp_exc->fpinst;
+	hwstate->fpinst2 = ufp_exc->fpinst2;
 
-	return err ? -EFAULT : 0;
+	return 0;
 }
 
 /*


