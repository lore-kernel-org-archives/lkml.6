Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELtvahckZon7JjFWZ+pu5Zk+HyWPaHLJ3TK7H3L9LUJJIHKq6yHjzsVd8UR7+FjOe6ylXRnI
ARC-Seal: i=1; a=rsa-sha256; t=1520128194; cv=none;
        d=google.com; s=arc-20160816;
        b=w67qiTv6/e9wmnwU6POGoMv/F+8X9qwCirXYE4Bie3UbZT/CiOB2MwFunarMiPubtA
         ACNdgWl7W2ijzd5h3XR5o66XT+xCWvt4qi3WK8xVvQMDULUX3ZfuNB7uJByHXIh83PNJ
         4w1C/+TEboF5BuoTKv2ITS7vA5I4G1ROhHik2b8GHRrS7cyztUSuSNfpUb9hd4+INZA2
         BVfsGSdQlpD2/vL1x9+LMZs+2HY+eeZhVH5482b7mntJnX3+wzpDZ4rYicOEZTiI+JIC
         OnZE8PevFuV8Uw+0DADqS+YbPnIIdG0AW4GmnDSoS2kXnPRJKf0gxI9d29Ym6DhOKsfx
         yi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=441GkcsWowhgj2r2S/x1OVOthufJrp7qZmlL17sx5Qs=;
        b=Vkfmas/U6WVKS/d6mLpI4baZTR2qKQiHthY6Bl497CpHLEGDMtL4+rmxsZw0pUwG6W
         q3KkQO7V0mNQzOcaznLdsu3jklOYS7ZWUvujOS885FtZWlz6PfNrO4FUzhDBZX2c2iSo
         f22j2vjgcObuttHQ/Sw1CaZeKZuTLT+XZ13j2OdOxmmgJbKeh9OL+t2TzdUqLe0XUoFu
         MRWGKdSh8Lut6X3kiCy27rM2PsQ1Clp5Zf9QJjflyC7uxRLPfTZPNrsKRSOGiTfbLaLX
         CDxkqmCb5zb5nOybAle7jnkITU5xr/v2Lq+zHWUVJh3FCV72BNjNor0hr35GniMdUfd5
         7HVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=lG/WAjG9;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=lG/WAjG9;
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
Subject: [PATCH 08/12] staging: iio: tsl2x7x: add error handling to tsl2x7x_prox_cal()
Date: Sat,  3 Mar 2018 20:49:38 -0500
Message-Id: <20180304014942.18727-9-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969941234541013?=
X-GMAIL-MSGID: =?utf-8?q?1593969941234541013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

tsl2x7x_prox_cal() did not have any error checks. This patch adds
the missing error handling and ensures that any errors are reported to
user space via in_proximity0_calibrate_store().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 380a6c96a69a..8adc6db44790 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -807,10 +807,10 @@ static void tsl2x7x_prox_calculate(int *data, int length,
  * Calculates a standard deviation based on the samples,
  * and sets the threshold accordingly.
  */
-static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
+static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 {
 	int prox_history[MAX_SAMPLES_CAL + 1];
-	int i;
+	int i, ret;
 	struct tsl2x7x_prox_stat prox_stat_data[2];
 	struct tsl2x7x_prox_stat *cal;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
@@ -825,25 +825,33 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 	}
 
 	/* have to stop to change settings */
-	tsl2x7x_chip_off(indio_dev);
+	ret = tsl2x7x_chip_off(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	/* Enable proximity detection save just in case prox not wanted yet*/
 	tmp_irq_settings = chip->settings.interrupts_en;
 	chip->settings.interrupts_en |= TSL2X7X_CNTL_PROX_INT_ENBL;
 
 	/*turn on device if not already on*/
-	tsl2x7x_chip_on(indio_dev);
+	ret = tsl2x7x_chip_on(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	/*gather the samples*/
 	for (i = 0; i < chip->settings.prox_max_samples_cal; i++) {
 		usleep_range(15000, 17500);
-		tsl2x7x_get_prox(indio_dev);
+		ret = tsl2x7x_get_prox(indio_dev);
+		if (ret < 0)
+			return ret;
 		prox_history[i] = chip->prox_data;
 		dev_info(&chip->client->dev, "2 i=%d prox data= %d\n",
 			 i, chip->prox_data);
 	}
 
-	tsl2x7x_chip_off(indio_dev);
+	ret = tsl2x7x_chip_off(indio_dev);
+	if (ret < 0)
+		return ret;
 	cal = &prox_stat_data[PROX_STAT_CAL];
 	tsl2x7x_prox_calculate(prox_history,
 			       chip->settings.prox_max_samples_cal, cal);
@@ -857,8 +865,13 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 
 	/* back to the way they were */
 	chip->settings.interrupts_en = tmp_irq_settings;
-	if (current_state == TSL2X7X_CHIP_WORKING)
-		tsl2x7x_chip_on(indio_dev);
+	if (current_state == TSL2X7X_CHIP_WORKING) {
+		ret = tsl2x7x_chip_on(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 
 static ssize_t
@@ -1018,8 +1031,11 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
 	if (strtobool(buf, &value))
 		return -EINVAL;
 
-	if (value)
-		tsl2x7x_prox_cal(indio_dev);
+	if (value) {
+		ret = tsl2x7x_prox_cal(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
-- 
2.14.3
