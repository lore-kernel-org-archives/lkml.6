Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286CDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D280C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvKfSVtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D280C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeIZRXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:23:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50232 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeIZRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:23:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id s12-v6so1841015wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UFoZ3c8H8D8HojkBTGUdAOuoezIBtfeEHIZr07uMF7w=;
        b=WvKfSVtOhWkl/iY7V1PURUIb3WWl5XuEfJM2tVy6ONaOPdGiyt/mH+H90Jbe2Jllmf
         X1Sr03Ayeaf2sY+zP8GawlE9X2dG0Li+j0Kmg6XJfhvgsolz/ZtT84AZSVNQOkKMLRnl
         0vgLE7mq1hrZFHbVma7X/r8iataoPBO1gE+Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UFoZ3c8H8D8HojkBTGUdAOuoezIBtfeEHIZr07uMF7w=;
        b=g+2ZVp0flGSZbsjk+JgI4s+Hu46lsYSodv1MmHtYLLAbZq+v7wnPFFfq3t/N5GZkjJ
         cUSWH2otNKKPuyzP+9u/E9HAMOwnzw/iULI2FoKohpHSXYaPUzp6ntm/vEw+TCT16c80
         djqoElLDrf/ebs7zzUhSaFtZ47+lhViGEwUSURS/pc3XHcjt5+QtSNgk/+L52J2zcFRD
         emcvtZ7ACPdV6TXhSWo1QfHnSlzPuF2T94wV44WH+auu1HUD+E0+AhPI3WfKuziJS/E9
         AY0EA69GpKmMxfmOhMAh9F1munXVRIPOVi9mGMxbLz+ZQXEIvLWKJVnI6L6Q68PspE6f
         ctkw==
X-Gm-Message-State: ABuFfohgK9UqXJZ2yRC0LH7QaxQ9ZkGkYVJcD9oh9wTs461ydyjorb4/
        p8R8TdNZ47AU6utDaU2EZHIfzg==
X-Google-Smtp-Source: ACcGV62M6TW5ZmUekOyvrIuJgUrvRBYsFhEXa1NUxO5QiMSyxhiSWBIdyEKZE/hlx9UV7tsT4Tmdkg==
X-Received: by 2002:a1c:e5cf:: with SMTP id c198-v6mr3949245wmh.113.1537960268746;
        Wed, 26 Sep 2018 04:11:08 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id k63-v6sm8549559wmd.46.2018.09.26.04.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 04:11:07 -0700 (PDT)
Subject: Re: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, stable@vger.kernel.org,
        me@tobin.cc
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org>
Date:   Wed, 26 Sep 2018 12:11:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2018 20:06, Daniel Thompson wrote:
> On Fri, Sep 14, 2018 at 12:35:44PM +0000, Christophe Leroy wrote:
>> On a powerpc 8xx, 'btc' fails as follows:
>>
>> Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
>> kdb> btc
>> btc: cpu status: Currently on cpu 0
>> Available cpus: 0
>> kdb_getarea: Bad address 0x0
>>
>> when booting the kernel with 'debug_boot_weak_hash', it fails as well
>>
>> Entering kdb (current=0xba99ad80, pid 284) due to Keyboard Entry
>> kdb> btc
>> btc: cpu status: Currently on cpu 0
>> Available cpus: 0
>> kdb_getarea: Bad address 0xba99ad80
>>
>> On other platforms, Oopses have been observed too, see
>> https://github.com/linuxppc/linux/issues/139
>>
>> This is due to btc calling 'btt' with %p pointer as an argument.
>>
>> This patch replaces %p by %px to get the real pointer value as
>> expected by 'btt'
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: <stable@vger.kernel.org> # 4.15+
> 
> Would a Fixes: be better here?
> Fixes: ad67b74d2469d9b82 ("printk: hash addresses printed with %p")

Christophe, When you add the Fixes: could you also add my

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Thanks.


> 
> No blame attached to Tobin, but the fixes makes it super clear what
> changed and why this breaks kdb (which was not explicitly called out
> the patch description).
> 
> 
> Daniel.
> 
>> ---
>>   kernel/debug/kdb/kdb_bt.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
>> index 6ad4a9fcbd6f..7921ae4fca8d 100644
>> --- a/kernel/debug/kdb/kdb_bt.c
>> +++ b/kernel/debug/kdb/kdb_bt.c
>> @@ -179,14 +179,14 @@ kdb_bt(int argc, const char **argv)
>>   				kdb_printf("no process for cpu %ld\n", cpu);
>>   				return 0;
>>   			}
>> -			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
>> +			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
>>   			kdb_parse(buf);
>>   			return 0;
>>   		}
>>   		kdb_printf("btc: cpu status: ");
>>   		kdb_parse("cpu\n");
>>   		for_each_online_cpu(cpu) {
>> -			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
>> +			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
>>   			kdb_parse(buf);
>>   			touch_nmi_watchdog();
>>   		}
>> -- 
>> 2.13.3
>>

