Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F97C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCA120673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCA120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbeK3Bzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:55:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:39709 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729863AbeK3Bzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:55:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 06:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="116472715"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2018 06:50:13 -0800
Received: from [10.251.23.56] (kliang2-mobl1.ccr.corp.intel.com [10.251.23.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8B0BE580213;
        Thu, 29 Nov 2018 06:50:11 -0800 (PST)
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
To:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Kyle Huey <me@kylehuey.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, robert@ocallahan.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com>
 <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com>
 <20181120221642.GE2131@hirez.programming.kicks-ass.net>
 <20181120222549.GA2149@hirez.programming.kicks-ass.net>
 <20181120223854.GH13936@tassilo.jf.intel.com>
 <20181121081420.GF2131@hirez.programming.kicks-ass.net>
 <CAP045AqRs4+F5rNKXLYHeuvLCvzd9U=eZY0X0NnHXxz3qk9TUw@mail.gmail.com>
 <20181127233615.GY13936@tassilo.jf.intel.com>
 <CABPqkBQseMq2xnvw71VXT6F=ZR57L+HUAmQ_dZY356Et8NpxQg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <14bdaa24-f7da-7f4d-b5b6-058322fb4af6@linux.intel.com>
Date:   Thu, 29 Nov 2018 09:50:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABPqkBQseMq2xnvw71VXT6F=ZR57L+HUAmQ_dZY356Et8NpxQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2018 8:25 PM, Stephane Eranian wrote:
> On Tue, Nov 27, 2018 at 3:36 PM Andi Kleen <ak@linux.intel.com> wrote:
>>
>>> It does seem that FREEZE_PERFMON_ON_PMI (misnamed as it is) is of
>>> rather limited use (or even negative, in our case) to a counter that's
>>> already restricted to ring 3.
>>
>> It's much faster. The PMI cost goes down dramatically.
>>
>> I still the the right fix is to add an perf event opt-out and let it be
>> used by rr.
>>
>>     V3 is without counter freezing.
>>      V4 is with counter freezing.
>>      The value is the average cost of the PMI handler.
>>      (lower is better)
>>
>>      perf options    `           V3(ns) V4(ns)  delta
>>      -c 100000                   1088   894     -18%
>>      -g -c 100000                1862   1646    -12%
>>      --call-graph lbr -c 100000  3649   3367    -8%
>>      --c.g. dwarf -c 100000      2248   1982    -12%
>>
> Is that measured on the same machine, i.e., do you force V3 on Skylake?

Yes, it's measured on same Kabylake machine with counter_freezing option 
disabled/enabled.


> All it does, I think, is save one wrmsr(GLOBAL_CTLR) on entry to the
> PMU interrupt handler or am I missing something?
> Or does it save two? The wrmsr(GLOBAL_CTRL) at the end to reactivate.

__intel_pmu_disable_all() and __intel_pmu_enable_all() are not called in 
V4 handler. So save at least two wrmsrl.

Thanks,
Kan


