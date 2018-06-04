Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeFDJRE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:17:04 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36235 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeFDJRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:17:01 -0400
X-Google-Smtp-Source: ADUXVKJR188jWzJKJkmLahqt8uzBAXE8s0UO1fpsWF0ftlzO5vW1/kFMUJ7Zi7WFNKOwLLFrehZECg==
Subject: Re: [PATCH] rpmsg: smd: do not use mananged resources for endpoints
 and channels
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgoswami@codeaurora.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        stable@vger.kernel.org
References: <20180601233231.11230-1-srinivas.kandagatla@linaro.org>
 <20180604004940.GA3206@builder>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <df8e6949-cf69-cca0-0668-7f9505fb38be@linaro.org>
Date: Mon, 4 Jun 2018 10:16:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180604004940.GA3206@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/06/18 01:49, Bjorn Andersson wrote:
> On Fri 01 Jun 16:32 PDT 2018, Srinivas Kandagatla wrote:
>> @@ -1380,11 +1380,13 @@ static void qcom_smd_edge_release(struct device *dev)
>>   {
>>   	struct qcom_smd_channel *channel;
>>   	struct qcom_smd_edge *edge = to_smd_edge(dev);
>> +	struct list_head *this, *tmp;
>>   
>> -	list_for_each_entry(channel, &edge->channels, list) {
>> -		SET_RX_CHANNEL_INFO(channel, state, SMD_CHANNEL_CLOSED);
>> -		SET_RX_CHANNEL_INFO(channel, head, 0);
>> -		SET_RX_CHANNEL_INFO(channel, tail, 0);
>> +	list_for_each_safe(this, tmp, &edge->channels) {
>> +		channel = list_entry(this, struct qcom_smd_channel, list);
> 
> Is there a reason not to use list_for_each_entry_safe()?
> 
No, I will respin the patch with this change.
thanks,
srini
>> +		list_del(&channel->list);
>> +		kfree(channel->name);
>> +		kfree(channel);
> 
> Regards,
> Bjorn
> 
