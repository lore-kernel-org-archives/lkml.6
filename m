Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C42ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAB22082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAB22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJYCmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:42:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:50666 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJYCmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:42:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 11:12:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,421,1534834800"; 
   d="scan'208";a="83849842"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2018 11:12:57 -0700
Received: from [10.254.75.130] (kliang2-mobl1.ccr.corp.intel.com [10.254.75.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 862A45803FA;
        Wed, 24 Oct 2018 11:12:56 -0700 (PDT)
Subject: Re: [PATCH 1/2] perf: Add munmap callback
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, Stephane Eranian <eranian@google.com>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <20181024162334.GG6218@tassilo.jf.intel.com>
 <20181024163208.GC15106@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <18d5fcf4-84b2-806c-eb2c-787b96e0fb90@linux.intel.com>
Date:   Wed, 24 Oct 2018 14:12:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024163208.GC15106@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2018 12:32 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 24, 2018 at 09:23:34AM -0700, Andi Kleen escreveu:
>>> +void perf_event_munmap(void)
>>> +{
>>> +	struct perf_cpu_context *cpuctx;
>>> +	unsigned long flags;
>>> +	struct pmu *pmu;
>>> +
>>> +	local_irq_save(flags);
>>> +	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
>>
>> Would be good have a fast path here that checks for the list being empty
>> without disabling the interrupts. munmap can be somewhat hot. I think
>> it's ok to make it slower with perf running, but we shouldn't impact
>> it without perf.
> 
> Right, look at how its counterpart, perf_event_mmap() works:
> 
> void perf_event_mmap(struct vm_area_struct *vma)
> {
>          struct perf_mmap_event mmap_event;
> 
>          if (!atomic_read(&nr_mmap_events))
>                  return;
> <SNIP>
> }
> 

Thanks. I'll add the nr_mmap_events check in V2.

Thanks,
Kan
