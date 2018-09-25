Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B55C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438E12145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hK6X+HZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438E12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeIYOgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:36:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44484 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeIYOgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:36:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so22344771wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/TZLcGQ/0xZoFVCfv+0S/8SwKR06M0FFTXVuHqsfaw=;
        b=hK6X+HZKAqrzHc+sguYcS3LAT0bQus7RtWMrRzAssIb4OSWF33zJISVYF8W+9qQk0y
         gmAn39i53R5s+cF6n0kxX86SiPjYQ7un4Mli3Hf/YtAkLidnODlgsnJvB12Yp+Vm6NWH
         +KUsgK8g7ID4fMFOBJcPn9+SeKod30zfxr5dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/TZLcGQ/0xZoFVCfv+0S/8SwKR06M0FFTXVuHqsfaw=;
        b=HSmDy4fYPyXMaIA6hMQHUmngAlJWfmywD9T7YJ32MTuDBZeo9TKPVDzJxH3HqqRkqk
         tUkMpAcklWXO/wRjJOBq9hsrR0ZCPvFaQ0hqmoeIu8Ky1ja6tyV0Rg7075EQxjPLBsp8
         yiNmyL0+CpfrXJJa5ekqvbuTPsw2SnPCxuuBg8mzNs8ptpgi17zYgjem+cFTNkrgZdxt
         HRxpyRLxvYrvKNl9Zuyj+AeUQntEnCFnDUjt3lF1l52D5hELjW+VJrVy1AA12uA5XQRS
         loCGnrolvwebd/GXYPxxA7jujx0HsVKOMI+QpVvDIy6vREFIoIIOfdLk4Z86swjSd6Qh
         bFDg==
X-Gm-Message-State: ABuFfojYqWVo1PMdHOaYsVlCbmZ0VwPkA3KFeArUC8Wbca5Hz4maMxVY
        HxSeTaKKy9h64kOSO4p2D85pVw==
X-Google-Smtp-Source: ACcGV60auPF/uObJ5d4H/dQBZxVGXrf/0T0ETXwYfwePAPXv9ohQSDIHNv8rR7qbEDoT5d8JMNoJEA==
X-Received: by 2002:a5d:6209:: with SMTP id y9-v6mr1929498wru.179.1537864192693;
        Tue, 25 Sep 2018 01:29:52 -0700 (PDT)
Received: from [192.168.0.12] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id r64-v6sm305103wme.42.2018.09.25.01.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 01:29:51 -0700 (PDT)
Subject: Re: [PATCH] rpmsg: core: add support to power domains for devices
To:     Suman Anna <s-anna@ti.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Loic Pallardy <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>
References: <20180615095939.1331-1-srinivas.kandagatla@linaro.org>
 <a80cce14-9e57-32a2-760f-3d29de009f99@ti.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <604f52b3-1296-8443-36a3-399c69561713@linaro.org>
Date:   Tue, 25 Sep 2018 09:29:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <a80cce14-9e57-32a2-760f-3d29de009f99@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

On 25/09/18 01:25, Suman Anna wrote:
> Hi Srinivas,
> 
> On 06/15/2018 04:59 AM, Srinivas Kandagatla wrote:
>> Some of the rpmsg devices need to switch on power domains to communicate
>> with remote processor. For example on Qualcomm DB820c platform LPASS
>> power domain needs to switched on for any kind of audio services.
>> This patch adds the missing power domain support in rpmsg core.
>>
>> Without this patch attempting to play audio via QDSP on DB820c would
>> reboot the system.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/rpmsg/rpmsg_core.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>> index b714a543a91d..8122807db380 100644
>> --- a/drivers/rpmsg/rpmsg_core.c
>> +++ b/drivers/rpmsg/rpmsg_core.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/module.h>
>>   #include <linux/rpmsg.h>
>>   #include <linux/of_device.h>
>> +#include <linux/pm_domain.h>
>>   #include <linux/slab.h>
>>   
>>   #include "rpmsg_internal.h"
>> @@ -449,6 +450,10 @@ static int rpmsg_dev_probe(struct device *dev)
>>   	struct rpmsg_endpoint *ept = NULL;
>>   	int err;
>>   
>> +	err = dev_pm_domain_attach(dev, true);
>> +	if (err)
>> +		goto out;
> 
> This patch has broken the virtio-rpmsg stack based rpmsg devices. These
> devices are non-DT and the rpmsg_dev_probe() is now failing with -19
> (-ENODEV) error code.
> 

There seems to be some dependency on this patch ( 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.19-rc5&id=919b7308fcc452cd4e282bab389c33384a9f3790 
) which seems to rework the return values from acpi_dev_pm_attach() and 
genpd_dev_pm_attach()



--srini


> Loic, Arnaud,
> Can one of you double-confirm this behavior on ST platforms as well?
> The patch came through 4.14.71 stable release and broke our downstream
> kernels.
> 
> regards
> Suman
> 
>> +
>>   	if (rpdrv->callback) {
>>   		strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
>>   		chinfo.src = rpdev->src;
>> @@ -490,6 +495,8 @@ static int rpmsg_dev_remove(struct device *dev)
>>   
>>   	rpdrv->remove(rpdev);
>>   
>> +	dev_pm_domain_detach(dev, true);
>> +
>>   	if (rpdev->ept)
>>   		rpmsg_destroy_ept(rpdev->ept);
>>   
>>
> 
