Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeBSKch (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:32:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39646 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752393AbeBSKcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:32:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C376860721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v3 14/25] ASoC: qcom: qdsp6: Add support to
 q6afe dai driver
To: srinivas.kandagatla@linaro.org, andy.gross@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org,
        spatakok@qti.qualcomm.com, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-15-srinivas.kandagatla@linaro.org>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <84723548-02a4-10e7-3de1-b347416d4fb0@codeaurora.org>
Date: Mon, 19 Feb 2018 16:02:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213165837.1620-15-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2018 10:28 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to q6afe backend dais driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/qdsp6/Makefile    |   2 +-
>   sound/soc/qcom/qdsp6/q6afe-dai.c | 280 +++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6afe.h     |   3 +
>   3 files changed, 284 insertions(+), 1 deletion(-)
>   create mode 100644 sound/soc/qcom/qdsp6/q6afe-dai.c
>
> diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
> index 660afcab98fd..c7833842b878 100644
> --- a/sound/soc/qcom/qdsp6/Makefile
> +++ b/sound/soc/qcom/qdsp6/Makefile
> @@ -1,5 +1,5 @@
>   obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
> -obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
> +obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o q6afe-dai.o
depmod: ERROR: Cycle detected: q6afe -> q6afe_dai -> q6afe
need to use like:
+qdsp6_afe-objs := q6afe.o q6afe-dai.o
+obj-$(CONFIG_SND_SOC_QDSP6_AFE) += qdsp6_afe.o
similarly for asm and adm
>   obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o q6routing.o
>   obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
>   obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
> new file mode 100644
> index 000000000000..f6a618e9db9e
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2011-2016, The Linux Foundation
> + * Copyright (c) 2018, Linaro Limited
> + */
> +
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
> +struct q6afe_dai_data {
> +	struct q6afe_port *port[AFE_PORT_MAX];
> +	struct q6afe_port_config port_config[AFE_PORT_MAX];
> +	bool is_port_started[AFE_PORT_MAX];
> +};
> +
> +static int q6hdmi_format_put(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct q6afe_dai_data *dai_data = kcontrol->private_data;
> +	int value = ucontrol->value.integer.value[0];
> +
> +	dai_data->port_config[AFE_PORT_HDMI_RX].hdmi.datatype = value;
> +
> +	return 0;
> +}
> +
> +static int q6hdmi_format_get(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +
> +	struct q6afe_dai_data *dai_data = kcontrol->private_data;
> +
> +	ucontrol->value.integer.value[0] =
> +		dai_data->port_config[AFE_PORT_HDMI_RX].hdmi.datatype;
> +
> +	return 0;
> +}
> +
> +static const char * const hdmi_format[] = {
> +	"LPCM",
> +	"Compr"
> +};
> +
> +static const struct soc_enum hdmi_config_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(2, hdmi_format),
> +};
> +
> +static const struct snd_kcontrol_new q6afe_config_controls[] = {
> +	SOC_ENUM_EXT("HDMI RX Format", hdmi_config_enum[0],
> +				 q6hdmi_format_get,
> +				 q6hdmi_format_put),
> +};
> +
> +static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
> +	int channels = params_channels(params);
> +	struct q6afe_hdmi_cfg *hdmi = &dai_data->port_config[dai->id].hdmi;
> +
> +	hdmi->sample_rate = params_rate(params);
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		hdmi->bit_width = 16;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		hdmi->bit_width = 24;
> +		break;
> +	}
> +
> +	/*refer to HDMI spec CEA-861-E: Table 28 Audio InfoFrame Data Byte 4*/
> +	switch (channels) {
> +	case 2:
> +		hdmi->channel_allocation = 0;
> +		break;
> +	case 3:
> +		hdmi->channel_allocation = 0x02;
> +		break;
> +	case 4:
> +		hdmi->channel_allocation = 0x06;
> +		break;
> +	case 5:
> +		hdmi->channel_allocation = 0x0A;
> +		break;
> +	case 6:
> +		hdmi->channel_allocation = 0x0B;
> +		break;
> +	case 7:
> +		hdmi->channel_allocation = 0x12;
> +		break;
> +	case 8:
> +		hdmi->channel_allocation = 0x13;
> +		break;
> +	default:
> +		dev_err(dai->dev, "invalid Channels = %u\n", channels);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int q6afe_dai_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
> +
> +	dai_data->is_port_started[dai->id] = false;
> +
> +	return 0;
> +}
> +
> +static void q6afe_dai_shutdown(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
> +	int rc;
> +
> +	rc = q6afe_port_stop(dai_data->port[dai->id]);
> +	if (rc < 0)
> +		dev_err(dai->dev, "fail to close AFE port\n");
> +
> +	dai_data->is_port_started[dai->id] = false;
> +
> +}
> +
> +static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
> +	int rc;
> +
> +	if (dai_data->is_port_started[dai->id]) {
> +		/* stop the port and restart with new port config */
> +		rc = q6afe_port_stop(dai_data->port[dai->id]);
> +		if (rc < 0) {
> +			dev_err(dai->dev, "fail to close AFE port\n");
> +			return rc;
> +		}
> +	}
> +
> +	if (dai->id == AFE_PORT_HDMI_RX)
> +		q6afe_hdmi_port_prepare(dai_data->port[dai->id],
> +					&dai_data->port_config[dai->id].hdmi);
> +
> +	rc = q6afe_port_start(dai_data->port[dai->id]);
> +	if (rc < 0) {
> +		dev_err(dai->dev, "fail to start AFE port %x\n", dai->id);
> +		return rc;
> +	}
> +	dai_data->is_port_started[dai->id] = true;
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
> +	{"HDMI Playback", NULL, "HDMI_RX"},
> +};
> +
> +static struct snd_soc_dai_ops q6hdmi_ops = {
> +	.prepare	= q6afe_dai_prepare,
> +	.hw_params	= q6hdmi_hw_params,
> +	.shutdown	= q6afe_dai_shutdown,
> +	.startup	= q6afe_dai_startup,
> +};
> +
> +static int msm_dai_q6_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
> +	struct snd_soc_dapm_context *dapm;
> +	struct q6afe_port *port;
> +
> +	dapm = snd_soc_component_get_dapm(dai->component);
> +
> +	port = q6afe_port_get_from_id(dai->dev, dai->id);
> +	if (IS_ERR(port)) {
> +		dev_err(dai->dev, "Unable to get afe port\n");
> +		return -EINVAL;
> +	}
> +	dai_data->port[dai->id] = port;
> +
> +	return 0;
> +}
> +
> +static int msm_dai_q6_dai_remove(struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
> +
> +	q6afe_port_put(dai_data->port[dai->id]);
> +
> +	return 0;
> +}
> +
> +static struct snd_soc_dai_driver q6afe_dais[] = {
> +	{
> +		.playback = {
> +			.stream_name = "HDMI Playback",
> +			.rates = SNDRV_PCM_RATE_48000 |
> +				 SNDRV_PCM_RATE_96000 |
> +			 SNDRV_PCM_RATE_192000,
> +			.formats = SNDRV_PCM_FMTBIT_S16_LE |
> +				   SNDRV_PCM_FMTBIT_S24_LE,
> +			.channels_min = 2,
> +			.channels_max = 8,
> +			.rate_max =     192000,
> +			.rate_min =	48000,
> +		},
> +		.ops = &q6hdmi_ops,
> +		.id = AFE_PORT_HDMI_RX,
> +		.name = "HDMI",
> +		.probe = msm_dai_q6_dai_probe,
> +		.remove = msm_dai_q6_dai_remove,
> +	},
> +};
> +
> +static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
> +				   struct of_phandle_args *args,
> +				   const char **dai_name)
> +{
> +	int id = args->args[0];
> +	int i, ret = -EINVAL;
> +
> +	for (i = 0; i  < ARRAY_SIZE(q6afe_dais); i++) {
> +		if (q6afe_dais[i].id == id) {
> +			*dai_name = q6afe_dais[i].name;
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
> +	SND_SOC_DAPM_AIF_OUT("HDMI_RX", "HDMI Playback", 0, 0, 0, 0),
> +};
> +
> +static const struct snd_soc_component_driver q6afe_dai_component = {
> +	.name		= "q6afe-dai-component",
> +	.dapm_widgets = q6afe_dai_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(q6afe_dai_widgets),
> +	.controls = q6afe_config_controls,
> +	.num_controls = ARRAY_SIZE(q6afe_config_controls),
> +	.dapm_routes = q6afe_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(q6afe_dapm_routes),
> +	.of_xlate_dai_name = q6afe_of_xlate_dai_name,
> +
> +};
> +
> +int q6afe_dai_dev_probe(struct device *dev)
> +{
> +	int rc = 0;
> +	struct q6afe_dai_data *dai_data;
> +
> +	dai_data = devm_kzalloc(dev, sizeof(*dai_data), GFP_KERNEL);
> +	if (!dai_data)
> +		rc = -ENOMEM;
> +
> +	q6afe_set_dai_data(dev, dai_data);
> +
> +	return  devm_snd_soc_register_component(dev, &q6afe_dai_component,
> +					  q6afe_dais, ARRAY_SIZE(q6afe_dais));
> +}
> +EXPORT_SYMBOL_GPL(q6afe_dai_dev_probe);
> +
> +int q6afe_dai_dev_remove(struct device *dev)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(q6afe_dai_dev_remove);
> +MODULE_DESCRIPTION("Q6 Audio Fronend dai driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
> index 43df524f01bb..647ed2d15545 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.h
> +++ b/sound/soc/qcom/qdsp6/q6afe.h
> @@ -26,6 +26,9 @@ struct q6afe_port;
>   void q6afe_set_dai_data(struct device *dev, void *data);
>   void *q6afe_get_dai_data(struct device *dev);
>   
> +int q6afe_dai_dev_probe(struct device *dev);
> +int q6afe_dai_dev_remove(struct device *dev);
> +
>   struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id);
>   int q6afe_port_start(struct q6afe_port *port);
>   int q6afe_port_stop(struct q6afe_port *port);
