Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EFDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045D620684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045D620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeHWQEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:04:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45820 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbeHWQEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:04:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7271DED1;
        Thu, 23 Aug 2018 05:35:13 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CB963F5BC;
        Thu, 23 Aug 2018 05:35:09 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] arm64: export memblock_reserve()d regions via
 /proc/iomem
To:     John Stultz <john.stultz@linaro.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        G Gregory <graeme.gregory@linaro.org>, al.stone@linaro.org,
        bhsharma@redhat.com, tbaicar@codeaurora.org,
        kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>,
        hanjun.guo@linaro.org, Sudeep Holla <sudeep.holla@arm.com>,
        dyoung@redhat.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
 <20180723015732.24252-2-takahiro.akashi@linaro.org>
 <CALAqxLU3+tu09M5=D-6xCqweKenfXtZuBGy6tqEP2DoGAs-LNA@mail.gmail.com>
 <38e0224a-46f8-85c3-abe2-5e89d16810ea@arm.com>
 <CALAqxLX=BBcjR3kbK8nhddzdtv7tMiDs2OcvMA-e9QNw6Lv3hg@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <dc5a9115-7536-6d72-18fd-60b5322c870c@arm.com>
Date:   Thu, 23 Aug 2018 13:35:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLX=BBcjR3kbK8nhddzdtv7tMiDs2OcvMA-e9QNw6Lv3hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 21/08/18 20:38, John Stultz wrote:
> On Tue, Aug 21, 2018 at 3:22 AM, James Morse <james.morse@arm.com> wrote:
>> On 08/21/2018 05:39 AM, John Stultz wrote:
>>>
>>> Since this patch landed, on the HiKey board at bootup I'm seeing:
>>>
>>> [    0.451884] WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/setup.c:271
>>> reserve_memblock_reserved_regions+0xd4/0x13c
> ...
>>>  From skimming the patch, it seems this is maybe expected? Or should
>>> this warning raise eyebrows? I can't quite figure it out.
>>

>>> /proc/iomem now has:
>>> ...
>>> 07410000-21efffff : System RAM
>>>    11000000-1113cfff : reserved
>>
>>
>>> 21f00000-21ffffff : reserved
>>
>>
>> ^ This entry is what triggered the warning.
>>
>> It expects that meblock_reserved() memory is also described as memory.
>> (memblock keeps them as separate lists, so its possible to reserve
>> memory that doesn't exist... which it looks like your system is doing)
> 
> So yea, I suspect the hikey dts isn't quite right here then.

The DT mem-reserve code goes and memblock_removes() some regions, instead of
marking them nomap.

Given memblock has a for_each_resv_unavail_range() that explicitly walks
reserved && !memory, it looks like this is expected, and its just me thinking
this is strange.

I will come up with a version of this patch that walks the 'System RAM'
resources that were created during boot, and adds the memblock_reserved()
regions to them, which should stop this happening.


Thanks,

James
