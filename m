Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689ABC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CDA21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TgCFpBnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfAWRqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:46:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40165 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:46:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so1522711pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6BfjCEBHdc6MrV1GJr/8ErQBlsGnUrVqtYH4hEsBMPg=;
        b=TgCFpBnxUFosCS4bJWEzl88RhZromeZA50eDtC3pu2842zZvPGmCc7QMGNIhLAyyE8
         Gq0QU3xikuG5KYBKmjA/DqDQl22QNhc+me8IkSRmVJsO6+5p3aNJnqlRt1slubBF1ohv
         7ueD+aqhewfIFeyFi3QZLLtl3almTulVfQDiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6BfjCEBHdc6MrV1GJr/8ErQBlsGnUrVqtYH4hEsBMPg=;
        b=IrWqWBjnueDApPelQs+Pt/L2DayCAIaVgQyuvj6gHkaLZ4ifUnEh8LhHTWxZfFc1pe
         paVGsYMrUdjY5bc9Uzc248RWUzN9ThrrL/+1VSQWJX4+mjI96sVY49mCUqm7LUocd2YV
         NnmsrOJp8xGbGJsi7bL7DJ089NmwiF7UlAFg/i5/uDq2fJCvrljDUsQZUPKH4rn4ivW+
         /cVjyLra1aI7oR3TjRBKRb+e+kdHCb/fMuSwTTdrGXniwuTDkpyTMkIjG04YETurWwYs
         2yQ/gOGxRsjZ6Odz6SJuYp+ExwclqM6l3uSMX8p5nofYgpbdVmPHdevb/rr3K2/+YDCG
         6Fyg==
X-Gm-Message-State: AJcUukf9J3ZPxSNQYH7PaA+N9Oo0sKm5Y7F0RzoRpnIPR7qS7saWdA88
        eNVtisTCcVAkvX866oUmKNpyWpTBRCjIsOHNW4EH0q7AkHBfD4BQBji2Mit2dsJZKg/YUZt/bsS
        erZiDWF2ra7qpFqL0ejvqnaYiYYOn1BH8ysAmle5Rp0h/FgSUEFXRoEg9P96aVNrHj6rqLIbW6N
        eqnxG4N77htwA=
X-Google-Smtp-Source: ALg8bN41gsntqWMTOGaOJ4QFEgr0GQtFY2tujN8Eo46QbtDZkoVaRWjfkqghBMuLVi9Vq9jN7K2otw==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr3010059pfh.228.1548265588026;
        Wed, 23 Jan 2019 09:46:28 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q187sm28696057pfq.128.2019.01.23.09.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 09:46:27 -0800 (PST)
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Pramod Kumar <pramod.kumar@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
 <20190123173343.GC55887@lakrids.cambridge.arm.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <90ba929c-362b-a561-1099-5887fc5f6286@broadcom.com>
Date:   Wed, 23 Jan 2019 09:46:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123173343.GC55887@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-23 9:33 a.m., Mark Rutland wrote:
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
> If graceful shutdown of Linux is not required (and is in fact
> undesireable), why is Linux involved at all in this shutdown process?
>
> For example, why is this not a secure interrupt taken to EL3, which can
> (gracefully) shut down the CPUs regardless?
Will need Pramod to explain the detailed rationale here.
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
> Ok, so this isn't actually about backing up RAM contents; it's about
> completing pending I/O.
>
> I'm still confused as to how that works. How do you avoid leaving the
> disk in some corrupt state if data runs out partway through?

Some additional flags and details are saved to disk with the "pending i/o".

On next power up an app runs which recovers the data and recovers it and 
completes processing.

Of course, if the store doesn't succeed properly portions of the 
recovery are discarded.

>
>> This data must be saved to disk and the high power CPUs consume too much
>> power to continue performing this operation.
>>
>>> CPUs might be running with IRQs disabled for an arbitrarily long time,
>> In an embedded linux system we control everything running.
> Sure, and that complete control allows you to do something better than
> this RFC, AFAICT.
If possible that would be great.  Need Pramod to comment whether the 
direct EL3 will solve all issues.
>
> Thanks,
> Mark.

Thanks for input Mark.

Scott

