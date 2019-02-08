Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A72C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDD021920
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfBHIzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:55:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:41703 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfBHIzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:55:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 00:55:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="scan'208";a="114635014"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2019 00:55:05 -0800
Subject: Re: [RFC PATCH] perf, bpf: Retain kernel executable code in memory to
 aid Intel PT tracing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190207111901.2399-1-adrian.hunter@intel.com>
 <20190207200211.GG32477@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <76a91fb3-0f4e-c55f-3176-3ad9a996e936@intel.com>
Date:   Fri, 8 Feb 2019 10:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190207200211.GG32477@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/02/19 10:02 PM, Peter Zijlstra wrote:
> On Thu, Feb 07, 2019 at 01:19:01PM +0200, Adrian Hunter wrote:
>> Subject to memory pressure and other limits, retain executable code, such
>> as JIT-compiled bpf, in memory instead of freeing it immediately it is no
>> longer needed for execution.
>>
>> While perf is primarily aimed at statistical analysis, tools like Intel
>> PT can aim to provide a trace of exactly what happened. As such, corner
>> cases that can be overlooked statistically need to be addressed. For
>> example, there is a gap where JIT-compiled bpf can be freed from memory
>> before a tracer has a chance to read it out through the bpf syscall.
>> While that can be ignored statistically, it contributes to a death by
>> 1000 cuts for tracers attempting to assemble exactly what happened. This is
>> a bit gratuitous given that retaining the executable code is relatively
>> simple, and the amount of memory involved relatively small. The retained
>> executable code is then available in memory images such as /proc/kcore.
>>
>> This facility could perhaps be extended also to init sections.
>>
>> Note that this patch is compile tested only and, at present, is missing
>> the ability to retain symbols.
> 
> You don't need the symbols; you already have them through
> PERF_RECORD_KSYMBOL.

And you intend to use that for module loading/unloading also?

> 
> Also; afaict this patch guarantees exactly nothing. It registers a
> shrinker which will (given enough memory pressure) happily free your
> text before we get around to copying it out.

No, there is a minimum size (default 0) which is not subject to the shrinker.

> 
> Did you read this proposal?

Please cc me on anything affecting Intel PT decoding.

> 
>   https://lkml.kernel.org/r/20190109101808.GG1900@hirez.programming.kicks-ass.net
> 
> (also: s/KCORE_QC/KCORE_QS/ for quiescent state)
> 
> That would create an RCU like interface to /proc/kcore and give you the
> guarantees you need, while also allowing the memory to get freed once
> you've obtained a copy.

So, open /proc/kcore and it pins all executable code in memory?

Do you intend to extend that to module / module init unloads?
