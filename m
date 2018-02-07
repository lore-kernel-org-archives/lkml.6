Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753939AbeBGLeV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:34:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47172 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbeBGLeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:34:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9E2960A06
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [RESEND PATCH v2 11/15] ASoC: qcom: qdsp6: Add
 support to q6afe dai driver
To: srinivas.kandagatla@linaro.org, Andy Gross <andy.gross@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>, sboyd@codeaurora.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-12-srinivas.kandagatla@linaro.org>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <33dbc1d9-ec33-b779-9258-4d1b13e17aaa@codeaurora.org>
Date: Wed, 7 Feb 2018 17:04:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20171214173402.19074-12-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/2017 11:03 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to q6afe backend dais driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/Kconfig           |   5 +
>   sound/soc/qcom/qdsp6/Makefile    |   1 +
>   sound/soc/qcom/qdsp6/q6afe-dai.c | 241 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 247 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6afe-dai.c
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index dd8fb0cde614..003ce182691c 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -64,6 +64,10 @@ config SND_SOC_QDSP6_ROUTING
>   	tristate
>   	default n
>   
> +config SND_SOC_QDSP6_AFE_DAI
> +	tristate
> +	default n
> +
>   config SND_SOC_QDSP6
>   	tristate "SoC ALSA audio driver for QDSP6"
>   	select SND_SOC_QDSP6_AFE
> @@ -71,6 +75,7 @@ config SND_SOC_QDSP6
>   	select SND_SOC_QDSP6_ASM
>   	select SND_SOC_QDSP6_CORE
>   	select SND_SOC_QDSP6_ROUTING
> +	select SND_SOC_QDSP6_AFE_DAI
>   	help
>   	 To add support for MSM QDSP6 Soc Audio.
>   	 This will enable sound soc platform specific
> diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
> index c1ad060a2341..bd8bd02bf09e 100644
> --- a/sound/soc/qcom/qdsp6/Makefile
> +++ b/sound/soc/qcom/qdsp6/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
>   obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
>   obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
>   obj-$(CONFIG_SND_SOC_QDSP6_ROUTING) += q6routing.o
> +obj-$(CONFIG_SND_SOC_QDSP6_AFE_DAI) += q6afe-dai.o
> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
> new file mode 100644
> index 000000000000..e9865c684bcb
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
> @@ -0,0 +1,241 @@
> +/* SPDX-License-Identifier: GPL-2.0
> +* Copyright (c) 2011-2016, The Linux Foundation
> +* Copyright (c) 2017, Linaro Limited
> +*/
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/pcm_params.h>
> +#include "q6afe.h"
> +
> +struct q6hdmi_dai_data {
> +	struct q6afe_port *port;
> +	struct q6afe_hdmi_cfg port_config;
> +	bool is_port_started;
> +};
> +
> +static int q6hdmi_format_put(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct q6hdmi_dai_data *dai_data = kcontrol->private_data;
> +	int value = ucontrol->value.integer.value[0];
> +
> +	dai_data->port_config.datatype = value;
....
> +
> +static struct platform_driver q6afe_dai_driver = {
> +	.probe  = q6afe_dai_dev_probe,
> +	.remove = q6afe_dai_dev_remove,
> +	.driver = {
> +		.name = "q6afe_dai",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +module_platform_driver(q6afe_dai_driver);
MODULE_LICENSE missing.
