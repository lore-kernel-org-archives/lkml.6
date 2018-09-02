Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C32C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 18:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCF020856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 18:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEXKH+Yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCF020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeIBWS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 18:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeIBWS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 18:18:57 -0400
Received: from archlinux (unknown [176.12.107.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C3020835;
        Sun,  2 Sep 2018 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535911340;
        bh=NIprCD9qe6te+diqs9tREvaAVPD6+S+HiisV3O6kljg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tEXKH+YhiHwHPjpBbsXZaW88v3JbyyN5QOy8vGt8RAyr2T9YhwHUWTYhnhylRzJLt
         jzVXCx/qWDrifDkppSkHVzT75TCxblNrZKw/N1qmceizC3ZIEr1k59TRN95vRQguxW
         8IA4v5CS7y8pvHAdWJk3Z2G1A0ZDmdEYdHYzwF0s=
Date:   Sun, 2 Sep 2018 19:02:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5758: Add support for hard reset
Message-ID: <20180902190214.116f2160@archlinux>
In-Reply-To: <1535554722-1094-1-git-send-email-stefan.popa@analog.com>
References: <1535554722-1094-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 17:58:42 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The ad5758 has a hardware reset active low input pin. This patch adds a
> devicetree entry for a reset GPIO and a new ad5758_reset() function.
> During
> initialization, it is checked if the reset property is specified and the
> the GPIO is being asserted, therefore the device will become active.
> 
> When the reset function is called, if the gpio_reset var is set, then
> the
> GPIO will be toggled, otherwise a software reset is performed.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Two minors inline. I'll tidy it up whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

I'm taking the view that the binding addition is very straight forward
but happy to have input from the DT maintainers if they wish to give
it!

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/dac/ad5758.txt         |  5 ++++
>  drivers/iio/dac/ad5758.c                           | 27 ++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
> index bba01a5..bbcd789 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ad5758.txt
> +++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
> @@ -50,6 +50,9 @@ Required properties:
>  
>  Optional properties:
>  
> + - reset-gpios : GPIO spec for the RESET pin. If specified, it will be
> + 		 asserted during driver probe.
There is a space at the start of the line above that shouldn't be there.

Fixed up.

> +
>   - adi,dc-dc-ilim-microamp: The dc-to-dc converter current limit
>  		   The following values are currently supported [uA]:
>  			* 150000
> @@ -71,6 +74,8 @@ AD5758 Example:
>  		spi-max-frequency = <1000000>;
>  		spi-cpha;
>  
> +		reset-gpios = <&gpio 22 0>;
> +
>  		adi,dc-dc-mode = <2>;
>  		adi,range-microvolt = <0 10000000>;
>  		adi,dc-dc-ilim-microamp = <200000>;
> diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
> index bd36333..b5cc5bd 100644
> --- a/drivers/iio/dac/ad5758.c
> +++ b/drivers/iio/dac/ad5758.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/property.h>
>  #include <linux/spi/spi.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -108,6 +109,7 @@ struct ad5758_range {
>  struct ad5758_state {
>  	struct spi_device *spi;
>  	struct mutex lock;
> +	struct gpio_desc *gpio_reset;
>  	struct ad5758_range out_range;
>  	unsigned int dc_dc_mode;
>  	unsigned int dc_dc_ilim;
> @@ -474,6 +476,22 @@ static int ad5758_internal_buffers_en(struct ad5758_state *st, bool enable)
>  					     AD5758_CAL_MEM_UNREFRESHED_MSK);
>  }
>  
> +static int ad5758_reset(struct ad5758_state *st)
> +{
> +	if (st->gpio_reset) {
> +		gpiod_set_value(st->gpio_reset, 0);
> +		usleep_range(100, 1000);
> +		gpiod_set_value(st->gpio_reset, 1);

This feels like an odd construct.  I would bring the usleep_range
and final return into this if block.

> +	} else {
> +		/* Perform a software reset */
> +		return ad5758_soft_reset(st);
> +	}
> +
> +	usleep_range(100, 1000);
> +
> +	return 0;
> +}
> +
>  static int ad5758_reg_access(struct iio_dev *indio_dev,
>  			     unsigned int reg,
>  			     unsigned int writeval,
> @@ -768,13 +786,18 @@ static int ad5758_init(struct ad5758_state *st)
>  {
>  	int regval, ret;
>  
> +	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
> +						 GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->gpio_reset))
> +		return PTR_ERR(st->gpio_reset);
> +
>  	/* Disable CRC checks */
>  	ret = ad5758_crc_disable(st);
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Perform a software reset */
> -	ret = ad5758_soft_reset(st);
> +	/* Perform a reset */
> +	ret = ad5758_reset(st);
>  	if (ret < 0)
>  		return ret;
>  

