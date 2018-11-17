Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635FAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCE62082A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkGA0LqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCE62082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeKRCsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeKRCsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:48:11 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E3FD206BA;
        Sat, 17 Nov 2018 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542472259;
        bh=AgyFHYZevveEymQ5RX1CvhSmRyxusnSx3Uui6rPPz5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lkGA0LqV0FDH+L5eBzLUZ4O7jwskuA2yNOB/K8vA6v+LTbSNiBHRECErrdOX3W9m+
         GPp5s/HQfk4botnvhTM54jb0/lKiC5EZk9LfEqUngXS74aZEMblCxZbtHFRh9/bGUO
         pIS7fMyZh/0AGKKoPSauOZDN/aUrzV6YoDD9+igg=
Date:   Sat, 17 Nov 2018 16:30:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] iio: ad_sigma_delta: Allow to provide custom
 data register address
Message-ID: <20181117163054.11a1d829@archlinux>
In-Reply-To: <1542108024-3307-1-git-send-email-stefan.popa@analog.com>
References: <1542108024-3307-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 13:20:24 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Some newer devices from the Sigma-Delta ADC family do have their data
> register at a different address than the current default address. Add a
> parameter to the ad_sigma_delta_info struct which allows to override the
> default address.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Added this commit.
> Changes in v3:
> 	- Nothing changed.
> Changes in v4:
> 	- Nothing changed.
> Changes in v5:
> 	- Nothing changed.
> 
>  drivers/iio/adc/ad_sigma_delta.c       | 22 +++++++++++++++++-----
>  include/linux/iio/adc/ad_sigma_delta.h |  3 +++
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index fc95107..ff5f2da 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -278,6 +278,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  {
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
>  	unsigned int sample, raw_sample;
> +	unsigned int data_reg;
>  	int ret = 0;
>  
>  	if (iio_buffer_enabled(indio_dev))
> @@ -305,7 +306,12 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		goto out;
>  
> -	ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_DATA,
> +	if (sigma_delta->info->data_reg != 0)
> +		data_reg = sigma_delta->info->data_reg;
> +	else
> +		data_reg = AD_SD_REG_DATA;
> +
> +	ret = ad_sd_read_reg(sigma_delta, data_reg,
>  		DIV_ROUND_UP(chan->scan_type.realbits + chan->scan_type.shift, 8),
>  		&raw_sample);
>  
> @@ -392,6 +398,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
>  	unsigned int reg_size;
> +	unsigned int data_reg;
>  	uint8_t data[16];
>  	int ret;
>  
> @@ -401,18 +408,23 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  			indio_dev->channels[0].scan_type.shift;
>  	reg_size = DIV_ROUND_UP(reg_size, 8);
>  
> +	if (sigma_delta->info->data_reg != 0)
> +		data_reg = sigma_delta->info->data_reg;
> +	else
> +		data_reg = AD_SD_REG_DATA;
> +
>  	switch (reg_size) {
>  	case 4:
>  	case 2:
>  	case 1:
> -		ret = ad_sd_read_reg_raw(sigma_delta, AD_SD_REG_DATA,
> -			reg_size, &data[0]);
> +		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
> +			&data[0]);
>  		break;
>  	case 3:
>  		/* We store 24 bit samples in a 32 bit word. Keep the upper
>  		 * byte set to zero. */
> -		ret = ad_sd_read_reg_raw(sigma_delta, AD_SD_REG_DATA,
> -			reg_size, &data[1]);
> +		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
> +			&data[1]);
>  		break;
>  	}
>  
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 730ead1..7e84351 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -39,6 +39,8 @@ struct iio_dev;
>   *		if there is just one read-only sample data shift register.
>   * @addr_shift: Shift of the register address in the communications register.
>   * @read_mask: Mask for the communications register having the read bit set.
> + * @data_reg: Address of the data register, if 0 the default address of 0x3 will
> + *   be used.
>   */
>  struct ad_sigma_delta_info {
>  	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
> @@ -47,6 +49,7 @@ struct ad_sigma_delta_info {
>  	bool has_registers;
>  	unsigned int addr_shift;
>  	unsigned int read_mask;
> +	unsigned int data_reg;
>  };
>  
>  /**

