Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAB4C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E9620866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E9620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeILNbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:31:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:50304 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeILNbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:31:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 01:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,364,1531810800"; 
   d="scan'208";a="261896246"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2018 01:27:27 -0700
Received: from [10.125.251.222] (abudanko-mobl.ccr.corp.intel.com [10.125.251.222])
        by linux.intel.com (Postfix) with ESMTP id C66705803CC;
        Wed, 12 Sep 2018 01:27:25 -0700 (PDT)
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com>
 <2c5d4b01-0eb8-f97e-6a70-44be7961d7f8@linux.intel.com>
 <20180910120643.GA4217@gmail.com>
 <1ad36918-ddd0-aa3c-c52e-e4e419409dd4@linux.intel.com>
 <20180911063512.GA130116@gmail.com>
 <20180911141907.GV24106@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9ba76110-ea81-2d0d-ba49-68ac1104c10e@linux.intel.com>
Date:   Wed, 12 Sep 2018 11:27:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911141907.GV24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 11.09.2018 17:19, Peter Zijlstra wrote:
> On Tue, Sep 11, 2018 at 08:35:12AM +0200, Ingo Molnar wrote:
>>> Well, explicit threading in the tool for AIO, in the simplest case, means 
>>> incorporating some POSIX API implementation into the tool, avoiding 
>>> code reuse in the first place. That tends to be error prone and costly.
>>
>> It's a core competency, we better do it right and not outsource it.
>>
>> Please take a look at Jiri's patches (once he re-posts them), I think it's a very good 
>> starting point.
> 
> There's another reason for doing custom per-cpu threads; it avoids
> bouncing the buffer memory around the machine. If the task doing the
> buffer reads is the exact same as the one doing the writes, there's less
> memory traffic on the interconnects.

Yeah, NUMA does matter. Memory locality, i.e. cache sizes and NUMA domains
for kernel/user buffers allocation, needs to be taken into account by the
effective solution. Luckily data losses hasn't been observed when testing 
matrix multiplication on 96 core dual socket machines.

> 
> Also, I think we can avoid the MFENCE in that case, but I'm not sure
> that one is hot enough to bother about on the perf reading side of
> things.

Yep, *FENCE may be costly in HW, especially on larger scale.

> 

Thanks,
Alexey
