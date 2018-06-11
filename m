Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0CD67C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC40A20839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC40A20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933334AbeFKX53 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 19:57:29 -0400
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:48610 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932300AbeFKX52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 19:57:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 2ECED1801E309;
        Mon, 11 Jun 2018 23:57:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cry03_40d20f7422201
X-Filterd-Recvd-Size: 2051
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 Jun 2018 23:57:25 +0000 (UTC)
Message-ID: <48143872d69d231273bd2c8ed835cbf0046a263d.camel@perches.com>
Subject: Re: [PATCH] staging:iio:accel:adis16240: sign extend function
 avoiding code duplication
From:   Joe Perches <joe@perches.com>
To:     Karim Eshapa <karim.eshapa@gmail.com>, lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Jun 2018 16:57:24 -0700
In-Reply-To: <20180611233814.18597-1-karim.eshapa@gmail.com>
References: <20180611233814.18597-1-karim.eshapa@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 01:38 +0200, Karim Eshapa wrote:
> Use sign_extend32 kernel function instead of code duplication.
> Safe also for 16 bit.

Perhaps remove the bits declaration and assignments
and just use 9 directly.

> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
[]
> @@ -292,9 +292,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, bits - 1);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_PEAK:
>  		bits = 10;
> @@ -302,9 +300,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, bits - 1);
>  		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;
