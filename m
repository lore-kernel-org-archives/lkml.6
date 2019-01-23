Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9C4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607FE2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NbEBAxuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfAWRFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:05:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40464 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfAWRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:05:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so1469342plq.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9kGPd+msbQEtf+/mpliwMm45Bffv6BgyFfK78q4Emdg=;
        b=NbEBAxuCGV8mVJp5AnFAZh3b7FGGsVP7v7iApo6vCCWbPhUeWcKfuPdF6fZiHXsgg+
         oNBhqfOcfBdakmYvaaKT5HaNqPl9DRyCw4/O9w7SXKm+tdBPdnZ/5/5R++vdh1Ps40mI
         x929V51TBBMlvN7cM48wWpdnZyf+Tby1qjSBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9kGPd+msbQEtf+/mpliwMm45Bffv6BgyFfK78q4Emdg=;
        b=dbErk8mWtz57ULIvEjx613RLccnnsOTN2zPzRjyxNNRRQv+BGbnN86DiroTtujwt5+
         4Up5D4pVbAHC9PvZrQPJZVLMzz1LhjFKv7S3rVEB5LpAWg/JsRG6dz/RYbhaDxcqadlK
         dQ+f+64SVkV+UgEfUudgZObgfzoDAnvUBhxHzJrfMsZ4SKEQq5/Qh6XDaiDqDkRAAiM+
         R+gvNkbJIrRctkE5fzCTI4cQDg+5ylZM4ew3ULzhIK+pSMwczbrXhil5BmTyNVHqR1ez
         beHB56aD4uE/P7uLDjZ1nDsrTLg/CO8Z8jUh+JIC6HJofpoM8hL/Oag9LFtRJ438bhD/
         1Xxw==
X-Gm-Message-State: AJcUukeTHSeMOo5VfdRwLcnG/FYFlkMlHULmvn8awOaqfuKen6q8UGQF
        QPFAdi4Os3nLAqkGaYPZxgw4dwWF7Iv84Xs0MklDfe2LntNNLRed4Cj0hB48HXGkH6uicy3ArMV
        BZ0rkIfXUmafNniFVW/C911bEhE3ye6BvG7srNjb4gu9LPF5Q6biz7vT+3dIsG4IOnOWU52VY1w
        q9iljj1sDzdvQ=
X-Google-Smtp-Source: ALg8bN4BqkhisjHyc0ae/HfXZswtniSh6TUO1LrfpnNWSPDIp4eLPsB3yFih3ZsKRS0bjzLrQQa26A==
X-Received: by 2002:a17:902:ab84:: with SMTP id f4mr2891888plr.207.1548263132502;
        Wed, 23 Jan 2019 09:05:32 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c9sm40089382pfc.92.2019.01.23.09.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 09:05:31 -0800 (PST)
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To:     Mark Rutland <mark.rutland@arm.com>,
        Pramod Kumar <pramod.kumar@broadcom.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
 <20190123164801.GA55887@lakrids.cambridge.arm.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <f1851a76-8078-b8e7-6a54-b038b47f9214@broadcom.com>
Date:   Wed, 23 Jan 2019 09:05:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123164801.GA55887@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Hopefully I can shed some light on the use case inline.

On 2019-01-23 8:48 a.m., Mark Rutland wrote:
> On Mon, Jan 21, 2019 at 11:30:02AM +0530, Pramod Kumar wrote:
>> On Mon, Jan 21, 2019 at 11:28 AM Pramod Kumar <pramod.kumar@broadcom.com>
>> wrote:
>>
>>      Need comes from a specific use case where one Accelerator card(SoC) is
>>      plugged in a sever over a PCIe interface.  This Card gets supply from a
>>      battery, which could provide very less power for a very small time, in case
>>      of any power loss. Once Card switches to battery, this has to reduce its
>>      power consumption to its lowest point and back-up the DDR contents asap
>>      before battery gets fully drained off.
> In this example is Linux running on the server, or on the accelerator?
Accelerator
>
> What precisely are you trying to back up from DDR, and why?
Data in DDR is being written to disk at this time (disk is connected to 
accelerator)
>
> What is responsible for backing up that contents?

A low power M-class processor and DMA engine which continues necessary 
operations to transfer DDR memory to disk.

The high power processors on the accelerator running linux needed to be 
halted ASAP on this power loss event and M0 take over. Graceful shutdown 
of linux and other peripherals is unnecessary (and we don't have the 
power necessary to do so).

>
>>      Since battery can provide limited power for a very short time hence need to
>>      transition to lowest power. As per the transition process , CPUs power
>>      domain has to be off but before that it needs to flush out its content to
>>      system memory(L3) so that content could be backed-up by a MCU, a controller
>>      consuming very less power. Since we can not afford plugging-out every
>>      individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs
>>      which ultimately switch to ATF to flush out all the CPUs caches and comes
>>      out of coherency domain so that its power rails could be switched-off.
> If you're stopping CPUs from completely arbitrary states, what is the
> benefit of saving the RAM contents?

Some of the RAM contains data that was in the process of being written 
to disk by the accelerator.

This data must be saved to disk and the high power CPUs consume too much 
power to continue performing this operation.

>
> CPUs might be running with IRQs disabled for an arbitrarily long time,

In an embedded linux system we control everything running.

But good point - we'll need to ensure interrupts are not disabled for 
too long.

> so there's no guarantee that all of them will be turned off before power
> is lost.
>
> I'm very confused as to what you're trying to achieve here.
>
> Thanks,
> Mark.

Regards,

  Scott

