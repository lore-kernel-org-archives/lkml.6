Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F07C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C46F20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZE9ajIXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C46F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeLJQTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:19:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38361 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLJQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:17:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so11927126wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHVyHtVc0G3Kpp5cjsZwGbecU0Xlg/ozATiwaeVvdoQ=;
        b=ZE9ajIXqPxmINSacZd+H8oprtTFFyxpDCOZ2azqgIZ4MrD8FGUNTWwvslD8KG0DOpi
         ilI581RXk+JktjgSE0o8KGaSlCe3pwRdpL4IRr0NIdB1tNJaUns2ocfnBSC2WqQuxR4Z
         CDACrhmZyDVqmlA1fYMQFSnKyE5geIbCOAcQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHVyHtVc0G3Kpp5cjsZwGbecU0Xlg/ozATiwaeVvdoQ=;
        b=msqRlqdKor0bS/Wf/CS4Epu3S/aaHJ1Xt9Wq7O9HQo7bwH35lQ/dpQ5hqA2qWsIRAT
         eqMbvd2kn8Nq/LhyHZlfb+i/TFAbRlQOvz4eNOhmaoSgxwyzbmvfB7cAkdpnZogb6LYR
         A9msP7h7ITpSx30cS4fGAoCfLd5+f74AFIOxq9gyDjioa9BRxZT1pfOexQa0D7KeK3nB
         Lk2aAYOUJ+/k87zSSekhUJEJiw9CDDT4z4sNt1cOyAWN2rSyJLjOeaWd6rmI9Ss6cRkt
         Mg/4n24rz0L1AOhqcUV/1wEqcYxaGA4a28cAtYhA9MTdgg/3/X81YHmVsYX/cYcCf+Zx
         hCKA==
X-Gm-Message-State: AA+aEWaHFQ1n2Zti7riZcxsv4rucQn77mV645q2hEjuoCdiNgkXEuUuw
        3dZfB54b4Pn1Gwk5S/DiYLJutg==
X-Google-Smtp-Source: AFSGD/VmMHUxhKg+eCn4NcXCKmMarXP8qz9Fx0lmTKt2sUbFkE9TD3lBen1AoXZTyUnuHgUca0BB7g==
X-Received: by 2002:a1c:a6d7:: with SMTP id p206mr10662383wme.143.1544458669864;
        Mon, 10 Dec 2018 08:17:49 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:17:48 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 03/17] drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI DSI support
Date:   Mon, 10 Dec 2018 21:47:15 +0530
Message-Id: <20181210161729.29720-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller on Allwinner A64 is similar to
Allwinner A31 without support of DSI mod clock(CLK_DSI_SCLK)

So, alter has_mod_clk bool via driver data for respective
SoC's compatible.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 561de393ea23..50f535ae57e9 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1120,11 +1120,18 @@ static const struct sun6i_dsi_variant sun6i_a31_dsi = {
 	.has_mod_clk = true,
 };
 
+static const struct sun6i_dsi_variant sun50i_a64_dsi = {
+};
+
 static const struct of_device_id sun6i_dsi_of_table[] = {
 	{
 		.compatible = "allwinner,sun6i-a31-mipi-dsi",
 		.data = &sun6i_a31_dsi,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-mipi-dsi",
+		.data = &sun50i_a64_dsi,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
-- 
2.18.0.321.gffc6fa0e3

