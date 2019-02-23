Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAA8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B161B20850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZT1wiVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfBWNIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41602 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbfBWNIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id n2so5176662wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zknq6lrBM9g2MG4i+DlDrNbTJDMKgmHTNCOozuPWOn8=;
        b=NZT1wiVx5mvjoKfO/K7unMCto8uwYTQTO12wJwxhD6siZaPOu02a4+wZG9MYp59uYy
         1YJEJmfNjqs8EGxLeEWz9ldhAq80auBG431nBW5/0FhIdJUkGD8+06oG6Q9AhTx4oEFP
         14I7vKDWX70tlygUL+kmN+XzWcPaX0wBIyTElbBhvDdglkR56edLiXsrMrbtt5FJwcf1
         8k5Qjwnfq/L5HBbscG3memMtWUJjxbGRMzkc2aPt1pBHwPzpaDllJyEFwIq/Eig12XpT
         qs0hj0KWwkw84oMYJDB01GJ/sLHtxm0yB3qx9ZVjqKMIgSyoxmNob4x83hLXJn3eWSng
         eUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zknq6lrBM9g2MG4i+DlDrNbTJDMKgmHTNCOozuPWOn8=;
        b=dkWEIbJAzSdFpR/yFF3xb6jH8Zxk37jMsgLGPNVfXyRNo7Gi+qqcZDBDAYObqsZZAU
         YLBDLS3onBbdDCevxNWD1iVIC1mKipYKFpRUDvaYkUo1JIZms0J/vWnBHb0QlcK7z+Jj
         X3+p5i3RR9N3rQOUKh2pWnqU6eMzO8BMF+vA+Vm4F4sFLPUTM3l3TulfvloVhwOZZLwq
         F1iX6LtEZkWDRlNkmwM5pevm1//y0trInNytqdmFAdI+T3oga0vt+HPyT/gW8b+jlTvZ
         lkHFOrpSr+gXTf0wHhAsTumoNizEb4SQ2qkS8m7Dh11BTyWl+uqsh4+uHu0NjsRzZfN9
         1n/A==
X-Gm-Message-State: AHQUAuZwgmmx4P933uBpANX4ghZDKapDhUN+MVNn+3sRiYrpeMxa+XwD
        VZAoMVSCiEDm5ie9gr7RKoa1UA==
X-Google-Smtp-Source: AHgI3IZusaMjdAVkzs37A+HeXwNHRHm980gkXuquhHM9bqxujJUJTHN+jVSvrcsoxZtv6xzVwJeu7w==
X-Received: by 2002:adf:f149:: with SMTP id y9mr6171700wro.282.1550927318385;
        Sat, 23 Feb 2019 05:08:38 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 18/18] soc/tegra: default select TEGRA_TIMER for Tegra210
Date:   Sat, 23 Feb 2019 14:07:06 +0100
Message-Id: <20190223130707.16704-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Lo <josephl@nvidia.com>

The tegra timer is necessary for Tegra210 to support CPU idle power-down
state. So select it by default.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/soc/tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index fe4481676da6..a0b03443d8c1 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -76,6 +76,7 @@ config ARCH_TEGRA_210_SOC
 	select PINCTRL_TEGRA210
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
+	select TEGRA_TIMER
 	help
 	  Enable support for the NVIDIA Tegra210 SoC. Also known as Tegra X1,
 	  the Tegra210 has four Cortex-A57 cores paired with four Cortex-A53
-- 
2.17.1

