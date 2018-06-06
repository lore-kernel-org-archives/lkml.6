Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gVU5VjED";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gVU5VjED"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49D5A6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932638AbeFFJv1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:51:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbeFFJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:51:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFF1C6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
To: Vinod <vkoul@kernel.org>
Cc: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        sibis@codeaurora.org
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
 <20180605061919.GQ16230@vkoul-mobl>
 <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
 <20180605164031.GZ16230@vkoul-mobl>
 <1b376fc2-6a1b-1457-ffff-332954d1bef8@codeaurora.org>
 <20180606064909.GC16230@vkoul-mobl>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <dbcbdb1c-7721-62ea-8f97-f0952a490052@codeaurora.org>
Date: Wed, 6 Jun 2018 15:21:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606064909.GC16230@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 6/6/2018 12:19 PM, Vinod wrote:
> Hi Sricharan,
> 
> On 06-06-18, 12:09, Sricharan R wrote:
> 
>>>>>> +config QCOM_Q6V5_WCSS
>>>>>> +	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
>>>>>> +	depends on OF && ARCH_QCOM
>>>>>> +	depends on QCOM_SMEM
>>>>>> +	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>>>>>> +	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>>>>>
>>>>> Is there a reason why it depends on RPMSG_QCOM_GLINK_SMEM=n? What would
>>>>> happen if distro wants both this and RPMSG_QCOM_GLINK_SMEM
>>>>>
>>>>   RPMSG_QCOM_GLINK_SMEM=n should be for the COMPILE_TEST. Probably that
>>>
>>> why would that be a limitation? I am more worried about
>>> RPMSG_QCOM_GLINK_SMEM=n being the condition here. In new drivers we
>>> should not typically have dependency on some symbol being not there
>>
>> Without that, if RPMSG_QCOM_GLINK_SMEM=m is compiled as a module, then
>> it would break the build.
> 
> Okay I do not know the details, but that doesn't sound correct to me.
> Breaking build sounds a bit extreme to me. Can you give details on this
> part..
> 

 Having, just, depends on RPMSG_QCOM_GLINK_SMEM || COMPILE_TEST,
 is going to break when RPMSG_QCOM_GLINK_SMEM=m and COMPILE_TEST=y.
 Hence the COMPILE_TEST && RPMSG_QCOM_GLINK_SMEM=n.

 Having said that, COMPILE_TEST is getting tested for RPMSG_QCOM_SMD=n in
 the previous line. So that's the reason for not having it in below line for
 RPMSG_QCOM_GLINK_SMEM.

>>>>   means that it should be corrected here and for ADSP, Q6V5_PIL as well.
>>>>   Bjorn, is that correct ?, should it be, below ?
>>>>  
>>>>   depends on (RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)) || (RPMSG_QCOM_GLINK_SMEM || (COMPILE_TEST && RPMSG_QCOM_GLINK_SMEM=n))
>>>
>>> that doesnt really sound good :(
>>
>>  Hmm, but i was thinking it should functionally depend on either SMD or GLINK and not both.
> 
> If you are depedent upon a symbol provided by a module you should say
> depends on. If a machine is not supposed to have both SMD or GLINK then
> the driver will not get probed.
> 

This is where, i was thinking, it should be functional if either of SMD or GLINK
is there, but should not require both.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
