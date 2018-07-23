Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAAEECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591DB20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591DB20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbeGWR6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:58:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:54283 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388357AbeGWR6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:58:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 09:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="218355166"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 23 Jul 2018 09:56:23 -0700
Received: from [10.252.208.45] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2127A580388;
        Mon, 23 Jul 2018 09:56:22 -0700 (PDT)
Subject: Re: [PATCH 3/4] perf/x86/intel/ds: Handle PEBS overflow for fixed
 counters
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        vincent.weaver@maine.edu, jolsa@redhat.com, ak@linux.intel.com
References: <20180309021542.11374-1-kan.liang@linux.intel.com>
 <20180309021542.11374-3-kan.liang@linux.intel.com>
 <20180723145944.GB2458@hirez.programming.kicks-ass.net>
 <20180723162114.GD2512@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <e56be489-3f66-8f27-37e4-77b12c1c99f4@linux.intel.com>
Date:   Mon, 23 Jul 2018 12:56:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723162114.GD2512@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/2018 12:21 PM, Peter Zijlstra wrote:
> On Mon, Jul 23, 2018 at 04:59:44PM +0200, Peter Zijlstra wrote:
>> On Thu, Mar 08, 2018 at 06:15:41PM -0800, kan.liang@linux.intel.com wrote:
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index ef47a418d819..86149b87cce8 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -2280,7 +2280,10 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>>>   	 * counters from the GLOBAL_STATUS mask and we always process PEBS
>>>   	 * events via drain_pebs().
>>>   	 */
>>> -	status &= ~(cpuc->pebs_enabled & PEBS_COUNTER_MASK);
>>> +	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
>>> +		status &= ~(cpuc->pebs_enabled & EXTENDED_PEBS_COUNTER_MASK);
>>> +	else
>>> +		status &= ~(cpuc->pebs_enabled & PEBS_COUNTER_MASK);
>>>   
>>>   	/*
>>>   	 * PEBS overflow sets bit 62 in the global status register
>>
>> Doesn't this re-introduce the problem fixed in commit fd583ad1563be,
>> where pebs_enabled:32-34 are PEBS Load Latency, instead of fixed
>> counters?
> 
> Also, since they 'fixed' that conflict, the PEBS_ALL version could be:
> 
> 	state &= cpuc->pebs_enabled;
> 
> Right?

Right.

Thanks,
Kan
