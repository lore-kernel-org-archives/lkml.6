Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELsvNQXuuQPYiQOgy89H9nin7wxPUjcX43+qH/oZhxVyUT5UC013FQ/RQcJXhgj3FNl0E13L
ARC-Seal: i=1; a=rsa-sha256; t=1520128195; cv=none;
        d=google.com; s=arc-20160816;
        b=TQl/NbF0cDOc7/Z7ToxEOE3OdPipxp5qXB6P23hOKvT9KAQept609nfPJtCg1y08Hi
         /wgpE+ow/XbHrAZp+9FrgEejYVvGTZiS7u+ABdrJPvZcpvXhc2VjW/0UmV96ScGryEQw
         Ml5L2dHjszHi4UeHkh5YOtg6gWqgDk1ls+hhIxVUJla0w4tsyPHa1Ih9urNMDkalxNuZ
         /N8z/TWFEO4FPBguIQPyGlxDNOY91NNkR1RZod2V/AvKqLVPXsPvszHFqTjS0/1z53VU
         9HaMt0GzbQvL7M75XrNDLCFIKnStaRZ7VSmN89K4TWruA5yaqU/2WFZSenBoXwbPRDeK
         WjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=0lC5O0uhN8xI2mFs5Ci/JuKVajLmg5fA2o4JbTKYCF0=;
        b=eM3HiA588+tov8Sog0VQTYuWa0tOA2IRmwW9TNknkzoCs5d2E4xWrr6zmdyeh9byMX
         tW85Hc6oafeVk24tzVt6W66wayrAz/JNg+QKHybcitvcAuIK5SDRvNGV5kmdXbk7wgYs
         +7cRVtAPQ4zegMdXgvNeUu0Ie7wMYUAJi8k+SMKlXGR58y9u0v0Fjx5AXS9iKD/XS54A
         NGeQNrs3NJ0bXftWw5tH2QDvXgsQldwuhRlXGvtqI7T6sEvRSon5Xrvod6z/y3sUcrrd
         a9pdLOaqgIjedPen6kkOFs0+/Ip8UE3lWB7FSg12dnqC6gRhk6B3Tz7kuBeqD1ZFucyG
         5pIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=tzyzi6Ul;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=tzyzi6Ul;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 10/12] staging: iio: tsl2x7x: make logging consistent and correct newlines
Date: Sat,  3 Mar 2018 20:49:40 -0500
Message-Id: <20180304014942.18727-11-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969942360641174?=
X-GMAIL-MSGID: =?utf-8?q?1593969942360641174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch updates all of the logging commands so that they are
consistent with the other messages, includes __func__ in the message,
and all of the messages include newlines.

This patch also removes some debug log messages from tsl2x7x_prox_cal().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 58 ++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index da7a4e025083..fb91c46c8747 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -378,7 +378,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 		ret = i2c_smbus_read_byte_data(chip->client, reg);
 		if (ret < 0) {
 			dev_err(&chip->client->dev,
-				"failed to read. err=%x\n", ret);
+				"%s: failed to read from register %x: %d\n",
+				__func__, reg, ret);
 			goto out_unlock;
 		}
 
@@ -424,7 +425,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 
 	/* note: lux is 31 bit max at this point */
 	if (ch1lux > ch0lux) {
-		dev_dbg(&chip->client->dev, "ch1lux > ch0lux-return last value\n");
+		dev_dbg(&chip->client->dev,
+			"%s: ch1lux > ch0lux; returning last value\n",
+			__func__);
 		ret = chip->als_cur_info.lux;
 		goto out_unlock;
 	}
@@ -600,7 +603,8 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
 
 	chip->settings.als_gain_trim = ret;
 	dev_info(&chip->client->dev,
-		 "%s als_calibrate completed\n", chip->client->name);
+		 "%s: %s ALS calibration successfully completed\n",
+		 __func__, chip->client->name);
 
 	return ret;
 }
@@ -644,7 +648,8 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	/* and make sure we're not already on */
 	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
 		/* if forcing a register update - turn off, then on */
-		dev_info(&chip->client->dev, "device is already enabled\n");
+		dev_info(&chip->client->dev, "%s: device is already enabled\n",
+			 __func__);
 		return -EINVAL;
 	}
 
@@ -681,12 +686,14 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	 */
 	for (i = 0, dev_reg = chip->tsl2x7x_config;
 			i < TSL2X7X_MAX_CONFIG_REG; i++) {
-		ret = i2c_smbus_write_byte_data(chip->client,
-						TSL2X7X_CMD_REG + i,
+		int reg = TSL2X7X_CMD_REG + i;
+
+		ret = i2c_smbus_write_byte_data(chip->client, reg,
 						*dev_reg++);
 		if (ret < 0) {
 			dev_err(&chip->client->dev,
-				"failed on write to reg %d.\n", i);
+				"%s: failed to write to register %x: %d\n",
+				__func__, reg, ret);
 			return ret;
 		}
 	}
