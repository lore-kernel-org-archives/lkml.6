Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeFBTgj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 15:36:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33630 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbeFBTgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 15:36:36 -0400
X-Google-Smtp-Source: ADUXVKK6OfzrmPiyA6fz3g0OiKXH/J9IBtqPX/ZG4AWPWF+eXMazUAMS9KFBBiAJSGS8KFMQgVJCiw==
Date: Sat, 2 Jun 2018 12:38:41 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] thermal: qcom: tsens: Allow number of sensors to come
 from DT
Message-ID: <20180602193841.GB510@tuxbook-pro>
References: <20180602193211.25731-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602193211.25731-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 02 Jun 12:32 PDT 2018, Bjorn Andersson wrote:

> For platforms that has multiple copies of the TSENS hardware block it's
> convenient to specify the number of sensors per block in DeviceTree.
> 
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org> [binding]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Please ignore, after sending this I saw that Eduardo picked up v1
yesterday.

Thanks Eduardo,
Bjorn

> ---
> 
> Changes since v1:
> - Added comment as suggested by Amit
> - Picked up Amit and Rob's R-b
> 
>  .../devicetree/bindings/thermal/qcom-tsens.txt      |  1 +
>  drivers/thermal/qcom/tsens.c                        | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 292ed89d900b..06195e8f35e2 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -8,6 +8,7 @@ Required properties:
>  
>  - reg: Address range of the thermal registers
>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> +- #qcom,sensors: Number of sensors in tsens block
>  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
>  nvmem cells
>  
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 3f9fe6aa51cc..b212bebcfc36 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -116,6 +116,7 @@ static int tsens_probe(struct platform_device *pdev)
>  	struct tsens_device *tmdev;
>  	const struct tsens_data *data;
>  	const struct of_device_id *id;
> +	u32 num_sensors;
>  
>  	if (pdev->dev.of_node)
>  		dev = &pdev->dev;
> @@ -130,18 +131,24 @@ static int tsens_probe(struct platform_device *pdev)
>  	else
>  		data = &data_8960;
>  
> -	if (data->num_sensors <= 0) {
> +	num_sensors = data->num_sensors;
> +
> +	/* Override driver provided num_sensors, if specified in DT */
> +	if (np)
> +		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
> +
> +	if (num_sensors <= 0) {
>  		dev_err(dev, "invalid number of sensors\n");
>  		return -EINVAL;
>  	}
>  
>  	tmdev = devm_kzalloc(dev, sizeof(*tmdev) +
> -			     data->num_sensors * sizeof(*s), GFP_KERNEL);
> +			     num_sensors * sizeof(*s), GFP_KERNEL);
>  	if (!tmdev)
>  		return -ENOMEM;
>  
>  	tmdev->dev = dev;
> -	tmdev->num_sensors = data->num_sensors;
> +	tmdev->num_sensors = num_sensors;
>  	tmdev->ops = data->ops;
>  	for (i = 0;  i < tmdev->num_sensors; i++) {
>  		if (data->hw_ids)
> -- 
> 2.17.0
> 
