Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E55EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7E12083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7E12083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeHaTmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:42:51 -0400
Received: from foss.arm.com ([217.140.101.70]:60546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeHaTmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:42:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E493A18A;
        Fri, 31 Aug 2018 08:34:48 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.Emea.Arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62EB93F5BD;
        Fri, 31 Aug 2018 08:34:47 -0700 (PDT)
Subject: Re: [RFC PATCH 00/20] x86/intel_rdt: Start abstraction for a second
 arch
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
References: <20180824104519.11203-1-james.morse@arm.com>
 <20180827142204.GA223688@romley-ivt3.sc.intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <dfe94bdc-8fe8-55ff-9c6d-268ffd9dc4ed@arm.com>
Date:   Fri, 31 Aug 2018 16:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827142204.GA223688@romley-ivt3.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 27/08/18 15:22, Fenghua Yu wrote:
> On Fri, Aug 24, 2018 at 11:44:59AM +0100, James Morse wrote:
>> ARM have some upcoming CPU features that are similar to Intel RDT. Resctrl
>> is the defacto ABI for this sort of thing, but it lives under arch/x86.
>>
>> To get existing software working, we need to make resctrl work with arm64.
>> This series is the first chunk of that. The aim is to move the filesystem/ABI
>> parts into /fs/resctrl, and implement a second arch backend.
>>
>>
>> What are the ARM features?
>> Future ARM SoCs may have a feature called MPAM: Memory Partitioning and
>> Monitoring. This is an umbrella term like RDT, and covers a range of controls
>> (like CAT) and monitors (like MBM, CMT).
> 
> Please send a link to MPAM spec.

I'm afraid there isn't a public spec yet, hopefully September/October.


>> This series is almost all about CDP. MPAM has equivalent functionality, but
>> it doesn't need enabling, and doesn't affect the available closids. (I'll
>> try and use Intel terms). MPAM expects the equivalent to IA32_PRQ_MSR to
>> be configured with an Instruction closid and a Data closid. These are the
>> same for no-CDP, and different otherwise. There is no need for them to be
>> adjacent.
>>
>> To avoid emulating CDP in arm64's arch code, this series moves all the ABI
>> parts of the CDP behaviour, (half the closid-space, each having two
>> configurations) into the filesystem parts of resctrl. These will eventually
>> be moved to /fs/.
> 
> Do you have the patches that moves code to /fs/resctrl?

Not currently in a usable state, I haven't successfully rebased this stuff over
the mba_sc additions yet.

My intention was to make any abstracting changes where the code is now, then
move the fs-specific parts in one go when its done. This is so the work can be
broken up into manageable chunks.


>> MPAMs control and monitor configuration is all memory mapped, the base
>> addresses are discovered via firmware tables, so we won't have a table of
>> possible resources that just need alloc_enabling.
>>
>> Is this it? No... there are another two series of a similar size that
>> abstract the MBM/CMT overflow threads and avoid 'fs' code accessing things
>> that have moved into the 'hw' arch specific struct.
>>
>>
>> I'm after feedback on the general approach taken here, bugs, as there are
>> certainly subtleties I've missed, and any strong-opinions on what should be
>> arch-specific, and what shouldn't.
>>
>> This series is based on v4.18, and can be retrieved from:
>> git://linux-arm.org/linux-jm.git -b mpam/resctrl_rework/rfc_1
> 
> Could you please publish MPAM patches as well? Then we can have better idea
> on ARM's specific code. This patch set only has Intel RDT part.

You want to see it all at once (great!). I'm not quite ready with all this yet,
so it will be a while. I assumed 'all at once' would be to much to ask from
reviewers, hence this attempt to break it into small chunks and post it over a
longer period of time.


Thanks,

James
