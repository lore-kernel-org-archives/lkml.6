Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B99BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160FF21537
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160FF21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389978AbeHGRox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:44:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:44164 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbeHGRow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:44:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 08:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,455,1526367600"; 
   d="scan'208";a="63009063"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2018 08:29:56 -0700
Received: from [10.254.74.167] (kliang2-mobl1.ccr.corp.intel.com [10.254.74.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BEC185801BD;
        Tue,  7 Aug 2018 08:29:55 -0700 (PDT)
Subject: Re: [PATCH 2/3] x86, perf: Add a separate Arch Perfmon v4 PMI handler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
References: <1533576223-11588-1-git-send-email-kan.liang@linux.intel.com>
 <1533576223-11588-2-git-send-email-kan.liang@linux.intel.com>
 <20180806183515.GR2494@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <fb5eb1f8-f071-d9e5-2ee3-372aa8f64525@linux.intel.com>
Date:   Tue, 7 Aug 2018 11:29:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806183515.GR2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2018 2:35 PM, Peter Zijlstra wrote:
> On Mon, Aug 06, 2018 at 10:23:42AM -0700, kan.liang@linux.intel.com wrote:
>> @@ -2044,6 +2056,14 @@ static void intel_pmu_disable_event(struct perf_event *event)
>>   	if (unlikely(event->attr.precise_ip))
>>   		intel_pmu_pebs_disable(event);
>>   
>> +	/*
>> +	 * We could disable freezing here, but doesn't hurt if it's on.
>> +	 * perf remembers the state, and someone else will likely
>> +	 * reinitialize.
>> +	 *
>> +	 * This avoids an extra MSR write in many situations.
>> +	 */
>> +
>>   	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
>>   		intel_pmu_disable_fixed(hwc);
>>   		return;
>> @@ -2119,6 +2139,11 @@ static void intel_pmu_enable_event(struct perf_event *event)
>>   	if (event->attr.exclude_guest)
>>   		cpuc->intel_ctrl_host_mask |= (1ull << hwc->idx);
>>   
>> +	if (x86_pmu.counter_freezing && !cpuc->frozen_enabled) {
>> +		enable_counter_freeze();
>> +		cpuc->frozen_enabled = 1;
>> +	}
>> +
>>   	if (unlikely(event_is_checkpointed(event)))
>>   		cpuc->intel_cp_status |= (1ull << hwc->idx);
>>   
> 
> Why here? That doesn't really make sense; should this not be in
> intel_pmu_cpu_starting() or something?


For Goldmont Plus, the counter freezing feature can be re-enabled at 
run-time by loading a newer microcode.
We need to check the x86_pmu.counter_freezing every time.


> 
>> +static bool disable_counter_freezing;
>> +module_param(disable_counter_freezing, bool, 0444);
>> +MODULE_PARM_DESC(disable_counter_freezing, "Disable counter freezing feature."
>> +		"The PMI handler will fall back to generic handler."
>> +		"Default is false (enable counter freezing feature).");
> 
> Why?
> 
>> +	/*
>> +	 * Ack the PMU late after the APIC.  This avoids bogus
> 
> That doesn't make sense. PMU and APIC do not have order.
>

The moment FROZEN bit is cleared, counters start counting immediately.
Here, we try to make it as close as possible to IRET.


Thanks,
Kan
