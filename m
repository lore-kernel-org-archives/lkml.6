Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF77AC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5972080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5972080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeLMHEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:04:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:23188 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbeLMHEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:04:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 23:04:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; 
   d="scan'208";a="125491785"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2018 23:04:43 -0800
Received: from [10.125.251.221] (abudanko-mobl.ccr.corp.intel.com [10.125.251.221])
        by linux.intel.com (Postfix) with ESMTP id A74AF580380;
        Wed, 12 Dec 2018 23:04:41 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v1 2/3] perf record: apply affinity masks when reading
 mmap buffers
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
 <6e5df6f0-5dfa-265e-73cd-803de96ac9b2@linux.intel.com>
 <20181212121531.GD25240@krava>
Organization: Intel Corp.
Message-ID: <23e17f0d-ed4a-e1f9-3e22-9ef983836eaf@linux.intel.com>
Date:   Thu, 13 Dec 2018 10:04:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181212121531.GD25240@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
On 12.12.2018 15:15, Jiri Olsa wrote:
> On Wed, Dec 12, 2018 at 10:40:22AM +0300, Alexey Budankov wrote:
>>
>> Build node cpu masks for mmap data buffers. Bind AIO data buffers
>> to nodes according to kernel data buffers location. Apply node cpu
>> masks to trace reading thread every time it references memory cross
>> node or cross cpu.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c |  9 +++++++++
>>  tools/perf/util/evlist.c    |  6 +++++-
>>  tools/perf/util/mmap.c      | 38 ++++++++++++++++++++++++++++++++++++-
>>  tools/perf/util/mmap.h      |  1 +
>>  4 files changed, 52 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 4979719e54ae..1a1438c73f96 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -532,6 +532,9 @@ static int record__mmap_evlist(struct record *rec,
>>  	struct record_opts *opts = &rec->opts;
>>  	char msg[512];
>>  
>> +	if (opts->affinity != PERF_AFFINITY_SYS)
>> +		cpu__setup_cpunode_map();
>> +
>>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>>  				 opts->auxtrace_mmap_pages,
>>  				 opts->auxtrace_snapshot_mode,
>> @@ -751,6 +754,12 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>>  		struct perf_mmap *map = &maps[i];
>>  
>>  		if (map->base) {
>> +			if (rec->opts.affinity != PERF_AFFINITY_SYS &&
>> +			    !CPU_EQUAL(&rec->affinity_mask, &map->affinity_mask)) {
>> +				CPU_ZERO(&rec->affinity_mask);
>> +				CPU_OR(&rec->affinity_mask, &rec->affinity_mask, &map->affinity_mask);
>> +				sched_setaffinity(0, sizeof(rec->affinity_mask), &rec->affinity_mask);
>> +			}
> 
> hum, so you change affinity every time you read different map?

That is what exactly happens when --affinity=cpu. With --affinity=node
thread affinity changes only when the thread gets mmap buffer allocated
at the remote node. For dual socket machine it is twice at max for one
loop execution.

> I'm surprised this is actualy faster..

Imagine that some app's thread running on cpu 0 of node 1 generates samples
into a kernel buffer which is also allocated at node 1. The tool thread 
running on cpu 0 of node 0 takes the buffer and puts some part of it into 
write syscall what can cause cross node memory move and induce collection 
overhead (from the kernel buffer into fs cache buffers executing some portion
of write syscall code on cpu 0 of node 0).

> 
> anyway this patch is doing 2 things.. binding the memory allocation
> to nodes and setting the process affinity, please seprate those and
> explain the logic behind

Separated in v2. Binding is implemented for AIO user space buffers only
to map them to the same nodes kernel buffers are mapped to. Tool thread 
affinity mask bouncing is implemented and applicable as for serial as
for AIO streaming. AIO streaming without binding can result in cross node 
memory moves from kernel buffers to AIO ones.

Thanks,
Alexey

> 
> thanks,
> jirka
> 
