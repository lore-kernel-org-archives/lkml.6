Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407CAC6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 12:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F4420659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 12:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F4420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeJNURv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 16:17:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:2542 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbeJNURv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 16:17:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2018 05:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,380,1534834800"; 
   d="scan'208";a="97342989"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2018 05:36:56 -0700
Message-ID: <5BC33978.2020302@intel.com>
Date:   Sun, 14 Oct 2018 20:41:28 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: Re: [PATCH v1] KVM/x86/vPMU: Guest PMI Optimization
References: <1539346817-8638-1-git-send-email-wei.w.wang@intel.com> <20181012163058.GN32651@tassilo.jf.intel.com> <0c774dad-9f16-e9c1-56ea-3865cdfaeee0@redhat.com>
In-Reply-To: <0c774dad-9f16-e9c1-56ea-3865cdfaeee0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2018 04:09 PM, Paolo Bonzini wrote:
>
>> It's not clear to me why you're special casing PMIs here. The optimization
>> should work generically, right?
> Yeah, you can even just check if the counter is in the struct
> cpu_hw_events guest mask, and if so always write the counter MSR directly.

Not sure if we could do that. I think the guest mask on the host 
reflects which counters are used by the host.

Here is the plan I have in mind:
#1 Creates a host perf event on the guest's first bit-setting to 
MSR_CORE_PERF_GLOBAL_CTRL; Meanwhile, disable the intercept of guest 
access to this perf counter related MSRs (i.e. config_base and event_base).
#2 When the vCPU is sched in,
     #2.1 make the MSRs of the perf counters (assigned to the guest in 
#1) interceptible, so that guest accesses to such a counter is captured, 
and marked it "used", and disable the intercept again;
     #2.2 also check if there is any counter that wasn't "used" in the 
last vCPU time slice, if there is, release that counter and the perf event.


>
>>> @@ -237,9 +267,23 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>   	default:
>>>   		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
>>>   		    (pmc = get_fixed_pmc(pmu, msr))) {
>>> -			if (!msr_info->host_initiated)
>>> -				data = (s64)(s32)data;
>>> -			pmc->counter += data - pmc_read_counter(pmc);
>>> +			if (pmu->in_pmi) {
>>> +				/*
>>> +				 * Since we are not re-allocating a perf event
>>> +				 * to reconfigure the sampling time when the
>>> +				 * guest pmu is in PMI, just set the value to
>>> +				 * the hardware perf counter. Counting will
>>> +				 * continue after the guest enables the
>>> +				 * counter bit in MSR_CORE_PERF_GLOBAL_CTRL.
>>> +				 */
>>> +				struct hw_perf_event *hwc =
>>> +						&pmc->perf_event->hw;
>>> +				wrmsrl(hwc->event_base, data);
>> Is that guaranteed to be always called on the right CPU that will run the vcpu?
>>
>> AFAIK there's an ioctl to set MSRs in the guest from qemu, I'm pretty sure
>> it won't handle that.
> How much of the performance improvement comes from here?  In theory
> pmc_read_counter() should always hit a relatively fast path, because the
> smp_call_function_single in perf_event_read doesn't need an IPI.
>
> In any case, this should be a separate patch.

Actually this change wasn't intended for performance improvement. It was 
adapted for the "fast path" we added to the MSR_CORE_PERF_GLOBAL_CTRL 
write handling.

The old implementation captures the guest updating of the period in 
pmc->counter, and then uses the pmc->counter for the perf event 
creation, which gets the guest requested period written to the 
underlying counter via the host perf core. The fast path avoids the perf 
event creation, and accordingly, we need to update the period value 
directly to the hardware counter.

Best,
Wei



