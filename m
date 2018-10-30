Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FD4C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C7E2082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjAXDxyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C7E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeJ3RZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:25:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55418 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeJ3RZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:25:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id s10-v6so10775169wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hhn9CGbh3lFTl9mLLGvkN64V1M5OZX+do3imSMuhEs0=;
        b=IjAXDxyJn/ilORJ+MvAgHS55EBlL4RCUrAwrrSyT+AXrXJb6bHnWYlZ+Nh6TDdminN
         S06sMcRvri89f6js/fT771OWaTJ6s8AtY0KDCrq885g9ncrynZ64luSzq8VwrF9+znZC
         4+yiR7Yy84WutuWrcHxwlPAlCjbT1KFPnteh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hhn9CGbh3lFTl9mLLGvkN64V1M5OZX+do3imSMuhEs0=;
        b=lXfHcfCwlQrA/NK/qQSk0fBchGvZc16GUwWUoh90vhoLlSDiDcCcl3aIZmP6cvBKAh
         9uLoQH2rP0bJuOTDw/cOvUF8JJ3bffCC5NPuacYMmwxHIJdmrLAfh9/e0+n3dU5IcO4h
         amsBDSD+GaWABB0SUn604v2qFSMRmR1GcEEDStMvaLZyPt+cLaTGEXxaGOQcHo31AoiO
         ZZnty/Pwapf8c4UWR6ZzdNENM/FjhaKBGQUPfVMxYVL2YHu8Af8rA+FweugI2UoaUVZC
         ylxhDQHRnZZlYd8WXwS66+h6BWaDj/A0w4+g5Ahr4JcKynnm5qFtsjCdiFWq3GHIeZj8
         O9jw==
X-Gm-Message-State: AGRZ1gJK3Qge5Ky7rgb9fm7sfTltV37Hh+8WC/aIQxUTX4Wo59/2ZDkS
        IED8GqNHKrvVxXoexDb12cMX6mQ1Hcg=
X-Google-Smtp-Source: AJdET5fUq3qmi/HjfHLnrvvt2LjEyZFPfxFgZntN3vtnqBR2vcfUPP+e2LBtZ7eX12B9s1ALGcSGPg==
X-Received: by 2002:a1c:f514:: with SMTP id t20-v6mr894231wmh.129.1540888366192;
        Tue, 30 Oct 2018 01:32:46 -0700 (PDT)
Received: from [192.168.0.40] (137.55.88.92.rev.sfr.net. [92.88.55.137])
        by smtp.googlemail.com with ESMTPSA id i7-v6sm25531022wmd.41.2018.10.30.01.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 01:32:45 -0700 (PDT)
Subject: Re: [PATCH 3/4] base/drivers/topology: Move instructions in the error
 path
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-3-git-send-email-daniel.lezcano@linaro.org>
 <CAOh2x==N=YM+4WE8wouM9mFd0h0L+npwww97e2HAf2HsEm5J0w@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <340a6999-2281-2eaf-5a83-b1a0898a2ab5@linaro.org>
Date:   Tue, 30 Oct 2018 09:32:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOh2x==N=YM+4WE8wouM9mFd0h0L+npwww97e2HAf2HsEm5J0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 07:12, Viresh Kumar wrote:
> On Mon, Oct 29, 2018 at 9:56 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> When the function topology_parse_cpu_capacity() fails, we set the boolean
>> cap_parsing_failed to true and we free the raw_capacity. This is correct as
>> the function begins with a check against cap_parsing_failed thus protecting
>> the function to be re-entered.
>>
>> However, even it is impossible that can happen with the current code, let's
> 
> Why impossible ?
>> move in the instructions:
>>
>>  - cap_parsing_failed = true;
>>  - free_raw_capacity();
>>
>>  ... in the 'else' block when the error is detected, that is more semantically
>>  correct.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/base/arch_topology.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index b19d6d4..7311641 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -155,9 +155,9 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>>                         pr_err("cpu_capacity: missing %pOF raw capacity\n",
>>                                 cpu_node);
>>                         pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
>> +                       cap_parsing_failed = true;
>> +                       free_raw_capacity();
>>                 }
>> -               cap_parsing_failed = true;
>> -               free_raw_capacity();
> 
> While it is fine to move free_raw_capacity(), it is not to move the
> other line. With your
> patch what will happen if the first CPU in DT doesn't have the
> "capacity-dmips-mhz"
> property set ? We will never set cap_parsing_failed and keep on
> re-entering this routine
> which wasn't required.

Ok.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

