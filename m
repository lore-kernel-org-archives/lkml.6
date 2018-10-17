Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E9FECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4120A2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4120A2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeJQXzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:55:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:57465 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQXzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:55:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 08:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="82213028"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2018 08:59:04 -0700
Received: from [10.252.7.84] (abudanko-mobl.ccr.corp.intel.com [10.252.7.84])
        by linux.intel.com (Postfix) with ESMTP id E52F658012D;
        Wed, 17 Oct 2018 08:59:00 -0700 (PDT)
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        mark.rutland@arm.com, megha.dey@intel.com, frederic@kernel.org
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <f12f2d18-2e25-1879-fe34-227c82618abd@linux.intel.com>
 <871s8o62if.fsf@ashishki-desk.ger.corp.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9052ed5a-207f-3be4-6a03-8a23ac358c74@linux.intel.com>
Date:   Wed, 17 Oct 2018 18:58:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <871s8o62if.fsf@ashishki-desk.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 17.10.2018 18:01, Alexander Shishkin wrote:
> Alexey Budankov <alexey.budankov@linux.intel.com> writes:
> 
>> Since it reduces to single cpu context (and single task context) at all times, 
>> ideally, it would probably be coded as simple as this: 
>>
>> 	perf_rotate_context()
>> 	{
>>             cpu = this_cpu_ptr(&cpu_context)
>>             for_every_pmu(pmu, cpu)
>>                     for_every_event_ctx(event_ctx, pmu)
>> 	                    rotate(event_ctx, pmu)
>> 	}
>>
>> so rotate(event_ctx, pmu) would operate on common events objects semantics 
>> and memory layout, and PMU specific code handle SW/HW programming differences.
> 
> Ok, what's event_ctx and how does that simplify things?

Currently, rotate_ctx() is called twice from perf_rotate_context() 
for cpu and task contexts:

struct perf_cpu_context {
	struct perf_event_context	ctx;
	struct perf_event_context	*task_ctx;

If it would be implemented in a loop that could, probably, reduce 
complexity of perf_rotate_context(), partly pushing the complexity 
*down* to SW/HW pmu specific code and perf_rotate_context() would 
become scalable for any number of contexts.

Thanks,
Alexey

> 
> Regards,
> --
> Alex
> 
