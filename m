Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F61C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384082170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384082170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeHTTDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:03:24 -0400
Received: from www381.your-server.de ([78.46.137.84]:50436 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeHTTDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:03:24 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1frmOb-0003ZZ-Q3; Mon, 20 Aug 2018 17:47:09 +0200
Received: from [2003:93:4e1f:ab00:8200:bff:fe9b:6612]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1frmOb-000Ito-KN; Mon, 20 Aug 2018 17:47:09 +0200
Subject: Re: [PATCH 1/3] iio: adxl372: Provide validate_trigger and
 validate_device callbacks
To:     Stefan Popa <stefan.popa@analog.com>, jic23@kernel.org
Cc:     Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534776823-18703-1-git-send-email-stefan.popa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1fc5f7bb-67d1-fa03-2242-b38b94a151ee@metafoo.de>
Date:   Mon, 20 Aug 2018 17:47:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534776823-18703-1-git-send-email-stefan.popa@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.1/24859/Mon Aug 20 10:44:44 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 04:53 PM, Stefan Popa wrote:
> This patch provides a validate_device callback for the trigger which makes
> sure that other devices are rejected.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com
> ---
>  drivers/iio/accel/adxl372.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index d2fdc75..5a039ba 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -762,11 +762,24 @@ static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
>  	return adxl372_set_interrupts(st, mask, 0);
>  }
>  
> +static int adxl372_validate_trigger(struct iio_dev *indio_dev,
> +				    struct iio_trigger *trig)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +
> +	if (st->dready_trig != trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static const struct iio_trigger_ops adxl372_trigger_ops = {
> +	.validate_device = &iio_trigger_validate_own_device,
>  	.set_trigger_state = adxl372_dready_trig_set_state,
>  };
>  
>  static const struct iio_info adxl372_info = {
> +	.validate_trigger = &adxl372_validate_trigger,

I wonder, if the device only works with the trigger and the trigger only
works with the device should we actually register a trigger?

Seems to be just extra hassle when setting up the device without any extra
benefits.
