Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeBSMuB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:50:01 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:33119 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbeBSMsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:48:14 -0500
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, maxime.ripard@bootlin.com,
        jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v4 13/13] iio: adc: axp20x_adc: remove !! in favor of ternary condition
Date: Mon, 19 Feb 2018 13:47:36 +0100
Message-Id: <9ec180ff4358ac6e163115aa7832a0674b6a640e.1519044068.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

!!'s behaviour isn't that obvious and sparse complained about it, so
let's replace it with a ternary condition.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/iio/adc/axp20x_adc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index a30a972..7a745cf 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -365,7 +365,7 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
 		return -EINVAL;
 	}
 
-	*val = !!(*val) * 700000;
+	*val = *val ? 700000 : 0;
 
 	return IIO_VAL_INT;
 }
@@ -442,15 +442,17 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
 	if (val != 0 && val != 700000)
 		return -EINVAL;
 
+	val = val ? 1 : 0;
+
 	switch (chan->channel) {
 	case AXP20X_GPIO0_V:
 		reg = AXP20X_GPIO10_IN_RANGE_GPIO0;
-		regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(!!val);
+		regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(val);
 		break;
 
 	case AXP20X_GPIO1_V:
 		reg = AXP20X_GPIO10_IN_RANGE_GPIO1;
-		regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(!!val);
+		regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(val);
 		break;
 
 	default:
-- 
git-series 0.9.1
