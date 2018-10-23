Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE73C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDA220665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="imQg/ATu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDA220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeJXAVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:21:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40667 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbeJXAVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:21:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id o14-v6so863150pgv.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWWnuHsT3EWI+rBeuVMFbdGlqNVmLWUDIsvLE5JrJmQ=;
        b=imQg/ATu0c/GP3r74jUwcsW6tRa3Mnfwj+BAeAqtOamet+rIXO3J89WUXs3RntZG6n
         7ps0K0lUGsEBNZ2QyzUmFHUq1GGrbEAoaO0XEwH7VLLMqf0gWI4IB3NtjTdMYSnemKY9
         RgQHlYBJ+XBdn1h5bcXIaxXtFffy1jyJ17ef0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWWnuHsT3EWI+rBeuVMFbdGlqNVmLWUDIsvLE5JrJmQ=;
        b=YZEHhojxer+0tGBoEzWLmrwpDCHeueWDo/r1SH2ji8UThUk3QVhZ5rP2mxSS42JkLy
         eLOFm0fx+FwpCtaI7oz7zrnDnB8p+en0D8I5R2DdmdCqBX3dAooX9DnBSGNY45BQldle
         k6PJUbn2qhh3eT/PerDblxf9r1azDV0PECyVqswCbLE7p9rqMDhGmRwCpaCb4ae0zApx
         SlL/CdD+Ays7yl9gVeAUkonyuBYi6iJ9BOzHSh/xNDz0lSM0DV13xcYyMUOQDebXKKsB
         90AwnsaJ2BatYmSIcSqtM9LlaRJe3JlQ92s4M4SiAEnGb8UbRrLPFzb84g62bsHjRwXQ
         fpWw==
X-Gm-Message-State: ABuFfohQN34o7BCtqJGVRttmpz5jeQqKbrVHxb49xVZ3LbQ1CDLCnTKE
        9nKCp/7S/oPks96kmDnUYTQyAA==
X-Google-Smtp-Source: ACcGV61SnFQUuHTGTtN1oSS3STpz+/WP8QArMDFvuRsbsvXVftFPf2apLSGq7JKtvkg3Pak/MTXW1Q==
X-Received: by 2002:a63:194a:: with SMTP id 10-v6mr47704331pgz.192.1540310271904;
        Tue, 23 Oct 2018 08:57:51 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id l2-v6sm2207609pgp.20.2018.10.23.08.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:57:51 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 3/4] arm64: defconfig: Enable DRM_SUN8I_DW_HDMI
Date:   Tue, 23 Oct 2018 21:27:26 +0530
Message-Id: <20181023155727.9383-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155727.9383-1-jagan@amarulasolutions.com>
References: <20181023155727.9383-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner DesignWare HDMI is needed for HDMI support
in ARM64 Allwinner SoC's, build it as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
- Enable it on defconfig 
Changes for v4:
- none
Changes for v3:
- skip SUN8I enablement, since it built statically for arm32
Changes for v2:
- Enable for SUN8I

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7f271178d421..cb614bd70716 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -447,6 +447,7 @@ CONFIG_DRM_EXYNOS_MIC=y
 CONFIG_DRM_ROCKCHIP=m
 CONFIG_DRM_SUN4I=m
 CONFIG_DRM_SUN8I_MIXER=m
+CONFIG_DRM_SUN8I_DW_HDMI=m
 CONFIG_ROCKCHIP_ANALOGIX_DP=y
 CONFIG_ROCKCHIP_CDN_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
-- 
2.18.0.321.gffc6fa0e3

