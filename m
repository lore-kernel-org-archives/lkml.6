Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EE1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73D42229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/EIJY9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407299AbfBNOtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:49:42 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45370 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407266AbfBNOth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:37 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so7052039qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=60g7G9GsgPysXeQeRaphSyl4TAccnCLeHznr84gZrn0=;
        b=V/EIJY9BGKspAndcNIdR3th42CLoUkdNivW75Klm61UNfZ5bUDb+8pQ9YgZ+aV9xaW
         quJp2RA+dWlDK3eGad2f+vpkapMMnVGuqwuBFVIeY57WfSscvObAdyBO/a6LuYnJCadR
         SgaQcUcVZQ9VbZVyPs8vu7TS/YXhoblTOO9nySwB//QuURMG2g6D+Xt/OnAAbNXrpCg/
         ajqXQGM6wLjN5oPZjbGUWzhvuBMl7RKG5nWYW7Xk6NHxSgcMLNBmzTLRXB5T1IQp4JSc
         2mgz3bRQMV60JYS8WdZTOmCJSwl2uxAbvYrhcmPI0rZ2LPEtN2DHL0L+SNIlWzfHL+Ru
         gRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=60g7G9GsgPysXeQeRaphSyl4TAccnCLeHznr84gZrn0=;
        b=b2mskKJMf5SEvWn8fLmmOzdCQXHZqwgOok75uXJjGIK7E0acOS8bZdaPEnVGPAKTzz
         n9eSGlHca94i+njgpWDGmc2j5cSFvfR1+90VS6aDO6nOIfXaLa/sJ9szlsff0xI0TZYA
         yrvPEsundv+rCDtbsQ+KH74KDvA7XCdOP+w6IXHnwMNB2l+lYgZFFkrLxYrTaGzyoFwL
         mDgHxl1tDTwIbomnMKg4lyNN3TURdfjBWMrAdezrWbEz2nfDgQXPdrUy66PcFsCt+iSM
         8UyNyTD1iSPbJZdbcwXmeHseCCnTpnbSn5BO2cjbrmZLzwh93HKb4Pkkh3WRXZ/m03+y
         x1BA==
X-Gm-Message-State: AHQUAuZ2STcTPg0p1jzwV0eyIYQirgj+bKdgCmQAKYGe4X8lgljpgWXj
        OqwLRBkU6jccLa4v1YQ1s5knKg==
X-Google-Smtp-Source: AHgI3IbUU3fl8LTHjYQsqZGkkIyqoaHWVIlo+/lOgXaFrHX57zihf8dkPnwR1cEkqHGfrtbL0hyKSA==
X-Received: by 2002:a0c:b2d9:: with SMTP id d25mr3234605qvf.79.1550155775806;
        Thu, 14 Feb 2019 06:49:35 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:35 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.9 02/16] ARM: 8791/1: vfp: use __copy_to_user() when saving VFP state
Date:   Thu, 14 Feb 2019 09:49:16 -0500
Message-Id: <20190214144930.27539-3-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit 3aa2df6ec2ca6bc143a65351cca4266d03a8bc41 upstream.

Use __copy_to_user() rather than __put_user_error() for individual
members when saving VFP state.
This has the benefit of disabling/enabling PAN once per copied struct
intead of once per write.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/thread_info.h |  4 ++--
 arch/arm/kernel/signal.c           | 13 +++++++------
 arch/arm/vfp/vfpmodule.c           | 20 ++++++++------------
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 57d2ad9c75ca..df8420672c7e 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -124,8 +124,8 @@ extern void vfp_flush_hwstate(struct thread_info *);
 struct user_vfp;
 struct user_vfp_exc;
 
-extern int vfp_preserve_user_clear_hwstate(struct user_vfp __user *,
-					   struct user_vfp_exc __user *);
+extern int vfp_preserve_user_clear_hwstate(struct user_vfp *,
+					   struct user_vfp_exc *);
 extern int vfp_restore_user_hwstate(struct user_vfp *,
 				    struct user_vfp_exc *);
 #endif
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index fbb325ff8acc..135b1a8e12eb 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -94,17 +94,18 @@ static int restore_iwmmxt_context(struct iwmmxt_sigframe *frame)
 
 static int preserve_vfp_context(struct vfp_sigframe __user *frame)
 {
-	const unsigned long magic = VFP_MAGIC;
-	const unsigned long size = VFP_STORAGE_SIZE;
+	struct vfp_sigframe kframe;
 	int err = 0;
 
-	__put_user_error(magic, &frame->magic, err);
-	__put_user_error(size, &frame->size, err);
+	memset(&kframe, 0, sizeof(kframe));
+	kframe.magic = VFP_MAGIC;
+	kframe.size = VFP_STORAGE_SIZE;
 
+	err = vfp_preserve_user_clear_hwstate(&kframe.ufp, &kframe.ufp_exc);
 	if (err)
-		return -EFAULT;
+		return err;
 
-	return vfp_preserve_user_clear_hwstate(&frame->ufp, &frame->ufp_exc);
+	return __copy_to_user(frame, &kframe, sizeof(kframe));
 }
 
 static int restore_vfp_context(struct vfp_sigframe __user *auxp)
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 8e5e97989fda..df3fa52c0aa3 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -554,12 +554,11 @@ void vfp_flush_hwstate(struct thread_info *thread)
  * Save the current VFP state into the provided structures and prepare
  * for entry into a new function (signal handler).
  */
-int vfp_preserve_user_clear_hwstate(struct user_vfp __user *ufp,
-				    struct user_vfp_exc __user *ufp_exc)
+int vfp_preserve_user_clear_hwstate(struct user_vfp *ufp,
+				    struct user_vfp_exc *ufp_exc)
 {
 	struct thread_info *thread = current_thread_info();
 	struct vfp_hard_struct *hwstate = &thread->vfpstate.hard;
-	int err = 0;
 
 	/* Ensure that the saved hwstate is up-to-date. */
 	vfp_sync_hwstate(thread);
@@ -568,22 +567,19 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp __user *ufp,
 	 * Copy the floating point registers. There can be unused
 	 * registers see asm/hwcap.h for details.
 	 */
-	err |= __copy_to_user(&ufp->fpregs, &hwstate->fpregs,
-			      sizeof(hwstate->fpregs));
+	memcpy(&ufp->fpregs, &hwstate->fpregs, sizeof(hwstate->fpregs));
+
 	/*
 	 * Copy the status and control register.
 	 */
-	__put_user_error(hwstate->fpscr, &ufp->fpscr, err);
+	ufp->fpscr = hwstate->fpscr;
 
 	/*
 	 * Copy the exception registers.
 	 */
-	__put_user_error(hwstate->fpexc, &ufp_exc->fpexc, err);
-	__put_user_error(hwstate->fpinst, &ufp_exc->fpinst, err);
-	__put_user_error(hwstate->fpinst2, &ufp_exc->fpinst2, err);
-
-	if (err)
-		return -EFAULT;
+	ufp_exc->fpexc = hwstate->fpexc;
+	ufp_exc->fpinst = hwstate->fpinst;
+	ufp_exc->fpinst2 = ufp_exc->fpinst2;
 
 	/* Ensure that VFP is disabled. */
 	vfp_flush_hwstate(thread);
-- 
2.17.1

