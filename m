Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E34C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF3720870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iSIkk6fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAWRdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:33:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41594 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAWRdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:33:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so1501442pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zLIen4CLcRcogVhE3JINq7XN+F9HlS+WGyrbfoPE9+8=;
        b=iSIkk6fls4FMiftKlByrSNryiR/oeWS/3YgsZlbrofxT0rKmp+R2We3gOC7YoM3Cz1
         D8FNVja6u3MDB8z0Np7MW8pb5u4Ointbx7h+rrwo5cFNZ0Lkz9cZHDTs5qa2gN+kOLLT
         CCwmBDmY/IA54Vu178gftZvtlBigjbqOgQMA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zLIen4CLcRcogVhE3JINq7XN+F9HlS+WGyrbfoPE9+8=;
        b=CCVtuDM90OVMI8r+VES8Q4MjJGuhtA00chK6nqsswqIOXm0BhA5Y74IalYARFm6kZt
         SW2Dr6LgG+R0Zw6Fj8lo7LQsIpfuVJm98HjAtymg4HWuX3jW1ji6r7TJaIKbCSx4z16z
         VOUjpmzFPJDqaLatjfqWtELk4WpbFKXYU6gKvV2wXGe4DYkBR57DTeDeNLGFGismtmMW
         gYhqXTnBn6i7jmBVOKS8PIP3RWQgJRoz0vrf+BuP2xYHlRcRdKU6ceLnOtOmOzu7uDqV
         Dqnkkt8UonvbhAq4VnwEYHCCC940AWhutUuAg4NtO3RYs8L6oTwC+W4sRgyWOqWfpA33
         zrxQ==
X-Gm-Message-State: AJcUukeL3CVJ6SvEu6ae3Nz6Kcc9ST5mFeCFIwCHH+u8r4k5SbjWVq8F
        +G7FEgLcQaLMjqjcdmxhU1j9E4k+3G6NXQ2TVJmTIDSPC+xo6sgQ2nEGR/g78ogucyItGDaCiYf
        k3mwi1kmzQpm30a1uM5f2Kj2lqYz4XS8lZ2U6qQqMjKzIzctklOwVSAE+isnrQuXIQ01/kpk+LT
        SwMUJqF+wHYXU=
X-Google-Smtp-Source: ALg8bN54lBhwtTYgUUckhBMWisULFMMjVEx2eWOp4yXXHUmJ4S+WxTrYph5+23iF88aV5rawBgCc6g==
X-Received: by 2002:a65:590b:: with SMTP id f11mr2785423pgu.60.1548264802463;
        Wed, 23 Jan 2019 09:33:22 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 128sm29989815pfu.129.2019.01.23.09.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 09:33:21 -0800 (PST)
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pramod Kumar <pramod.kumar@broadcom.com>,
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
 <f1851a76-8078-b8e7-6a54-b038b47f9214@broadcom.com>
 <20190123172115.GA31694@e107155-lin>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <6a62b11d-420d-8e1c-b0d0-326963f17853@broadcom.com>
Date:   Wed, 23 Jan 2019 09:33:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123172115.GA31694@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 2019-01-23 9:21 a.m., Sudeep Holla wrote:
> On Wed, Jan 23, 2019 at 09:05:26AM -0800, Scott Branden wrote:
>> Hi Mark,
>>
>> Hopefully I can shed some light on the use case inline.
>>
>> On 2019-01-23 8:48 a.m., Mark Rutland wrote:
>>> On Mon, Jan 21, 2019 at 11:30:02AM +0530, Pramod Kumar wrote:
>>>> On Mon, Jan 21, 2019 at 11:28 AM Pramod Kumar <pramod.kumar@broadcom.com>
>>>> wrote:
>>>>
>>>>       Need comes from a specific use case where one Accelerator card(SoC) is
>>>>       plugged in a sever over a PCIe interface.  This Card gets supply from a
>>>>       battery, which could provide very less power for a very small time, in case
>>>>       of any power loss. Once Card switches to battery, this has to reduce its
>>>>       power consumption to its lowest point and back-up the DDR contents asap
>>>>       before battery gets fully drained off.
>>> In this example is Linux running on the server, or on the accelerator?
>> Accelerator
>>> What precisely are you trying to back up from DDR, and why?
>> Data in DDR is being written to disk at this time (disk is connected to
>> accelerator)
>>> What is responsible for backing up that contents?
>> A low power M-class processor and DMA engine which continues necessary
>> operations to transfer DDR memory to disk.
>>
>> The high power processors on the accelerator running linux needed to be
>> halted ASAP on this power loss event and M0 take over. Graceful shutdown of
>> linux and other peripherals is unnecessary (and we don't have the power
>> necessary to do so).
>>
> It may be unnecessary for your use-case, but not recommended.
No choice - we don't have the time/power for a graceful shutdown.
>
>>>>       Since battery can provide limited power for a very short time hence need to
>>>>       transition to lowest power. As per the transition process , CPUs power
>>>>       domain has to be off but before that it needs to flush out its content to
>>>>       system memory(L3) so that content could be backed-up by a MCU, a controller
>>>>       consuming very less power. Since we can not afford plugging-out every
>>>>       individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs
>>>>       which ultimately switch to ATF to flush out all the CPUs caches and comes
>>>>       out of coherency domain so that its power rails could be switched-off.
>>> If you're stopping CPUs from completely arbitrary states, what is the
>>> benefit of saving the RAM contents?
>> Some of the RAM contains data that was in the process of being written to
>> disk by the accelerator.
>>
>> This data must be saved to disk and the high power CPUs consume too much
>> power to continue performing this operation.
>>
> Why will suspend to ram or idle not work ? It will power off the secondaries
> which this patch is trying to achieve, but in more sane way so that no
> data/state is lost/corrupted as I stated earlier.
We need to take over control of the disk write operations.  There is no 
time/power available to leave linux running.
>
>>> CPUs might be running with IRQs disabled for an arbitrarily long time,
>> In an embedded linux system we control everything running.
>>
> By which I assume you have patches to do all sorts of things to make this
> work and this patch standalone is of no use :)

I believe other patch is in a standalone driver to be upstreamed.

Remainder of code is on a standalone M0 processor not running linux.

>
> I don't like this as it's not scalable to big systems as this is in the
> same code path as system off/reset.
Many things are not used by big systems and vice versa.  What do you 
suggest is done otherwise?
>
> --
> Regards,
> Sudeep

Regards,

  Scott

