Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2A8C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBA72075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uvdgRRDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBA72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeJXLjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:39:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39280 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeJXLjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:39:04 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9O3CtB7052199;
        Tue, 23 Oct 2018 22:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540350775;
        bh=asFRP8/czEmd3Z4LIvHtvllDK4QGN+M4ROSx8G1l52U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uvdgRRDvIXBlrNXSu9Q0S2COAA5K3DMRonUO6f1bJ3VOrR6rFjcurB0Fn0ErK3ZdH
         TUIiu0pG2fLrdiQs866xdVwuq2WkutScntxS7dQWGtwGBKxG4rhD1exVd/LMdTe2oB
         1oF2j7spdaAG/8Z+ec3kE0tlDDhKjV+vVLMyAtL4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9O3CtZx029332;
        Tue, 23 Oct 2018 22:12:55 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 22:12:54 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 22:12:54 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9O3Cs4V017774;
        Tue, 23 Oct 2018 22:12:54 -0500
Subject: Re: [PATCH v3 08/13] remoteproc: add prepare and unprepare ops
To:     Loic PALLARDY <loic.pallardy@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-9-git-send-email-loic.pallardy@st.com>
 <20180510005249.GF29093@builder>
 <b4d9dfbdc6684e59bec149f80897bd42@SFHDAG7NODE2.st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <eb72a51b-ca3c-6a50-fdcb-a06e1ddf9402@ti.com>
Date:   Tue, 23 Oct 2018 22:12:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b4d9dfbdc6684e59bec149f80897bd42@SFHDAG7NODE2.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

> >> -----Original Message-----
>> From: Bjorn Andersson [mailto:bjorn.andersson@linaro.org]
>> Sent: Thursday, May 10, 2018 2:53 AM
>> To: Loic PALLARDY <loic.pallardy@st.com>
>> Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
>> benjamin.gaignard@linaro.org
>> Subject: Re: [PATCH v3 08/13] remoteproc: add prepare and unprepare ops
>>
>> On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:
>>
>>> On some SoC architecture, it is needed to enable HW like
>>> clock, bus, regulator, memory region... before loading
>>> co-processor firmware.
>>>
>>> This patch introduces prepare and unprepare ops to execute
>>> platform specific function before firmware loading and after
>>> stop execution.
>>>
>>> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
>>> ---
>>>  drivers/remoteproc/remoteproc_core.c | 20 +++++++++++++++++++-
>>>  include/linux/remoteproc.h           |  4 ++++
>>>  2 files changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>> b/drivers/remoteproc/remoteproc_core.c
>>> index 7a500cb..0ebbc4f 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -1058,12 +1058,22 @@ static int rproc_fw_boot(struct rproc *rproc,
>> const struct firmware *fw)
>>>  		return ret;
>>>  	}
>>>
>>> +	/* Prepare rproc for firmware loading if needed */
>>> +	if (rproc->ops->prepare) {
>>> +		ret = rproc->ops->prepare(rproc);
>>> +		if (ret) {
>>> +			dev_err(dev, "can't prepare rproc %s: %d\n",
>>> +				rproc->name, ret);
>>> +			goto disable_iommu;
>>> +		}
>>> +	}
>>
>> We do allow drivers to implement custom versions of parse_fw() - and
>> they can call the resource-table-parse-fw from the custom function.
>>
>> So with the proposed refactoring in patch 9 I would like for parse_fw()
>> to call back into the core to fill out the resource lists and then
>> before jumping to rproc_start() we loop over the allocator functions.

I do like this patch and actually have a need for something similar for
supporting loading into internal memories for some R5F remote processors
on the latest TI SoCs. R5Fs have both resets and halt signals, and the
reset needs to be released to allow loading into TCMs, with the start
performing the halt. I am forced to do this between rproc_alloc() and
rproc_start() at the moment, but this really creates a mismatch between
my probe, start, stop and remove.

That said, I do agree with you that the way this was used with carveouts
should not have been used. Overloading the parse_fw to achieve above is
not right either. Please see my comments on Loic's v4 ST remoteproc
patch [1].

[1] https://patchwork.kernel.org/patch/10547153/

> 
> Agree
> Regards,
> Loic
>>
>>> +
>>>  	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
>>>
>>>  	/* load resource table */
>>>  	ret = rproc_load_rsc_table(rproc, fw);
>>>  	if (ret)
>>> -		goto disable_iommu;
>>> +		goto unprepare_rproc;
>>>
>>>  	/* reset max_notifyid */
>>>  	rproc->max_notifyid = -1;
>>> @@ -1086,6 +1096,10 @@ static int rproc_fw_boot(struct rproc *rproc,
>> const struct firmware *fw)
>>>  	kfree(rproc->cached_table);
>>>  	rproc->cached_table = NULL;
>>>  	rproc->table_ptr = NULL;
>>> +unprepare_rproc:
>>> +	/* release HW resources if needed */
>>> +	if (rproc->ops->unprepare)
>>> +		rproc->ops->unprepare(rproc);
>>>  disable_iommu:
>>>  	rproc_disable_iommu(rproc);
>>>  	return ret;
>>> @@ -1331,6 +1345,10 @@ void rproc_shutdown(struct rproc *rproc)
>>>  	/* clean up all acquired resources */
>>>  	rproc_resource_cleanup(rproc);
>>>
>>> +	/* release HW resources if needed */
>>> +	if (rproc->ops->unprepare)
>>> +		rproc->ops->unprepare(rproc);
>>
>> And this would then be handled by the rproc_resource_cleanup() function,
>> looping over all resources and calling release().
>>
>> Regards,
>> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

