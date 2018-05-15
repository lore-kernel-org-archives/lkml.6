Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeEOG6C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:58:02 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43346 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbeEOG57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:57:59 -0400
X-Google-Smtp-Source: AB8JxZo+oVg+USx3Xv1GS1xFS2eGue+caApeDJhdX5nwgrfrUabkh5KIR3gVdfye2Fpne94xa4/iZlJHLxRtad0Mh2g=
MIME-Version: 1.0
In-Reply-To: <20180507235339.8836-1-bjorn.andersson@linaro.org>
References: <20180507235339.8836-1-bjorn.andersson@linaro.org>
From: Amit Kucheria <amit.kucheria@verdurent.com>
Date: Tue, 15 May 2018 09:57:58 +0300
Message-ID: <CAHLCerNSNSiER=_aD5ef6+6sq=5HMxrxNpj4h9S5JUJawTp-Pw@mail.gmail.com>
Subject: Re: [PATCH] thermal: qcom: tsens: Allow number of sensors to come
 from DT
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux PM list <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 8, 2018 at 2:53 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> For platforms that has multiple copies of the TSENS hardware block it's
> necessary to be able to specify the number of sensors per block in DeviceTree.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Just one comment below, otherwise,

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt       |  1 +
>  drivers/thermal/qcom/tsens.c                         | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
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
> index 3f9fe6aa51cc..20f3b87d7667 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -116,6 +116,7 @@ static int tsens_probe(struct platform_device *pdev)
>         struct tsens_device *tmdev;
>         const struct tsens_data *data;
>         const struct of_device_id *id;
> +       u32 num_sensors;
>
>         if (pdev->dev.of_node)
>                 dev = &pdev->dev;
> @@ -130,18 +131,23 @@ static int tsens_probe(struct platform_device *pdev)
>         else
>                 data = &data_8960;
>
> -       if (data->num_sensors <= 0) {
> +       num_sensors = data->num_sensors;
> +


Probably worth adding a comment that we're overriding the num_sensors
from DT if available here.

> +       if (np)
> +               of_property_read_u32(np, "#qcom,sensors", &num_sensors);
> +
> +       if (num_sensors <= 0) {
>                 dev_err(dev, "invalid number of sensors\n");
>                 return -EINVAL;
>         }
>
>         tmdev = devm_kzalloc(dev, sizeof(*tmdev) +
> -                            data->num_sensors * sizeof(*s), GFP_KERNEL);
> +                            num_sensors * sizeof(*s), GFP_KERNEL);
>         if (!tmdev)
>                 return -ENOMEM;
>
>         tmdev->dev = dev;
> -       tmdev->num_sensors = data->num_sensors;
> +       tmdev->num_sensors = num_sensors;
>         tmdev->ops = data->ops;
>         for (i = 0;  i < tmdev->num_sensors; i++) {
>                 if (data->hw_ids)
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
