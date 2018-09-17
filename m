Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D18ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747F3214DC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747F3214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbeIQWFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:05:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:51535 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbeIQWFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:05:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 09:37:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,386,1531810800"; 
   d="scan'208";a="81127729"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.130]) ([10.24.14.130])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Sep 2018 09:37:15 -0700
Subject: Re: [PATCH V3 2/6] perf/core: Add helper to obtain performance
 counter index
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1536685533.git.reinette.chatre@intel.com>
 <6f93048a74c66a275f8eb6e1298f10552d1e5d95.1536685533.git.reinette.chatre@intel.com>
 <20180917082336.GP24124@hirez.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <fdb736aa-3c2a-67d3-473f-b5a2a7d2c0e5@intel.com>
Date:   Mon, 17 Sep 2018 09:37:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917082336.GP24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 9/17/2018 1:23 AM, Peter Zijlstra wrote:
> On Tue, Sep 11, 2018 at 10:14:33AM -0700, Reinette Chatre wrote:
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 53c500f0ca79..c04dc666425c 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1025,6 +1025,27 @@ static inline int in_software_context(struct perf_event *event)
>>  	return event->ctx->pmu->task_ctx_nr == perf_sw_context;
>>  }
>>  
>> +/**
>> + * perf_rdpmc_index - Return PMC counter used for event
>> + * @event: the perf_event to which the PMC counter was assigned
>> + *
>> + * The counter assigned to this performance event may change if interrupts
>> + * are enabled. This counter should thus never be used while interrupts are
>> + * enabled. Before this function is used to obtain the assigned counter the
>> + * event could be checked for validity using, for example,
>> + * perf_event_read_local(), within the same interrupt disabled section in
>> + * which this counter is planned to be used.
>> + *
>> + * Return: The index of the performance monitoring counter assigned to
>> + * @perf_event.
>> + */
>> +static inline int perf_rdpmc_index(struct perf_event *event)
>> +{
>> +	lockdep_assert_irqs_disabled();
>> +
>> +	return event->hw.event_base_rdpmc;
>> +}
> 
> I said arch/x86/include/asm/perf_events.h and call it:
> x86_perf_rdpmc_index().
> 
> This function is very much x86 specific.
> 

My response to your original request includes the reason why I made this
change instead. Since you did not reply I assumed that you agreed with
the conclusion and I proceeded with my proposal there:
http://lkml.kernel.org/r/f47a2146-2f1a-49fc-2306-3341154f1186@intel.com

The reason why I made this change is repeated in the cover letter of
this series:
http://lkml.kernel.org/r/cover.1536685533.git.reinette.chatre@intel.com

My original response is copied here for your convenience:
Hi Peter,

On 9/6/2018 7:47 AM, Peter Zijlstra wrote:
> On Thu, Aug 16, 2018 at 01:16:07PM -0700, Reinette Chatre wrote:
>
>> +static inline int x86_perf_rdpmc_ctr_get(struct perf_event *event)
>> +{
>> +	lockdep_assert_irqs_disabled();
>> +
>> +	return IS_ERR_OR_NULL(event) ? -1 : event->hw.event_base_rdpmc;
>> +}
>
> That should be in arch/x86/include/asm/perf_event.h if anywhere. Also,
> call the thing x86_perf_rdpmc_index(), that's consistent with the other
> naming.

Moving it to arch/x86/include/asm/perf_event.h is not trivial since this
file is not familiar with struct perf_event.

struct perf_event, struct hw_perf_event and its member event_base_rdpmc
are all defined in include/linux/perf_event.h - could this function
perhaps be moved there? If so, would perf_rdpmc_index() perhaps be a
better name to be consistent with the other naming?

>
> I don't think there's any point in testing for !event, this is an
> interface that mandates you know wth you're doing anyway.
>

I could add:
/* !CONFIG_PERF_EVENTS */
static inline int perf_rdpmc_index(struct perf_event *event)
{
        return -1;
}

Reinette
