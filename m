Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637515; cv=none;
        d=google.com; s=arc-20160816;
        b=qwYTFNEA8wWldnW7K5SDa/CRTLmS7pO+uIftdlRhTaT/T1MjtEJas89lFvObu5YGFC
         gePIX32HzncEbIOPMOmWpcd5oaMTYDPc3wtdL62FTgP+GZ+ySVGxCdAFNMgEo+2bnKtQ
         wwxkBTIGVYMGrkbK250OkvlWWh/ekQ4qpu50Flv3kuT75Avke8b//nSJE2kgMyTabAdO
         mFqCm6KSDH90yaiQ8rFCaz4dohZ7rjBk7VGViaCGXjhDLVgSGjNT+yewui31DuJshQf6
         Hg59L9mPYQt9b6olrGUHw+X8HC0r7HXQGeB91OjT8w1r+JhSX2aEnmjwrj98Su/EzAs5
         J0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=g7nGO8bR3Zc6fs6EfJAtMeq6spNuLwzu3LhfHYcCQRY=;
        b=IPi9bAhPIjlXHLod1pLdDPjayBXcOFp4X7clD/PdqcRrste0/ZgtqP4YCR/+0aJOYo
         JBQ3U5vp8KrM15r0q9jzVF692al/eq3z5s3gU7pDg0lWAPWySLz9hRZVGlUu1V7HOSsh
         TCMdnaLgyrjq6vfTDbw7LsGMKYusYkA6c7RBN26nVqZ5YNR5G6z1wawMu581J576aSRs
         XjiuBdiSUzTMSv2vlebBUC5BAdYzrlYTPVlDH7IXlLtf6/uw31U8VqqKgvf8OnJNpvwD
         e9/gBonmDvyXM2tJ+wN+yDjVxwag9LdnTekR5Jg0YcGl7IST2EZxsrspYIUbBmg1+Hwa
         SlfA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=WZAik8LO;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=WZAik8LO;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx48x+4Huz3JKhhRp9Cc3xkuvOUiqFzK4XnzHXpRFw+y98q9EnENlHmQkDkZ2pmQiG8j+jtMfvA==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 09/14] staging: iio: ad7746: Add remove()
Date: Fri, 13 Apr 2018 13:36:46 -0300
Message-Id: <1523637411-8531-10-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649731441296741?=
X-GMAIL-MSGID: =?utf-8?q?1597649731441296741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This allows the driver to be probed and removed as a module powering it
down on remove().

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index c29a221..05506bf9 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -775,6 +775,31 @@ static int ad7746_probe(struct i2c_client *client,
 	return 0;
 }
 
+static int ad7746_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ad7746_chip_info *chip = iio_priv(indio_dev);
+	unsigned char regval;
+	int ret;
+
+	mutex_lock(&chip->lock);
+
+	regval = chip->config | AD7746_CONF_MODE_PWRDN;
+	ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
+
+	mutex_unlock(&chip->lock);
+
+	if (ret < 0) {
+		dev_warn(&client->dev, "Could NOT Power Down!\n");
+		goto out;
+	}
+
+	iio_device_unregister(indio_dev);
+
+out:
+	return ret;
+}
+
 static const struct i2c_device_id ad7746_id[] = {
 	{ "ad7745", 7745 },
 	{ "ad7746", 7746 },
@@ -799,6 +824,7 @@ static struct i2c_driver ad7746_driver = {
 		.of_match_table = of_match_ptr(ad7746_of_match),
 	},
 	.probe = ad7746_probe,
+	.remove = ad7746_remove,
 	.id_table = ad7746_id,
 };
 module_i2c_driver(ad7746_driver);
-- 
2.7.4
