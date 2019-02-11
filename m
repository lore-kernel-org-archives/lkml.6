Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B51C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1B42083B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S3sQAZXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388354AbfBKUDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:03:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28720 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfBKUDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549915413; x=1581451413;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dgMKljKrDeD8eESyLJyIVqLOrHbFP/IE6E7imTUziVA=;
  b=S3sQAZXAvVGu1iJM4UVlPd6yT0zB8rBc45SCFZh+9gr06JcR1jrcpALS
   1n5n0mEego5tib66l9fiFmFNxyra2Nk3HY2R3q1P3uiNLm43AmtDQ4Q+P
   xsoKGcFw5nmm9o21TguE6BnCq5cnYaDE9KThKpNq05QfFV2PNSE91zj+1
   S+Xt+PiKZrNBtNrrivF6i5aTjE8DR3KPnQ/K8msxhH6iRj6E/frPUdKbv
   MDk3OVAzGOOVe21K/pUzP7AuYG5Ud1IYjCbfFO1a6e1w4IBTAh3kIp9G+
   eg6R6Ud3t4lNGyjqetk7eDZDG9yE2bIjAy5D/jjdhAH9fXHIT4GPDWUWK
   w==;
X-IronPort-AV: E=Sophos;i="5.58,360,1544457600"; 
   d="scan'208";a="199141389"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 04:03:33 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Feb 2019 11:44:09 -0800
Received: from cnf000690.ad.shared (HELO [10.86.62.97]) ([10.86.62.97])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2019 12:03:32 -0800
Subject: Re: [v3 PATCH 8/8] RISC-V: Assign hwcap only according to boot cpu.
To:     Palmer Dabbelt <palmer@sifive.com>,
        "david.abdurachmanov@gmail.com" <david.abdurachmanov@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "me@packi.ch" <me@packi.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "schwab@suse.de" <schwab@suse.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "zongbox@gmail.com" <zongbox@gmail.com>
References: <mhng-baffacaa-599b-4c89-a5a0-e0c85ddb6d44@palmer-si-x1c4>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <83562b9d-e94b-76ce-7240-aac1dce43205@wdc.com>
Date:   Mon, 11 Feb 2019 12:03:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <mhng-baffacaa-599b-4c89-a5a0-e0c85ddb6d44@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 11:02 AM, Palmer Dabbelt wrote:
> On Fri, 08 Feb 2019 20:26:07 PST (-0800), david.abdurachmanov@gmail.com wrote:
>> On Sat, Feb 9, 2019 at 12:03 AM Atish Patra <atish.patra@wdc.com> wrote:
>>>
>>> On 2/8/19 1:11 AM, Christoph Hellwig wrote:
>>>>> +     * We don't support running Linux on hertergenous ISA systems.
>>>>> +     * But first "okay" processor might not be the boot cpu.
>>>>> +     * Check the ISA of boot cpu.
>>>>
>>>> Please use up your available 80 characters per line in comments.
>>>>
>>> I will fix it.
>>>
>>>>> +            /*
>>>>> +             * All "okay" hart should have same isa. We don't know how to
>>>>> +             * handle if they don't. Throw a warning for now.
>>>>> +             */
>>>>> +            if (elf_hwcap && temp_hwcap != elf_hwcap)
>>>>> +                    pr_warn("isa mismatch: 0x%lx != 0x%lx\n",
>>>>> +                            elf_hwcap, temp_hwcap);
>>>>> +
>>>>> +            if (hartid == boot_cpu_hartid)
>>>>> +                    boot_hwcap = temp_hwcap;
>>>>> +            elf_hwcap = temp_hwcap;
>>>>
>>>> So we always set elf_hwcap to the capabilities of the previous cpu.
>>>>
>>>>> +            temp_hwcap = 0;
>>>>
>>>> I think tmp_hwcap should be declared and initialized inside the outer loop
>>>> instead having to manually reset it like this.
>>>>
>>>>> +    }
>>>>>
>>>>> +    elf_hwcap = boot_hwcap;
>>>>
>>>> And then reset it here to the boot cpu.
>>>>
>>>> Shoudn't we only report the features supported by all cores?  Otherwise
>>>> we'll still have problems if the boot cpu supports a feature, but not
>>>> others.
>>>>
>>>
>>> Hmm. The other side of the argument is boot cpu does have a feature that
>>> is not supported by other hart that didn't even boot.
>>> The user space may execute something based on boot cpu capability but
>>> that won't be enabled.
>>>
>>> At least, in this way we know that we are compatible completely with
>>> boot cpu capabilities. Thoughts ?
>>
>> There is one example on the market, e.g., Samsung Exynos 9810.
>>
>> Mongoose 3 (big cores) only support ARMv8.0, while Cortex-A55
>> (little ones) support ARMv8.2 (and that brings atomics support).
>> I think, it's the only ARM SOC that supports different ISA extensions
>> between cores on the same package.
>>
>> Kernel scheduler doesn't know that big cores are missing atomics
>> support or that applications needs it and moves the thread
>> resulting in illegal instruction.
>>
>> E.g., see Golang issue: https://github.com/golang/go/issues/28431
>>
>> I also recall Jon Masters (Computer Architect at Red Hat) advocating
>> against having cores with mismatched capabilities on the server market.
>>
>> It just causes more problems down the line.
> 
> IMO the best bet is to only put extensions in HWCAP that are supported by all
> the harts that userspace will be scheduled on.
> 
Fair enough. Instead of setting HWCAP in setup_arch() once, we can set 
it only for boot cpu. It will be updated after every cpu comes up online.

Thus, HWCAP will consists all extensions supported by all cpus that are 
online currently.


Regards,
Atish
