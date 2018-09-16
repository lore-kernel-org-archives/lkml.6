Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF63ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF4721476
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBY8WI9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF4721476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeIPQzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 12:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbeIPQzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 12:55:06 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E8520867;
        Sun, 16 Sep 2018 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537097547;
        bh=Lpd7+9rXkM8lNUyIUkpXIOXsmP7Ig8wQCkbBZeCWxP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VBY8WI9nHmDMQSG2ufc0pelNmkc+r8hE2/GlMzf1vUsU4uKhF0Jte2qT3OoJekY7p
         quxbzdcOVaMuRgooIg9EEVQfr8+zLv/trmP1UBFrSVUmMjz7uTCI9Ay6YyAYSfwMKb
         datP/14zNukYArOaJvv5GywAwcOyfqkn94SdIWgI=
Date:   Sun, 16 Sep 2018 12:32:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] spi: add software implementation for SPI_CS_WORD
Message-ID: <20180916123222.67136773@archlinux>
In-Reply-To: <20180913003920.30600-3-david@lechnology.com>
References: <20180913003920.30600-1-david@lechnology.com>
        <20180913003920.30600-3-david@lechnology.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 19:39:18 -0500
David Lechner <david@lechnology.com> wrote:

> This adds a default software implementation for the SPI_CS_WORD flag for
> controllers that don't have such a feature.
> 
> The SPI_CS_WORD flag indicates that the CS line should be toggled
> between each word sent, not just between each transfer. The
> implementation works by using existing functions to split transfers into
> one-word-sized transfers and sets the cs_change bit for each of the
> new transfers.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
Looks good to me but I'm not that familiar with this code..

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/spi/spi.c | 31 +++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 9da0bc5a036c..84518ed58872 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2783,8 +2783,10 @@ int spi_setup(struct spi_device *spi)
>  		return -EINVAL;
>  	/* help drivers fail *cleanly* when they need options
>  	 * that aren't supported with their current controller
> +	 * SPI_CS_WORD has a fallback software implementation,
> +	 * so it is ignored here.
>  	 */
> -	bad_bits = spi->mode & ~spi->controller->mode_bits;
> +	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
>  	ugly_bits = bad_bits &
>  		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
>  	if (ugly_bits) {
> @@ -2838,6 +2840,33 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
>  	if (list_empty(&message->transfers))
>  		return -EINVAL;
>  
> +	/* If an SPI controller does not support toggling the CS line on each
> +	 * transfer (indicated by the SPI_CS_WORD flag), we can emulate it by
> +	 * splitting transfers into one-word transfers and ensuring that
> +	 * cs_change is set for each transfer.
> +	 */
> +	if ((spi->mode & SPI_CS_WORD) && !(ctlr->mode_bits & SPI_CS_WORD)) {
> +		size_t maxsize;
> +		int ret;
> +
> +		maxsize = (spi->bits_per_word + 7) / 8;
> +
> +		/* spi_split_transfers_maxsize() requires message->spi */
> +		message->spi = spi;
> +
> +		ret = spi_split_transfers_maxsize(ctlr, message, maxsize,
> +						  GFP_KERNEL);
> +		if (ret)
> +			return ret;
> +
> +		list_for_each_entry(xfer, &message->transfers, transfer_list) {
> +			/* don't change cs_change on the last entry in the list */
> +			if (list_is_last(&xfer->transfer_list, &message->transfers))
> +				break;
> +			xfer->cs_change = 1;
> +		}
> +	}
> +
>  	/* Half-duplex links include original MicroWire, and ones with
>  	 * only one data pin like SPI_3WIRE (switches direction) or where
>  	 * either MOSI or MISO is missing.  They can also be caused by

