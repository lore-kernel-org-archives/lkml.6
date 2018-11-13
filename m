Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59EDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA2922360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fgj2+qwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA2922360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbeKMWON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:14:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36879 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732950AbeKMWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:14:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id u3-v6so3280853pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 04:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLHTmRw6P1EM9PG0wbsYEZPP/KaTwRVrTq4TSxAqcYw=;
        b=Fgj2+qwlrYcCshT/z5bP3mgEptmkVa7vIos+P4USWGrf1T75ShhzOE/2yNPGGovDqq
         xazt4YfPLn+fK/mBv2IGSLQsuBVHQUHOoGdMKz9xSaTZIM6TBtG9Tq53jplULkhjXTGl
         8DR+8zb8yUndSMq3rh5qcIHTlxKcqFbs5QM/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLHTmRw6P1EM9PG0wbsYEZPP/KaTwRVrTq4TSxAqcYw=;
        b=FwBMHMBk09m7mku5pe2wAFQHyknb/4Z+y8ozFATTsPYKFM46W9+tC/WlzijDVS0EZN
         7zq6S5uG+MqTEt+jP04rvwXeXJmK5byu2COuo2YZILtBwUQWrVe1yMO85+fEfEkLSOzf
         2+ViWIvPlrmWOKw1IYmAGL1Gl4bfsbh12sNG6Ut0dPADLchjoaskSx7wrRtRSGZljWRL
         kPIIIg6kqjaJGbd3avsOMQdPomQsL5uSA+ZISTo1VLpDKs8O/xMMFMkH5AygBjnQJVcu
         w4tUcdogLYqV0/5LifBxCX6Nl5qyoDR6NjP5BJwzESotG4mO+0mBoNJ8U3wdZOjOSUia
         Z6wg==
X-Gm-Message-State: AGRZ1gLIN0qYqlOBXmxuAPLMh3R/7Km3KJ8ktEr1iCdGWaMqfHaEIoAL
        hTRFa8AGUct9k8JFUmTVRvygKA==
X-Google-Smtp-Source: AJdET5cdadulBj2DWHt9NjzhFlSog+QNKYpBsRJZ8xJh42oS8CBFKLDH+t5NeOP1bCvu6IchE2gnyg==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr4499456pgf.33.1542111379208;
        Tue, 13 Nov 2018 04:16:19 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id g65sm14312614pfa.63.2018.11.13.04.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 04:16:18 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 4/4] arm64: defconfig: Enable PWM_SUN4I
Date:   Tue, 13 Nov 2018 17:45:35 +0530
Message-Id: <20181113121535.24137-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113121535.24137-1-jagan@amarulasolutions.com>
References: <20181113121535.24137-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner PWM support need for ARM64 Allwinner SoC's
which used pwms, builds it as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v6:
- none
Changes for v5:
- new patch

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cb614bd70716..dfdbc0646472 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -648,6 +648,7 @@ CONFIG_PWM_MESON=m
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_SAMSUNG=y
+CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
 CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
-- 
2.18.0.321.gffc6fa0e3

