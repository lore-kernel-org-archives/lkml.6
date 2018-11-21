Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55633C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1836B20831
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHD8yfz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1836B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeKUTPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:15:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34750 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeKUTPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:15:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so4504199plo.1;
        Wed, 21 Nov 2018 00:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RGFzQPQL9ABPKfnhY9vFI4JPTMwlwVkcO6R1305BAKk=;
        b=sHD8yfz97TdSDm54j79tMHl5sCFW5JpmousRb0kf7JkxdJXMtJVGUSGkfRK3QPhsmj
         JrTNeGqDGSeHUy1kaX16XuIMi5syYG9zTzMEBnxNuAQEDQVUqa3dHwDzdxGFUkSWdx/C
         20Z1bCZpRwhlQ3JxA2MxUvk1lMDYfAwsmbFMFJk9fYCGo3wr7x5VhNJlyCor4OQ35MIl
         8bvV9bl6x1Oh3e4cnZNWWAeaVf2qifAXfN6+rspNk4z5QNlXTyXP0ZtVdN8VVeEyZDDn
         lrXyW5ABs/vndIMcAF5SkKRbkvsvcWLiA4TVW/KRajM66z3B+eWy5cNM/OAXp4jsEDy4
         g7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RGFzQPQL9ABPKfnhY9vFI4JPTMwlwVkcO6R1305BAKk=;
        b=rKCdZTwyxpihihRm5vtuydfnqlyGMgDQ8vN9lSY4b/BYSc5I+Ha4rRTNPOIFtoMpLu
         b2dtDvx3FJmJ2/qq1NL7J+MWoQZ3g46oshJMUVoFL9a0R7KkB0WhM9dHPqHJmIayY3hv
         vI5DzrMR5Dk2mos3w7Uf2y/yEGgWOCmMws9F4mZytzyKGczy8HjZRMaueM7rbbIlk4u4
         a6QsOa/AA3Hv64vIahfvBuuus5uN5kQbZDTdRRMCr5oOWOjIoLfVWL3TjVUlG43YZyxz
         A4L0q8JrO+e9U59TTI8umE9IqMS5TPFbzeuci3G5VUlVM5OuJfpxaddNrBoLV1af3xDq
         tTtw==
X-Gm-Message-State: AGRZ1gKV20pOkgtTfG0ob5F9+loMJE0qbovrrZn2e6Iv+3lZnaGEv3S1
        2/4Rp2ZkgChZmbVHQ71P66lWCbC+
X-Google-Smtp-Source: AFSGD/V/wh7U4nQYN3+aay08URFVtRJbDqur8npwcjbxQfqKfVAv9JRXyxR0p3eZWc6yQt4uPF+MRQ==
X-Received: by 2002:a63:4665:: with SMTP id v37mr5206483pgk.425.1542789727589;
        Wed, 21 Nov 2018 00:42:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n73sm29487517pfj.148.2018.11.21.00.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 00:42:06 -0800 (PST)
Subject: Re: [PATCH 2/2] hwmon: (ntc_thermistor): add support for B57891S0103
 from Epcos
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20181117121248.32143-1-peda@axentia.se>
 <20181117121248.32143-2-peda@axentia.se>
 <20181119170732.GA27435@roeck-us.net>
 <f1235661-f8f2-9885-1e7f-491f5c234078@axentia.se>
 <20181119212806.GC5795@roeck-us.net>
 <f15d3e1c-1b53-f390-78e2-6a88c77aed05@axentia.se>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b732b7e0-0076-9cb3-a146-4d0cd80d2658@roeck-us.net>
Date:   Wed, 21 Nov 2018 00:42:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f15d3e1c-1b53-f390-78e2-6a88c77aed05@axentia.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 10:06 PM, Peter Rosin wrote:
> On 2018-11-19 22:28, Guenter Roeck wrote:
>> On Mon, Nov 19, 2018 at 09:16:12PM +0000, Peter Rosin wrote:
>>>>
>>>> Guess I deserve the non-alphabetic order as penalty for not enforcing it
>>>> earlier. I'll accept the patch after DT approval and submit another one
>>>> myself afterwards to restore alphabetic order.
>>>
>>> Right, I'm thinking another good change would be to introduce an enum
>>> into the ntc_thermistor_id array, because the hard-coded numbering in
>>
>> Yes, sounds like a good idea.
>>
>>> the ntc_match variable is a bit fragile in my taste, and that list would
>>> also benefit from being alphabetic. Currently there's simply no way to
>>> add things in the middle without causing mayhem. I thought about doing
>>> that, but didn't want to waste energy doing it up front without knowing
>>> if it would be well received (the driver might have been superseded or
>>
>> It would.
> 
> Right, so I have some patches sorting things out... However, one question

Sounds good.

> before I send them: Is it ok to sort the enum ntc_thermistor_type in the
> include/linux/platform_data/ntc_thermistor.h header or will that break
> stuff?
> 

Should be ok. It is not an UAPI, after all.

Guenter

> Cheers,
> Peter
> 
>> Guenter
>>
>>> something). I'm glad that you have volunteered to clean things up.
>>> Ha! :-)
>>>
>>> Cheers,
>>> Peter
>>>
>>>> Guenter
>>>>
>>>>>   };
>>>>>   
>>>>>   struct ntc_thermistor_platform_data {
>>>>> -- 
>>>>> 2.11.0
>>>>>
>>>
> 

