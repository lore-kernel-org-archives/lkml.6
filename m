Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933497AbeEWOsR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:48:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39692 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933332AbeEWOsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:48:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4772601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [RFC PATCH 5/5] remoteproc: qcom: Introduce Hexagon V5 based WCSS
 driver
To: Vinod <vkoul@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20180523052054.19025-1-bjorn.andersson@linaro.org>
 <20180523052054.19025-6-bjorn.andersson@linaro.org>
 <20180523060516.GD20991@vkoul-mobl> <20180523065815.GZ14924@minitux>
 <20180523073723.GF20991@vkoul-mobl>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <fa0af8c1-f635-13e7-e600-4c1f91a48351@codeaurora.org>
Date: Wed, 23 May 2018 20:18:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523073723.GF20991@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 5/23/2018 1:07 PM, Vinod wrote:
> On 22-05-18, 23:58, Bjorn Andersson wrote:
>> On Tue 22 May 23:05 PDT 2018, Vinod wrote:
>>
>>> On 22-05-18, 22:20, Bjorn Andersson wrote:
>>>
>>>> +static int q6v5_wcss_reset(struct q6v5_wcss *wcss)
>>>> +{
>>>> +	int ret;
>>>> +	u32 val;
>>>> +	int i;
>>>> +
>>>> +	/* Assert resets, stop core */
>>>> +	val = readl(wcss->reg_base + QDSP6SS_RESET_REG);
>>>> +	val |= Q6SS_CORE_ARES | Q6SS_BUS_ARES_ENABLE | Q6SS_STOP_CORE;
>>>> +	writel(val, wcss->reg_base + QDSP6SS_RESET_REG);
>>>> +
>>>> +	/* BHS require xo cbcr to be enabled */
>>>> +	val = readl(wcss->reg_base + QDSP6SS_XO_CBCR);
>>>> +	val |= 0x1;
>>>> +	writel(val, wcss->reg_base + QDSP6SS_XO_CBCR);
>>>
>>> As commented on previous patch, it would help IMO to add a modify() wrapper
>>> here which would perform read, modify and write.
>>>
>>
>> Iirc the code ended up like this because a lot of these operations ended
>> up being line wrapped and harder to read using some modify(reg, mask,
>> val) helper. That said, the function isn't very pretty in it's current
>> state either...
> 
> Agreed :) and i thought modify make help it make better
> 
>> One of the parts of the RFC is that this sequence is a verbatim copy
>> from the qcom_q6v5_pil.c driver for 8996, so if we find this duplication
>> suitable I would prefer that we keep them the same.
>>
>>
>> The alternative to duplicating this function is as Sricharan proposed to
>> have the qcom_q6v5_pil.c be both a driver for both the single-stage
>> remoteproc and the two-stage (load boot loader, then modem firmware).
>>
>>> Looking at the patch, few other comments would be applicable too, so would be
>>> great if you/Sricharan can update this
>>>
>>
>> I agree, the primary purpose of this patch was rather to get feedback on
>> the structure of the drivers, I do expect this to take another round
>> through the editor to get some polishing touches. Sorry if this wasn't
>> clear from the description.
> 
> Since Sricharan replied to comments, I though they would be fixed. Yeah this is
> fine from RFC..
> 

 Thanks for this.

 Tested this on ipq8074 and wcss rproc is up with this.

 Tested-by: Sricharan R <sricharan@codeaurora.org>

 So regarding the cleanup, as i see, this consolidates the code much better.

 so about the point of avoiding duplication for soc specific functions like
 qcv5_wcss_reset common between qcv5_wcss and qcv5_pil drivers as done in my
 series, with a second thought that feels it might be difficult to maintain
 in the longer run. Since the sequences are specific to each soc and for now
 although some part of it is common, for a minor update in one soc, common
 code needs to reworked every time and tested on all boards that share them.

 So feels like having the duplication for hw init sequences is the cleaner way.

 Apart from that for other comments on the q6v5 wcss driver, i can address them
 on this final patch that you have posted and same can be included in your
 next version. Please let me know how you want to go about it.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
