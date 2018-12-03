Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445BAC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB9C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Hr/xAyT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB9C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLCKIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:08:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37808 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeLCKIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:08:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so11448171wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dg+DbPWOiIWTEBIboqaFlKrQScH+lEmDG+NCL3SG4qM=;
        b=Hr/xAyT52bglpYPM26vtwVjw0lVi0riGdwBTt/Uqb6wsvE2smy8q0cbYurg03WIILo
         cG805J7COWGGGcN1i/oPutV5O29qrzM/zr6QKkWDl7I1ma9c7znHWIEClb+j0PzuWgIu
         NIhsAm9mzdwTmQmwt2f9mKA0av9nbuxKtVIss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dg+DbPWOiIWTEBIboqaFlKrQScH+lEmDG+NCL3SG4qM=;
        b=ps9QuiFipEdfyOqTJJ5UhK8+S+pCoIk/uOU/PryD+G+xB/hjn+jDTHgIxOJoubxHGk
         jxGu5DjTa3yFT0NhXHCgO+2o0U2zCXL538W5D3Fqdpa+7ublKkQUExyWtFuNE7jFUu0Y
         z0NGQy7TznNXHljZaqGfPJpqeZPbRuWZ23ka+3uQFWtGoN+GHvOCCI3TY41jUNOeeNyL
         qXNuAQOLEZJoa/Ieh72DbD6oYgJ55VpX6P1uzFz6O5VmxByWz+32SKmjoz1Jq8p1CThS
         f8tszv3iZgUY0ecngoKL/LDISzEJu201lEsLXDJKllTiXRqZjtZmJK5SUwXpHWTZkzE1
         XdZw==
X-Gm-Message-State: AA+aEWbN/9uqLrmIOZUs14m5BRI4AOdMap7FApcNbC8Y/buUH9qMfnJV
        4unKr6P88+IPNKBiQ2RrzLoGHw==
X-Google-Smtp-Source: AFSGD/UK9g8q6lqOZkyiIHQVvaX8DUIaGiep5wexUKg8ZFn8bAxbcvqvPj7E0tiWbgOM/Hf0bE/ZmQ==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr9094939wrq.265.1543831679146;
        Mon, 03 Dec 2018 02:07:59 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id n15sm18589236wrt.21.2018.12.03.02.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:07:58 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/5] media: sun6i: Add vcc-csi supply regulator
Date:   Mon,  3 Dec 2018 15:37:45 +0530
Message-Id: <20181203100747.16442-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203100747.16442-1-jagan@amarulasolutions.com>
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Allwinner A64 CSI controllers are supply with
VCC-PE pin, which may not be turned on by default.

Add support for such boards by adding voltage regulator handling
code to sun6i csi driver.

Used vcc-csi instead of vcc-pe to have better naming convention
wrt other controller pin supplies.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../media/platform/sunxi/sun6i-csi/sun6i_csi.c    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 6950585edb5a..5836fa5e6b01 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/sched.h>
 #include <linux/sizes.h>
@@ -36,6 +37,7 @@ struct sun6i_csi_dev {
 	struct clk			*clk_mod;
 	struct clk			*clk_ram;
 	struct reset_control		*rstc_bus;
+	struct regulator		*regulator;
 
 	int				planar_offset[3];
 };
@@ -163,9 +165,16 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 		clk_disable_unprepare(sdev->clk_ram);
 		clk_disable_unprepare(sdev->clk_mod);
 		reset_control_assert(sdev->rstc_bus);
+		regulator_disable(sdev->regulator);
 		return 0;
 	}
 
+	ret = regulator_enable(sdev->regulator);
+	if (ret) {
+		dev_err(sdev->dev, "Enable vcc csi supply err %d\n", ret);
+		return ret;
+	}
+
 	ret = clk_prepare_enable(sdev->clk_mod);
 	if (ret) {
 		dev_err(sdev->dev, "Enable csi clk err %d\n", ret);
@@ -809,6 +818,12 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
+	sdev->regulator = devm_regulator_get(&pdev->dev, "vcc-csi");
+	if (IS_ERR(sdev->regulator)) {
+		dev_err(&pdev->dev, "Unable to acquire csi vcc supply\n");
+		return PTR_ERR(sdev->regulator);
+	}
+
 	sdev->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus", io_base,
 						 &sun6i_csi_regmap_config);
 	if (IS_ERR(sdev->regmap)) {
-- 
2.18.0.321.gffc6fa0e3

