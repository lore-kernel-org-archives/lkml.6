Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF093C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E41A21902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRtf+fna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393994AbfBNCKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:38 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45949 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfBNCKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:30 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so5140335qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2KcANZZu3B+b5HtApH0abXmIyTLE/qQis8j8nSO9A+k=;
        b=YRtf+fnalzvYzEFEGgnWPy00GIpL/bexiZ1RxPdCli1K4lq/hmRrRKkB/JpxTgl0Qt
         d0fPkLe4R5CbjnFVdt2yunkAymTbtKdaDsgIUo2TJvR+YGLgPR5dgZaZzBckYUryeWgr
         MO7JUgxfzxDtMYCT6aRA4OidQMRdsC71oyvW7CL38JZDgC8fdWTNdM6PRW9YYg6gTIF7
         efeYLICL6sc9ZMr0qvfAc/bnCkfqrjAgLvsa0snW/Bs2uwUwdbK7nDb/4TB4Heedu9x6
         2jDIPD8N/wkZyxP8/ddhHZgut917OgixKkyUsa5BMs3zqC5hnABSVvA9gQ3WtwHBX+Iq
         YUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2KcANZZu3B+b5HtApH0abXmIyTLE/qQis8j8nSO9A+k=;
        b=eOUlKLnVEH+fqfhoRaoUtEeQuYJIHsSe2K2R2+wYjtkW0UQx7L7o6fi3sblZpIJxWY
         wD+JwRlRu7eRTQG8Y/43brvmH89rvQnzeGMJfl4rM73zl8Qx1BmaG5qouO7C0xcBfrL3
         FOMQEOknfZcqrWLNQqHeJ4CiG/hnNZUgNi27y82BhiHGhtFu8NzXOCzXkHSVVf4c9VP3
         MvyCaXdwe9whXVS0d6isgtCwH7AiCrR7h+UycX/0Nu27zw5R+m/eMJrQ0FersL9pOUTr
         wXsXo86/Ixb/W2b+sxUmZD9r/z55/J9nmIo4x5D+jU71BhXGG/NbwiGSet4QrI3t+Vsf
         AxLg==
X-Gm-Message-State: AHQUAuZm9ipzPlr/nUxlZiRf5zn3uC7cp8XcuvC7mg1BjtWKy2ifp/bB
        mLFJR13znYBxml9yAqlLCyhHlg==
X-Google-Smtp-Source: AHgI3IbLjBtRwJjiW7vuPmPsBHq125WQ7V4HpYt9WNmX4X5Hqd7ZI8UpNuukPUDlOV8ULYYwaSnqxg==
X-Received: by 2002:ac8:3501:: with SMTP id y1mr1017461qtb.209.1550110229015;
        Wed, 13 Feb 2019 18:10:29 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:28 -0800 (PST)
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
Subject: [PATCH 4.14 V2 03/17] ARM: 8791/1: vfp: use __copy_to_user() when saving VFP state
Date:   Wed, 13 Feb 2019 21:10:08 -0500
Message-Id: <20190214021022.5313-4-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
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
index b12499cc3582..1eb83ee7e1cc 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -136,17 +136,18 @@ static int restore_iwmmxt_context(char __user **auxp)
 
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
 
 static int restore_vfp_context(char __user **auxp)
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 6abcd4af8274..6bacd69c9e81 100644
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

