Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC2C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DD42075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G2mYSTmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DD42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJZJVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:21:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39338 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZJVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:21:48 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9Q0krew018415;
        Thu, 25 Oct 2018 19:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540514813;
        bh=eTan8QQgnjxMsXrAZqDNl2UAi35vuMqgH2Ztt+40nJM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=G2mYSTmKT3PMRXluy7SXUSaAnDgX1oG/kBgNnncKk88L7hZ1yB7KiSU/sXrQcy7y8
         RiW1bxcP78dN88p1OVOFwVGYNu7sKKijM21iS2OP/GK6OxrhiNr+fIYQWl+XWUPP+W
         Cw2hKbJfFlK5s489ZuoFsMjL4G3wLo/O8h2RXt5k=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9Q0krie028708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 19:46:53 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 25
 Oct 2018 19:46:53 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 25 Oct 2018 19:46:53 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9Q0krit030489;
        Thu, 25 Oct 2018 19:46:53 -0500
Subject: Re: [PATCH v4 01/17] remoteproc: configure IOMMU only if device
 address requested
To:     Loic PALLARDY <loic.pallardy@st.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-2-git-send-email-loic.pallardy@st.com>
 <f6af2ded-dfcd-7cb9-6557-a17c40166836@ti.com>
 <c23ecc9e33fd477c9afa03066b245644@SFHDAG7NODE2.st.com>
 <42092363-d9ff-9a98-680d-9c8fbeaed2be@ti.com>
 <1b7e02e6762d4f02b21706d5a4a8c502@SFHDAG7NODE2.st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <1acf91fd-e0f6-22aa-d3a5-ab1fd91ad195@ti.com>
Date:   Thu, 25 Oct 2018 19:46:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1b7e02e6762d4f02b21706d5a4a8c502@SFHDAG7NODE2.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

> >> -----Original Message-----
>> From: Suman Anna <s-anna@ti.com>
>> Sent: mercredi 24 octobre 2018 05:47
>> To: Loic PALLARDY <loic.pallardy@st.com>; bjorn.andersson@linaro.org;
>> ohad@wizery.com
>> Cc: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
>> benjamin.gaignard@linaro.org
>> Subject: Re: [PATCH v4 01/17] remoteproc: configure IOMMU only if device
>> address requested
>>
>> On 10/23/18 2:40 PM, Loic PALLARDY wrote:
>>> Hi Suman,
>>>
>>>> -----Original Message-----
>>>> From: Suman Anna <s-anna@ti.com>
>>>> Sent: mardi 23 octobre 2018 19:26
>>>> To: Loic PALLARDY <loic.pallardy@st.com>; bjorn.andersson@linaro.org;
>>>> ohad@wizery.com
>>>> Cc: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
>>>> benjamin.gaignard@linaro.org
>>>> Subject: Re: [PATCH v4 01/17] remoteproc: configure IOMMU only if
>> device
>>>> address requested
>>>>
>>>> Hi Loic,
>>>>
>>>> On 7/27/18 8:14 AM, Loic Pallardy wrote:
>>>>> If there is no IOMMU associate to remote processor device,
>>>>> remoteproc_core won't be able to satisfy device address requested
>>>>> in firmware resource table.
>>>>> Return an error as configuration won't be coherent.
>>>>>
>>>>> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
>>>>
>>>> This patch is breaking my Davinci platforms. It is not really required
>>>> that you _should_ have IOMMUs when a valid DA is mentioned. Please
>> see
>>>> the existing description (paras 4 and 5) on the fw_rsc_carveout
>>>> kerneldoc in remoteproc.h file.
>>>
>>> Thanks for pointing this comment. Indeed sMMU is not mandatory, and at
>> first sight I agree we should remove the restriction introduced by the patch.
>>> Driver porting on the series should be done before adding this.
>>>>
>>>> We do have platforms where we have some internal sub-modules within
>> the
>>>> remote processor sub-system that provides some linear
>>>> address-translation (most common case with 32-bit processors supporting
>>>> 64-bit addresses). Also, we have some upcoming SoCs where we have an
>>>> MMU
>>>> but is not programmable by Linux.
>>>>
>>>> There is one comment there, but I don't think this is actually handled
>>>> in the current remoteproc core.
>>>> "If @da is set to
>>>>  * FW_RSC_ADDR_ANY, then the host will dynamically allocate it, and
>> then
>>>>  * overwrite @da with the dynamically allocated address."
>>>>
>>> I don't remember it was implemented like described.
>>
>> Yes, it was missing, and one of your patches seem to add this behavior
>> now. That said, I really don't think the remoteproc core can dictate the
>>  da. Even if the individual remoteproc driver were to furnish this, how
>> would you get such data without forcing a fixed behavior for all
>> possible firmwares (not desirable). We should get rid of this comment,
>> and any code that seems to do this.
> 
> Agree that if some rules are fixed by firmware, rproc core can't overwrite them.
> It was the goal of the patch as without sMMU if you don't have a match between rproc core carveout allocation and firmware rsc request, rproc core can't answer the request.

