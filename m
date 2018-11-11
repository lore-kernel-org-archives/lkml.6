Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F72C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A20621104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1AGE9gG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A20621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeKKVem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKKVem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:34:42 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78AE420866;
        Sun, 11 Nov 2018 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541936780;
        bh=aDpqByw+K9QwAazZ0pefapYDeY09OkzhuxVheH1CfXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1AGE9gG1zEydAHLO64oxx5wHYG+C4rT4uB6KLTaCcDSgTaw0Bov3YksgrG9Wcn36n
         0RDLbsvo0HPCxWfFYTMfH+YpPEzdxQqwSKUDKwvoFjOtCXKL1i6DsctY3f9JAGsarM
         3cTS9SdVaxCG0ORqkywBqsfTV/1zFxkdeCrPLXFM=
Date:   Sun, 11 Nov 2018 11:46:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: Re: [PATCH 3/6] staging:iio:ad2s90: Add max frequency check at
 probe
Message-ID: <20181111114614.7a235253@archlinux>
In-Reply-To: <20181109220044.24843-4-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
        <20181109220044.24843-4-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 20:00:41 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch adds a max frequency check at the beginning of ad2s90_probe
> function so that when it is set to a value above 0.83Mhz, dev_err is
> called with an appropriate message and -EINVAL is returned.
> 
> The defined limit is 0.83Mhz instead of 2Mhz, which is the chip's max
> frequency as specified in the datasheet, because, as also specified in
> the datasheet, a 600ns delay is expected between the application of a
> logic LO to CS and the application of SCLK. Since the delay is not
> implemented in the spi code, to satisfy it, SCLK's period should be at
> most 2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which
> gives roughly 830000Hz.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> Alex's S-o-B was added because he gave the code suggestion for this
> patch.
If he gave the actual code then he should be the credited author
git commit --amend --author=...

If it was just a suggestion, then an informal tag such as 
Suggested-by is usually used.

Signed-off-by has formal legal meaning to do with the developer
certificate of origin, it's not valid as a way of crediting someone
with a contribution to the patch.


> 
>  drivers/staging/iio/resolver/ad2s90.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 95c118c48400..949ff55ac6b0 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -19,6 +19,12 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> +/*
> + * Although chip's max frequency is 2Mhz, it needs 600ns between CS and the
> + * first falling edge of SCLK, so frequency should be at most 1 / (2 * 6e-7)
> + */
> +#define AD2S90_MAX_SPI_FREQ_HZ  830000
> +
>  struct ad2s90_state {
>  	struct mutex lock;
>  	struct spi_device *sdev;
> @@ -78,6 +84,12 @@ static int ad2s90_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	struct ad2s90_state *st;
>  
> +	if (spi->max_speed_hz > AD2S90_MAX_SPI_FREQ_HZ) {
> +		dev_err(&spi->dev, "SPI CLK, %d Hz exceeds %d Hz\n",
> +			spi->max_speed_hz, AD2S90_MAX_SPI_FREQ_HZ);
> +		return -EINVAL;
> +	}
Now this is interesting as a follow up to the previous and may actually
answer the question I raised.  Let's see what Mark and Rob come
back with. If possible I'd like us to resolve this once and for all
with a thread to point people back to!

> +
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;

