Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AE2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C47621852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbeLTNnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:43:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36222 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbeLTNnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:43:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so961315pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uvXH82qG+vk0v23eTDrf0/ym40QVLBTETdMdA9Hq7ag=;
        b=koy6Jp6EotatIOuqe00+FGp14lmTFMwS9d+Dx67QcLWYmMbfDawhJVfxPMvj2Lj//z
         y1v3fc/vK/tMeong7FH3ON+NX14q6jN4QPhVWIYso7i38ZYcSuM/+da7+y/IQVpTlieC
         Po1T8Pmp58Shw9vR1YHEmgMJLnzcG/4WQLqKQ0LFxvny6YuOW2tQgJFNxJWMXM1C3mAg
         iOV87M8ns7mMmn86WBQ1Dc99vdv3Vg2zvbf/LNvRpwbuSrSrRIcgNaJi+QiLK8arAvsu
         Mcs2ICuP2LODsc7vd5SMEt/IJsU44mHIjNQzHCl/cTn/gxEvB5ytVjtARPShLCej0fan
         YlTg==
X-Gm-Message-State: AA+aEWaP3z81NZKtSOrZtu4Q4loJmGbMG6QOH2yRw8N08WzPmRyGoOVT
        vDapHzoGn9ntN8xjVjd28WTjyg==
X-Google-Smtp-Source: AFSGD/WnUzFMtUCzXQ/tnrH2+kto/438gwgSp1dSOUg68XKivku7uGPC7D4XfyoYrto2vNdk+XL57Q==
X-Received: by 2002:a62:2044:: with SMTP id g65mr24260734pfg.127.1545313379591;
        Thu, 20 Dec 2018 05:42:59 -0800 (PST)
Received: from bsingh.kernel.org ([125.16.97.118])
        by smtp.gmail.com with ESMTPSA id l5sm32489776pgu.86.2018.12.20.05.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:42:58 -0800 (PST)
Subject: Re: [PATCH v2] hpet: Fix missing '=' character in the __setup() code
 of hpet_mmap_enable
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     clemens@ladisch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20181220120524.30732-1-bsingh@redhat.com>
 <20181220122932.GB17138@kroah.com>
From:   Buland Singh <bsingh@redhat.com>
Message-ID: <a9704df4-53ee-5b12-2ab1-477fb7e8f083@redhat.com>
Date:   Thu, 20 Dec 2018 19:12:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181220122932.GB17138@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 5:59 PM, Greg KH wrote:
> On Thu, Dec 20, 2018 at 05:35:24PM +0530, Buland Singh wrote:
>> Commit '3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for
>> user processes")' introduced a new kernel command line parameter hpet_mmap,
>> that is required to expose the memory map of the HPET registers to
>> user-space. Unfortunately the kernel command line parameter 'hpet_mmap' is
>> broken and never takes effect due to missing '=' character in the __setup()
>> code of hpet_mmap_enable.
>>
>> Before this patch:
>>
>> dmesg output with the kernel command line parameter hpet_mmap=1
>>
>> [    0.204152] HPET mmap disabled
>>
>> dmesg output with the kernel command line parameter hpet_mmap=0
>>
>> [    0.204192] HPET mmap disabled
>>
>> After this patch:
>>
>> dmesg output with the kernel command line parameter hpet_mmap=1
>>
>> [    0.203945] HPET mmap enabled
>>
>> dmesg output with the kernel command line parameter hpet_mmap=0
>>
>> [    0.204652] HPET mmap disabled
>>
>> Fixes: 3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for user processes")
>> Signed-off-by: Buland Singh <bsingh@redhat.com>
>> ---
>>   drivers/char/hpet.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
>> index 4a22b4b41aef..9bffcd37cc7b 100644
>> --- a/drivers/char/hpet.c
>> +++ b/drivers/char/hpet.c
>> @@ -377,7 +377,7 @@ static __init int hpet_mmap_enable(char *str)
>>   	pr_info("HPET mmap %s\n", hpet_mmap_enabled ? "enabled" : "disabled");
>>   	return 1;
>>   }
>> -__setup("hpet_mmap", hpet_mmap_enable);
>> +__setup("hpet_mmap=", hpet_mmap_enable);

Hello Greag,

> This has _never_ worked?  Since 3.13?  

Yes, that's true :)

> Why not just remove the thing as it is obvious no one actually has ever used it.  > That would make the code even simpler :)

Data Plane Development Kit (DPDK)[1] provides API that requires the CONFIG_HPET_MMAP
kernel configuration option to be enabled[2]. Some end users might want to use the
HPET MMAP functionality within the application.
  
Regards,
Buland Singh

[1] https://www.dpdk.org
[2] https://doc.dpdk.org/guides-18.08/linux_gsg/enable_func.html








