Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF90EC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68197214AB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="18dI5END"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68197214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeHYMWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbeHYMWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:22:19 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0A621477;
        Sat, 25 Aug 2018 08:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535186642;
        bh=F7eB4YPsis3op95iT1DD5/mWTi2mcKAKYMzRRUMeLSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=18dI5END0cjQDKLfgsV9YXoZ41T7IOQeqSUGOdAw7TOO7jiezuIUvZbhxtzzCmM68
         ofyRoIrAiT2pjXIBYAoCWhJnRm4Sb0Vvnjh6BMqP1Ws+k4AdenQl1TNh/oALrfA6j5
         y6tDUzj4rCH3b1MWNRusCkqjiueA2PSfYe8FwuOY=
Date:   Sat, 25 Aug 2018 09:43:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, freeman.liu@spreadtrum.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: sc27xx: Add ADC scale calibration
Message-ID: <20180825094357.6425ab4a@archlinux>
In-Reply-To: <cc6b76c5d660818d3ff7833ea5be4f32ed960f54.1535103920.git.baolin.wang@linaro.org>
References: <4a7e33457617e6f0f7c9627fe20ddd3039e4fe82.1535103920.git.baolin.wang@linaro.org>
        <cc6b76c5d660818d3ff7833ea5be4f32ed960f54.1535103920.git.baolin.wang@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 17:53:16 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch adds support to read calibration values from the eFuse
> controller to calibrate the ADC channel scales, which can make ADC
> sample data more accurate.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
This looks good to me.  I'll leave it for now though given open questions
on patch 1 and to allow others time to comment on this if they wish -
particularly as it includes a binding addition.

Jonathan

> ---
>  .../bindings/iio/adc/sprd,sc27xx-adc.txt           |    4 ++
>  drivers/iio/adc/sc27xx_adc.c                       |   52 ++++++++++++++++++--
>  2 files changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> index 8aad960..b4daa15 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> @@ -12,6 +12,8 @@ Required properties:
>  - interrupts: The interrupt number for the ADC device.
>  - #io-channel-cells: Number of cells in an IIO specifier.
>  - hwlocks: Reference to a phandle of a hwlock provider node.
> +- nvmem-cells: A phandle to the calibration cells provided by eFuse device.
> +- nvmem-cell-names: Should be "big_scale_calib", "small_scale_calib".
>  
>  Example:
>  
> @@ -32,5 +34,7 @@ Example:
>  			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
>  			#io-channel-cells = <1>;
>  			hwlocks = <&hwlock 4>;
> +			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
> +			nvmem-cell-names = "big_scale_calib", "small_scale_calib";
>  		};
>  	};
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 153c311..7ac78eda 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -5,6 +5,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -87,16 +88,48 @@ struct sc27xx_adc_linear_graph {
>   * should use the small-scale graph, and if more than 1.2v, we should use the
>   * big-scale graph.
>   */
> -static const struct sc27xx_adc_linear_graph big_scale_graph = {
> +static struct sc27xx_adc_linear_graph big_scale_graph = {
>  	4200, 3310,
>  	3600, 2832,
>  };
>  
> -static const struct sc27xx_adc_linear_graph small_scale_graph = {
> +static struct sc27xx_adc_linear_graph small_scale_graph = {
>  	1000, 3413,
>  	100, 341,
>  };
>  
> +static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
> +	4200, 856,
> +	3600, 733,
> +};
> +
> +static const struct sc27xx_adc_linear_graph small_scale_graph_calib = {
> +	1000, 833,
> +	100, 80,
> +};
> +
> +static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
> +{
> +	return ((calib_data & 0xff) + calib_adc - 128) * 4;
> +}
> +
> +static void
> +sc27xx_adc_scale_calibration(const struct sc27xx_adc_linear_graph *calib_graph,
> +			     u32 calib_data, bool big_scale)
> +{
> +	struct sc27xx_adc_linear_graph *graph;
> +
> +	if (big_scale)
> +		graph = &big_scale_graph;
> +	else
> +		graph = &small_scale_graph;
> +
> +	/* Only need to calibrate the adc values in the linear graph. */
> +	graph->adc0 = sc27xx_adc_get_calib_data(calib_data, calib_graph->adc0);
> +	graph->adc1 = sc27xx_adc_get_calib_data(calib_data >> 8,
> +						calib_graph->adc1);
> +}
> +
>  static int sc27xx_adc_get_ratio(int channel, int scale)
>  {
>  	switch (channel) {
> @@ -209,7 +242,7 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
>  	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
>  }
>  
> -static int sc27xx_adc_to_volt(const struct sc27xx_adc_linear_graph *graph,
> +static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
>  			      int raw_adc)
>  {
>  	int tmp;
> @@ -371,6 +404,7 @@ static int sc27xx_adc_write_raw(struct iio_dev *indio_dev,
>  
>  static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>  {
> +	u32 val;
>  	int ret;
>  
>  	ret = regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> @@ -390,6 +424,18 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>  	if (ret)
>  		goto disable_clk;
>  
> +	/* ADC channel scales' calibration from nvmem device */
> +	ret = nvmem_cell_read_u32(data->dev, "big_scale_calib", &val);
> +	if (ret)
> +		goto disable_clk;
> +
> +	sc27xx_adc_scale_calibration(&big_scale_graph_calib, val, true);
> +
> +	ret = nvmem_cell_read_u32(data->dev, "small_scale_calib", &val);
> +	if (ret)
> +		goto disable_clk;
> +
> +	sc27xx_adc_scale_calibration(&small_scale_graph_calib, val, false);
>  	return 0;
>  
>  disable_clk:

