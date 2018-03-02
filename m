Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423803AbeCBNN0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:13:26 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34632 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423710AbeCBNNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:13:20 -0500
X-Google-Smtp-Source: AG47ELsHBhCmKbIGE3dlpaSwcBnT7336Qrf0KOY/SbVh9eNtxrERINwQV5Z1qxw2Vy7qHXQLvPeyzQ==
Subject: Re: [PATCH v3 05/25] ASoC: qcom: qdsp6: Add support to Q6AFE
To: Mark Brown <broonie@kernel.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
 <20180301205940.GR12864@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <66d37327-b8ea-0da5-3e05-435cec5d84ab@linaro.org>
Date: Fri, 2 Mar 2018 13:13:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180301205940.GR12864@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review comments,

On 01/03/18 20:59, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:58:17PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
>> +// SPDX-License-Identifier: GPL-2.0
>> +#ifndef __DT_BINDINGS_Q6_AFE_H__
>> +#define __DT_BINDINGS_Q6_AFE_H__
>> +
>> +/* Audio Front End (AFE) Ports */
>> +#define AFE_PORT_HDMI_RX	8
>> +
>> +#endif /* __DT_BINDINGS_Q6_AFE_H__ */
> 
> Please use a C++ comment here as well for consistency, it looks more
> intentional.
> 
Yep, I will fix such occurrences in next version.