Question is what are we going to use to check that - da or pa? With
fixed memory support, I would think that this would have to be based on
pa if specified. Given that the meaning of da can change from firmware
to firmware (in the case of some translators), but you can only reserve
a fixed reserved memory at kernel bootup time.

> In the rest of the series, da in rsc table is updated only in some specific cases (i.e. da is equal to FW_RSC_ADDR_ANY). If there is a force update I agree we should not allow it.
>>
>>>
>>> I have remarks about the comment:
>>> "* We will always use @da to negotiate the device addresses, even if it
>>>  * isn't using an iommu. In that case, though, it will obviously contain
>>>  * physical addresses."
>>>
>>> When there is no sMMU, we can't consider that da contains a physical
>> address because coprocessor can have its own memory map just because it
>> is a 32bit processor accessing only a part of the memory and the main is 64bit
>> one. The 2 processors won't see the internal memory at the same base
>> address for example.
>>
>> Agreed, believe it was valid when it was written (32-bit platforms
>> supporting 32-bit addresses). I think this is akin to an IPA
>> (Intermediate Physical Address).
>>
>>> So what should we do when carveout allocated by host is not fitting with
>> resource table request?
>>> - put a warning and overwrite da address in the resource table?
>>
>> Hmm, why da? This goes to my earlier comment about how you are able to
>> decide the da. Atleast your current ST driver seems to be assigning the
>> same value as the physical bus address for da, which would prompt why
>> you would still need a carveout entry in the resource table if it is
>> truly one-to-one.
>>
>> Eg, I have an upcoming usecase with R5Fs on newer TI SoCs where we
>> actually have a sub-module called Region Address Translator (RAT) which
>> can only be programmed by the R5F for translating the 32-bit CPU
>> addresses to larger physical address space, and yet I need the da and pa
>> to be able to do loading. I cannot dictate the da since that is what the
>> firmware images are linked against. So, have to rely on the firmware
>> providing this data for me.
>>
>>> - stop rproc probe as no match detected?
>>
>> I think that is the safest approach.
> 
> So we agree on the patch if a WARN is added and comment updated.
> Are we aligned ?

Did you mixup the comments from patch 2 here? This patch is still not ok
because of the implicit assumptions - we can have a valid da specified
even with no MMUs (because of some psuedo-MMU like sub-modules that can
provide the translation on the remote-processor side).

> 
>>
>>>
>>> Later in the series, carveout allocation is changed. Resource table carveout
>> are either linked with an existing carveout registered by driver or added to
>> carveout list for allocations.
>>> In the case you described, TI driver should first register the specific
>> carveout regions thank to the helper.
>>
>> The current series should still continue to work without having to
>> enforce new name assignments (unless needed and being defined to use
>> the
>> new features being added).
>>

> OK but if we implement above solution, if da is different from "dma" address (from dma_alloc_coherent) and no sMMU registered, rproc start procedure will failed.

That would be the case only when you have no translators of any kind in
between the CPU and the bus right within the remote processor subsystem
right and really da == dma (or pa)? In patch 2, you modified the rsc->pa
from dma to rproc_va_to_pa() to actually reflect the pa, yet here using
dma as the actual device address.

regards
Suman

> 
> Regards,
> Loic
>>>
>>> Regards,
>>> Loic
>>>
>>>> regards
>>>> Suman
>>>>
>>>>> ---
>>>>>  drivers/remoteproc/remoteproc_core.c | 10 +++++++++-
>>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>>> b/drivers/remoteproc/remoteproc_core.c
>>>>> index 4cd1a8e..437fabf 100644
>>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>>> @@ -657,7 +657,15 @@ static int rproc_handle_carveout(struct rproc
>>>> *rproc,
>>>>>  	 * to use the iommu-based DMA API: we expect 'dma' to contain the
>>>>>  	 * physical address in this case.
>>>>>  	 */
>>>>> -	if (rproc->domain) {
>>>>> +
>>>>> +	if (rsc->da != FW_RSC_ADDR_ANY && !rproc->domain) {
>>
>> Maybe this should really be a reverse check when you have MMUs,
>> if (rproc->domain && rsc->da == FW_RSC_ADDR_ANY)
>>
>> regards
>> Suman
>>
>>>>> +		dev_err(dev->parent,
>>>>> +			"Bad carveout rsc configuration\n");
>>>>> +		ret = -ENOMEM;
>>>>> +		goto dma_free;
>>>>> +	}
>>>>> +
>>>>> +	if (rsc->da != FW_RSC_ADDR_ANY && rproc->domain) {
>>>>>  		mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
>>>>>  		if (!mapping) {
>>>>>  			ret = -ENOMEM;
>>>>>
>>>
> 

