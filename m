Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C2C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A17722360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TPcn0i1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A17722360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbeKMWOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:14:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47101 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732950AbeKMWOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:14:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id s9-v6so5942808pfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 04:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DWOJVAerhzZxS+YqaNRQsVrlJsmi4A9mLxgHlp2Deiw=;
        b=TPcn0i1eDZXzfwTAa94Q07zyTsw+pT0QkG6vH8Qf8DBpH8gce2op4AW+GmLZNeV1El
         0G+5+oqWjjZ8Y/521LbK8BPEZL5wAx4hqHRFG/A8Z9g+zpOoduscJjxaPb0O+CR9wUYH
         qYIYXCDYItKpzF/OFAFYMQBZKtni7KTnUVQDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWOJVAerhzZxS+YqaNRQsVrlJsmi4A9mLxgHlp2Deiw=;
        b=ua8DVl5ZkgHbflXufRbVjKaDUbw7vosZv9jzq1IsI8C1adPP2l6JvtIfcvzxrThK8G
         rUwLGsfBh3P3sAplrcwSb6nhIl8lsWIm8kXi6FKukjzyEmsVnRm+DO4TC0ElBOxdjzgo
         kwICDU1qAIGo4YveJIE8rYqafBrA/ub/la4sSFLRPUCQ3+1D4JZEuu7M80UNNaJmOplY
         RBO/QDZMVN+eceYLluN+lWLNqK/01xxWO59HT18vzMsjv0425iHnfoG9xuQFHcH9qtpt
         i6lt24rT05PLL5qFhq8ZA5bXz/7ltDQSNuDEe0QuAUAYWlZVBmCKBK+H7Lm0zzcWyUsL
         w9aQ==
X-Gm-Message-State: AGRZ1gKgZ9MmvwMaycnFJ6jYp5obvY0R35lE2Z83mpyJ7Ak1H4s4jXU3
        +45Y+2u/ts+8BLvoXM2UM+7VcQ==
X-Google-Smtp-Source: AJdET5cpYNsmuYjre11Fj0Lw+WCZ8vpCG0qeiwqqHFXXfnNg944UT+E4DIHgS/Na4/LPwh7cIg0Imw==
X-Received: by 2002:a65:41c2:: with SMTP id b2mr4496671pgq.67.1542111370832;
        Tue, 13 Nov 2018 04:16:10 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id g65sm14312614pfa.63.2018.11.13.04.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 04:16:10 -0800 (PST)
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
Subject: [PATCH v6 3/4] arm64: defconfig: Enable DRM_SUN8I_DW_HDMI
Date:   Tue, 13 Nov 2018 17:45:34 +0530
Message-Id: <20181113121535.24137-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113121535.24137-1-jagan@amarulasolutions.com>
References: <20181113121535.24137-1-jagan@amarulasolutions.com>
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
Changes for v6:
- none
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