>> +config SND_SOC_QDSP6_AFE
>> +	tristate
>> +	default n
>> +
> 
> n is the default anyway, no need to specify it (I know some uses already
> slipped through here but it'd be better to fix those).
> 
>> index 000000000000..0a5af06bb50e
>> --- /dev/null
>> +++ b/sound/soc/qcom/qdsp6/q6afe.c
>> @@ -0,0 +1,520 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2011-2017, The Linux Foundation
>> + * Copyright (c) 2018, Linaro Limited
>> + */
> 
Yep, I will fix this, I think I picked this up variant while this was 
still being discussed. I will fix all such occurrences.

> Same here with the comment, just make the whole comment a C++ comment
> rather than having one comment using both styles.  Similar things apply
> elsewhere.
> 
>> +/* Port map of index vs real hw port ids */
>> +static struct afe_port_map port_maps[AFE_PORT_MAX] = {
>> +	[AFE_PORT_HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX,
>> +				AFE_PORT_HDMI_RX, 1, 1},
>> +};
> 
> Is this not device specific in any way?  It looks likely to be.
It is specific to Audio firmware build.
AFAIK, DSP port IDs are consistent across a given range of AVS firmware 
builds. So far I have seen them not change in any of the B family SoCs.
However on older A family SOCs these are very different numbers. Which 
is where ADSP version info would help select correct map.

> 
>> +static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
>> +{
>> +	struct q6afe_port *p = NULL;
>> +
>> +	spin_lock(&afe->port_list_lock);
>> +	list_for_each_entry(p, &afe->port_list, node)
>> +		if (p->token == token)
>> +			break;
>> +
>> +	spin_unlock(&afe->port_list_lock);
> 
> Why do we need to lock the port list, what are we protecting it against?

This is just to protect the list from anyone deleting this.

Its very rare but the use case could be somelike the adsp is up and we 
are in the middle of finding a port and then adsp went down or crashed 
we would delete an entry in the list.

> We don't write here which suggests either there's some kind of race
> condition in this lookup or the lock is not doing anything.
> 
>> +static int afe_callback(struct apr_device *adev,
>> +			struct apr_client_message *data)
>> +{
>> +	struct q6afe *afe = dev_get_drvdata(&adev->dev);
>> +	struct aprv2_ibasic_rsp_result_t *res;
>> +	struct q6afe_port *port;
>> +
>> +	if (!data->payload_size)
>> +		return 0;
>> +
>> +	res = data->payload;
>> +	if (data->opcode == APR_BASIC_RSP_RESULT) {
>> +		if (res->status) {
> 
> Shouldn't we use a switch statement here in case we want to handle
> something else?

Yep, I will fix this.

> 
>> +		switch (res->opcode) {
>> +		case AFE_PORT_CMD_SET_PARAM_V2:
>> +		case AFE_PORT_CMD_DEVICE_STOP:
>> +		case AFE_PORT_CMD_DEVICE_START:
>> +			afe->state = AFE_CMD_RESP_AVAIL;
>> +			port = afe_find_port(afe, data->token);
>> +			if (port)
>> +				wake_up(&port->wait);
> 
> No locking here?  It seems a bit odd that the AFE global state is being
> set to say there's a response available but we wake a specific port.
> 

This callback is invoked in interrupt context and sends are serialized 
at afe level.

Yep, It does not make sense to have a global state, I will fix this by 
making this state specific to port.

>> +	ret = apr_send_pkt(afe->apr, data);
>> +	if (ret < 0) {
>> +		dev_err(afe->dev, "packet not transmitted\n");
>> +		ret = -EINVAL;
>> +		goto err;
> 
> Why squash the error code here?  We don't even print it.
Will fix this in next version.
> 
>> +	}
>> +
>> +	ret = wait_event_timeout(*wait, (afe->state == AFE_CMD_RESP_AVAIL),
>> +				 msecs_to_jiffies(TIMEOUT_MS));
>> +	if (!ret) {
>> +		ret = -ETIMEDOUT;
>> +	} else if (afe->status > 0) {
>> +		dev_err(afe->dev, "DSP returned error[%s]\n",
>> +		       q6dsp_strerror(afe->status));
>> +		ret = q6dsp_errno(afe->status);
> 
> If we time out here and the DSP delivers a response later it looks like
> we'll get data corruption - the DSP will happily deliver the response
> into shared state.
> 
If I make this state specific to port, we could handle this case much 
cleanly.

>> +static int afe_port_start(struct q6afe_port *port,
>> +			  union afe_port_config *afe_config)
>> +{
>> +	struct afe_audioif_config_command config = {0,};
>> +	struct q6afe *afe = port->afe;
>> +	int port_id = port->id;
>> +	int ret, param_id = port->cfg_type;
>> +
>> +	config.port = *afe_config;
>> +
>> +	ret  = q6afe_port_set_param_v2(port, &config, param_id,
>> +				       sizeof(*afe_config));
>> +	if (ret) {
>> +		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
>> +			port_id, ret);
>> +		return ret;
>> +	}
>> +	return afe_send_cmd_port_start(port);
> 
> Why not just inline this function here?  It appears to have only this
> user.
Will do that.

> 
>> +	int index = 0;
> 
> We set index to 0...
does not make sense, will remove this initialization.
>> +
>> +	port_id = port->id;
>> +	index = port->token;
> 
> ...the unconditionally overwrite it?
> 
>> +/**
>> + * q6afe_port_start() - Start a afe port
>> + *
>> + * @port: Instance of port to start
>> + *
>> + * Return: Will be an negative on packet size on success.
>> + */
>> +int q6afe_port_start(struct q6afe_port *port)
>> +{
>> +	return afe_port_start(port, &port->port_cfg);
>> +}
>> +EXPORT_SYMBOL_GPL(q6afe_port_start);
> 
> This is the third level of wrapper for the port start command in this
> file.  Do we *really* need all these wrappers?

Intention here is that we have plans to support different version of 
ADSP, on A family this command is different, so having this wrapper 
would help tackle this use-case.
> 
>> +struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
>> +{
> 
>> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>> +	if (!port)
>> +		return ERR_PTR(-ENOMEM);
> 
> The _port_get_ function is allocating data but...
> 
>> +/**
>> + * q6afe_port_put() - Release port reference
>> + *
>> + * @port: Instance of port to put
>> + */
>> +void q6afe_port_put(struct q6afe_port *port)
>> +{
>> +	struct q6afe *afe = port->afe;
>> +
>> +	spin_lock(&afe->port_list_lock);
>> +	list_del(&port->node);
>> +	spin_unlock(&afe->port_list_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(q6afe_port_put);
> 
> ...the _port_put() function isn't freeing it.  That seems leaky.  I'm

Yes, I can probably free it here instead of depending on device core to 
do that.

> also a bit worried about this being a spinlock that we're using for
> allocation, and not even spin_lock_irqsave().  Presumably this is
> protecting against interrupts otherwise we'd not need a spinlock but
> for that to work we'd need the _irqsave()?
Yes, I need to use _irqsave/restore variant here, Will fix that in next 
version,
> 
Thanks,
Srini
