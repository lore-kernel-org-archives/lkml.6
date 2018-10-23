Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F8C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4A620813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G/TXyMok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4A620813
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeJXCEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:04:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48148 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeJXCEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:04:33 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NHe7wS077142;
        Tue, 23 Oct 2018 12:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540316407;
        bh=lme3swre1KmJlG3BeN5UK60iQ3gEQNO4+3zoH8z/z38=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=G/TXyMokMBV6eBMcymphE3sGwrAG/dYW65Fwk/scPcQF0COz0ebIUHyTGBHkJgkPj
         5mq5MyT/hFa+K6GyxuGtOSP1NELOR0nNYvB3TA3LgkI2cHtjkaKlgFZ2Q6pP0dcFPx
         ymggWXkZcU/QlFGkFIt6B73ryChLIR+V5EXO1PC4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9NHe7wr104263
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 12:40:07 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 12:40:07 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 12:40:07 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NHe7Ji016207;
        Tue, 23 Oct 2018 12:40:07 -0500
Subject: Re: [PATCH v2 05/16] remoteproc: modify rproc_handle_carveout to
 support preallocated region
To:     Loic PALLARDY <loic.pallardy@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
References: <1512060411-729-1-git-send-email-loic.pallardy@st.com>
 <1512060411-729-6-git-send-email-loic.pallardy@st.com>
 <20171214005917.GG17344@builder>
 <0bbc0455b6ee45cdb0ebab04117b6a40@SFHDAG7NODE2.st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <9ced2a8b-916e-9447-4be7-6316385ade0a@ti.com>
Date:   Tue, 23 Oct 2018 12:40:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0bbc0455b6ee45cdb0ebab04117b6a40@SFHDAG7NODE2.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> On Thu 30 Nov 08:46 PST 2017, Loic Pallardy wrote:
>>
>>> In current version rproc_handle_carveout function support only dynamic
>>> region allocation.
>>> This patch extends rproc_handle_carveout function to support different
>> carveout
>>> configurations:
>>> - fixed DA and fixed PA: check if already part of pre-registered carveouts
>>> (platform driver). If no, return error.
>>> - fixed DA and any PA: check if already part of pre-allocated carveouts
>>> (platform driver). If not found and rproc supports iommu, continue with
>>> dynamic allocation (DA will be used for iommu programming), else return
>>> error as no way to force DA.
>>> - any DA and any PA: use original dynamic allocation
>>>
>>> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
>>> ---
>>>  drivers/remoteproc/remoteproc_core.c | 40
>> ++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 40 insertions(+)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>> b/drivers/remoteproc/remoteproc_core.c
>>> index 78525d1..515a17a 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -184,6 +184,10 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da,
>> int len)
>>>  	struct rproc_mem_entry *carveout;
>>>  	void *ptr = NULL;
>>>
>>> +	/*
>>> +	 * da_to_va platform driver is deprecated. Driver should register
>>> +	 * carveout thanks to rproc_add_carveout function
>>> +	 */
>>
>> I think this comment is unrelated to the rest of this patch. I also
>> think that at the end of the carveout-rework we should have a patch
>> removing this ops.
> 
> I'll remove this comment and add a da_to_va clean-up patch at the end of the series

da_to_va platform ops is actually used to provide the remoteproc
internal memory translations for the most part, not restricted just to
fixed carveouts. Also, typically these do have multiple address-views -
one the regular bus-address view, and another a remote processor address
view.

regards
Suman

> 
>>
>>>  	if (rproc->ops->da_to_va) {
>>>  		ptr = rproc->ops->da_to_va(rproc, da, len);
>>>  		if (ptr)
>>> @@ -677,6 +681,7 @@ static int rproc_handle_carveout(struct rproc
>> *rproc,
>>>  	struct rproc_mem_entry *carveout, *mapping;
>>>  	struct device *dev = &rproc->dev;
>>>  	dma_addr_t dma;
>>> +	phys_addr_t pa;
>>>  	void *va;
>>>  	int ret;
>>>
>>> @@ -698,6 +703,41 @@ static int rproc_handle_carveout(struct rproc
>> *rproc,
>>>  	if (!carveout)
>>>  		return -ENOMEM;
>>>
>>> +	/* Check carveout rsc already part of a registered carveout */
>>> +	if (rsc->da != FW_RSC_ADDR_ANY) {
>>
>> As mentioned before, I consider it perfectly viable for rsc->da to be
>> ANY and the driver providing a fixed carveout.
> 
> Yes I'll change sequence to lookup by name first and then verify exact parameters matching , not only da definition.
> 
>>
>>> +		va = rproc_find_carveout_by_da(rproc, rsc->da, rsc->len);
>>> +
>>> +		if (va) {
>>
>> In a system with an iommu it's possible that rsc->len is larger than
>> some carveout->len and va is NULL here so we fall through, allocate some
>> memory and remap a segment of the carveout. (Or hopefully fails
>> attempting).
>>
>>> +			/* Registered region found */
>>> +			pa = rproc_va_to_pa(va);
>>> +			if (rsc->pa != FW_RSC_ADDR_ANY && rsc->pa !=
>> (u32)pa) {
>>> +				/* Carveout doesn't match request */
>>> +				dev_err(dev->parent,
>>> +					"Failed to find carveout fitting da and
>> pa\n");
>>> +				return -ENOMEM;
>>> +			}
>>> +
>>> +			/* Update rsc table with physical address */
>>> +			rsc->pa = (u32)pa;
>>> +
>>> +			/* Update carveouts list */
>>> +			carveout->va = va;
>>> +			carveout->len = rsc->len;
>>> +			carveout->da = rsc->da;
>>> +			carveout->priv = (void *)CARVEOUT_RSC;
>>> +
>>> +			list_add_tail(&carveout->node, &rproc->carveouts);
>>
>> rproc_find_carveout_by_da() will return a reference into a carveout, now
>> we add another overlapping carveout into the same list.
>>
>>
>> I think it would be saner to not allow the resource table to describe
>> subsets of carveouts registered by the driver.
>>
>> In which case this would better find a carveout by name or exact da,
>> then check that the pa, da, len and rsc->flags are adequate.
> 
> Agree
> /Loic
>>
>>> +
>>> +			return 0;
>>> +		}
>>> +
>>> +		if (!rproc->domain) {
>>
>> Currently this function ignore invalid values of da when !domain, so I
>> think it would be good you can submit this sanity check in it's own
>> patch so that anyone bisecting this would know why their broken firmware
>> suddenly isn't loadable.
>>
>>> +			dev_err(dev->parent,
>>> +				"Bad carveout rsc configuration\n");
>>> +			return -ENOMEM;
>>> +		}
>>> +	}
>>> +
>>
>> Regards,
>> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

