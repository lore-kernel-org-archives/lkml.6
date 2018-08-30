Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3C0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B31620838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0MxvQAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B31620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeH3TsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52409 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbeH3TsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id y139-v6so2458893wmc.2;
        Thu, 30 Aug 2018 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=awc7lOb1lT80drwezjxAgYVu4AbsJ53UXF1LdxXOCho=;
        b=X0MxvQAWNa/QHG1a/x8gvN03aFC9bPKcstD3++OvpK/mWPr/Nu71ydd6Bi41ISzadw
         qIrOAT4F4OdsZ2kzh+q00Iis58hoEqbdTQiaJXXSzS2z9xTXQ5TxEH5tqgZjYazGaWjL
         bgRuTIATJ9oEsL4Wiu0TCg4IYGtnZMurHeihga0x6jkxCqTnuwwGYQJO+iPhrO6Es8uG
         PfJfsu2w7Xck8vTApyDRlNjCvRFoI5IwEtRAnxtxmXrFhmaoTmiGArLtORnF021wvrAd
         TAL+o92qdd4pPHPE+vbp5YWVnctSPkhqkJ92iBaWO2vxPhz1KGnXaQA3f6nl67oaEha3
         JKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=awc7lOb1lT80drwezjxAgYVu4AbsJ53UXF1LdxXOCho=;
        b=RlO5JBPY1Ynt6MAlVm7Q3VyjKbiF8PLuXEEC4f6fEfw7d6NjdEOL4dg1K+uEI6XuZU
         yH08gy9rL8vmV+0GdXichfRnk99oGr4OoObqxUptVWQwcFuVvakiYyoMG3YFG9e3c7lq
         Wkhtb5yf1f3KBhE+X7f/YvH6xyEyiqvX3NhXpizea6QNjI7jbZm6XE3PdEUVPhyXWwm6
         v+AqbPhE+opsnZOmX2yuSZlB/Put9l6jVFvaqoafkwK9CXxb/aQR+lbJ/cYwmk8Ua1d4
         a/KGr6exwwO8QFh/BbWPCoExLobq0XEP6JPUL9MX2n3Yr4ZlKDx8pSpLit8HJG6yeb2b
         h5Eg==
X-Gm-Message-State: APzg51DqrotD9OusUHyFbj/9ZLvcMlEPpA+KWV2WGgycXJaa3HYtvNs8
        Zs1R05QkhMDrUODYyVGteSU=
X-Google-Smtp-Source: ANB0VdZ9TFSjSij1veJmjfSvCzyhdYiErnmAIpTWPnan95g96ps8uKTdevRe8LnmmxEcbDyC2EYNlg==
X-Received: by 2002:a1c:7e13:: with SMTP id z19-v6mr2044367wmc.156.1535643937235;
        Thu, 30 Aug 2018 08:45:37 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:36 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 17/30] iio: adc: sun4i-gpadc-iio: rework: support clocks and reset
Date:   Thu, 30 Aug 2018 17:45:05 +0200
Message-Id: <20180830154518.29507-18-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For adding newer sensor some basic rework of the code is necessary.

The SoCs after H3 has newer thermal sensor ADCs, which have two clock
inputs (bus clock and sampling clock) and a reset. The registers are
also re-arranged.

This commit reworks the code, adds the process of the clocks and resets.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 72 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index c278e165e161..c12de48c4e86 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -22,6 +22,7 @@
  * shutdown for not being used.
  */
 
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -31,6 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/thermal.h>
 #include <linux/delay.h>
 
@@ -63,6 +65,9 @@ struct gpadc_data {
 	int		(*ths_suspend)(struct sun4i_gpadc_iio *info);
 	int		(*ths_resume)(struct sun4i_gpadc_iio *info);
 	bool		support_irq;
+	bool		has_bus_clk;
+	bool		has_bus_rst;
+	bool		has_mod_clk;
 	u32		temp_data_base;
 };
 
@@ -127,6 +132,9 @@ struct sun4i_gpadc_iio {
 	struct mutex			mutex;
 	struct thermal_zone_device	*tzd;
 	struct device			*sensor_device;
+	struct clk			*bus_clk;
+	struct clk			*mod_clk;
+	struct reset_control		*reset;
 };
 
 static const struct iio_chan_spec sun4i_gpadc_channels[] = {
@@ -472,8 +480,13 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					     &sun4i_gpadc_regmap_config);
+	if (info->data->has_bus_clk)
+		info->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus",
+				base, &sun4i_gpadc_regmap_config);
+	else
+		info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+				&sun4i_gpadc_regmap_config);
+
 	if (IS_ERR(info->regmap)) {
 		ret = PTR_ERR(info->regmap);
 		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
@@ -498,9 +511,58 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 		}
 	}
 
+	if (info->data->has_bus_rst) {
+		info->reset = devm_reset_control_get(&pdev->dev, NULL);
+		if (IS_ERR(info->reset)) {
+			ret = PTR_ERR(info->reset);
+			return ret;
+		}
+
+		ret = reset_control_deassert(info->reset);
+		if (ret)
+			return ret;
+	}
+
+	if (info->data->has_bus_clk) {
+		info->bus_clk = devm_clk_get(&pdev->dev, "bus");
+		if (IS_ERR(info->bus_clk)) {
+			ret = PTR_ERR(info->bus_clk);
+			goto assert_reset;
+		}
+
+		ret = clk_prepare_enable(info->bus_clk);
+		if (ret)
+			goto assert_reset;
+	}
+
+	if (info->data->has_mod_clk) {
+		info->mod_clk = devm_clk_get(&pdev->dev, "mod");
+		if (IS_ERR(info->mod_clk)) {
+			ret = PTR_ERR(info->mod_clk);
+			goto disable_bus_clk;
+		}
+
+		/* Running at 4MHz */
+		ret = clk_set_rate(info->mod_clk, 4000000);
+		if (ret)
+			goto disable_bus_clk;
+
+		ret = clk_prepare_enable(info->mod_clk);
+		if (ret)
+			goto disable_bus_clk;
+	}
+
 	info->sensor_device = &pdev->dev;
 
 	return 0;
+
+disable_bus_clk:
+	clk_disable_unprepare(info->bus_clk);
+
+assert_reset:
+	reset_control_assert(info->reset);
+
+	return ret;
 }
 
 static int sun4i_gpadc_probe(struct platform_device *pdev)
@@ -586,6 +648,12 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	if (!info->data->support_irq)
 		iio_map_array_unregister(indio_dev);
 
+	clk_disable_unprepare(info->mod_clk);
+
+	clk_disable_unprepare(info->bus_clk);
+
+	reset_control_assert(info->reset);
+
 	return 0;
 }
 
-- 
2.11.0

