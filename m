Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELtqlCZ4gLjsQ2pDYO8/apxQQrVib9InrBs7CG+zi8SYYLgqA4sCt1q6vJmi5JFHcQ9Caagc
ARC-Seal: i=1; a=rsa-sha256; t=1520128195; cv=none;
        d=google.com; s=arc-20160816;
        b=j7J5Myb6Y3p9u+D2vDXrRFrDINEVN9Ono84qKZkUbnY7eUIONa8ALZbDg3221BgPGP
         u5uEKwlSzTwz1Iq9lB0j5ILYN94Rkjb6DCG01c8Z7FOFYWk5V3HWfDaOSYRsRXZgzKKj
         i4r4QMsT/m9Ts9+jbyF5r+XkZuBs+hGJUyalB8O7k/mTWUCoSXTnL2/lpMBJbvNsa7V5
         oLDtu4nsrbPJA7PqKl/DFt3QM+OpWWtq7Kszb/dTcApFxkc0whrfLbPd3Gp8l9/QGayh
         q1maMOWFv3tYifSQBcaE04XUtpmjr8uvyMyRV1WNqkKkydrEXgNBHJ9jkN4T42jXMPNk
         Nc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=5NwMJXbYrjrKmOo5TzXhu5/5XsfUzLAjgxKMHNWN1ms=;
        b=B/Hy4LEdH5ksYB8FOpzECTmzU36b7u/9wXUav3WJIv0Coabcx8Y93n8j383o9OQG0D
         s5sgLK9jEGU9WWwFNf4OJ+w/n9pULwiRpkLXTvaMAYlMpa7TKnejVT4gsnv/ZzmEnEgB
         c//vRlM1oqasO5YpjmYIxsfiD7Y524jAHgEEk5N781fhflu8lmKjceqi9m7egEH4w1Z2
         YPHPqyuQsw5NeNEWv2ieBOfVvr15tCIJ+Td5m7fBD/ohesErnqDJMjsspNJ7IyPRSsUY
         8yPig4/gs/R93QvFvw5GjnjKHQRvLi5QUo36AzmW1MtZwtYx2IvTQbHWb4EJKunK2r4m
         nYqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=vgKVeT4Q;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=vgKVeT4Q;
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
Subject: [PATCH 12/12] staging: iio: tsl2x7x: make proximity sensor function correctly
Date: Sat,  3 Mar 2018 20:49:42 -0500
Message-Id: <20180304014942.18727-13-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969943189282236?=
X-GMAIL-MSGID: =?utf-8?q?1593969943189282236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The bits for setting up the proximity diode were not setup correctly and
this was causing the proximity sensor to not function correctly. This
patch sets up the correct bit mask in tsl2x7x_chip_on() based on what
the data sheet expects. From page 35 of the TSL2771 data sheet:
https://ams.com/eng/content/download/250264/976045/file/TSL2771_DS000105_3-00.pdf

- Bits 0-1 is the ALS gain control
- Bits 2-3 is reserved (The proximity gain control on other tsl2x7x chips)
- Bits 4-5 is the proximity diode select
- Bits 6-7 is the LED drive strength

tsl2x7x_chip_on() had the power and diode hardcoded, so these are
extracted out into the settings so that these fields can be configured
in the platform data.

The default prox_gain is changed from 1 (2X gain) to 0 (1X gain) since
the proximity gain control on the TSL2771, TMD2771, and other chips have
these fields listed as reserved, and to write 0 into those bits.

Verified that the proximity sensor now works correctly on a TSL2771
hooked up to a Raspberry Pi 2.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 25 ++++++++++++++-----------
 drivers/staging/iio/light/tsl2x7x.h |  2 ++
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 8c29a52153c1..ab518cdec43e 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -109,15 +109,15 @@
 #define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
 
 /*Prox diode to use */
-#define TSL2X7X_DIODE0			0x10
-#define TSL2X7X_DIODE1			0x20
-#define TSL2X7X_DIODE_BOTH		0x30
+#define TSL2X7X_DIODE0			0x01
+#define TSL2X7X_DIODE1			0x02
+#define TSL2X7X_DIODE_BOTH		0x03
 
 /* LED Power */
 #define TSL2X7X_100_mA			0x00
-#define TSL2X7X_50_mA			0x40
-#define TSL2X7X_25_mA			0x80
-#define TSL2X7X_13_mA			0xD0
+#define TSL2X7X_50_mA			0x01
+#define TSL2X7X_25_mA			0x02
+#define TSL2X7X_13_mA			0x03
 #define TSL2X7X_MAX_TIMER_CNT		0xFF
 
 #define TSL2X7X_MIN_ITIME		3
@@ -228,7 +228,7 @@ static const struct tsl2x7x_settings tsl2x7x_default_settings = {
 	.als_time = 219, /* 101 ms */
 	.als_gain = 0,
 	.prx_time = 254, /* 5.4 ms */
-	.prox_gain = 1,
+	.prox_gain = 0,
 	.wait_time = 245,
 	.prox_config = 0,
 	.als_gain_trim = 1000,
@@ -240,7 +240,9 @@ static const struct tsl2x7x_settings tsl2x7x_default_settings = {
 	.prox_thres_low  = 0,
 	.prox_thres_high = 512,
 	.prox_max_samples_cal = 30,
-	.prox_pulse_count = 8
+	.prox_pulse_count = 8,
+	.prox_diode = TSL2X7X_DIODE1,
+	.prox_power = TSL2X7X_100_mA
 };
 
 static const s16 tsl2x7x_als_gain[] = {
@@ -664,9 +666,10 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 
 	/* Set the gain based on tsl2x7x_settings struct */
 	chip->tsl2x7x_config[TSL2X7X_GAIN] =
-		chip->settings.als_gain |
-			(TSL2X7X_100_mA | TSL2X7X_DIODE1) |
-			(chip->settings.prox_gain << 2);
+		(chip->settings.als_gain & 0xFF) |
+		((chip->settings.prox_gain & 0xFF) << 2) |
+		(chip->settings.prox_diode << 4) |
+		(chip->settings.prox_power << 6);
 
 	/* set chip struct re scaling and saturation */
 	chip->als_saturation = als_count * 922; /* 90% of full scale */
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index 6624cbca7a83..28b0e7fdc9b8 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -78,6 +78,8 @@ struct tsl2x7x_settings {
 	int prox_thres_high;
 	int prox_pulse_count;
 	int prox_max_samples_cal;
+	int prox_diode;
+	int prox_power;
 };
 
 /**
-- 
2.14.3
