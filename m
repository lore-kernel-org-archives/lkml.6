Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD73C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24B62147E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnNI0E7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24B62147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeHYM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbeHYM0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:26:02 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BBE621477;
        Sat, 25 Aug 2018 08:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535186865;
        bh=r1HLz70+/YUxsTyyYVX3Vcie3xf+ZixZI4ziD0a+qg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mnNI0E7QdebK/j4keCHnnScyZRpbWzbYBIvH5nRALYgKgRpTIABE28m15mfwOB0dB
         l5CtAnjwpLZcRGTH0FaaslTttoSUkGDY7/BDx4rnNmujWl6PQ8epzq2MzXMTJ++tUU
         QcMAULhP6irvtHoO+thLH+xMkMfzM/i//X+4nAEY=
Date:   Sat, 25 Aug 2018 09:47:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH] iio: dac: mcp4922: fix error handling in
 mcp4922_write_raw
Message-ID: <20180825094741.4581deb0@archlinux>
In-Reply-To: <20180824202440.21754-1-marcus.folkesson@gmail.com>
References: <20180824202440.21754-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 22:24:40 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Do not try to write negative values and make sure that the write goes well.
> 
+CC Michael as it's his driver.

I'll take this as it 'appears' straight forward but I won't be pushing
it out as a non rebasing branch for a few days if I've missed anything.

Applied to the togreg branch of iio.git and pushed out for now as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/iio/dac/mcp4922.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
> index bf9aa3fc0534..b5190d1dae8e 100644
> --- a/drivers/iio/dac/mcp4922.c
> +++ b/drivers/iio/dac/mcp4922.c
> @@ -94,17 +94,22 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
>  		long mask)
>  {
>  	struct mcp4922_state *state = iio_priv(indio_dev);
> +	int ret;
>  
>  	if (val2 != 0)
>  		return -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val > GENMASK(chan->scan_type.realbits-1, 0))
> +		if (val < 0 || val > GENMASK(chan->scan_type.realbits - 1, 0))
>  			return -EINVAL;
>  		val <<= chan->scan_type.shift;
> -		state->value[chan->channel] = val;
> -		return mcp4922_spi_write(state, chan->channel, val);
> +
> +		ret = mcp4922_spi_write(state, chan->channel, val);
> +		if (!ret)
> +			state->value[chan->channel] = val;
> +		return ret;
> +
>  	default:
>  		return -EINVAL;
>  	}

