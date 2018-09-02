Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627AFC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 08:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EE920856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 08:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t72hi8As"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EE920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeIBNKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 09:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeIBNKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 09:10:11 -0400
Received: from archlinux (82-132-217-68.dab.02.net [82.132.217.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC43A2077C;
        Sun,  2 Sep 2018 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535878510;
        bh=TDn1i4FhH6lB/iowyZ3LBkQeZpHrwjK7xBjtu2Rhs7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t72hi8AsupGI/GC6C63UBfjXkz/E/vUif7IJOKPtSTDZamxpHZdUpU/xcxnW1X9wj
         eS/F+jtxUVMmekMnU7p/X4rLLzb3HytGI9EVr0N6gdVrjb1/K3NMJmMv9ysk0QLEaL
         tIjjqomQ7TUJ3IuQi6PhgBQ1y/u95G3yjHexFw4g=
Date:   Sun, 2 Sep 2018 09:55:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, freeman.liu@spreadtrum.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: sc27xx: Add ADC scale calibration
Message-ID: <20180902095343.42f827c7@archlinux>
In-Reply-To: <61cad47d5d10c771d3cc371744533e87d192ee96.1535434262.git.baolin.wang@linaro.org>
References: <0adef2f9eafa913eb9f4bc1ed3dc643d09bf02a2.1535434262.git.baolin.wang@linaro.org>
        <61cad47d5d10c771d3cc371744533e87d192ee96.1535434262.git.baolin.wang@linaro.org>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 14:04:05 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch adds support to read calibration values from the eFuse
> controller to calibrate the ADC channel scales, which can make ADC
> sample data more accurate.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes from v1:
>  - Use nvmem_cell_read() instead of nvmem_cell_read_u32().
> ---
>  .../bindings/iio/adc/sprd,sc27xx-adc.txt           |    4 ++
>  drivers/iio/adc/sc27xx_adc.c                       |   74 +++++++++++++++++++-
>  2 files changed, 75 insertions(+), 3 deletions(-)
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
> index 153c311..7940b23 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -5,10 +5,12 @@
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/slab.h>
>  
>  /* PMIC global registers definition */
>  #define SC27XX_MODULE_EN		0xc08
> @@ -87,16 +89,73 @@ struct sc27xx_adc_linear_graph {
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
> +static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
> +					bool big_scale)
> +{
> +	const struct sc27xx_adc_linear_graph *calib_graph;
> +	struct sc27xx_adc_linear_graph *graph;
> +	struct nvmem_cell *cell;
> +	const char *cell_name;
> +	u32 calib_data = 0;
> +	void *buf;
> +	size_t len;
> +
> +	if (big_scale) {
> +		calib_graph = &big_scale_graph_calib;
> +		graph = &big_scale_graph;
> +		cell_name = "big_scale_calib";
> +	} else {
> +		calib_graph = &small_scale_graph_calib;
> +		graph = &small_scale_graph;
> +		cell_name = "small_scale_calib";
> +	}
> +
> +	cell = nvmem_cell_get(data->dev, cell_name);
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	buf = nvmem_cell_read(cell, &len);
> +	nvmem_cell_put(cell);
> +
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	memcpy(&calib_data, buf, min(len, sizeof(u32)));
> +
> +	/* Only need to calibrate the adc values in the linear graph. */
> +	graph->adc0 = sc27xx_adc_get_calib_data(calib_data, calib_graph->adc0);
> +	graph->adc1 = sc27xx_adc_get_calib_data(calib_data >> 8,
> +						calib_graph->adc1);
> +
> +	kfree(buf);
> +	return 0;
> +}
> +
>  static int sc27xx_adc_get_ratio(int channel, int scale)
>  {
>  	switch (channel) {
> @@ -209,7 +268,7 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
>  	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
>  }
>  
> -static int sc27xx_adc_to_volt(const struct sc27xx_adc_linear_graph *graph,
> +static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
>  			      int raw_adc)
>  {
>  	int tmp;
> @@ -390,6 +449,15 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>  	if (ret)
>  		goto disable_clk;
>  
> +	/* ADC channel scales' calibration from nvmem device */
> +	ret = sc27xx_adc_scale_calibration(data, true);
> +	if (ret)
> +		goto disable_clk;
> +
> +	ret = sc27xx_adc_scale_calibration(data, false);
> +	if (ret)
> +		goto disable_clk;
> +
>  	return 0;
>  
>  disable_clk:
> -- 
> 1.7.9.5
> 

