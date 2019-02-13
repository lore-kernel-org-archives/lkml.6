Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3DDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6C3206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bylE+VkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394821AbfBMVcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:32:33 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44587 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394795AbfBMVc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so4421107qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ADQDpeTXG9pWgt+iamM9Cmi26SsIAtmUaJH5Crr7iPE=;
        b=bylE+VkMOO4hIOd9uSGuNlN74QoZvhmAPx+T+ZSqCbcgSeR4MuoSRbK0/mCLeCS1kC
         8mBPhJddgiezzdnOFI1e0Hk2+g5X81whlLrl7u7bZSWxwGo/whqv40ykWCcXJyUo7HCq
         mJh+iU1KqgisH3Dh11uPsvJMsa5gEiCKNdyarE8ZSnEx+52DgKGvs9j0s2R90GXA3AFP
         VpaHYxiWpyMx9Y7bqnXA4GMTj+TXYO0rnF4ciqihML+wuPychBQ4XtgJfELKNaUQuS3i
         Vvv8nVhxWR0kNHavHg6IduZHrDAOW35HJryjTKT/35eF/xTBXm8JW8ncpZB2tW16QG0H
         uI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ADQDpeTXG9pWgt+iamM9Cmi26SsIAtmUaJH5Crr7iPE=;
        b=caEeRA/uFlcsjNHXLPqBpQ+5bjVHG/+yqTNXeM0tC9bKErhWNpkherq0uGNc8ThPnh
         EAfeFcTw/WPGYOf3+p95eoUDdwu3aHqYb8aLPglOWvWvHlDot64ZIBpDeeNtUStUTHSA
         2fcI4+tjWZ+XArxqbQmKHUJEl9S0xlA9YZC2++vECnsMqZN0v6HTB7Ksl/gaYyBsm9qv
         4WV2bbRbwyTQ4F085AsTmT9RgZ+8J9dZdk5SPtF4lMBHMdjkKRL2iI6Z9f1SzjeYEgWS
         urslDLDCW/tJaluUpPmBCy/ERknuiKcA5nmQfxB28ojT74LdpptU9wzI9m+q6cRjbMJj
         F1Dg==
X-Gm-Message-State: AHQUAuZJkai/wnlXFWelYYFqQkclPBGtMG8m2JmyrE7HmVidHfOLbNNr
        HVoZqrjaE/GY4NpKbK/maswKTw==
X-Google-Smtp-Source: AHgI3IYz8IBn4iko9QcIs9dbw8dxMfkpbzMPcZt31mXi5B2aXwILnN3550Qp33798L+kSKYcDKMOjw==
X-Received: by 2002:ac8:2b51:: with SMTP id 17mr229831qtv.328.1550093547353;
        Wed, 13 Feb 2019 13:32:27 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:26 -0800 (PST)
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
Subject: [PATCH 4.19 01/17] ARM: 8789/1: signal: copy registers using __copy_to_user()
Date:   Wed, 13 Feb 2019 16:32:07 -0500
Message-Id: <20190213213223.916-2-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit 5ca451cf6ed04443774bbb7ee45332dafa42e99f upstream.

When saving the ARM integer registers, use __copy_to_user() to
copy them into user signal frame, rather than __put_user_error().
This has the benefit of disabling/enabling PAN once for the whole copy
intead of once per write.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/kernel/signal.c | 49 ++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index b8f766cf3a90..76fe75d36312 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -288,30 +288,35 @@ static int
 setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set)
 {
 	struct aux_sigframe __user *aux;
+	struct sigcontext context;
 	int err = 0;
 
-	__put_user_error(regs->ARM_r0, &sf->uc.uc_mcontext.arm_r0, err);
-	__put_user_error(regs->ARM_r1, &sf->uc.uc_mcontext.arm_r1, err);
-	__put_user_error(regs->ARM_r2, &sf->uc.uc_mcontext.arm_r2, err);
-	__put_user_error(regs->ARM_r3, &sf->uc.uc_mcontext.arm_r3, err);
-	__put_user_error(regs->ARM_r4, &sf->uc.uc_mcontext.arm_r4, err);
-	__put_user_error(regs->ARM_r5, &sf->uc.uc_mcontext.arm_r5, err);
-	__put_user_error(regs->ARM_r6, &sf->uc.uc_mcontext.arm_r6, err);
-	__put_user_error(regs->ARM_r7, &sf->uc.uc_mcontext.arm_r7, err);
-	__put_user_error(regs->ARM_r8, &sf->uc.uc_mcontext.arm_r8, err);
-	__put_user_error(regs->ARM_r9, &sf->uc.uc_mcontext.arm_r9, err);
-	__put_user_error(regs->ARM_r10, &sf->uc.uc_mcontext.arm_r10, err);
-	__put_user_error(regs->ARM_fp, &sf->uc.uc_mcontext.arm_fp, err);
-	__put_user_error(regs->ARM_ip, &sf->uc.uc_mcontext.arm_ip, err);
-	__put_user_error(regs->ARM_sp, &sf->uc.uc_mcontext.arm_sp, err);
-	__put_user_error(regs->ARM_lr, &sf->uc.uc_mcontext.arm_lr, err);
-	__put_user_error(regs->ARM_pc, &sf->uc.uc_mcontext.arm_pc, err);
-	__put_user_error(regs->ARM_cpsr, &sf->uc.uc_mcontext.arm_cpsr, err);
-
-	__put_user_error(current->thread.trap_no, &sf->uc.uc_mcontext.trap_no, err);
-	__put_user_error(current->thread.error_code, &sf->uc.uc_mcontext.error_code, err);
-	__put_user_error(current->thread.address, &sf->uc.uc_mcontext.fault_address, err);
-	__put_user_error(set->sig[0], &sf->uc.uc_mcontext.oldmask, err);
+	context = (struct sigcontext) {
+		.arm_r0        = regs->ARM_r0,
+		.arm_r1        = regs->ARM_r1,
+		.arm_r2        = regs->ARM_r2,
+		.arm_r3        = regs->ARM_r3,
+		.arm_r4        = regs->ARM_r4,
+		.arm_r5        = regs->ARM_r5,
+		.arm_r6        = regs->ARM_r6,
+		.arm_r7        = regs->ARM_r7,
+		.arm_r8        = regs->ARM_r8,
+		.arm_r9        = regs->ARM_r9,
+		.arm_r10       = regs->ARM_r10,
+		.arm_fp        = regs->ARM_fp,
+		.arm_ip        = regs->ARM_ip,
+		.arm_sp        = regs->ARM_sp,
+		.arm_lr        = regs->ARM_lr,
+		.arm_pc        = regs->ARM_pc,
+		.arm_cpsr      = regs->ARM_cpsr,
+
+		.trap_no       = current->thread.trap_no,
+		.error_code    = current->thread.error_code,
+		.fault_address = current->thread.address,
+		.oldmask       = set->sig[0],
+	};
+
+	err |= __copy_to_user(&sf->uc.uc_mcontext, &context, sizeof(context));
 
 	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
 
-- 
2.17.1

