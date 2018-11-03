Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94585C32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF1A204FD
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFtmKC0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF1A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeKCMIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 08:08:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40370 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeKCMIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 08:08:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so1837827pfi.7;
        Fri, 02 Nov 2018 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0G0Fsl3PgljYlpbGbd4z637ddnurAYWlRf+vlyva/L4=;
        b=rFtmKC0Lhek4xs1IdbXeOAHlGwzcaOJ0FezO2C8NRJTstMS4/PqHJ5P4b9tAV05ZPA
         4REMP4gOf5QA/8t8QwvAFl+Z0VpoByh261QHdPhKNCjLQu6vueLZOcuaBfFpODeOhan1
         9+QW1HHMp0Hnhtq9YOF4iiGAw8IuTRM8g+Z2iwMGFqqsPUShABNo+CaB0C8OnL9rIg98
         pSQpJkrrB4bbJzag6YZ/0AL2Q76OvpGqukzQL3nMCORriX64UJRkgTPqHHJrRig4TvEq
         6UkxNoFV4qTVag01QdLIHoSW+tQvEHbPRirRWy4+WcXuhP1pVBDpXbAzvVCAaqHmIgrq
         7sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0G0Fsl3PgljYlpbGbd4z637ddnurAYWlRf+vlyva/L4=;
        b=kiw4kxrDMBnesgBRnkgc+YL8wBssJwl4sEt6JDh9NyKpKwZFFejzKH7Z2HpbTk9tEV
         UfYklsPCZL0oDZoNu6bzgBvVyyWu3BAloBiv16FVee2H3oJQm92RBLVtzi2oIuM6DILF
         1oKvKwfLl60EcLlNrk9uVdyRrqHAKEyly6lv2DSD1ypkrrnLtCKGNKkyHFI+6jhO2z+l
         iY73BTBagjK2Xtyyo+yy0dRcwohVYAhyp5CY4hxhVPrPSSWjtL54iBI8lvoEINL40DZd
         j8xmoV07YS6NXyH4lb4TuzWO/x75pVtsrtC482+ykDcjt/hwN9zsQiaP4ozaG6hyWtz5
         4h6A==
X-Gm-Message-State: AGRZ1gJAfIP3nQMqsP6Cw03jg8wlnZhOSphjmhkIKyasU2YfO5G3aIGG
        uOJdCaBk13fEDbz/vSmy2QMg3eq5
X-Google-Smtp-Source: AJdET5fUNqJ5eMbHHkTWI1AAcw230YGp88GiC2KJp8DiSFySSKkETbpNj5Hw+3tGE5VRfSoBQJr1FQ==
X-Received: by 2002:a63:6782:: with SMTP id b124mr9828013pgc.151.1541213949418;
        Fri, 02 Nov 2018 19:59:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p64-v6sm35517862pfi.22.2018.11.02.19.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 19:59:08 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] hwmon: (core) Add pm ops to hwmon class
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181025235122.3240-1-nicoleotsuka@gmail.com>
 <20181025235122.3240-2-nicoleotsuka@gmail.com>
 <20181102175435.GA4749@roeck-us.net>
 <20181102194854.GA26329@Asurada-Nvidia.nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <52ca82e6-d63c-22e9-8577-5e6d48c17770@roeck-us.net>
Date:   Fri, 2 Nov 2018 19:59:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102194854.GA26329@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 12:48 PM, Nicolin Chen wrote:
> On Fri, Nov 02, 2018 at 10:54:35AM -0700, Guenter Roeck wrote:
> 
>>> Actually, pm_runtime core also scans a class-level pm pointer:
>>>           else if (dev->class && dev->class->pm)
>>>                    ops = dev->class->pm;
>>>
>>> This means that hwmon class in the hwmon core could actually
>>> have its own generic pm callbacks so that a registered driver
>>> would have the capability to link their own callbacks to the
>>> hwmon core's.
>>>
>>> So this patch adds a pm pointer to the hwmon class with some
>>> generic pm callbacks of system suspend/resume and pm_runtime
>>> suspend/resume, and also allows hwmon drivers to pass valid
>>> pm pointers through _with_info API when registering devices.
>>>
>>
>> Just to give an update: I am not happy with having to add hwmon
>> specific pm callbacks. That doesn't look right to me. I'll have
>> to spend time figuring out how other virtual devices handle this
>> situation. Unfortunately, time is always scarce, so this will likely
>> take a while.
> 
> That's okay. Would it be possible then for me to add PM runtime
> functions just in ina3221, without touching hwmon core? It will
> belong to the I2C device, not hwmon device any more.
> 

If that works, sure. We can always add generic support later.

Guenter

>> Also, please note that I won't accept function macros. I understand
>> that are used a lot, especially in older hwmon drivers, but they just
>> make the code more difficult to read and often add unnecessary code.
> 
> Okay. Will be careful to use them in future hwmon patches.
> 
> Thanks
> Nicolin
> 

