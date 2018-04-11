Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbeDKQdj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:33:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45432 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753040AbeDKQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:33:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80334607EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Wed, 11 Apr 2018 10:33:34 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org
Subject: Re: [PATCH v5 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
Message-ID: <20180411163334.GE19682@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-6-ilina@codeaurora.org>
 <20180411003139.GE6727@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180411003139.GE6727@builder>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10 2018 at 18:31 -0600, Bjorn Andersson wrote:
>On Thu 05 Apr 09:18 PDT 2018, Lina Iyer wrote:
>> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
>[..]
>> @@ -439,6 +445,107 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
>>  }
>>  EXPORT_SYMBOL(rpmh_rsc_send_data);
>>
>> +static int find_match(const struct tcs_group *tcs, const struct tcs_cmd *cmd,
>> +		      int len)
>> +{
>> +	int i, j;
>> +
>> +	/* Check for already cached commands */
>> +	for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
>
>Wouldn't it be good if this cared about TCS boundaries?
>
A sequence would never cross a TCS boundary. So it doesn't need to be
checked.

>> +		for (j = 0; j < len; j++) {
>> +			if (tcs->cmd_cache[i] != cmd[0].addr) {
>> +				if (j == 0)
>> +					break;
>> +				WARN(tcs->cmd_cache[i + j] != cmd[j].addr,
>> +				     "Message does not match previous sequence.\n");
>> +				return -EINVAL;
>> +			} else if (j == len - 1) {
>> +				return i;
>> +			}
>> +		}
>> +	}
>> +
>> +	return -ENODATA;
>> +}
>> +
>> +static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
>> +		      int *m, int *n)
>> +{
>> +	int slot, offset;
>> +	int i = 0;
>> +
>> +	/* Find if we already have the msg in our TCS */
>
>"Search for the sequence of addresses in our tcs group"
>
OK
>> +	slot = find_match(tcs, msg->cmds, msg->num_cmds);
>> +	if (slot >= 0)
>> +		goto copy_data;
>> +
>> +	/* Do over, until we can fit the full payload in a TCS */
>> +	do {
>> +		slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
>> +						  i, msg->num_cmds, 0);
>> +		if (slot == MAX_TCS_SLOTS)
>> +			return -ENOMEM;
>> +		i += tcs->ncpt;
>> +	} while (slot + msg->num_cmds - 1 >= i);
>
>Does this conditional check that the sequence of free slots that we
>found doesn't extend past the boundary of a TCS?
>
Yes, it does.

>I'm sorry, but this code is hard to understand. I would find this much
>easier to read if there was one bitmap per TCS and you just looped over
>them to find free regions.
>
Hmm, its too many bitmaps otherwise.

>> +
>> +copy_data:
>> +	bitmap_set(tcs->slots, slot, msg->num_cmds);
>> +	/* Copy the addresses of the resources over to the slots */
>> +	for (i = 0; i < msg->num_cmds; i++)
>> +		tcs->cmd_cache[slot + i] = msg->cmds[i].addr;
>> +
>> +	offset = slot / tcs->ncpt;
>> +	*m = offset + tcs->offset;
>> +	*n = slot % tcs->ncpt;
>> +
>> +	return 0;
>> +}
>> +
>> +static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>> +{
>> +	struct tcs_group *tcs;
>> +	int m = 0, n = 0;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	tcs = get_tcs_for_msg(drv, msg);
>> +	if (IS_ERR(tcs))
>> +		return PTR_ERR(tcs);
>> +
>> +	spin_lock_irqsave(&tcs->lock, flags);
>> +	/* find the m-th TCS and the n-th position in the TCS to write to */
>> +	ret = find_slots(tcs, msg, &m, &n);
>> +	if (!ret)
>> +		__tcs_buffer_write(drv, m, n, msg);
>> +	spin_unlock_irqrestore(&tcs->lock, flags);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * rpmh_rsc_write_ctrl_data: Write request to the controller
>> + *
>> + * @drv: the controller
>> + * @msg: the data to be written to the controller
>> + *
>> + * There is no response returned for writing the request to the controller.
>> + */
>> +int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
>
>So this is exactly the same thing as rpmh_rsc_send_data() but for one of
>the non-active TCSs?
>
Yes.
>Can't we have a single API for writing msg to the hardware and if it's
>active we "send" it as well?
>
Hmm.. It can be done.

>> +{
>> +	if (!msg || !msg->cmds || !msg->num_cmds ||
>> +	    msg->num_cmds > MAX_RPMH_PAYLOAD) {
>> +		pr_err("Payload error\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Data sent to this API will not be sent immediately */
>> +	if (msg->state == RPMH_ACTIVE_ONLY_STATE)
>> +		return -EINVAL;
>
>If you're concerned about this then the API isn't clear enough.
>
>> +
>> +	return tcs_ctrl_write(drv, msg);
>> +}
>> +EXPORT_SYMBOL(rpmh_rsc_write_ctrl_data);
>> +
>>  static int rpmh_probe_tcs_config(struct platform_device *pdev,
>>  				 struct rsc_drv *drv)
>>  {
>> @@ -512,6 +619,19 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
>>  		tcs->mask = ((1 << tcs->num_tcs) - 1) << st;
>>  		tcs->offset = st;
>>  		st += tcs->num_tcs;
>> +
>> +		/*
>> +		 * Allocate memory to cache sleep and wake requests to
>> +		 * avoid reading TCS register memory.
>> +		 */
>> +		if (tcs->type == ACTIVE_TCS)
>> +			continue;
>
>Rather than "the rest of this loop shouldn't be done for the active tcs
>group" just make another loop... Or at least make the comment relate
>directly to the code it's adjacent.
>
Will move the comment out.
>> +
>> +		tcs->cmd_cache = devm_kcalloc(&pdev->dev,
>> +					      tcs->num_tcs * ncpt, sizeof(u32),
>> +					      GFP_KERNEL);
>> +		if (!tcs->cmd_cache)
>> +			return -ENOMEM;
>

Thanks for the review Bjorn.

-- Lina
