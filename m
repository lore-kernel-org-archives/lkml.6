Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F9C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D513F20854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrQJe1MS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D513F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbeKEByL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:54:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbeKEByL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:54:11 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A072081D;
        Sun,  4 Nov 2018 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541349518;
        bh=Qmmyidfk2PTVKec/mhCJ6Fzl8W6aqhqmy/DfGQSZ084=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IrQJe1MSjHDrkfRjP/onD4cudxd01m8bR7y3A5YoA8dGKe4TIK/2GgeHXTAUsf0Sa
         Yivulfsht1W6OASwbiLtIScho5ZJyQxmXCjzo1FUMJOLQhMPgxxBPpkEFVAmhjWqjE
         XIqwCaUlCxcSyVu7LdRA100HTeFF9jFMjdMyxBvA=
Date:   Sun, 4 Nov 2018 16:38:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 2/6] staging:iio:ad2s90: Make probe handle spi_setup
 failure
Message-ID: <20181104163834.43dab5fd@archlinux>
In-Reply-To: <20181103224948.31014-3-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
        <20181103224948.31014-3-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  3 Nov 2018 19:49:44 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> Previously, ad2s90_probe ignored the return code from spi_setup, not
> handling its possible failure. This patch makes ad2s90_probe check if
> the code is an error code and, if so, do the following:
> 
> - Call dev_err with an appropriate error message.
> - Return the spi_setup's error code.
> 
> Note: The 'return ret' statement could be out of the 'if' block, but
> this whole block will be moved up in the function in the patch:
> 'staging:iio:ad2s90: Move device registration to the end of probe'.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Very nicely presented patch.  Thanks.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s90.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index ba55de29ef36..4908c8a95fad 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -86,7 +86,12 @@ static int ad2s90_probe(struct spi_device *spi)
>  	/* need 600ns between CS and the first falling edge of SCLK */
>  	spi->max_speed_hz = 830000;
>  	spi->mode = SPI_MODE_3;
> -	spi_setup(spi);
> +	ret = spi_setup(spi);
> +
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "spi_setup failed!\n");
> +		return ret;
> +	}
>  
>  	return 0;
>  }

