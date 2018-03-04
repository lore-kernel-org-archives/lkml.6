Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELveQDpF1Gc14/cwHg6GTm/hbu/Iw3yxPU0sALWL+HcpT1Dm6J+4VtXxnwnHA6vEuVaXvmzD
ARC-Seal: i=1; a=rsa-sha256; t=1520128192; cv=none;
        d=google.com; s=arc-20160816;
        b=f6eAovmWe2P1SMYakPt65+NmvAIoUZ/rvm9lbBhUJh1AzDg+ky17yTofPfqvEqo/I/
         oN4FhBVnTeHNUtmizm4OqQqQJkAODUkAvHrpHsbrsNDtohY50RgZi8jjB6qeHILKN6PK
         1JOPwTbkdwl8W93FDkGefRYbmriXHOcH5BwQTR1Mw5+Xyymk2cdZfXhV28LlPH/U1inl
         TvnTut/XKnj5S7C0OAwwL45S+a5e5Xql0n2eM13sRBPg9KxuK3ClbguJ5iad5GUhLDf/
         t3UqjSOWUe7QvEALAne7KIY7OTozWiVVc+vO/LA3iIcdgo1ZjAhzH8yS+4MOioVt2pUm
         MDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=2xkfKFWGtSUpO/x3igpcQp15Gsyne+IFsCXPG/zIVPI=;
        b=0ZAHWifIEuiszL5NfVTwrULhRiQvE2fir5Q/oC7nS6hihG63gCSDCKMTWHznKvdu7O
         3gYz4GNFz5KOcGhqD944XJxhPQVEvrl75FtKWjU/d94DhaODZU26L8QjWUNKt/Rjw6FY
         cNO9TRNiQOoHy9+e2+G87yxQim9ZIjd/sQb4fks4tYt/4QISJWWrGK/93XYCMr7iLu+J
         Se1X9Tkz7rQE7XHX+lT2pflPo4WDU5Fvk6fKTriAAvep9S31FWlClyUgErsgOK2enV/n
         ITJ0qmwJKvKNOzvCnb1DeBG/mZbF/bV39kYy5B0KDFNBgOEhIrb7pVhJ+i/rV2UzYPef
         ACZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=bIg9woLL;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=bIg9woLL;
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
Subject: [PATCH 04/12] staging: iio: tsl2x7x: add common function for writing to the control register
Date: Sat,  3 Mar 2018 20:49:34 -0500
Message-Id: <20180304014942.18727-5-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969939997010070?=
X-GMAIL-MSGID: =?utf-8?q?1593969939997010070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There were four places where the same chunk of code was used to write
to the control register. This patch creates a common function
tsl2x7x_write_control_reg() to reduce duplicate code.

The function tsl2x7x_chip_off() did not correctly return an error
code so this patch also corrects that issue.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 54 +++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 6bb622816660..cf16dd206c0b 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -307,6 +307,21 @@ static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
 	return ret;
 }
 
+static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(chip->client,
+					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, data);
+	if (ret < 0) {
+		dev_err(&chip->client->dev,
+			"%s: failed to write to control register %x: %d\n",
+			__func__, data, ret);
+	}
+
+	return ret;
+}
+
 /**
  * tsl2x7x_get_lux() - Reads and calculates current lux value.
  * @indio_dev:	pointer to IIO device
@@ -597,7 +612,6 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	int i;
 	int ret = 0;
 	u8 *dev_reg;
-	u8 utmp;
 	int als_count;
 	int als_time;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
@@ -659,14 +673,9 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	 * TSL2X7X Specific power-on / adc enable sequence
 	 * Power on the device 1st.
 	 */
-	utmp = TSL2X7X_CNTL_PWR_ON;
-	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, utmp);
-	if (ret < 0) {
-		dev_err(&chip->client->dev,
-			"%s: failed on CNTRL reg.\n", __func__);
+	ret = tsl2x7x_write_control_reg(chip, TSL2X7X_CNTL_PWR_ON);
+	if (ret < 0)
 		return ret;
-	}
 
 	/*
 	 * Use the following shadow copy for our delay before enabling ADC.
@@ -691,16 +700,12 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	 * NOW enable the ADC
 	 * initialize the desired mode of operation
 	 */
-	utmp = TSL2X7X_CNTL_PWR_ON |
-			TSL2X7X_CNTL_ADC_ENBL |
-			TSL2X7X_CNTL_PROX_DET_ENBL;
-	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, utmp);
-	if (ret < 0) {
-		dev_err(&chip->client->dev,
-			"%s: failed on 2nd CTRL reg.\n", __func__);
+	ret = tsl2x7x_write_control_reg(chip,
+					TSL2X7X_CNTL_PWR_ON |
+					TSL2X7X_CNTL_ADC_ENBL |
+					TSL2X7X_CNTL_PROX_DET_ENBL);
+	if (ret < 0)
 		return ret;
-	}
 
 	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
 
@@ -713,13 +718,9 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 			reg_val |= TSL2X7X_CNTL_PROX_DET_ENBL;
 
 		reg_val |= chip->settings.interrupts_en;
-		ret = i2c_smbus_write_byte_data(chip->client,
-						TSL2X7X_CMD_REG | TSL2X7X_CNTRL,
-						reg_val);
+		ret = tsl2x7x_write_control_reg(chip, reg_val);
 		if (ret < 0)
-			dev_err(&chip->client->dev,
-				"%s: failed in tsl2x7x_IOCTL_INT_SET.\n",
-				__func__);
+			return ret;
 
 		ret = tsl2x7x_clear_interrupts(chip,
 					       TSL2X7X_CMD_PROXALS_INT_CLR);
@@ -732,16 +733,11 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 
 static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
 {
-	int ret;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 
 	/* turn device off */
 	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;
-
-	ret = i2c_smbus_write_byte_data(chip->client,
-					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, 0x00);
-
-	return ret;
+	return tsl2x7x_write_control_reg(chip, 0x00);
 }
 
 /**
-- 
2.14.3