@@ -708,7 +715,8 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
 
 	if (chip->settings.interrupts_en != 0) {
-		dev_info(&chip->client->dev, "Setting Up Interrupt(s)\n");
+		dev_info(&chip->client->dev, "%s: Setting up interrupt(s)\n",
+			 __func__);
 
 		reg_val = TSL2X7X_CNTL_PWR_ON | TSL2X7X_CNTL_ADC_ENBL;
 		if (chip->settings.interrupts_en == 0x20 ||
@@ -819,8 +827,8 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 
 	if (chip->settings.prox_max_samples_cal > MAX_SAMPLES_CAL) {
 		dev_err(&chip->client->dev,
-			"max prox samples cal is too big: %d\n",
-			chip->settings.prox_max_samples_cal);
+			"%s: prox_max_samples_cal %d is too big\n",
+			__func__, chip->settings.prox_max_samples_cal);
 		chip->settings.prox_max_samples_cal = MAX_SAMPLES_CAL;
 	}
 
@@ -845,8 +853,6 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 		if (ret < 0)
 			return ret;
 		prox_history[i] = chip->prox_data;
-		dev_info(&chip->client->dev, "2 i=%d prox data= %d\n",
-			 i, chip->prox_data);
 	}
 
 	ret = tsl2x7x_chip_off(indio_dev);
@@ -857,12 +863,6 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 			       chip->settings.prox_max_samples_cal, cal);
 	chip->settings.prox_thres_high = (cal->max << 1) - cal->mean;
 
-	dev_info(&chip->client->dev, " cal min=%d mean=%d max=%d\n",
-		 cal->min, cal->mean, cal->max);
-	dev_info(&chip->client->dev,
-		 "%s proximity threshold set to %d\n",
-		 chip->client->name, chip->settings.prox_thres_high);
-
 	/* back to the way they were */
 	chip->settings.interrupts_en = tmp_irq_settings;
 	if (current_state == TSL2X7X_CHIP_WORKING) {
@@ -1000,12 +1000,14 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
 	n = value[0];
 	if ((n % 3) || n < 6 ||
 	    n > ((ARRAY_SIZE(chip->tsl2x7x_device_lux) - 1) * 3)) {
-		dev_info(dev, "LUX TABLE INPUT ERROR 1 Value[0]=%d\n", n);
+		dev_info(dev, "%s: lux table input error 1. n=%d\n",
+			 __func__, n);
 		return -EINVAL;
 	}
 
 	if ((value[(n - 2)] | value[(n - 1)] | value[n]) != 0) {
-		dev_info(dev, "LUX TABLE INPUT ERROR 2 Value[0]=%d\n", n);
+		dev_info(dev, "%s: lux table input error 2. n=%d\n",
+			 __func__, n);
 		return -EINVAL;
 	}
 
@@ -1150,14 +1152,14 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
 			chip->settings.persistence &= 0xF0;
 			chip->settings.persistence |=
 				(filter_delay & 0x0F);
-			dev_info(&chip->client->dev, "%s: ALS persistence = %d",
+			dev_info(&chip->client->dev, "%s: ALS persistence = %d\n",
 				 __func__, filter_delay);
 		} else {
 			chip->settings.persistence &= 0x0F;
 			chip->settings.persistence |=
 				((filter_delay << 4) & 0xF0);
 			dev_info(&chip->client->dev,
-				 "%s: Proximity persistence = %d",
+				 "%s: Proximity persistence = %d\n",
 				 __func__, filter_delay);
 		}
 		ret = 0;
@@ -1372,7 +1374,7 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 		chip->settings.als_time =
 			TSL2X7X_MAX_TIMER_CNT - (val2 / TSL2X7X_MIN_ITIME);
 
-		dev_info(&chip->client->dev, "%s: als time = %d",
+		dev_info(&chip->client->dev, "%s: als time = %d\n",
 			 __func__, chip->settings.als_time);
 		break;
 	default:
@@ -1738,8 +1740,9 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 
 	ret = i2c_smbus_write_byte(clientp, TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
 	if (ret < 0) {
-		dev_err(&clientp->dev, "write to cmd reg failed. err = %d\n",
-			ret);
+		dev_err(&clientp->dev,
+			"%s: Failed to write to CMD register: %d\n",
+			__func__, ret);
 		return ret;
 	}
 
@@ -1773,7 +1776,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 						indio_dev);
 		if (ret) {
 			dev_err(&clientp->dev,
-				"%s: irq request failed", __func__);
+				"%s: IRQ request failed\n", __func__);
 			return ret;
 		}
 	}
@@ -1790,7 +1793,8 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 		return ret;
 	}
 
-	dev_info(&clientp->dev, "%s Light sensor found.\n", id->name);
+	dev_info(&clientp->dev, "%s: %s Light sensor found.\n", __func__,
+		 id->name);
 
 	return 0;
 }
-- 
2.14.3
