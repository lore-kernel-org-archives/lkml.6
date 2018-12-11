Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3E7C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB8120851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB8120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeLKSeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:34:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:2450 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbeLKSeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:34:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 10:34:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="97945078"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.157]) ([10.24.14.157])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2018 10:34:00 -0800
Subject: Re: [PATCH V2] x86/intel_rdt: Ensure usage of CPUs are locked while
 needed
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <b7b17432a80f95a1fa21a1698ba643014f58ad31.1544476425.git.reinette.chatre@intel.com>
 <20181211123404.GC27375@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <ece2581e-d5e5-c26c-53e5-0cef8b37e59f@intel.com>
Date:   Tue, 11 Dec 2018 10:33:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181211123404.GC27375@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 12/11/2018 4:34 AM, Borislav Petkov wrote:
> On Mon, Dec 10, 2018 at 01:21:54PM -0800, Reinette Chatre wrote:
>> The user triggers the creation of a pseudo-locked region when writing
>> the requested schemata to the schemata resctrl file. The pseudo-locking
>> of a region is required to be done on a CPU that is associated with the
>> cache on which the pseudo-locked region will reside. In order to run the
>> locking code on a specific CPU the needed CPU has to be selected and
>> ensured to remain online during the entire locking sequence.
>>
>> At this time the cpu_hotplug_lock is not taken during the pseudo-lock
>> region creation and it is thus possible for a CPU to be selected to run
>> the pseudo-locking code and then that CPU to go offline before the
>> thread is able to run on it.
>>
>> Fix this by ensuring that the cpu_hotplug_lock is taken while the CPU on
>> which code has to run needs to be controlled. Since the cpu_hotplug_lock
>> is always taken before rdtgroup_mutex the lock order is maintained.
>>
>> Fixes: e0bdfe8e36f3 ("x86/intel_rdt: Support creation/removal of pseudo-locked region")
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: stable@vger.kernel.org
>> ---
>> V2:
>> - Rebase against tip/x86/urgent
>> - Modify subject from x86/resctrl to x86/intel_rdt to match subject used
>>   before the code reorganization.
>>
>>  arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> I took it but changed the subject to the more straight-forward:

Thank you very much.

> 
> "x86/intel_rdt: Disable CPU hotplug while modifying schemata"

I am not sure that this is an issue when updating a schemata in the
general case. In the case when just CAT schemata (without
pseudo-locking) is updated then the cpu mask associated with the cache
instance is indeed used to determine which CPUs should have their
registers changed but only the current CPU is not checked for being
online, for the other CPUs smp_call_function_many() is used that
includes an online check.

> Now, your second patch:
> 
>   Subject: [PATCH V2] x86/resctrl: Fix rdt_find_domain() return value and checks
>   Message-Id: <b88cd4ff6a75995bf8db9b0ea546908fe50f69f3.1544479852.git.reinette.chatre@intel.com>
> 
> has the new file paths, has Fixes: tags but no CC:stable.
> 
> I'm guessing it needs to go in the next merge window with the rest of
> the new stuff and not now, with the urgent pile?
> 
> I'm thinking that because it is not really a bug now, as the negative ID
> happens to work.

I had the same question in V1's notes to the maintainer :)

My initial concern was the lack of IS_ERR checking. Understanding the
flow better now it seems to me that this is indeed not a bug now. The
reasoning is that an ERR_PTR is only returned when a negative id is
provided in the parameters to rdt_find_domain(). There are currently
only two places where a negative id could be provided to
rdt_find_domain(), domain_add_cpu() and domain_remove_cpu(), and both
locations test the return value using IS_ERR.

Reinette


