Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELs2x8olMyqjts2Hnezhu6N0mGFY/SmjJ1/ZCxJJ5qI8pDL32+NdPJI7k5EtSV9NKGEBVMYs
ARC-Seal: i=1; a=rsa-sha256; t=1520128191; cv=none;
        d=google.com; s=arc-20160816;
        b=m/T3xW1U/93CK1VFfrb2cslC2wGDxl8fDR2unX803KoD+5+HDeqnDYklJo6O3HbEUW
         6yYiSX/FYh4aP7sSXHgk+Zpnl3/+Bou2HyLN/vWokWyHQy2gZ9mhLJu8oUKcR4ouoXNO
         7QTpOhvuWuqNxcxhZrFZBoH9w1FYmCCkMvRwFZgDPNZ3IGfNkDu6Q8zhrxYczuU+Q6Lb
         RWLiBCsZPW+he3o/tw0fUzwdxiBo9cyOmC+uNn0yvukrkrhVWN6nErCTs+a7+pKSKpyC
         XLgJJCc8bMKuV0d7T+LZypkVzKI8s6rGfdtuqbkOptmMx5aP/m+/uKn56Qs1lAHrz0GH
         XkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6jqdU2j6OfR8g9sx+AXIpF9cxDyQ2BuDQMaPj2X2wCI=;
        b=hzGmU20iAdU9/TfhUdFqi7gRmSn1mUkWZcpLmFJa5TE1WKOOxaXFSQhQMYMk2w/svt
         X/iW56SpkT3kOzaptvOdW8+yZ0uy1zYtuUhr/EgOf1CXiuiOhQ2x6viCFmarDZqfQ6AA
         JAgzwCMTvkCvfIvRhVPYcwt3FySJsewO4Ryv04/rhoz7fbRR3y5Fe/vNyA4XWGZ34Twg
         fXBFrNn4kFtZu7VCRl+/Jx7GsrfM2zfpH7NpqWP0HQv06La0bNsvMgv1Esmt3MdaizwU
         1uU5dIqlEXtYAao814BxLFws3+ADUz+ZO3HCX7w6NlnHizrKAhn9InTWVdfVkiT0MbLP
         RW9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=JvmTFlUq;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=JvmTFlUq;
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
Subject: [PATCH 02/12] staging: iio: tsl2x7x: add common function for clearing interrupts
Date: Sat,  3 Mar 2018 20:49:32 -0500
Message-Id: <20180304014942.18727-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969938624244484?=
X-GMAIL-MSGID: =?utf-8?q?1593969938624244484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There were three places where the same chunk of code was used to clear
interrupts. This patch creates a common function
tsl2x7x_clear_interrupts() to reduce duplicate code.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 52 +++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index b7e3f966c3a6..c02db03ef369 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -279,6 +279,20 @@ static const u8 device_channel_config[] = {
 	ALSPRX2
 };
 
+static int tsl2x7x_clear_interrupts(struct tsl2X7X_chip *chip, int reg)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte(chip->client,
+				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN | reg);
+	if (ret < 0)
+		dev_err(&chip->client->dev,
+			"%s: failed to clear interrupt status %x: %d\n",
+			__func__, reg, ret);
+
+	return ret;
+}
+
 /**
  * tsl2x7x_get_lux() - Reads and calculates current lux value.
  * @indio_dev:	pointer to IIO device
@@ -346,16 +360,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 		buf[i] = ret;
 	}
 
-	/* clear any existing interrupt status */
-	ret = i2c_smbus_write_byte(chip->client,
-				   TSL2X7X_CMD_REG |
-				   TSL2X7X_CMD_SPL_FN |
-				   TSL2X7X_CMD_ALS_INT_CLR);
-	if (ret < 0) {
-		dev_err(&chip->client->dev,
-			"i2c_write_command failed - err = %d\n", ret);
-		goto out_unlock; /* have no data, so return failure */
-	}
+	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_ALS_INT_CLR);
+	if (ret < 0)
+		goto out_unlock;
 
 	/* extract ALS/lux data */
 	ch0 = le16_to_cpup((const __le16 *)&buf[0]);
@@ -706,17 +713,10 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 				"%s: failed in tsl2x7x_IOCTL_INT_SET.\n",
 				__func__);
 
-		/* Clear out any initial interrupts  */
-		ret = i2c_smbus_write_byte(chip->client,
-					   TSL2X7X_CMD_REG |
-					   TSL2X7X_CMD_SPL_FN |
-					   TSL2X7X_CMD_PROXALS_INT_CLR);
-		if (ret < 0) {
-			dev_err(&chip->client->dev,
-				"%s: Failed to clear Int status\n",
-				__func__);
-		return ret;
-		}
+		ret = tsl2x7x_clear_interrupts(chip,
+					       TSL2X7X_CMD_PROXALS_INT_CLR);
+		if (ret < 0)
+			return ret;
 	}
 
 	return ret;
@@ -1421,14 +1421,10 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 						    IIO_EV_DIR_EITHER),
 			       timestamp);
 	}
-	/* Clear interrupt now that we have handled it. */
-	ret = i2c_smbus_write_byte(chip->client,
-				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN |
-				   TSL2X7X_CMD_PROXALS_INT_CLR);
+
+	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
 	if (ret < 0)
-		dev_err(&chip->client->dev,
-			"Failed to clear irq from event handler. err = %d\n",
-			ret);
+		return ret;
 
 	return IRQ_HANDLED;
 }
-- 
2.14.3
