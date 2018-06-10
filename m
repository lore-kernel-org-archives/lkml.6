Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cv4tEI2nHVuEVgAAmS7hNA
	; Sun, 10 Jun 2018 22:34:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2D28460792; Sun, 10 Jun 2018 22:34:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AB31A601D2;
	Sun, 10 Jun 2018 22:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB31A601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753624AbeFJWeu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 18:34:50 -0400
Received: from smtprelay0062.hostedemail.com ([216.40.44.62]:50168 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753486AbeFJWes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 18:34:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 92C24100E86C3;
        Sun, 10 Jun 2018 22:34:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cast97_c79105329649
X-Filterd-Recvd-Size: 2945
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 Jun 2018 22:34:45 +0000 (UTC)
Message-ID: <f32e6e86a92c76ca2fab2abbf3ae3f454afbe72e.camel@perches.com>
Subject: Re: [PATCH] staging:iio:accel: use sign extend function avoiding
 code duplication
From: Joe Perches <joe@perches.com>
To: Karim Eshapa <karim.eshapa@gmail.com>, lars@metafoo.de,
        Himanshu Jha <himanshujha199640@gmail.com>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date: Sun, 10 Jun 2018 15:34:44 -0700
In-Reply-To: <20180610220920.12244-1-karim.eshapa@gmail.com>
References: <20180610220920.12244-1-karim.eshapa@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-11 at 00:09 +0200, Karim Eshapa wrote:
> Use sign_extend32 kernel function instead of code duplication.
> This function is also safe for 16 bits.

Firstly:

This file is not in staging anymore.
Please use the -next tree for patches.

> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
[]
> @@ -227,9 +227,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, bits);
>  		return IIO_VAL_INT;
>  	}

Secondly:

A similar patch with a different bits value was
already applied.

Please verify the appropriate bits value.

commit e7f3bfb7eb7d9307c0c157f82fceb228f0aec1d9
Author: Himanshu Jha <himanshujha199640@gmail.com>
Date:   Sat Mar 17 01:36:23 2018 +0530

    Staging: iio: accel: adis16201: Use sign_extend32 function
    
    Use sign_extned32() for 32 bit sign extending rather than hard coding.
    
    Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
    Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/adis16201.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 87ad3d421c12..526dde481f84 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -173,9 +173,8 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+
+		*val = sign_extend32(val16, bits - 1);
                return IIO_VAL_INT;
        }
 
