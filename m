Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781F3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B02D20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kbf6jSps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B02D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJZHYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:24:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49138 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeJZHYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:24:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9PMo7Qm115848;
        Thu, 25 Oct 2018 17:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540507807;
        bh=M5RrSis0IJYZXofFfHCRuJXKKOp70bhksYRr4BEZTC4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kbf6jSpsba5WGUjWG7ihJmx136src61qT9g7t0vIv4CBkZeYRZxBMauZ7Aip7V83C
         tCfHByi5LdY4xv19G9NhLbZ7xbeK1rflEItMIAzPTG4OwQ/FFDjGdZzt2DwkXSEVx/
         5n870mb8T+TAm46D9E3/+t2pGZlr3skP5I4KJPHE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9PMo7Nc051841
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 17:50:07 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 25
 Oct 2018 17:50:07 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 25 Oct 2018 17:50:07 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9PMo7Zg010934;
        Thu, 25 Oct 2018 17:50:07 -0500
Subject: Re: [PATCH v4 10/17] remoteproc: add helper function to check
 carveout device address
To:     Loic PALLARDY <loic.pallardy@st.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-11-git-send-email-loic.pallardy@st.com>
 <2844874b-9484-aeee-c614-411d0ff38d12@ti.com>
 <8b16461d7d99487480253cde5cdcfd2c@SFHDAG7NODE2.st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <5e86ac7e-e0db-205e-1c60-bc0be9f75859@ti.com>
Date:   Thu, 25 Oct 2018 17:50:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8b16461d7d99487480253cde5cdcfd2c@SFHDAG7NODE2.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On 10/24/18 10:24 AM, Loic PALLARDY wrote:
> Hi Suman,
> 
>> -----Original Message-----
>> From: Suman Anna <s-anna@ti.com>
>> Sent: mercredi 24 octobre 2018 00:14
>> To: Loic PALLARDY <loic.pallardy@st.com>; bjorn.andersson@linaro.org;
>> ohad@wizery.com
>> Cc: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
>> benjamin.gaignard@linaro.org
>> Subject: Re: [PATCH v4 10/17] remoteproc: add helper function to check
>> carveout device address
>>
>> Hi Loic,
>>
>> On 7/27/18 8:14 AM, Loic Pallardy wrote:
>>> This patch introduces a function to verify that a specified carveout
>>> is fitting request device address and associated length
>>>
>>> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
>>> ---
>>>  drivers/remoteproc/remoteproc_core.c | 47
>> ++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 47 insertions(+)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>> b/drivers/remoteproc/remoteproc_core.c
>>> index 1e0fe3e..5dd5edf 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -259,6 +259,53 @@ struct rproc_mem_entry *
>>>  	return mem;
>>>  }
>>>
>>> +/**
>>> + * rproc_check_carveout_da() - Check specified carveout da configuration
>>> + * @rproc: handle of a remote processor
>>> + * @mem: pointer on carveout to check
>>> + * @da: area device address
>>> + * @len: associated area size
>>> + *
>>> + * This function is a helper function to verify requested device area
>> (couple
>>> + * da, len) is part of specified carevout.
>>
>> %s/carevout/carveout/
> OK
>>
>>> + *
>>> + * Return: 0 if carveout matchs request else -ENOMEM
>>
>> %s/matchs/matches/
> OK
>>
>>> + */
>>> +int rproc_check_carveout_da(struct rproc *rproc, struct
>> rproc_mem_entry *mem,
>>
>> static int since this seems to be only a local function.
> OK
>>
>>> +			    u32 da, u32 len)
>>> +{
>>> +	struct device *dev = &rproc->dev;
>>> +	int delta = 0;
>>> +
>>> +	/* Check requested resource length */
>>> +	if (len > mem->len) {
>>> +		dev_err(dev, "Registered carveout doesn't fit len
>> request\n");
>>> +		return -ENOMEM;
>>
>> ENOMEM not typically used for these kind of errors, you were probably
>> inclined to used this since it is dealing with memory.
> 
> -EINVAL will be better
>>
>>> +	}
>>> +
>>
>> Both the below codepaths are exercised only when da is not
>> FW_RSC_ADDR_ANY, and you are returning 0 otherwise (which is the case of
>> matches as per your description above). Is that what you really want -
>> should it be an error
> 
> Yes when da is equal to FW_RSC_ADDR_ANY we should check the length too

Can you update the comments in the function description accordingly as
well, the current code silently returns 0 if da = FW_RSC_ADDR_ANY.

> 
>>
>>> +	if (da != FW_RSC_ADDR_ANY && mem->da == FW_RSC_ADDR_ANY)
>> {
>>> +		/* Update existing carveout da */
>>> +		mem->da = da;
>>
>> Where would you need to update this?

> In that case, we have 2 carveouts with the same name.
> One has some fixed requests. The other one has none.
> The goal here is to align both on the one which has the strongest requirements.
> I think length is missing.

It almost looks like there is a need for range overlap checks on all the
carveouts after all of them are registered, and error out if any overlap
irrespective of the name schema.

regards
Suman

> 
> Regards,
> Loic
> 
>>
>> regards
>> Suman
>>
>>> +	} else if (da != FW_RSC_ADDR_ANY && mem->da !=
>> FW_RSC_ADDR_ANY) {
>>> +		delta = da - mem->da;
>>> +
>>> +		/* Check requested resource belongs to registered carveout
>> */
>>> +		if (delta < 0) {
>>> +			dev_err(dev,
>>> +				"Registered carveout doesn't fit da
>> request\n");
>>> +			return -ENOMEM;
>>> +		}
>>> +
>>> +		if (delta + len > mem->len) {
>>> +			dev_err(dev,
>>> +				"Registered carveout doesn't fit len
>> request\n");
>>> +			return -ENOMEM;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>
>>
>>> +}
>>> +
>>>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>>>  {
>>>  	struct rproc *rproc = rvdev->rproc;
>>>
> 

