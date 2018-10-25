Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BD9C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFD420831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFD420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJYWLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:11:30 -0400
Received: from www381.your-server.de ([78.46.137.84]:43548 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeJYWLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:11:30 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1gFfqO-0000Pk-P4; Thu, 25 Oct 2018 15:38:36 +0200
Received: from [2003:93:4d12:1e00:8200:bff:fe9b:6612]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1gFfqO-0008PH-GZ; Thu, 25 Oct 2018 15:38:36 +0200
Subject: Re: [PATCH] staging: iio: ad7780: update voltage on read
To:     Renato Lui Geh <renatogeh@gmail.com>, Michael.Hennerich@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, alexandru.Ardelean@analog.com,
        stefan.popa@analog.com, giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
References: <20181025133223.kn7cjlyep7bmx2mm@renatolg>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c958f5fc-2a58-8471-62a4-20b0c7267bd0@metafoo.de>
Date:   Thu, 25 Oct 2018 15:38:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025133223.kn7cjlyep7bmx2mm@renatolg>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.2/25067/Wed Oct 24 23:01:03 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 03:32 PM, Renato Lui Geh wrote:
> The ad7780 driver previously did not read the correct device output.
> This patch fixes two issues.
> 
> - The driver read an outdated value set at initialization. It now
> updates its voltage on read.
> - Variable val subtracted an uninitialized value on
> IIO_CHAN_INFO_OFFSET. This was fixed by assiging the correct value
> instead.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>

Hi,

Thanks for the patch, this looks good.

But please create one patch per issue and do not put unrelated changes into
the same patch.

Also your mail client seems to have replaced tabs in the patch with spaces,
this means the patch will not apply cleanly. Check the
Documentation/email-clients.txt file for some hints how to configure your
mail client so it will not break patches.

- Lars

> ---
> drivers/staging/iio/adc/ad7780.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c
> b/drivers/staging/iio/adc/ad7780.c
> index b67412db0318..06700fe554a2 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -87,16 +87,20 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
>                long m)
> {
>     struct ad7780_state *st = iio_priv(indio_dev);
> +    int voltage_uv = 0;
> 
>     switch (m) {
>     case IIO_CHAN_INFO_RAW:
>         return ad_sigma_delta_single_conversion(indio_dev, chan, val);
>     case IIO_CHAN_INFO_SCALE:
> +        voltage_uv = regulator_get_voltage(st->reg);
> +        if (voltage_uv)
> +            st->int_vref_mv = voltage_uv/1000;
>         *val = st->int_vref_mv * st->gain;
>         *val2 = chan->scan_type.realbits - 1;
>         return IIO_VAL_FRACTIONAL_LOG2;
>     case IIO_CHAN_INFO_OFFSET:
> -        *val -= (1 << (chan->scan_type.realbits - 1));
> +        *val = -(1 << (chan->scan_type.realbits - 1));
>         return IIO_VAL_INT;
>     }
> 

