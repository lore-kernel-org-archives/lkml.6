Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7977DC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCB220870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xHvPtStW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCB220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJ2AlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 20:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeJ2AlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 20:41:16 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1FCD20843;
        Sun, 28 Oct 2018 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540742177;
        bh=9m3t/3LtuQuhc1+fao5lCvlyVDiqyVIY2vIK0UVsXQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xHvPtStWiJjF1gH3j1ESTr4vo14hSqeKrJacAult870ja1WZoJnThJUFLAf6bVQ4O
         iKptqeHS+XdU9xFaqlPArwq4k2LfyXLlsbYUWA6w0u6KPZuH4g8eefYIkKC5Ldluc+
         ++2CKTCubltxewD07hg+LxvJ79X9zfS1YgADCpvo=
Date:   Sun, 28 Oct 2018 15:56:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: update voltage on read
Message-ID: <20181028155611.67abeafb@archlinux>
In-Reply-To: <1f7b2c6ee0e18b1c43a8b27f482b08313c52d4e9.1540506298.git.renatogeh@gmail.com>
References: <cover.1540506298.git.renatogeh@gmail.com>
        <1f7b2c6ee0e18b1c43a8b27f482b08313c52d4e9.1540506298.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 19:30:04 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> The ad7780 driver previously did not read the correct device output, as
> it read an outdated value set at initialization. It now updates its
> voltage on read.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7780.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index b67412db0318..27972563bb6a 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -87,11 +87,15 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad7780_state *st = iio_priv(indio_dev);
> +	int voltage_uv = 0;
No initialization needed as it is always set in the paths where it is used
(before it is used).
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
>  		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
>  	case IIO_CHAN_INFO_SCALE:
> +		voltage_uv = regulator_get_voltage(st->reg);
> +		if (voltage_uv)
> +			st->int_vref_mv = voltage_uv/1000;
>  		*val = st->int_vref_mv * st->gain;
Is there actually a reason (now) to have the stashed value
of int_vref_mv in the state structure?

Also, I think we are always replacing the value that is retrieved
in probe so we can drop reading it there as well.

Thanks,

Jonathan

>  		*val2 = chan->scan_type.realbits - 1;
>  		return IIO_VAL_FRACTIONAL_LOG2;

