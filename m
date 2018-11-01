Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A925BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6864A20830
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6864A20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeKAXMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:12:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:4260 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbeKAXMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:12:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 07:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,452,1534834800"; 
   d="scan'208";a="92949471"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Nov 2018 07:09:39 -0700
Received: from [10.251.5.195] (kliang2-mobl1.ccr.corp.intel.com [10.251.5.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 200565802E4;
        Thu,  1 Nov 2018 07:09:38 -0700 (PDT)
Subject: Re: [PATCH 1/2] perf: Add munmap callback
To:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <CABPqkBQEp9SLQuAonW7-c9HzH4bSgUyJGJ5ZZNXHy-0phHvvZQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c7356e5d-71e2-1562-1a0b-2ca0d985d4cb@linux.intel.com>
Date:   Thu, 1 Nov 2018 10:09:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABPqkBQEp9SLQuAonW7-c9HzH4bSgUyJGJ5ZZNXHy-0phHvvZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2018 3:30 PM, Stephane Eranian wrote:
> The need for this new record type extends beyond physical address conversions
> and PEBS. A long while ago, someone reported issues with symbolization related
> to perf lacking munmap tracking. It had to do with vma merging. I think the
> sequence of mmaps was as follows in the problematic case:
> 1.   addr1 = mmap(8192);
> 2.   munmap(addr1 + 4096, 4096)
> 3.   addr2 = mmap(addr1+4096, 4096)
> 
> If successful, that yields addr2 = addr1 + 4096 (could also get the
> same without forcing the address).
> 
> In that case, if I recall correctly, the vma for 1st mapping (now at
> 4k) and that of the 2nd mapping (4k)
> get merged into a single 8k vma and this is what perf_events will
> record for PERF_RECORD_MMAP.
> On the perf tool side, it is assumed that if two timestamped mappings
> overlap then, the latter overrides
> the former. In this case, perf would loose the mapping of the first
> 4kb and assume all symbols comes from
> 2nd mapping. Hopefully I got the scenario right. If so, then you'd
> need PERF_RECORD_UNMAP to
> disambiguate assuming the perf tool is modified accordingly.
> 

Hi Stephane and Peter,

I went through the link(https://lkml.org/lkml/2017/1/27/452). I'm trying 
to understand the problematic case.

It looks like the issue can only be triggered by perf inject --jit. 
Because it can inject extra MMAP events.
As my understanding,  Linux kernel only try to merge VMAs if they are 
both from anon or they are both from the same file. --jit breaks the 
rule, and makes the merged VMA partly from anon, partly from file.
Now, there is a new MMAP event which range covers the modified VMA.
Without the help of MUNMAP event, perf tool have no idea if the new one 
is a newly merged VMA (modified VMA + a new VMA) or a brand new VMA.
Current code just simply overwrite the modified VMAs. The VMA 
information which --jit injected may be lost. The symbolization may be 
lost as well.

Except --jit, the VMAs information should be consistent between kernel 
and perf tools. We shouldn't observe the problem. MUNMAP event is not 
needed.

Is my understanding correct?

Do you have a test case for the problem?

Thanks,
Kan
