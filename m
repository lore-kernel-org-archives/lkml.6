Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55D120834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZtkdVtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55D120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeH3Ttb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:49:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55456 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbeH3Ts1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so2477870wmc.5;
        Thu, 30 Aug 2018 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yEZZzXd7EqL0QVZwjKI2SdtLyI0ltZvJ5hxxkextUgQ=;
        b=CZtkdVtp06Yg5sR3ngIwd7L3KZq3/8j6SAEeTg0uaSi+JSVl+cDdDJEIvqRX5/PArS
         wFGgH/7HekLrY8j6dDC+YVVW5BXKbeGLkUGM7jgJa/oyhiENbrtXAv4zrDiW+xJlBkYM
         vfE18JH3/kUupsg24QSbbZN7uS68p/gXoiKYDqV9Fi2zKK0uGlQsf9Gp6fH9xYbX3f5x
         mng/6G+VfhJwFyj6xQvbNI1S2dLMIFFWyqQIUgPAdPqZJT3s/22HkVgocnkVB4I6tGpw
         k4IVea8z5V5+J/XKnrgbx4vnVjNoUtdAFN4HBZr4ymAhoYK170zmK+s8ZuNDiid8xIOV
         tYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yEZZzXd7EqL0QVZwjKI2SdtLyI0ltZvJ5hxxkextUgQ=;
        b=bdlaj52u2Nob73CyuzvSxY19eSLdrHPHzKkaZ0XRrJVDkZYeRyR1IzLhkKza5fVdRM
         7nemLc4nAFF4fvo45gva1aK9rnvTGrZmjlEBxzGq0t2LsbDjgjVxOOC8+Okzt+X7dD7/
         yrJfESROHc1mRt+GIRWyzaoj4YWjUt6BWoRQodpXXa+is6Y3xmbG8ZTDekGon5vOMqev
         PFYtyzS5n7jtrq3vtHhpgFzM9QJmuc2tDmWZ7uTmWZJ5ezblqyzP+nR//9Bzfd6rJtqv
         quaIi1eU+Cn5Dlq+LU/NspsFuaOtAq//FXNzIzYY9kw93G1STqF+uvvlEFQg4hWqTpKv
         Emyw==
X-Gm-Message-State: APzg51AklzTlDY60bZ89n0ZdAzCQB/TEakOkkFjCa4Y98jkGDGbzcbyQ
        EqoFS2AII/eByAHZo2WpzN4=
X-Google-Smtp-Source: ANB0Vdb4pUa0lLdosCK8FR5C6yVnMsY5GJ3f0A6QraMpJ04jdB2+jJlgh34MIlB8Vt40xIlnGqDMjQ==
X-Received: by 2002:a1c:1943:: with SMTP id 64-v6mr2087807wmz.89.1535643940503;
        Thu, 30 Aug 2018 08:45:40 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:40 -0700 (PDT)
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
Subject: [PATCH v3 20/30] iio: adc: sun4i-gpadc-iio: rework: device specific suspend & resume
Date:   Thu, 30 Aug 2018 17:45:08 +0200
Message-Id: <20180830154518.29507-21-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different sensors will have different suspend and resume functions. So
we are modularize the suspend and resume functions.

The resume function configures and initializes the thermal sensor and
the suspend function disables the sensors.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 2fd73d143815..c7b46c82e3e5 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -76,6 +76,9 @@ struct gpadc_data {
 
 static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
 
+static int sun4i_ths_resume(struct sun4i_gpadc_iio *info);
+static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info);
+
 static const struct gpadc_data sun4i_gpadc_data = {
 	.temp_offset = -1932,
 	.temp_scale = 133,
@@ -87,6 +90,8 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.ths_resume = sun4i_ths_resume,
+	.ths_suspend = sun4i_ths_suspend,
 	.sensor_count = 1,
 };
 
@@ -101,6 +106,8 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.ths_resume = sun4i_ths_resume,
+	.ths_suspend = sun4i_ths_suspend,
 	.sensor_count = 1,
 };
 
@@ -115,6 +122,8 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.ths_resume = sun4i_ths_resume,
+	.ths_suspend = sun4i_ths_suspend,
 	.sensor_count = 1,
 };
 
@@ -123,6 +132,8 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_scale = 162,
 	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.ths_resume = sun4i_ths_resume,
+	.ths_suspend = sun4i_ths_suspend,
 	.sensor_count = 1,
 };
 
@@ -401,6 +412,11 @@ static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id)
 static int sun4i_gpadc_runtime_suspend(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
+	return info->data->ths_suspend(info);
+}
+
+static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info)
+{
 
 	/* Disable the ADC on IP */
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
@@ -415,7 +431,11 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
 static int sun4i_gpadc_runtime_resume(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
+	return info->data->ths_resume(info);
+}
 
+static int sun4i_ths_resume(struct sun4i_gpadc_iio *info)
+{
 	/* clkin = 6MHz */
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
 		     SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(2) |
-- 
2.11.0

