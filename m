Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F1CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8A320867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tdQ6AThl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8A320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeIZBLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:11:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60758 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbeIZBLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:11:20 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8PJ2KDp026750;
        Tue, 25 Sep 2018 14:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537902140;
        bh=gvM2BMb5/+wRo8hBW8lNGwU9bNQDFGg/1zKYayIboX4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tdQ6AThlho7ucnL+SIh6z5njGv5QDzPYp4lV0ZtHuEkYTU/5cwQuiuR9CFt3FwbOD
         8nFtaIS/EzDw+tMjRTQJyB6bTR9zSOgPfirpizLDTRHxnEhqkANT8qBoEeYn9Y6hM2
         TamB2uYDv2rU6vu6AEi1bliuUAW+zdN3mnmMTL7Q=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8PJ2KAh009107;
        Tue, 25 Sep 2018 14:02:20 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 25
 Sep 2018 14:02:20 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 25 Sep 2018 14:02:20 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8PJ2J7Z018041;
        Tue, 25 Sep 2018 14:02:20 -0500
Subject: Re: [PATCH] rpmsg: core: add support to power domains for devices
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>
References: <20180615095939.1331-1-srinivas.kandagatla@linaro.org>
 <a80cce14-9e57-32a2-760f-3d29de009f99@ti.com>
 <91dda9df-8074-925d-dcd3-d7c01e6f2363@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <9afb010d-397f-2103-6692-bb4ca55b8236@ti.com>
Date:   Tue, 25 Sep 2018 14:02:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <91dda9df-8074-925d-dcd3-d7c01e6f2363@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

> On 09/25/2018 02:25 AM, Suman Anna wrote:
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
>>>  drivers/rpmsg/rpmsg_core.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>> index b714a543a91d..8122807db380 100644
>>> --- a/drivers/rpmsg/rpmsg_core.c
>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/rpmsg.h>
>>>  #include <linux/of_device.h>
>>> +#include <linux/pm_domain.h>
>>>  #include <linux/slab.h>
>>>  
>>>  #include "rpmsg_internal.h"
>>> @@ -449,6 +450,10 @@ static int rpmsg_dev_probe(struct device *dev)
>>>  	struct rpmsg_endpoint *ept = NULL;
>>>  	int err;
>>>  
>>> +	err = dev_pm_domain_attach(dev, true);
>>> +	if (err)
>>> +		goto out;
>>
>> This patch has broken the virtio-rpmsg stack based rpmsg devices. These
>> devices are non-DT and the rpmsg_dev_probe() is now failing with -19
>> (-ENODEV) error code.
>>
>> Loic, Arnaud,
>> Can one of you double-confirm this behavior on ST platforms as well?
>> The patch came through 4.14.71 stable release and broke our downstream
>> kernels.

> I do not reproduce issue on 4.14.0 + your patch,  on my ST platform (not
> able to test on the LTS branch).
> By looking the source code, seems that your issue is related to
> genpd_dev_pm_attach that returns -ENODEV because you have
> no remoteproc device node...
> Do you have a rproc node defined in your DT? we have one.

The dev here is not the remoteproc dev but the rpmsg device which does
not have an OF node, and so I get the ENODEV due to the check on
dev->of_node in genpd_dev_pm_attach. I do have DT remoteproc nodes.

Are you publishing an rpmsg device from the remote side and are they
being probed? Issue is seen only during the probe phase, you will not
see any errors if the rpmsg devices are just being published and created.

regards
Suman

> 
> Regards
> Arnaud
> 
>>
>> regards
>> Suman
>>
>>> +
>>>  	if (rpdrv->callback) {
>>>  		strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
>>>  		chinfo.src = rpdev->src;
>>> @@ -490,6 +495,8 @@ static int rpmsg_dev_remove(struct device *dev)
>>>  
>>>  	rpdrv->remove(rpdev);
>>>  
>>> +	dev_pm_domain_detach(dev, true);
>>> +
>>>  	if (rpdev->ept)
>>>  		rpmsg_destroy_ept(rpdev->ept);
>>>  
>>>
>>

