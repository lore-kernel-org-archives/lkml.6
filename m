Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C2220657
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i8zuosJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C2220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeIYX3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:29:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39260 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeIYX3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:29:33 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8PHKpCg037770;
        Tue, 25 Sep 2018 12:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537896052;
        bh=377WllVwQlRFzzvanaaYGAhAdZqtgdgh+pnvVx/M9ME=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i8zuosJcMCb1lm9UKfbQULtRfgehf0cno7Nd7xUsW1m8wAtQDRI/08fNkx8l9rXRG
         Q89WApdmVYiu33FZP9WlNyeRiP3pFaa8/QXeeI3ulS6031sHmTz+y8fXatT2coqBe4
         j176tTrKRYNpxqiBNuJ8uIHmZu/ZOwhXA+3eaPT0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8PHKpwM009196;
        Tue, 25 Sep 2018 12:20:51 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 25
 Sep 2018 12:20:52 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 25 Sep 2018 12:20:51 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8PHKp0g026408;
        Tue, 25 Sep 2018 12:20:51 -0500
Subject: Re: [PATCH] rpmsg: core: add support to power domains for devices
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        <stable@vger.kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180615095939.1331-1-srinivas.kandagatla@linaro.org>
 <a80cce14-9e57-32a2-760f-3d29de009f99@ti.com>
 <604f52b3-1296-8443-36a3-399c69561713@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <3e5ea87d-02ac-c3a3-2eaf-7b6ba8be348b@ti.com>
Date:   Tue, 25 Sep 2018 12:20:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <604f52b3-1296-8443-36a3-399c69561713@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On 09/25/2018 03:29 AM, Srinivas Kandagatla wrote:
> Hi Suman,
> 
> On 25/09/18 01:25, Suman Anna wrote:
>> Hi Srinivas,
>>
>> On 06/15/2018 04:59 AM, Srinivas Kandagatla wrote:
>>> Some of the rpmsg devices need to switch on power domains to communicate
>>> with remote processor. For example on Qualcomm DB820c platform LPASS
>>> power domain needs to switched on for any kind of audio services.
>>> This patch adds the missing power domain support in rpmsg core.
>>>
>>> Without this patch attempting to play audio via QDSP on DB820c would
>>> reboot the system.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>   drivers/rpmsg/rpmsg_core.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>> index b714a543a91d..8122807db380 100644
>>> --- a/drivers/rpmsg/rpmsg_core.c
>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>> @@ -15,6 +15,7 @@
>>>   #include <linux/module.h>
>>>   #include <linux/rpmsg.h>
>>>   #include <linux/of_device.h>
>>> +#include <linux/pm_domain.h>
>>>   #include <linux/slab.h>
>>>     #include "rpmsg_internal.h"
>>> @@ -449,6 +450,10 @@ static int rpmsg_dev_probe(struct device *dev)
>>>       struct rpmsg_endpoint *ept = NULL;
>>>       int err;
>>>   +    err = dev_pm_domain_attach(dev, true);
>>> +    if (err)
>>> +        goto out;
>>
>> This patch has broken the virtio-rpmsg stack based rpmsg devices. These
>> devices are non-DT and the rpmsg_dev_probe() is now failing with -19
>> (-ENODEV) error code.
>>
> 
> There seems to be some dependency on this patch (
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.19-rc5&id=919b7308fcc452cd4e282bab389c33384a9f3790
> ) which seems to rework the return values from acpi_dev_pm_attach() and
> genpd_dev_pm_attach()
> 

OK, I see that dependent commit is part of the 4.18 Linux kernel. So
mainline kernel has no issues, but this patch was picked up in 4.14.71
(don't know why) as commit 1ed3a9307230, so 4.14 stable is broken. So,
how do we proceed here - don't think we can pick all those dependent
patches against stable.

regards
Suman

> 
> 
> --srini
> 
> 
>> Loic, Arnaud,
>> Can one of you double-confirm this behavior on ST platforms as well?
>> The patch came through 4.14.71 stable release and broke our downstream
>> kernels.
>>
>> regards
>> Suman
>>
>>> +
>>>       if (rpdrv->callback) {
>>>           strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
>>>           chinfo.src = rpdev->src;
>>> @@ -490,6 +495,8 @@ static int rpmsg_dev_remove(struct device *dev)
>>>         rpdrv->remove(rpdev);
>>>   +    dev_pm_domain_detach(dev, true);
>>> +
>>>       if (rpdev->ept)
>>>           rpmsg_destroy_ept(rpdev->ept);
>>>  
>>

