Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428350AbeCBNwZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:52:25 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38074 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424338AbeCBNwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:52:20 -0500
X-Google-Smtp-Source: AG47ELvlphIEVRTCTnTOJ/OwU4IzvU7vXR1H/Zppcy2rN/wix9LnS/kNn/Nfmor6X61EnyaqvZbaxw==
Subject: Re: [PATCH v3 14/25] ASoC: qcom: qdsp6: Add support to q6afe dai
 driver
To: Mark Brown <broonie@kernel.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-15-srinivas.kandagatla@linaro.org>
 <20180302125054.GH6255@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7c17e021-e2ab-f177-713e-f332bafca522@linaro.org>
Date: Fri, 2 Mar 2018 13:52:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180302125054.GH6255@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review comments,

On 02/03/18 12:50, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:58:26PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
>> +static int q6hdmi_format_put(struct snd_kcontrol *kcontrol,
>> +				struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct q6afe_dai_data *dai_data = kcontrol->private_data;
>> +	int value = ucontrol->value.integer.value[0];
>> +
>> +	dai_data->port_config[AFE_PORT_HDMI_RX].hdmi.datatype = value;
>> +
>> +	return 0;
>> +}
> 
> No validation, and do we not need to tell a currently running stream if
> the format changed on it (or block such changes if they're not going to
> work, which seems more likely)?
Yes, It would not work if the stream is running.
This mixer has to be setup before the stream/port is prepared/started.
TBH, I have no means to test Compr format, I should probably remove this 
control until am able to test this format.

> 
>> +static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
>> +				struct snd_pcm_hw_params *params,
>> +				struct snd_soc_dai *dai)
>> +{
>> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
>> +	int channels = params_channels(params);
>> +	struct q6afe_hdmi_cfg *hdmi = &dai_data->port_config[dai->id].hdmi;
>> +
>> +	hdmi->sample_rate = params_rate(params);
>> +	switch (params_format(params)) {
>> +	case SNDRV_PCM_FORMAT_S16_LE:
>> +		hdmi->bit_width = 16;
>> +		break;
>> +	case SNDRV_PCM_FORMAT_S24_LE:
>> +		hdmi->bit_width = 24;
>> +		break;
>> +	}
> 
> This silently accepts invalid values.
> 
Yep, I will fix this in next version.

>> +	/*refer to HDMI spec CEA-861-E: Table 28 Audio InfoFrame Data Byte 4*/
> 
> Coding style, spaces around the /* */.
Agreed! Will fix it in next version.

> 
>> +static int q6afe_dai_startup(struct snd_pcm_substream *substream,
>> +				struct snd_soc_dai *dai)
>> +{
>> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
>> +
>> +	dai_data->is_port_started[dai->id] = false;
>> +
>> +	return 0;
>> +}
> 
> If this is needed it makes me a bit worried that we've got some kind of
> bug with not shutting things down properly somewhere - what's going on
> here?

This looks over done, we do not need to set this flag in startup, as it 
would be properly reset in shutdown.

Will remove this function totally as its not required.

> 
>> +static void q6afe_dai_shutdown(struct snd_pcm_substream *substream,
>> +				struct snd_soc_dai *dai)
>> +{
>> +	struct q6afe_dai_data *dai_data = q6afe_get_dai_data(dai->dev);
>> +	int rc;
>> +
>> +	rc = q6afe_port_stop(dai_data->port[dai->id]);
>> +	if (rc < 0)
>> +		dev_err(dai->dev, "fail to close AFE port\n");
> 
> Better to print the error code so users have more information to debug
> the problem.

Yep.

> 
>> +			.stream_name = "HDMI Playback",
>> +			.rates = SNDRV_PCM_RATE_48000 |
>> +				 SNDRV_PCM_RATE_96000 |
>> +			 SNDRV_PCM_RATE_192000,
> 
> Indentation again.
Will sort it out in next version.
> 
>> +static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
>> +				   struct of_phandle_args *args,
>> +				   const char **dai_name)
>> +{
>> +	int id = args->args[0];
>> +	int i, ret = -EINVAL;
> 
> Coding style, don't mix initialization in with other variable
> declarations on the same line like this.

Will fix all such instances in next version.

> 
>> +int q6afe_dai_dev_remove(struct device *dev)
>> +{
>> +	return 0;
>> +}
> 
> Remove empty functions, if they can't be removed it's probably not OK
> for them to be empty either.
Sure will do that.

> 
thanks,
srini
