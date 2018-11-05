Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15437C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D256120825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D256120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeKEUd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:33:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:19461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeKEUd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:33:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 03:14:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="86760907"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2018 03:14:15 -0800
Message-ID: <5BE02725.3010707@intel.com>
Date:   Mon, 05 Nov 2018 19:19:01 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com
Subject: Re: [PATCH v1 1/8] perf/x86: add support to mask counters from host
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com> <1541066648-40690-2-git-send-email-wei.w.wang@intel.com> <20181101145257.GD3178@hirez.programming.kicks-ass.net> <5BDC140F.6060303@intel.com> <20181105093413.GO3178@hirez.programming.kicks-ass.net>
In-Reply-To: <20181105093413.GO3178@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2018 05:34 PM, Peter Zijlstra wrote:
> On Fri, Nov 02, 2018 at 05:08:31PM +0800, Wei Wang wrote:
>> On 11/01/2018 10:52 PM, Peter Zijlstra wrote:
>>>> @@ -723,6 +724,9 @@ static void perf_sched_init(struct perf_sched *sched, struct event_constraint **
>>>>    	sched->max_weight	= wmax;
>>>>    	sched->max_gp		= gpmax;
>>>>    	sched->constraints	= constraints;
>>>> +#ifdef CONFIG_CPU_SUP_INTEL
>>>> +	sched->state.used[0]	= cpuc->intel_ctrl_guest_mask;
>>>> +#endif
>>> NAK.  This completely undermines the whole purpose of event scheduling.
>>>
>> Hi Peter,
>>
>> Could you share more details how it would affect the host side event
>> scheduling?
> Not all counters are equal; suppose you have one of those chips that can
> only do PEBS on counter 0, and then hand out 0 to the guest for some
> silly event. That means nobody can use PEBS anymore.

Thanks for sharing your point.

In this example (assume PEBS can only work with counter 0), how would 
the existing approach (i.e. using host event to emulate) work?
For example, guest wants to use PEBS, host also wants to use PEBS or 
other features that only counter 0 fits, I think either guest or host 
will not work then.

With the register level virtualization approach, we could further 
support that case: if guest requests to use a counter which host happens 
to be using, we can let host and guest both be satisfied by supporting 
counter context switching on guest/host switching. In this case, both 
guest and host can use counter 0. (I think this is actually a policy 
selection, the current series chooses to be guest first, we can further 
change it if necessary)


>> Would you have any suggestions?
> I would suggest not to use virt in the first place of course ;-)
>
> But whatever you do; you have to keep using host events to emulate the
> guest PMU. That doesn't mean you can't improve things; that code is
> quite insane from what you told earlier.

I agree that the host event emulation is a functional approach, but it 
may not be an effective one (also got complaints from people about 
today's perf in the guest).
We actually have similar problems when doing network virtualization. The 
more effective approach tends to be the one that bypasses the host 
network stack. Both the network stack and perf stack seem to be too 
heavy to be used as part of the emulation.

Hope we could have thorough discussions on the two approaches from 
virtualization point of view, and get to know why host event emulation 
has to be the one, or it could be better to use the register level 
virtualization model.

Best,
Wei



