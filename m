Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0706121902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSJWiF25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394057AbfBNCL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:11:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40335 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393882AbfBNCKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so2708895qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xIzVBfVsJyFafmUW72TZLqDDrY1szfaf1MexYWgTKBk=;
        b=bSJWiF25S/UclV7gkfOpR2SXzbsw/A4AR4+zqb6qpO1veqy64HDC/XScLrdw2icpDo
         8MeRynHIaSNrIqFB0vfA6ZGHYZNkbKWzCbhK9J6kq6BZ8+glVioFlrXk2DDOFNNacJQm
         K2go/hcpMhSEu9jvcd6bGuaBqIYV8qC28c8ZuJUdy0TnBq08qIO8x4EWMT+3xP57x3oN
         egAFkNBRPOprcjoZo+wOGoqVT9JJ7kQUpHquKsi1QRij0QRawyMbLRLzNCAyrOkzF5iI
         W5GYCuAYRxuPYgAyg9OBraDCEXAkMPV3Ya1oVVwTU+g1WovCI5VzvAHvoqz5pZXHWMw+
         6BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xIzVBfVsJyFafmUW72TZLqDDrY1szfaf1MexYWgTKBk=;
        b=kjPHfl8IAhqCak1woiF3AqFdT8/Syd2bM0r4EXkEqF73wNGZcvOhTbcfefQLMdR8Aw
         Rga25JY1wCn8z+DVlEm4Rt3hakPQi/6tLJ9gSGCWO6vgDNmB8ssuCj9wp/RrPwOQjKsx
         oWUNBsXZiYcWRfy3YxERzL+ipzSyXsCpeexuRtru3P39xgvaHVoqgo/dk3ZNmNRgDwbT
         hnl01GpDiSZcLN04uwtUX6Pll05rHEX6TWVMGnYRfxtYX2pHMMRZzxQtjbjYEpd+wiYY
         YV0Uj7pXVsg25tc5IgsAyUfv6U6CnZGHaFKuTt0PDUZ+sYy5x666VqEx6FGpGmpuf+xC
         33/g==
X-Gm-Message-State: AHQUAub9oE7H9Bcp1QngXDuBxa6lg5bqGPcsTGBbvwnCt5TrXludsWDe
        Ip0sonGwtsvaCegU0b+abvnmtA==
X-Google-Smtp-Source: AHgI3IYfUk2A8qd0ubf+k0DgmFRWZzwMACnQjGBVT7rPfaVEaK5tRcEzUmZly/sGJCvQiVwaInr56A==
X-Received: by 2002:a37:3641:: with SMTP id d62mr982296qka.14.1550110231737;
        Wed, 13 Feb 2019 18:10:31 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:31 -0800 (PST)
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
Subject: [PATCH 4.14 V2 05/17] ARM: 8793/1: signal: replace __put_user_error with __put_user
Date:   Wed, 13 Feb 2019 21:10:10 -0500
Message-Id: <20190214021022.5313-6-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
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
index 1eb83ee7e1cc..02e6b6dfffa7 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -344,7 +344,7 @@ setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set)
 	if (err == 0)
 		err |= preserve_vfp_context(&aux->vfp);
 #endif
-	__put_user_error(0, &aux->end_magic, err);
+	err |= __put_user(0, &aux->end_magic);
 
 	return err;
 }
@@ -476,7 +476,7 @@ setup_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 	/*
 	 * Set uc.uc_flags to a value which sc.trap_no would never have.
 	 */
-	__put_user_error(0x5ac3c35a, &frame->uc.uc_flags, err);
+	err = __put_user(0x5ac3c35a, &frame->uc.uc_flags);
 
 	err |= setup_sigframe(frame, regs, set);
 	if (err == 0)
@@ -496,8 +496,8 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
-	__put_user_error(0, &frame->sig.uc.uc_flags, err);
-	__put_user_error(NULL, &frame->sig.uc.uc_link, err);
+	err |= __put_user(0, &frame->sig.uc.uc_flags);
+	err |= __put_user(NULL, &frame->sig.uc.uc_link);
 
 	err |= __save_altstack(&frame->sig.uc.uc_stack, regs->ARM_sp);
 	err |= setup_sigframe(&frame->sig, regs, set);
-- 
2.17.1

