Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADFCC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7419F20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcQptZHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7419F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeKDDez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:34:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45049 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeKDDez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:34:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id j13-v6so2478692pff.11;
        Sat, 03 Nov 2018 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LXZSTr5gMeJx5cdOh8/puIgwDhKvMpFODVnFF9s0rnM=;
        b=NcQptZHUaBUIphm+LOFWoj8RbKUW5RcKevezqffIQk4eCSQwt7mJT9CN3sE0Qixcbi
         pRiaXqlisa912LHqZZPwgZKBOlNCC63S/3v0+at93iU+svS7ZbzhOa3+x7gQA6XuLkFQ
         gViYw0x1gocW5fswr/OUXwcrMHBLHqdtBHXoPihKZjUoHClvGUc6ppWkvESnVud1S43V
         TVjxtRGGJrUNerZcpu3L/7nKBUfgsVTkpg1vkee0m3xUJSEVLT5wJpEq8VZfacHU2Isx
         9UjUmm0wxBLJG+04467LgVxnW64fm7XP/2i7JiD5IEuHwfEuxtP17pYHIEC2y8fX7uQd
         0r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXZSTr5gMeJx5cdOh8/puIgwDhKvMpFODVnFF9s0rnM=;
        b=nY+6ZAmYwC2wBezE9aQGf38pYdRjvmCpmHZIJaPSNuhLhn9zri3zdPnO20IlCpMcXv
         b2/nTimxzdnEp8U4EFyXs9Pp0VcK5mpOMH9xZMkDDBx/zh0bRTud+4NJ3mO2Fy0/ziYz
         eyLdj36wZiYqnsZ3CRHcOOjvNX/akuep79n/Bau+giJ31bHVw+gAe6IAmpvXwfjhxosZ
         RVpzZ/BgRG7ncukgx268+D/3WnWXivgBlo1HS+5PawXWWkRRjD/JZzFw9ZrKslF58hlN
         pzSTpOsmam2TeHOD68IyK2vod88me1pU0K2C78v6ANU1a9oz3kA9SLrZcNdoPBmkf6I3
         cWBg==
X-Gm-Message-State: AGRZ1gLMG42+C4/QRTZo5wiYrhrCo59mCp8orPiOJcbf0dQzR75CYTNU
        Rl45QPk89LdGMkdpm5NQY41GvcCL
X-Google-Smtp-Source: AJdET5fhNe8UcwwHAj9B8QXwIgLWlbp1q11HLELHSshr6/GsQ1ljYtROqfiEthGoLZ+HcJ4NCPHChg==
X-Received: by 2002:a63:1765:: with SMTP id 37-v6mr15042509pgx.131.1541269373626;
        Sat, 03 Nov 2018 11:22:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m12-v6sm43456931pgd.81.2018.11.03.11.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 11:22:52 -0700 (PDT)
Subject: Re: [PATCH 4.14 000/143] 4.14.79-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181102182857.064326086@linuxfoundation.org>
 <34e8a999-20e1-5e7d-863b-b0585a24e83b@roeck-us.net>
 <20181103150434.GA24235@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4d41e43e-0ccd-06cb-0bd8-b8ed6dd48fe7@roeck-us.net>
Date:   Sat, 3 Nov 2018 11:22:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181103150434.GA24235@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/18 8:04 AM, Greg Kroah-Hartman wrote:
> On Sat, Nov 03, 2018 at 07:31:42AM -0700, Guenter Roeck wrote:
>> On 11/2/18 11:33 AM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.14.79 release.
>>> There are 143 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Nov  4 18:27:59 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>
>> Build results:
>> 	total: 150 pass: 149 fail: 1
>> Failed builds:
>> 	xtensa:allmodconfig
>> Qemu test results:
>> 	total: 318 pass: 318 fail: 0\
>>
>> Build failure:
>>
>> In file included from include/linux/mlx5/port.h:36:0,
>>                   from include/linux/mlx5/driver.h: In function ‘mlx5_get_vector_affinity_hint’:
>> include/linux/mlx5/driver.h:1208:13: error:
>> 	‘struct irq_desc’ has no member named ‘affinity_hint’
>>
>> Caused by commit 19b743c448db ("net/mlx5: Fix mlx5_get_vector_affinity function").
> 
> Odd, this should be fixed by a later patch in the same queue, as 0 day
> also reported this.
> 
> Yes, e3ca34880652 ("net/mlx5: Fix build break when CONFIG_SMP=n") in the
> 4.14 tree should resolve this.  Ah, Sasha added it at the "last minute"
> after I did the -rc1 release.  So this should be resolved now, I'll push
> out a -rc2 so that it can be verified...
> 

v4.14.78-144-gb825fd9fbad5 builds fine.

Thanks,
Guenter
