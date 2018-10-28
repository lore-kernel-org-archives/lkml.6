Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AD4C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFD420870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+LbOptw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFD420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJ2B2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJ2B2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:28:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154CA20831;
        Sun, 28 Oct 2018 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540745014;
        bh=cqORAtsmXSF+s3KV+zPXIit7fNEofDuLgtXfTkmbT4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X+LbOptw0nSnwp8T7VXoOpDT8anNmFpvQJ1R0Qkh09TfAt1oFpYgM8WPllRqqrO4y
         jXwZ2teNV2h6FldrbK/ZMvfYiU+2ekNUweqU/uwHyPLz3pNvnyrHOA89TTo5WkJJX1
         4t1G4gYlY9FJKM3x6ThJaGiod4hFo0GYau/0rsG4=
Date:   Sun, 28 Oct 2018 16:43:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/6] staging:iio:ad2s90: Make probe handle spi_setup
 failure
Message-ID: <20181028164329.57162e06@archlinux>
In-Reply-To: <20181027020005.3140-3-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
        <20181027020005.3140-3-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 23:00:01 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> Previously, ad2s90_probe ignored the return code from spi_setup, not
> handling its possible failure. This patch makes ad2s90_probe check if
> the code is an error code and, if so, do the following:
> 
> - Call dev_err with an appropriate error message.
> - Return the spi_setup's error code, aborting the execution of the
> rest of the function.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  drivers/staging/iio/resolver/ad2s90.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 11fac9f90148..d6a42e3f1bd8 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -88,7 +88,12 @@ static int ad2s90_probe(struct spi_device *spi)
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
I would have reordered this first to be before the iio_device_register call.
The reason being that it would avoid this comment.

Drop the return ret out of the block above and return ret unconditionally.

I don't mind too much as I know this is moving later, but I only know that
because of the earlier discussion ;)  Few reviewers read the whole patch
set before responding to the early patches - it's just too much like hard
work.  So if you can do things in an order that minimizes standard responses
then that's great.

Patch is fine though - could be solved by a comment in the intro that
says the code in question will move in patch X.

Jonathan
>  
>  	return 0;
>  }

