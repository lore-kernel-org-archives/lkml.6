Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC3CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C2621531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RTJd4fD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C2621531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeI0SHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:07:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39603 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeI0SHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:07:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85-v6so1781575pge.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FM12r1PqeZ0UEqfU8rhB/PQ8rkjshYJl/wf5YHK4Yz4=;
        b=RTJd4fD+eMmL4P/QjE5qS6xoksq8acj/sVh0lIYy72C06IpsjttQ4YPpBLPIhYlS5+
         nW39V7kznbYTdrU4rXkyvm0U+KKQnlSphKbW7ijALohmc7xeaJImfGf8IzH+pTyLdtxb
         14o0zwvqEhHY8PYxCpmGaY3Y0WZJ90upAzShA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FM12r1PqeZ0UEqfU8rhB/PQ8rkjshYJl/wf5YHK4Yz4=;
        b=QYKXPjlH6ungdwCp/E4mFwzY/6j6gdc8H96YeISvqMjxWcgLKyJNQkXmjfWRXI0h/4
         VldMwGnHt+Q1AkK8a8b6etHLVjtFbOJYDb+IbsLvaSazBoCLLdyNoYZBV24aZCPNitR+
         f+lx4T90y0o57p/vyiHpDcDycCJ+Gvba04EoaaIZnCLLnpufeBZLwvEX0NfNYiI7kkr9
         jruNODydTGlioeOsK50KMiJLnKAXxadYI30ILk8/ZZbbfg787dby1mHRLMO50ptn8qld
         DJcLETxzka53q2m9lS5GxYGBVIzQcvVEU5yoDtElaCB7FylGvglFZBzbc1NEtL85ogEj
         jhBA==
X-Gm-Message-State: ABuFfoif2UVcZfQF5MHUotsAoKf3DpkB6KIXRhvXiuyX813JJ4k7Q4HM
        +Tw8Z/3nUHlhtUuEh6wt+JxM1w==
X-Google-Smtp-Source: ACcGV60olxErzia9r7PJhIrOBpwIbFEa2glfR4hi9Kn4gxZi5wR7V0lzZVKjzt3HhxIFgqug0WcIiQ==
X-Received: by 2002:a63:e14a:: with SMTP id h10-v6mr9847345pgk.358.1538048997135;
        Thu, 27 Sep 2018 04:49:57 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.83])
        by smtp.gmail.com with ESMTPSA id v36-v6sm3744872pgn.85.2018.09.27.04.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 04:49:56 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
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
Subject: [PATCH 06/12] drm/sun4i: sun6i_mipi_dsi: Fix VBP size calculation
Date:   Thu, 27 Sep 2018 17:18:44 +0530
Message-Id: <20180927114850.24565-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180927114850.24565-1-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to horizontal and vertical timings are defined
per the diagram from include/drm/drm_modes.h

Back porch = [hv]total - [hv]sync_end

So, update SUN6I_DSI_BASIC_SIZE0_VBP calculation as
mode->vtotal - mode->vsync_end

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 1c7e42015645..599284971ab6 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -526,8 +526,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE0_REG,
 		     SUN6I_DSI_BASIC_SIZE0_VSA(mode->vsync_end -
 					       mode->vsync_start) |
-		     SUN6I_DSI_BASIC_SIZE0_VBP(mode->vsync_start -
-					       mode->vdisplay));
+		     SUN6I_DSI_BASIC_SIZE0_VBP(mode->vtotal -
+					       mode->vsync_end));
 
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE1_REG,
 		     SUN6I_DSI_BASIC_SIZE1_VACT(mode->vdisplay) |
-- 
2.18.0.321.gffc6fa0e3

