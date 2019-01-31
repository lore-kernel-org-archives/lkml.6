Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E83C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D487218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfAaJxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:53:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:31955 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbfAaJw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:52:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 01:52:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="139463872"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2019 01:52:58 -0800
Received: from [10.125.252.36] (abudanko-mobl.ccr.corp.intel.com [10.125.252.36])
        by linux.intel.com (Postfix) with ESMTP id 41FA358042B;
        Thu, 31 Jan 2019 01:52:56 -0800 (PST)
Subject: Re: [PATCH v5 0/4] Reduce NUMA related overhead in perf record
 profiling on large server systems
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
 <20190128112748.GC15461@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <cbe9780b-e5fa-8abc-11da-4dbbc9593128@linux.intel.com>
Date:   Thu, 31 Jan 2019 12:52:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128112748.GC15461@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.2019 14:27, Jiri Olsa wrote:
> On Tue, Jan 22, 2019 at 08:45:12PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> The patch set has been validated on BT benchmark from NAS Parallel 
>> Benchmarks [2] running on dual socket, 44 cores, 88 hw threads Broadwell 
>> system with kernels v4.4-21-generic (Ubuntu 16.04) and v4.20.0-rc5 
>> (tip perf/core). 
>>
>> The patch set is for Arnaldo's perf/core repository.
>>
>> OVERHEAD:
>> 			       BENCH REPORT BASED   ELAPSED TIME BASED
>> 	  v4.20.0-rc5 
>>           (tip perf/core):
>> 				
>> (current) SERIAL-SYS  / BASE : 1.27x (14.37/11.31), 1.29x (15.19/11.69)
>> 	  SERIAL-NODE / BASE : 1.15x (13.04/11.31), 1.17x (13.79/11.69)
>> 	  SERIAL-CPU  / BASE : 1.00x (11.32/11.31), 1.01x (11.89/11.69)
>> 	
>> 	  AIO1-SYS    / BASE : 1.29x (14.58/11.31), 1.29x (15.26/11.69)
>> 	  AIO1-NODE   / BASE : 1.08x (12.23/11.31), 1,11x (13.01/11.69)
>> 	  AIO1-CPU    / BASE : 1.07x (12.14/11.31), 1.08x (12.83/11.69)
>>
>> 	  v4.4.0-21-generic
>>           (Ubuntu 16.04 LTS):
>>
>> (current) SERIAL-SYS  / BASE : 1.26x (13.73/10.87), 1.29x (14.69/11.32)
>> 	  SERIAL-NODE / BASE : 1.19x (13.02/10.87), 1.23x (14.03/11.32)
>> 	  SERIAL-CPU  / BASE : 1.03x (11.21/10.87), 1.07x (12.18/11.32)
>> 	
>> 	  AIO1-SYS    / BASE : 1.26x (13.73/10.87), 1.29x (14.69/11.32)
>> 	  AIO1-NODE   / BASE : 1.10x (12.04/10.87), 1.15x (13.03/11.32)
>> 	  AIO1-CPU    / BASE : 1.12x (12.20/10.87), 1.15x (13.09/11.32)
>>
>> ---
>> Alexey Budankov (4):
>>   perf record: allocate affinity masks
>>   perf record: bind the AIO user space buffers to nodes
>>   perf record: apply affinity masks when reading mmap buffers
>>   perf record: implement --affinity=node|cpu option
>>
>>  tools/perf/Documentation/perf-record.txt |   5 ++
>>  tools/perf/builtin-record.c              |  45 +++++++++-
>>  tools/perf/perf.h                        |   8 ++
>>  tools/perf/util/cpumap.c                 |  10 +++
>>  tools/perf/util/cpumap.h                 |   1 +
>>  tools/perf/util/evlist.c                 |   6 +-
>>  tools/perf/util/evlist.h                 |   2 +-
>>  tools/perf/util/mmap.c                   | 105 ++++++++++++++++++++++-
>>  tools/perf/util/mmap.h                   |   3 +-
>>  9 files changed, 175 insertions(+), 10 deletions(-)
>>
>> ---
>> Changes in v5:
>> - avoided multiple allocations of online cpu maps by 
>>   implementing it once in cpu_map__online()
>> - reduced indentation at record__parse_affinity()
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>

Thanks! 
Alexey

> 
> thanks,
> jirka
> 
