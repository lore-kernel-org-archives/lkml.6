Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51D7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F0720875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJY4hEq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F0720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeJEPfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:35:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46011 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeJEPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:35:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id t70-v6so4406948pgd.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cgtDeG/Ehv3U0rCfPAFLUS5QOWH3AAbYdutBmQHtGQE=;
        b=FJY4hEq3Fk+gI7G/wjn6NSMYM3gJrAfCaO/vEZeB3KOnk7Wjvk1YvXxYrwrccLuyG7
         p1yQS8WQusQzJlNot6UT86RnpnTuJB7scuyqEe4XlQ15EeFzhoQJOj8AhHKR5I3dMnDc
         UdEXEw8v70IG0skLTj5aR+WF34GJ/R+Pwv4eXJ2W8LHwnj9T3tQJyvefN7r/syDeSoZZ
         snRkJDfRvKYLk+fNf+MiAsONfeETcIPwzab8AcUJ/JfKMZKmOVaX2jAFhBEzJQ25OSmz
         vrFKZxThhJzI4GzDzLmutVIELbO9FQpzQRF22fcsA67ZItQLOihREGDXH2MCb7kd+bxU
         NOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgtDeG/Ehv3U0rCfPAFLUS5QOWH3AAbYdutBmQHtGQE=;
        b=e6HIZDx+iZYbg4oO00pBfAbR+Xh41zhunmaYiif9PXCE/CihoCYhq65wAF9OB6QSm2
         zRECr7by4FWaTjGqelNnsPLMeEp8yqYhjQ4vjA6PaXLil939v/o2N6OhAQiBYJezCoFq
         PLG9BTVKKMkaq0OTb9OF7k2ONdXVXB76sb7md+zDNnbfEODoFW+pN7Str8bL9iOXPfUc
         8e9gtURL1NmEHKnZnUUdG3tF6bKTO0DIHU7/26ZKT9xnaPCcbdXmJz7Aa6x04UVA7VaV
         XX7glEyQXQsuqHSN9XqMzprj8+ilUcagq8w8LV8uJ/8poX6hbNpZxZ9bdLOP4LKhA2eV
         4bOg==
X-Gm-Message-State: ABuFfohV1Uw6HpoyeblXx7s7AC1HXdewOAgDjn+rS/dwzuR0mjz4pdKl
        QegsbVebiJr+PzIzUzOuvGj4TBXX
X-Google-Smtp-Source: ACcGV6016i4ifXARwwP2S3ZgkYl4f4AdJKQ5fb3vEzWqsrehUZh+K4khvf+9Am52cPZEaJctEEoJxQ==
X-Received: by 2002:a63:9e02:: with SMTP id s2-v6mr4735997pgd.302.1538728685660;
        Fri, 05 Oct 2018 01:38:05 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a79-v6sm10598588pfa.124.2018.10.05.01.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:38:04 -0700 (PDT)
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Peng Hao <peng.hao2@zte.com.cn>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
Date:   Fri, 5 Oct 2018 01:38:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2018 01:14 AM, Koenig, Christian wrote:
> Am 04.10.2018 um 20:52 schrieb Guenter Roeck:
>> Hi,
>>
>> On Fri, Sep 14, 2018 at 06:05:52PM +0800, Peng Hao wrote:
>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:
>>>       In function ‘gmc_v8_0_process_interrupt’:
>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:10:
>>>       warning: missing braces around initializer [-Wmissing-braces]
>>>
>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>> Was there any feedback on this patch ? The problem does affect us,
>> and we'll need a fix.
> 
> Well as discussed using "{ { 0 } }" is as wrong as using "{ 0 }".
> 

Ah, sorry, I must have missed the discussion.

It is for sure not the best solution, but at least it compiles, and it seems
to be proliferating.

$ git grep "{ *{ *0 *} *}" | wc
     144    1180   11802
$ git grep "{ *{ *0 *} *}" drivers/gpu/drm/amd/ | wc
      50     459    5239

> We should either use only "{ }" or even better make nails with heads and
> use memset().

I'd rather leave it up to the compiler to decide what is most efficient.

Guenter

> 
> Christian.
> 
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index 9333109..55f4755 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>>>    		gmc_v8_0_set_fault_enable_default(adev, false);
>>>    
>>>    	if (printk_ratelimit()) {
>>> -		struct amdgpu_task_info task_info = { 0 };
>>> +		struct amdgpu_task_info task_info = { {0} };
>>>    
>> I wondered if
>> 		struct amdgpu_task_info task_info = { };
>> would be better.
>>
>> Thanks,
>> Guenter
>>
>>>    		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>    
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 72f8018..e8b78c5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>>>    	}
>>>    
>>>    	if (printk_ratelimit()) {
>>> -		struct amdgpu_task_info task_info = { 0 };
>>> +		struct amdgpu_task_info task_info = { {0} };
>>>    
>>>    		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>    
> 

