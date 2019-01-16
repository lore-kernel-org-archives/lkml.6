Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3766C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E65B2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfAPS6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:58:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:13269 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbfAPS6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:58:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 10:58:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="128306916"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 16 Jan 2019 10:58:49 -0800
Received: from [10.251.26.191] (kliang2-mobl1.ccr.corp.intel.com [10.251.26.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D2D5F580261;
        Wed, 16 Jan 2019 10:58:48 -0800 (PST)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH V5 2/4] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
References: <1546900465-5121-1-git-send-email-kan.liang@linux.intel.com>
 <1546900465-5121-2-git-send-email-kan.liang@linux.intel.com>
 <20190116131401.GG15409@zn.tnic>
Message-ID: <b5acda13-a4f8-397c-586f-dd506cfe2d7f@linux.intel.com>
Date:   Wed, 16 Jan 2019 13:58:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116131401.GG15409@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/16/2019 8:14 AM, Borislav Petkov wrote:
>> +static __init void intel_isolation_quirk(void)
>> +{
>> +	x86_pmu.check_microcode = intel_check_isolation;
>> +	intel_check_isolation();
>> +}
>> +
>>   static const struct { int id; char *name; } intel_arch_events_map[] __initconst = {
>>   	{ PERF_COUNT_HW_CPU_CYCLES, "cpu cycles" },
>>   	{ PERF_COUNT_HW_INSTRUCTIONS, "instructions" },
>> @@ -4424,6 +4483,7 @@ __init int intel_pmu_init(void)
>>   	case INTEL_FAM6_HASWELL_X:
>>   	case INTEL_FAM6_HASWELL_ULT:
>>   	case INTEL_FAM6_HASWELL_GT3E:
>> +		x86_add_quirk(intel_isolation_quirk);
> And reportedly, the quirks are one-off things - not what this one
> needs to do. So you need to run this unconditionally at the end of
> intel_pmu_init() and get rid of all that quirks indirection.

Hi Borislav,

Thanks for the review. I will change the code according to all your 
comments.

Besides, I will do one more change which impacts your last comment.

Current intel_check_isolation() will set x86_pmu.pebs_isolated=0 for the 
platforms not in the table. It's OK for now. But it will be a problem 
for future platforms.
I've confirmed with Andi. The microcode patch has been merged into 
future platforms. So we have to always set x86_pmu.pebs_isolated=1 for 
future platforms. That means we have to add the CPU model to the table 
for each new platforms. It will be hard to maintain.

I plan to rename x86_pmu.pebs_isolated to x86_pmu.no_pebs_isolation. The 
default value for x86_pmu.no_pebs_isolation is 0. So we don't need to 
worry about the future platforms.
The unconditional check will be moved to the begin of intel_pmu_init(). 
The old platforms, which doesn't have microcode fix, will be specially 
handled by adding x86_pmu.no_pebs_isolation=1 after each "case :" of old 
platforms.

Thanks,
Kan
