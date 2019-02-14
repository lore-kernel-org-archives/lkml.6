Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DCEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C86222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O23hPUmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439354AbfBNOtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:49:52 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46738 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407270AbfBNOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:39 -0500
Received: by mail-qk1-f195.google.com with SMTP id i5so3677410qkd.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=njKhqNVW1q77dfnJouybYtAijgeLOYBipkp1AnzUgE8=;
        b=O23hPUmTPYxoo3uILFDTZz7epP3dts+rXc5g2YO4Xz/tEc2cf8SlFWmqgKsqzOpkCd
         8RBuDUOwA0twNEt3dO2wtdVMNPPit1eRPwVmmhQ0oAWqxlyYpbAFbl3Ilovh8O52ZTKK
         zI2yh91q+EKI5ApQZUUoOzkXeZxnOeKCa+1fOVzL2oSEfnXaFBZndxC0O5/s5QgINz9E
         Q6yMXfMljTgsLB7Ko0g9vF8A+r9iPjYtzQT+32+Ps6qictWs8/LFiUbXBj21nk8q4hsQ
         799ypVQ442qrgjiQFtSdCTUQ6ST4jpdR9zjctiKdZck3dOjGA2kgaPK0WF2JeoxY3eVY
         4BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=njKhqNVW1q77dfnJouybYtAijgeLOYBipkp1AnzUgE8=;
        b=OJg+jHlMgo6eX1oLTUqCeq61Pjav05MhJk6HIVCBpAUyNBdX1Htx2QH6M9dsOX8iLY
         ImfNTxGUTTd4CIDfZy+6zSQHWwDEnp1Y4vplHcMcoPymulFtUhkAMdGGd13ABDNnYtOS
         eYVYLgcO2QK7ZEoazBkHw/53KL9VkPFpAvdcGFNaZN9UoTdYUdRl4laY4mgMwo4gvBVu
         gwe0ygbc/fJndAXXlXRth0v6HTo6Fg5kA+T136vLb8RNDeSGPc1Fto+Ok3L9j11MiqbP
         B4KfMpil0fcZgMGD0Y5zopvOE6r0hXyAofUem+FWUwiU/G9N4j+yVYPR+by6moTaao/Z
         N6jA==
X-Gm-Message-State: AHQUAuZlmXCO6Cg2CL0BPaJKvyQfQjVH8gk7WlZuEBs0yvA8MJjZ7rMT
        pm/RDvUV+TYve2kcaJTwYjrZLA==
X-Google-Smtp-Source: AHgI3IZeLOitEMQ7JlaeqazgDG5amrIQ9TI436hGm3PGw0z+wD5nC1StYU/ccIhO7n9txbFYE3MmDQ==
X-Received: by 2002:a37:8443:: with SMTP id g64mr3129866qkd.334.1550155778416;
        Thu, 14 Feb 2019 06:49:38 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:37 -0800 (PST)
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
Subject: [PATCH 4.9 04/16] ARM: 8793/1: signal: replace __put_user_error with __put_user
Date:   Thu, 14 Feb 2019 09:49:18 -0500
Message-Id: <20190214144930.27539-5-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit 18ea66bd6e7a95bdc598223d72757190916af28b upstream.

With Spectre-v1.1 mitigations, __put_user_error is pointless. In an attempt
to remove it, replace its references in frame setups with __put_user.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/kernel/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 135b1a8e12eb..0a066f03b5ec 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -302,7 +302,7 @@ setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set)
 	if (err == 0)
 		err |= preserve_vfp_context(&aux->vfp);
 #endif
-	__put_user_error(0, &aux->end_magic, err);
+	err |= __put_user(0, &aux->end_magic);
 
 	return err;
 }
@@ -434,7 +434,7 @@ setup_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 	/*
 	 * Set uc.uc_flags to a value which sc.trap_no would never have.
 	 */
-	__put_user_error(0x5ac3c35a, &frame->uc.uc_flags, err);
+	err = __put_user(0x5ac3c35a, &frame->uc.uc_flags);
 
 	err |= setup_sigframe(frame, regs, set);
 	if (err == 0)
@@ -454,8 +454,8 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
-	__put_user_error(0, &frame->sig.uc.uc_flags, err);
-	__put_user_error(NULL, &frame->sig.uc.uc_link, err);
+	err |= __put_user(0, &frame->sig.uc.uc_flags);
+	err |= __put_user(NULL, &frame->sig.uc.uc_link);
 
 	err |= __save_altstack(&frame->sig.uc.uc_stack, regs->ARM_sp);
 	err |= setup_sigframe(&frame->sig, regs, set);
-- 
2.17.1

