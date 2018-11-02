Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E17EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B39F2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B39F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeKBSKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:10:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:52058 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeKBSKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:10:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 02:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,455,1534834800"; 
   d="scan'208";a="105355805"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga002.jf.intel.com with ESMTP; 02 Nov 2018 02:03:47 -0700
Message-ID: <5BDC140F.6060303@intel.com>
Date:   Fri, 02 Nov 2018 17:08:31 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com
Subject: Re: [PATCH v1 1/8] perf/x86: add support to mask counters from host
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com> <1541066648-40690-2-git-send-email-wei.w.wang@intel.com> <20181101145257.GD3178@hirez.programming.kicks-ass.net>
In-Reply-To: <20181101145257.GD3178@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2018 10:52 PM, Peter Zijlstra wrote:
> On Thu, Nov 01, 2018 at 06:04:01PM +0800, Wei Wang wrote:
>> Add x86_perf_mask_perf_counters to reserve counters from the host perf
>> subsystem. The masked counters will not be assigned to any host perf
>> events. This can be used by the hypervisor to reserve perf counters for
>> a guest to use.
>>
>> This function is currently supported on Intel CPUs only, but put in x86
>> perf core because the counter assignment is implemented here and we need
>> to re-enable the pmu which is defined in the x86 perf core in the case
>> that a counter to be masked happens to be used by the host.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   arch/x86/events/core.c            | 37 +++++++++++++++++++++++++++++++++++++
>>   arch/x86/include/asm/perf_event.h |  1 +
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 106911b..e73135a 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -716,6 +716,7 @@ struct perf_sched {
>>   static void perf_sched_init(struct perf_sched *sched, struct event_constraint **constraints,
>>   			    int num, int wmin, int wmax, int gpmax)
>>   {
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>   	int idx;
>>   
>>   	memset(sched, 0, sizeof(*sched));
>> @@ -723,6 +724,9 @@ static void perf_sched_init(struct perf_sched *sched, struct event_constraint **
>>   	sched->max_weight	= wmax;
>>   	sched->max_gp		= gpmax;
>>   	sched->constraints	= constraints;
>> +#ifdef CONFIG_CPU_SUP_INTEL
>> +	sched->state.used[0]	= cpuc->intel_ctrl_guest_mask;
>> +#endif
> NAK.  This completely undermines the whole purpose of event scheduling.
>

Hi Peter,

Could you share more details how it would affect the host side event 
scheduling?

We wanted to partition out the perf counters that the guest needs and
dedicated them to guest usages for that period (i.e. guest occupation 
period).
The remaining counters are still schedulable for the host events (there 
won't be
many other perf events when the guest runs, watchdog_hld seems to be the one
that would).

Would you have any suggestions? Thanks.

Best,
Wei






