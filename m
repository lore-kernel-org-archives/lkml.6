Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD54C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E576206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbAPnFK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394902AbfBMVdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:33:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41370 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394819AbfBMVce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:34 -0500
Received: by mail-qk1-f196.google.com with SMTP id u188so2325922qkh.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DKiPUgce4JTheoGvWXbyBEIdokTDXbYrmiEYcaxz36E=;
        b=DbAPnFK7wOOhgCkSXvr0rLYtTRXuMZoONdFu6iHTzWBB/el8BuICjM2pTFOqGm9uUD
         MzehSpAKMBox9yPh88f2hG4Knzskm9d/Uq8PuLOjVRmRyw5HfRE6h65JxG1hWs/jgzb7
         ep/kP7umpWmHAL7RDckVkr84vFvbcl+65Eci/o6yk9AgDW1Ho6YpNC0KPJG4GyO4KOof
         qU7020prSwEjhrPdjOhv0nTnfZ7UB3eFEgtPH/+g/B13w+swHlEWHm6+9ejg/Yh4evoc
         YKL4JtBxJiSaOeonz7KnTt4HCuTAV2YpOxp3PrVTmVy1PE7u0Hl25MccfI52IVcaCcLa
         sAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DKiPUgce4JTheoGvWXbyBEIdokTDXbYrmiEYcaxz36E=;
        b=TulGEV+RRbeTcQ2C0lUPIbsCjc2mLJLkT6L6IBWXijtw0d+sK6lQz2X3u/jw72J/YM
         KdabpBxhqptapysSivXgByZ4t8o3A2fnSkgYzK2codadBM/bRQg/kz8mhJ6lol7x/27t
         WKjSJg2DlywFdb+86u2WWKuVvHHg2/6ubBDKzMomGf8UTX9VwcLIDbfPPfgv0k9ZQBla
         WFEsfN9Y/VCFeHAscAk3r+CEEb4yGFEPbKkRul8wRBGdrKjsfdubDMQV+Za9XZIxRj2O
         tvJ1CXeqrfHkjqIR3kfFMBu4mw6+TnGVnwFHyYKbz7vwFEBLocUmZYeSXZSklpKYalHg
         sP2w==
X-Gm-Message-State: AHQUAuaOxQb/JJIzeNlVSlcKT0rehpFkDkdWFZFTXFweha1A5f7asESE
        fWx1+g1XU2+NeXy4kZNvvrAAyw==
X-Google-Smtp-Source: AHgI3Ibx+sKx3L99liSsDx+HFc+v/ruM6shgCriTB9LCyaZtBZ2LkNnyIIhH56SKc+xo29hyIj24zg==
X-Received: by 2002:a37:a14d:: with SMTP id k74mr216780qke.242.1550093552772;
        Wed, 13 Feb 2019 13:32:32 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:32 -0800 (PST)
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
Subject: [PATCH 4.19 05/17] ARM: 8793/1: signal: replace __put_user_error with __put_user
Date:   Wed, 13 Feb 2019 16:32:11 -0500
Message-Id: <20190213213223.916-6-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
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
index 1e2ecfe080bb..b908382b69ff 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -336,7 +336,7 @@ setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set)
 	if (err == 0)
 		err |= preserve_vfp_context(&aux->vfp);
 #endif
-	__put_user_error(0, &aux->end_magic, err);
+	err |= __put_user(0, &aux->end_magic);
 
 	return err;
 }
@@ -499,7 +499,7 @@ setup_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 	/*
 	 * Set uc.uc_flags to a value which sc.trap_no would never have.
 	 */
-	__put_user_error(0x5ac3c35a, &frame->uc.uc_flags, err);
+	err = __put_user(0x5ac3c35a, &frame->uc.uc_flags);
 
 	err |= setup_sigframe(frame, regs, set);
 	if (err == 0)
@@ -519,8 +519,8 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
-	__put_user_error(0, &frame->sig.uc.uc_flags, err);
-	__put_user_error(NULL, &frame->sig.uc.uc_link, err);
+	err |= __put_user(0, &frame->sig.uc.uc_flags);
+	err |= __put_user(NULL, &frame->sig.uc.uc_link);
 
 	err |= __save_altstack(&frame->sig.uc.uc_stack, regs->ARM_sp);
 	err |= setup_sigframe(&frame->sig, regs, set);
-- 
2.17.1

