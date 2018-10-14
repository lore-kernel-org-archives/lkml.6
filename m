Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F334C71125
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 12:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB5D20843
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 12:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB5D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbeJNUaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 16:30:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:35756 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeJNUaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 16:30:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2018 05:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,380,1534834800"; 
   d="scan'208";a="100130489"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga002.jf.intel.com with ESMTP; 14 Oct 2018 05:49:23 -0700
Message-ID: <5BC33C63.7010904@intel.com>
Date:   Sun, 14 Oct 2018 20:53:55 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com
Subject: Re: [PATCH v1] KVM/x86/vPMU: Guest PMI Optimization
References: <1539346817-8638-1-git-send-email-wei.w.wang@intel.com> <20181013133013.GA15612@worktop.programming.kicks-ass.net>
In-Reply-To: <20181013133013.GA15612@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2018 09:30 PM, Peter Zijlstra wrote:
> On Fri, Oct 12, 2018 at 08:20:17PM +0800, Wei Wang wrote:
>> Guest changing MSR_CORE_PERF_GLOBAL_CTRL causes KVM to reprogram pmc
>> counters, which re-allocates a host perf event. This process is
> Yea gawds, that's horrific. Why does it do that? We have
> PERF_EVENT_IOC_PERIOD which does that much better. Still, what you're
> proposing is faster still -- if it is correct.

I'm not sure about the back story. Probably it was an initial functional 
implementation.

>> This patch implements a fast path to handle the guest change of
>> MSR_CORE_PERF_GLOBAL_CTRL for the guest pmi case. Guest change of the
>> msr will be applied to the hardware when entering the guest, and the
>> old perf event will continue to be used. The guest setting of the
>> perf counter for the next irq period in pmi will also be written
>> directly to the hardware counter when entering the guest.
> What you're failing to explain here is why exactly it is ok to write to
> the MSR directly without updating the perf_event state. I didn't take
> the time to go through all that, but it certainly needs documenting.

OK. The guest itself has the perf event (the one that is using the 
hardware counter), and the event state is managed by the guest perf core.
The host side perf event isn't the one that uses the hardware counter. 
Essentially, it is here on the host just to occupy the counter (via the 
host perf core) for the guest. The writing to the MSR here is 
essentially performed on behave of the guest perf event.
So, for the host side perf event, I think its state should be active as 
long as the guest is using the counter. The state will be changed to 
inactive (as usual) when the vCPU is scheduled out.

> This is something that can certainly get broken by accident.
>
> Is there any documentation/comment that explains how this virtual PMU
> crud works in general?

I haven't found any docs that could be useful so far.


>> +u64 intel_pmu_disable_guest_counters(void)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	u64 mask = cpuc->intel_ctrl_host_mask;
>> +
>> +	cpuc->intel_ctrl_host_mask = ULONG_MAX;
>> +
>> +	return mask;
>> +}
>> +EXPORT_SYMBOL_GPL(intel_pmu_disable_guest_counters);
> OK, this them gets the MSR written when we re-enter the guest, after the
> WRMSR trap, right?

Yes, the guest value will be loaded to the MSR.

>
> +		/*
> +		 * The guest PMI handler is asking for enabling the perf
> +		 * counters. This happens at the end of the guest PMI handler,
> +		 * so clear in_pmi.
> +		 */
> +		intel_pmu_enable_guest_counters(pmu->counter_mask);
> +		pmu->in_pmi = false;
> +	}
> +}
> The v4 PMI handler does not in fact do that I think.
>
>> @@ -237,9 +267,23 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>   	default:
>>   		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
>>   		    (pmc = get_fixed_pmc(pmu, msr))) {
>> -			if (!msr_info->host_initiated)
>> -				data = (s64)(s32)data;
>> -			pmc->counter += data - pmc_read_counter(pmc);
>> +			if (pmu->in_pmi) {
>> +				/*
>> +				 * Since we are not re-allocating a perf event
>> +				 * to reconfigure the sampling time when the
>> +				 * guest pmu is in PMI, just set the value to
>> +				 * the hardware perf counter. Counting will
>> +				 * continue after the guest enables the
>> +				 * counter bit in MSR_CORE_PERF_GLOBAL_CTRL.
>> +				 */
>> +				struct hw_perf_event *hwc =
>> +						&pmc->perf_event->hw;
>> +				wrmsrl(hwc->event_base, data);
> But all this relies on the event calling the overflow handler; how does
> this not corrupt the event state such that x86_perf_event_set_period()
> might decide that the generated PMI is a spurious one?
>

We will make the optimization more general in the next version, instead 
of relying on PMI, so the above 2 questions would be gone then.

Best,
Wei



