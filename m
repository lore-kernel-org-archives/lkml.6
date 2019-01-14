Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50435C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A5120659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfANInf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:43:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:32383 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbfANInf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:43:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 00:43:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,477,1539673200"; 
   d="scan'208";a="125843102"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2019 00:43:34 -0800
Received: from [10.125.252.160] (abudanko-mobl.ccr.corp.intel.com [10.125.252.160])
        by linux.intel.com (Postfix) with ESMTP id 82472580261;
        Mon, 14 Jan 2019 00:43:32 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v1 0/4] perf: enable compression of record mode trace to
 save storage space
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eaa8b5da-103f-61c8-bdca-2a2a27bf1715@linux.intel.com>
 <20190109172843.GE19455@krava>
Organization: Intel Corp.
Message-ID: <b1df6115-e03c-47f4-bdb8-29f1980763f0@linux.intel.com>
Date:   Mon, 14 Jan 2019 11:43:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109172843.GE19455@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 09.01.2019 20:28, Jiri Olsa wrote:
> On Mon, Dec 24, 2018 at 04:21:33PM +0300, Alexey Budankov wrote:
>>
>> The patch set implements runtime record trace compression accompanied by 
>> trace file decompression implemented in the tool report mode. Zstandard 
>> library API [1] is used for compression/decompression of data that come 
>> from perf_events kernel data buffers.
>>
>> Realized -z,--compression_level=n option provides ~3-5x avg. trace file 
>> size reduction on the tested workloads what significantly saves user's 
>> storage space on larger server systems where trace file size can easily 
>> reach several tens or even hundreds of GiBs, especially when profiling 
>> with stacks for later dwarf unwinding, context-switches tracing and etc.
>>
>> The option is effective jointly with asynchronous trace writing because 
>> compression requires auxiliary memory buffers to operate on and memory 
>> buffers for asynchronous trace writing serve that purpose.
> 
> I dont like that it's onlt for aio only, I can't really see why it's

For serial streaming, on CPU bound codes, under full system utilization it 
can induce more runtime overhead and increase data loss because amount of 
code on performance critical path grows, of course size of written data 
reduces but still. Feeding kernel buffer content by user space code to a 
syscall is extended with intermediate copying to user space memory with 
doing some math on it in the middle.

> a problem for normal data.. can't we just have one layer before and
> stream the data to the compress function instead of the file (or aio
> buffers).. and that compress functions would spit out 64K size COMPRESSED
> events, which would go to file (or aio buffers)

It is already almost like that. Compression could be bridged using AIO 
buffers but then still streamed to file serially using record__pushfn() 
and that would make some sense for moderate profiling cases on systems 
without AIO support and trace streaming based on it.

> 
> the report side would process them (decompress) on the session layer
> before the tool callbacks are called

It is already pretty similar to that.

Thanks,
Alexey

> 
> jirka
> 
