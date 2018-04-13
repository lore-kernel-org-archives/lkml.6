Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637465; cv=none;
        d=google.com; s=arc-20160816;
        b=BgS236gNsEvg+W1S2gt9CfSChcQolpdf32R1Z890kZwWX7GPwbkl5CkDzkqctve/5A
         hqdMXpZ89paZYdYH0EuDr0o0wEQ9AYbOS/ShYzwmv625zgUeOuBXCuhIK6wp8xOW52EH
         HHVOLVCrETZdioJ3Q/Nu5IMte5S6rEg+wrLeGFV270JJR8nWSkq7A9LBG/10Xu9skkrj
         E/KrvBEe+fkocougbFQgVLjfugCR3sWX1ixa+EwKupeiRzjY1pUYevNf7BPyqMDhiGfx
         jA8+cVoU6RBK4jKDXovX/A8AiG2rQ8I9h01QbvUBaWsoxur6GPvSi8c1uiI3XewOt3d7
         QAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=AQ+TIPQWmENrQncV6f3ZGjV/67cQJ+PcqdWnTWyhAFM=;
        b=zHRf/EBJJovy9AmK/64lLWBygn9oqvEHJ5on1OMr1Wqko5qtAcGsVkmxbe18YOaYUr
         rSiKdBKUmA13Y9ZaUsRywNzpH/uqcouAui6k3uZEkSxq1Xny4gJ9JlCTLXYFGQrlafkF
         m31xlyLKMO+D3r9LgpahoJzEzU3nWATAqG4JdLV/22NkAhQKFFW246Tjg656pXYZ4x7R
         QcZMmgH/km6nmFSAVNdgKAiuEaG3UqsNlwOqk3G68VeXQb22+IeiBwL13WuU5FIUSv/d
         AkmBQlviz5VEtA125iq8AkMlSCorO1DogNshkTYsltFAOClZd4j8qnh0xtFOgntkMxcD
         vw9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=Xbgltohd;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=Xbgltohd;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx48W6HGKxbDU/0ZgP1Nt8slwWI/8unAQZzVZcgleOcT0GjGmePdfF7PcM8uswdyJbLZWd0t69A==
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
Subject: [PATCH v2 01/14] staging: iio: ad7746: Automatically swap values in readings/writings
Date: Fri, 13 Apr 2018 13:36:38 -0300
Message-Id: <1523637411-8531-2-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649678648759937?=
X-GMAIL-MSGID: =?utf-8?q?1597649678648759937?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Data to read or write was being handled with the swab16() macro instead
of using i2c_smbus_{read,write}_swapped.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 4882dbc..53e28ae 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -451,7 +451,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
-		ret = i2c_smbus_write_word_data(chip->client, reg, swab16(val));
+		ret = i2c_smbus_write_word_swapped(chip->client, reg, val);
 		if (ret < 0)
 			goto out;
 
@@ -462,8 +462,8 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = i2c_smbus_write_word_data(chip->client,
-				AD7746_REG_CAP_OFFH, swab16(val));
+		ret = i2c_smbus_write_word_swapped(chip->client,
+						   AD7746_REG_CAP_OFFH, val);
 		if (ret < 0)
 			goto out;
 
@@ -594,21 +594,21 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
-		ret = i2c_smbus_read_word_data(chip->client, reg);
+		ret = i2c_smbus_read_word_swapped(chip->client, reg);
 		if (ret < 0)
 			goto out;
 		/* 1 + gain_val / 2^16 */
 		*val = 1;
-		*val2 = (15625 * swab16(ret)) / 1024;
+		*val2 = (15625 * ret) / 1024;
 
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		ret = i2c_smbus_read_word_data(chip->client,
-					       AD7746_REG_CAP_OFFH);
+		ret = i2c_smbus_read_word_swapped(chip->client,
+						  AD7746_REG_CAP_OFFH);
 		if (ret < 0)
 			goto out;
-		*val = swab16(ret);
+		*val = ret;
 
 		ret = IIO_VAL_INT;
 		break;
-- 
2.7.4
