Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CD4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D342085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D342085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeKFBEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:04:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:53307 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbeKFBEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:04:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 07:43:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="271517232"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2018 07:43:43 -0800
Received: from [10.251.16.220] (kliang2-mobl1.ccr.corp.intel.com [10.251.16.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B9E2C580213;
        Mon,  5 Nov 2018 07:43:42 -0800 (PST)
Subject: Re: [PATCH 1/2] perf: Add munmap callback
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <CABPqkBQEp9SLQuAonW7-c9HzH4bSgUyJGJ5ZZNXHy-0phHvvZQ@mail.gmail.com>
 <c7356e5d-71e2-1562-1a0b-2ca0d985d4cb@linux.intel.com>
 <CABPqkBRT678TYMbPMwsUjmazQij_qFDgu2nS7dm619ukni5EGQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <abe1cbab-d010-0899-acb1-32b1f9bf17df@linux.intel.com>
Date:   Mon, 5 Nov 2018 10:43:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABPqkBRT678TYMbPMwsUjmazQij_qFDgu2nS7dm619ukni5EGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/2018 5:59 AM, Stephane Eranian wrote:
> Hi Kan,
> 
> I built a small test case for you to demonstrate the issue for code and data.
> Compile the test program and then do:
> For text:
> $ perf record  ./mmap
> $ perf report -D | fgrep MMAP2
> 
> The test program mmaps 2 pages, unmaps the second, and remap 1 page
> over the freed space.
> If you look at the MMAP2 record, you will not be able to reconstruct
> what happened and perf will
> get confused should it try to symbolize from the address range
> 
> With Text:
> PERF_RECORD_MMAP2 5937/5937: [0x400000(0x1000) @ 0 08:01 400938
> 824817672]: r-xp /home/eranian/mmap
> PERF_RECORD_MMAP2 5937/5937: [0x7f7c01019000(0x2000) @ 0x7f7c01019000
> 00:00 0 0]: rwxp //anon
> PERF_RECORD_MMAP2 5937/5937: [0x7f7c01019000(0x2000) @ 0x7f7c01019000
> 00:00 0 0]: rwxp //anon
> 
> ^^^^^^^^^^^^^^^^^^^^^^^^ captures the whole VMA but not the mapping
> change in user space
> 
> For data:
> $ perf record -d  ./mmap
> $ perf report -D | fgrep MMAP2
> With data:
> PERF_RECORD_MMAP2 6430/6430: [0x400000(0x1000) @ 0 08:01 400938
> 3278843184]: r-xp /home/eranian/mmap
> PERF_RECORD_MMAP2 6430/6430: [0x7f4aa704b000(0x2000) @ 0x7f4aa704b000
> 00:00 0 0]: rw-p //anon
> PERF_RECORD_MMAP2 6430/6430: [0x7f4aa704b000(0x2000) @ 0x7f4aa704b000
> 00:00 0 0]: rw-p //anon
> 
> Same test case with data.
> Perf will think the entire 2 pages have been replaced when in fact
> only the second has.
> I believe the problem is likely to impact data and jitted code cache
> 
> #include <sys/types.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <err.h>
> #include <getopt.h>
> 
> int main(int argc, char **argv)
> {
> void *addr1, *addr2;
> size_t pgsz = sysconf(_SC_PAGESIZE);
> int n = 2;
> int ret;
> int c, mode = 0;
> 
> while ((c = getopt(argc, argv, "hd")) != -1) {
> switch (c) {
> case 'h':
> printf("[-h]\tget this help\n");
> printf("[-d]\tuse data mmaps (no PROT_EXEC)\n");
> return 0;
> case 'd':
> mode = PROT_EXEC;
> break;
> default:
> errx(1, "unknown option");
> }
> }
> /* default to data */
> if (mode == 0)
> mode = PROT_WRITE;
> 
> /*
> * mmap 2 contiugous pages
> */
> addr1 = mmap(NULL, n * pgsz, PROT_READ| mode, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> if (addr1 == (void *)MAP_FAILED)
> err(1, "mmap 1 failed");
> 
> printf("addr1=[%p : %p]\n", addr1, addr1 + n * pgsz);
> 
> /*
> * unmap only the second page
> */
> ret = munmap(addr1 + pgsz, pgsz);
> if (ret == -1)
> err(1, "munmp failed");
> 
> /*
> * mmap 1 page at the location of the unmap page (should reuse virtual space)
> * This creates a continuous region built from two mmaps and
> potentially two different sources
> * especially with jitted runtimes
> */

The two mmaps are both anon. As my understanding, we cannot symbolize 
from the anonymous address, can we?
If we cannot, why we have to distinguish with them? I think we do not 
need to know their sources for symbolization.

As my understanding, only --jit can inject MMAP event, which tag an 
anon. Perf can symbolize the address after that. Then the unmap is needed.

Thanks,
Kan
> addr2 = mmap(addr1 + pgsz, 1 * pgsz, PROT_READ|PROT_WRITE | mode,
> MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> 
> printf("addr2=%p\n", addr2);
> 
> if (addr2 == (void *)MAP_FAILED)
> err(1, "mmap 2 failed");
> if (addr2 != (addr1 + pgsz))
> errx(1, "wrong mmap2 address");
> 
> sleep(1);
> 
> return 0;
> }
> 
> On Thu, Nov 1, 2018 at 7:10 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 10/24/2018 3:30 PM, Stephane Eranian wrote:
>>> The need for this new record type extends beyond physical address conversions
>>> and PEBS. A long while ago, someone reported issues with symbolization related
>>> to perf lacking munmap tracking. It had to do with vma merging. I think the
>>> sequence of mmaps was as follows in the problematic case:
>>> 1.   addr1 = mmap(8192);
>>> 2.   munmap(addr1 + 4096, 4096)
>>> 3.   addr2 = mmap(addr1+4096, 4096)
>>>
>>> If successful, that yields addr2 = addr1 + 4096 (could also get the
>>> same without forcing the address).
>>>
>>> In that case, if I recall correctly, the vma for 1st mapping (now at
>>> 4k) and that of the 2nd mapping (4k)
>>> get merged into a single 8k vma and this is what perf_events will
>>> record for PERF_RECORD_MMAP.
>>> On the perf tool side, it is assumed that if two timestamped mappings
>>> overlap then, the latter overrides
>>> the former. In this case, perf would loose the mapping of the first
>>> 4kb and assume all symbols comes from
>>> 2nd mapping. Hopefully I got the scenario right. If so, then you'd
>>> need PERF_RECORD_UNMAP to
>>> disambiguate assuming the perf tool is modified accordingly.
>>>
>>
>> Hi Stephane and Peter,
>>
>> I went through the link(https://lkml.org/lkml/2017/1/27/452). I'm trying
>> to understand the problematic case.
>>
>> It looks like the issue can only be triggered by perf inject --jit.
>> Because it can inject extra MMAP events.
>> As my understanding,  Linux kernel only try to merge VMAs if they are
>> both from anon or they are both from the same file. --jit breaks the
>> rule, and makes the merged VMA partly from anon, partly from file.
>> Now, there is a new MMAP event which range covers the modified VMA.
>> Without the help of MUNMAP event, perf tool have no idea if the new one
>> is a newly merged VMA (modified VMA + a new VMA) or a brand new VMA.
>> Current code just simply overwrite the modified VMAs. The VMA
>> information which --jit injected may be lost. The symbolization may be
>> lost as well.
>>
>> Except --jit, the VMAs information should be consistent between kernel
>> and perf tools. We shouldn't observe the problem. MUNMAP event is not
>> needed.
>>
>> Is my understanding correct?
>>
>> Do you have a test case for the problem?
>>
>> Thanks,
>> Kan
