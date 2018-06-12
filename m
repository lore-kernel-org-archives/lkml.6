Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 70D54C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6A5208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeBYaZXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6A5208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934321AbeFLQWD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:22:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40092 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933792AbeFLQWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:22:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id l41-v6so24728090wre.7;
        Tue, 12 Jun 2018 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SD/vkKHHe7VcwOgHxPuKmedkuT8iyzrA6ySLSwiuTjg=;
        b=CeBYaZXtTxoZnvDWBeFC8jqDZAvf0eDGl/5WVQrRrVKD/H3HN9zuEquL0HkTsaqe6S
         sN5BCdMJCdKhrPNFugfFDvS+UTCHk/LMkM0hMPtcAttEgoRPy6TPYMeq9PfKSeyiI+lU
         Z7InJQ9gndcdGV18HcuGV54QkYDWSWdGp9jz8ZxwZFc1IbOBINSzBWg1htOzs6uva+VN
         8+IahUTtjVCPnE5cZEM5MlOnynQ6thyIRtB9lWQdkfEIfdza8Agrg2Uxfu9m150pWtPy
         xsGN9XpE6dZlNurmivjzMruZ/yLLXOtmZc3xfMUT3XJ5vcT5eImVSeeQw+8TG3w9/no1
         OSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SD/vkKHHe7VcwOgHxPuKmedkuT8iyzrA6ySLSwiuTjg=;
        b=Sk9VLjnghnJljLamMWnYp2JDw1UdyUPKtvktSKLyKNVPnYJuVNfrLT8Ymdzn34dW6w
         xztO5KqhOShTTrDnjjyFV3YXuKPo4+vYKovUPITz0sVz9ORd2ojaAcGR0/m7BogG+gcW
         0RlD3SrJfW2ddrxlcTlzO4u5w7ptjAbvHbAzmDNmpZe0Aab9z+ie9qFWKEoj+cz2pRaO
         zW5Q22JuXZB8ie+sbSMJG1GS72/KX/3sxW6Ghv5InpA7nkkquYs2CZcN2jHM9S9W+0Z9
         TCX3cTIQ59rvzaejKHlAwVc5d4V2IbaAxGM03zsrDxT0hEkAh+qZ7UzNUrfKKFRwTAEx
         tYZw==
X-Gm-Message-State: APt69E2Y2Dm+U5n8/wpNvFqaabaQtOUFx16bw4X0KJ/zWj4VfAC28fcR
        +89HvgCod4HPkAahi3IE1HI=
X-Google-Smtp-Source: ADUXVKL+3jBGk4svywO8TZy+gpbDKq/V2/zZCPu5CopS3796fBPuhnJuJsATqxpgW4sk1e/+AfJlEw==
X-Received: by 2002:adf:fd88:: with SMTP id d8-v6mr800943wrr.276.1528820519977;
        Tue, 12 Jun 2018 09:21:59 -0700 (PDT)
Received: from localhost.localdomain ([197.54.242.32])
        by smtp.gmail.com with ESMTPSA id o13-v6sm557959wmc.8.2018.06.12.09.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 09:21:58 -0700 (PDT)
From:   Karim Eshapa <karim.eshapa@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH v2] staging:iio:accel:adis16240: sign extend function avoiding code duplication
Date:   Tue, 12 Jun 2018 18:21:53 +0200
Message-Id: <20180612162153.21789-1-karim.eshapa@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sign_extend32 kernel function instead of code duplication,
Safe also for 16 bit. and remove declaration of bits variable not needed.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>

>On Tue, 2018-06-12 at 01:38 +0200, Karim Eshapa wrote:
>> Use sign_extend32 kernel function instead of code duplication.
>> Safe also for 16 bit.
>
>Perhaps remove the bits declaration and assignments
>and just use 9 directly.
>
>> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
>
>> @@ -292,9 +292,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>>               ret = adis_read_reg_16(st, addr, &val16);
>>               if (ret)
>>                       return ret;
>> -             val16 &= (1 << bits) - 1;
>> -             val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>> -             *val = val16;
>> +             *val = sign_extend32(val16, bits - 1);
>>               return IIO_VAL_INT;
>>       case IIO_CHAN_INFO_PEAK:
>>               bits = 10;
>> @@ -302,9 +300,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>>               ret = adis_read_reg_16(st, addr, &val16);
>>               if (ret)
>>                       return ret;
>> -             val16 &= (1 << bits) - 1;
>> -             val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>> -             *val = val16;
>> +             *val = sign_extend32(val16, bits - 1);
>>               return IIO_VAL_INT;
>>       }
>>       return -EINVAL;
---
 drivers/staging/iio/accel/adis16240.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index fff6d99089cc..24e525f1ef25 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -250,7 +250,6 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 {
 	struct adis *st = iio_priv(indio_dev);
 	int ret;
-	int bits;
 	u8 addr;
 	s16 val16;
 
@@ -287,24 +286,18 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		*val = 25000 / 244 - 0x133; /* 25 C = 0x133 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		bits = 10;
 		addr = adis16240_addresses[chan->scan_index][0];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, 9);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PEAK:
-		bits = 10;
 		addr = adis16240_addresses[chan->scan_index][1];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, 9);
 		return IIO_VAL_INT;
 	}
 	return -EINVAL;
-- 
2.17.1

