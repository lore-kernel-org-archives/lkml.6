Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5516C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB812562E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwJCcKft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB812562E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeF3RW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 13:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbeF3RWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 13:22:24 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6765D2561A;
        Sat, 30 Jun 2018 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530379344;
        bh=1SdkLzrB1bmhBKOmUSGb6n3IvNVAm3LQ5CCTRC6FETg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HwJCcKftbAsB0gyse6zY9BehkNaUsChmz8ELw37gabcrU9oMKhHR2UnDCwAmNWlvw
         /ZAioTPitrngxXJC0oGb4AJUHZDyXIYUPOpD39WjYwzYYGsiOdTadETH/uPHQC4enz
         ftKaqKr000d4VPRLQ795HNyoH1qDWmWbbuXeccn8=
Date:   Sat, 30 Jun 2018 18:22:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Karim Eshapa <karim.eshapa@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging:iio:impedance-analyzer:ad5933: Macro
 replacement Cleanups.
Message-ID: <20180630182219.31c668d0@archlinux>
In-Reply-To: <20180625191123.3685-1-karim.eshapa@gmail.com>
References: <20180625191123.3685-1-karim.eshapa@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 21:11:23 +0200
Karim Eshapa <karim.eshapa@gmail.com> wrote:

> Doing some macro replacement to start an array of structures
> so it can be reused by manipulating it with different values.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
There are all sorts of issues with the ABI this driver is providing to
userspace, but this isn't a bad bit of cleanup none the less.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  .../staging/iio/impedance-analyzer/ad5933.c   | 57 +++++++------------
>  1 file changed, 19 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 3bcf49466361..14df89510396 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -116,45 +116,26 @@ static struct ad5933_platform_data ad5933_default_pdata  = {
>  	.vref_mv = 3300,
>  };
>  
> +#define AD5933_CHANNEL(_type, _extend_name, _info_mask_separate, _address, \
> +		_scan_index, _realbits) { \
> +	.type = (_type), \
> +	.extend_name = (_extend_name), \
> +	.info_mask_separate = (_info_mask_separate), \
> +	.address = (_address), \
> +	.scan_index = (_scan_index), \
> +	.scan_type = { \
> +		.sign = 's', \
> +		.realbits = (_realbits), \
> +		.storagebits = 16, \
> +	}, \
> +}
> +
>  static const struct iio_chan_spec ad5933_channels[] = {
> -	{
> -		.type = IIO_TEMP,
> -		.indexed = 1,
> -		.channel = 0,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_SCALE),
> -		.address = AD5933_REG_TEMP_DATA,
> -		.scan_index = -1,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> -	}, { /* Ring Channels */
> -		.type = IIO_VOLTAGE,
> -		.indexed = 1,
> -		.channel = 0,
> -		.extend_name = "real",
> -		.address = AD5933_REG_REAL_DATA,
> -		.scan_index = 0,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 16,
> -			.storagebits = 16,
> -		},
> -	}, {
> -		.type = IIO_VOLTAGE,
> -		.indexed = 1,
> -		.channel = 0,
> -		.extend_name = "imag",
> -		.address = AD5933_REG_IMAG_DATA,
> -		.scan_index = 1,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 16,
> -			.storagebits = 16,
> -		},
> -	},
> +	AD5933_CHANNEL(IIO_TEMP, NULL, BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE), AD5933_REG_TEMP_DATA, -1, 14),
> +	/* Ring Channels */
> +	AD5933_CHANNEL(IIO_VOLTAGE, "real", 0, AD5933_REG_REAL_DATA, 0, 16),
> +	AD5933_CHANNEL(IIO_VOLTAGE, "imag", 0, AD5933_REG_IMAG_DATA, 1, 16),
>  };
>  
>  static int ad5933_i2c_write(struct i2c_client *client, u8 reg, u8 len, u8 *data)

