Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06691FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37D920861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37D920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeINM2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:28:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:41753 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbeINM2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:28:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 00:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="90393647"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2018 00:15:04 -0700
Received: from [10.125.251.160] (abudanko-mobl.ccr.corp.intel.com [10.125.251.160])
        by linux.intel.com (Postfix) with ESMTP id 72CF158053F;
        Fri, 14 Sep 2018 00:15:02 -0700 (PDT)
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>, kernel-team@lge.com
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914022910.GA15146@sejong>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f706445f-8bf6-8d8a-860e-51b9333c5947@linux.intel.com>
Date:   Fri, 14 Sep 2018 10:15:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914022910.GA15146@sejong>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On 14.09.2018 5:29, Namhyung Kim wrote:
> On Thu, Sep 13, 2018 at 07:10:35PM +0300, Alexey Budankov wrote:
>> Hi,
> 
> Hello,
> 
>>
>> On 13.09.2018 15:54, Jiri Olsa wrote:
>>> hi,
>>> sending *RFC* for threads support in perf record command.
>>>
>>> In big picture this patchset adds perf record --threads
>>> option that allows to create threads in following modes:
>>>
>>> 1) single thread mode (current)
>>>
>>>   $ perf record ...
>>>   $ perf record --threads=1 ...
>>>
>>>   - all maps are read/stored under process thread
>>>
>>> 2) mode with specific (X) number of threads
>>>
>>>   $ perf record --threads=X ...
>>>
>>>   - maps are spread equaly among threads
>>>
>>> 3) mode that creates thread for every monitored memory map
>>>
>>>   $ perf record --threads ...
>>>
>>>   - which in perf record is equal to number of CPUs, and
>>>     it pins each thread to its map's cpu:
>>>
>>> 4) TODO - NUMA aware threads/maps separation
>>>    ...
>>>
>>> The perf.data stays as a single file.
> 
> I'm not sure we really need to keep it as a single file.  As it's a
> kind of big changes, we might consider breaking compatibility and use
> a directory structure.
> 
> 
>>>
>>> v2 changes:
>>>   - rebased to current Arnaldo's perf/core
>>>     (also based on few fixes from my perf/core, see the branch details below)
>>>
>>> This patchset contains lot of preparation changes to make
>>> threaded record possible:
>>>
>>>   - Namhyung's changes to create multiple data streams in
>>>     perf data file, which allows having each thread data
>>>     being stored in separate files and merged into single
>>>     perf data after
>>>
>>>   - Namhyung's changes to create track mmaps for auxiliary
>>>     events
>>>
>>>   - Namhyung's changes to search for threads/mmaps/comms
>>>     using the time. This is needed because we have now
>>>     multiple data streams which are processed separately,
>>>     but they all need access to complete auxiliary events
>>>     data (threads/mmaps/comms). That's also a reason why
>>>     the auxiliary events are stored into separate data
>>>     stream, which is processed before real data.
>>>
>>>   - the rest of the code that adds threads abstraction into
>>>     record command allows to create them and distribute maps
>>>     among them
>>>
>>>   - other preparational changes
>>>
>>> The threaded monitoring currently can't monitor backward maps
>>> and there are probably more limitations which I haven't spotted
>>> yet.
>>>
>>> So far I tested on laptop:
>>>   http://people.redhat.com/~jolsa/record_threads/test-4CPU.txt
>>>
>>> and a one bigger server:
>>>   http://people.redhat.com/~jolsa/record_threads/test-208CPU.txt
>>>
>>> I can see decrease in recorded LOST events, but both the benchmark
>>> and the monitoring must be carefully configured wrt:
>>>   - number of events (frequency)
>>>   - size of the memory maps
>>>   - size of events (callchains)
>>>   - final perf.data size
>>>
>>> It's also available in:
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>>>   perf/record_threads
>>>
>>> thoughts? ;-) thanks
>>> jirka
>>
>> It is preferable to split into smaller pieces that bring 
>> some improvement proved by metrics numbers and ready for 
>> merging and upstream. Do we have more metrics than the 
>> data loss from trace AIO patches?
> 
> Well, this change is to enable parallel access of perf data so the
> preparation works don't affect single thread processing (hopefully) or
> make it even worse.  I'm not sure if could be split for performance
> benefits.
> 
> 
>>
>> There is usage of Posix threading API but there is no 
>> its implementation in the patch series, to avoid dependency 
>> on externally coded designs in the core of the tool.
> 
> Do you mean it needs to implement its own threading?  I don't think
> that's what Ingo wanted to.

Pthreads implementation is still a part of libc and even part of 
other libpthread.so binary in case of glibc.

I guess for Pthreads it is probably acceptable to reside separately 
because as glibc as bionic provide reasonable implementation. 

But which else libc libraries do Perf target? It is preferable to 
clarify it in advance in order to provide complete implementation.

Thanks,
Alexey

> 
> Thanks,
> Namhyung
> 
> 
>>
>>>
>>>
>>> ---
>>> Jiri Olsa (30):
>>>       perf tools: Remove perf_tool from event_op2
>>>       perf tools: Remove perf_tool from event_op3
>>>       perf tools: Pass struct perf_mmap into auxtrace_mmap__read* functions
>>>       perf tools: Add struct perf_mmap arg into record__write
>>>       perf tools: Create separate mmap for dummy tracking event
>>>       perf tools: Make copyfile_offset global
>>>       perf tools: Add perf_data__create_index function
>>>       perf record: Add --index option for building index table
>>>       perf tools: Convert dead thread list into rbtree
>>>       perf tools: Add thread::exited flag
>>>       perf callchain: Maintain libunwind's address space in map_groups
>>>       perf tools: Rename perf_evlist__munmap_filtered to perf_mmap__put_filtered
>>>       tools lib fd array: Introduce fdarray__add_clone function
>>>       tools lib subcmd: Add OPT_INTEGER_OPTARG|_SET options
>>>       perf tools: Move __perf_session__process_events args into struct
>>>       perf ui progress: Fix index progress display
>>>       perf tools: Add threads debug variable
>>>       perf tools: Add perf_mmap__read_tail function
>>>       perf record: Introduce struct record_thread
>>>       perf record: Read record thread's mmaps
>>>       perf record: Move waking into struct record
>>>       perf record: Move samples into struct record_thread
>>>       perf record: Move bytes_written into struct record_thread
>>>       perf record: Add record_thread start/stop/process functions
>>>       perf record: Wait for all threads being started
>>>       perf record: Add --threads option
>>>       perf record: Add --thread-stats option support
>>>       perf record: Add maps to --thread-stats output
>>>       perf record: Spread maps for --threads option
>>>       perf record: Spread maps for --threads=X option
>>>
>>> Namhyung Kim (18):
>>>       perf tools: Use a software dummy event to track task/mmap events
>>>       perf tools: Extend perf_evlist__mmap_ex() to use track mmap
>>>       perf report: Skip dummy tracking event
>>>       perf tools: Add HEADER_DATA_INDEX feature
>>>       perf tools: Handle indexed data file properly
>>>       perf tools: Introduce thread__comm(_str)_by_time() helpers
>>>       perf tools: Add a test case for thread comm handling
>>>       perf tools: Use thread__comm_by_time() when adding hist entries
>>>       perf tools: Introduce machine__find*_thread_by_time()
>>>       perf tools: Add a test case for timed thread handling
>>>       perf tools: Maintain map groups list in a leader thread
>>>       perf tools: Introduce thread__find_symbol_by_time() and friends
>>>       perf callchain: Use thread__find_addr_location_by_time() and friends
>>>       perf tools: Add a test case for timed map groups handling
>>>       perf tools: Save timestamp of a map creation
>>>       perf tools: Introduce map_groups__{insert,find}_by_time()
>>>       perf tools: Use map_groups__find_addr_by_time()
>>>       perf tools: Add testcase for managing maps with time
>>>
>>>  tools/lib/api/fd/array.c                 |  17 +
>>>  tools/lib/api/fd/array.h                 |   1 +
>>>  tools/lib/subcmd/parse-options.c         |   2 +
>>>  tools/lib/subcmd/parse-options.h         |   9 +
>>>  tools/perf/Documentation/perf-record.txt |   4 +
>>>  tools/perf/Documentation/perf.txt        |   1 +
>>>  tools/perf/builtin-annotate.c            |   7 +-
>>>  tools/perf/builtin-inject.c              |  32 +-
>>>  tools/perf/builtin-record.c              | 899 +++++++++++++++++++++++++++++--
>>>  tools/perf/builtin-report.c              |  12 +-
>>>  tools/perf/builtin-script.c              |  38 +-
>>>  tools/perf/builtin-stat.c                |  23 +-
>>>  tools/perf/perf.c                        |   1 +
>>>  tools/perf/perf.h                        |   3 +
>>>  tools/perf/tests/Build                   |   4 +
>>>  tools/perf/tests/builtin-test.c          |  16 +
>>>  tools/perf/tests/dwarf-unwind.c          |   4 +-
>>>  tools/perf/tests/hists_common.c          |   2 +-
>>>  tools/perf/tests/hists_link.c            |   2 +-
>>>  tools/perf/tests/tests.h                 |   4 +
>>>  tools/perf/tests/thread-comm.c           |  48 ++
>>>  tools/perf/tests/thread-lookup-time.c    | 181 +++++++
>>>  tools/perf/tests/thread-map-time.c       |  90 ++++
>>>  tools/perf/tests/thread-mg-share.c       |   7 +-
>>>  tools/perf/tests/thread-mg-time.c        |  94 ++++
>>>  tools/perf/ui/browsers/hists.c           |  30 +-
>>>  tools/perf/ui/gtk/hists.c                |   3 +
>>>  tools/perf/util/auxtrace.c               |  30 +-
>>>  tools/perf/util/auxtrace.h               |  21 +-
>>>  tools/perf/util/data.c                   |  64 +++
>>>  tools/perf/util/data.h                   |   5 +
>>>  tools/perf/util/debug.c                  |   2 +
>>>  tools/perf/util/debug.h                  |   1 +
>>>  tools/perf/util/dso.c                    |   2 +-
>>>  tools/perf/util/event.c                  | 135 ++++-
>>>  tools/perf/util/evlist.c                 |  96 +++-
>>>  tools/perf/util/evlist.h                 |   7 +-
>>>  tools/perf/util/evsel.h                  |  15 +
>>>  tools/perf/util/header.c                 |  93 +++-
>>>  tools/perf/util/header.h                 |  18 +-
>>>  tools/perf/util/hist.c                   |   4 +-
>>>  tools/perf/util/intel-pt.c               |   2 +-
>>>  tools/perf/util/machine.c                | 293 ++++++++--
>>>  tools/perf/util/machine.h                |  22 +-
>>>  tools/perf/util/map.c                    |  79 ++-
>>>  tools/perf/util/map.h                    |  40 +-
>>>  tools/perf/util/mmap.c                   |   6 +-
>>>  tools/perf/util/mmap.h                   |  33 +-
>>>  tools/perf/util/session.c                | 178 +++---
>>>  tools/perf/util/session.h                |   5 +-
>>>  tools/perf/util/stat.c                   |   5 +-
>>>  tools/perf/util/stat.h                   |   5 +-
>>>  tools/perf/util/symbol-elf.c             |   2 +-
>>>  tools/perf/util/symbol.c                 |   4 +-
>>>  tools/perf/util/thread.c                 | 200 ++++++-
>>>  tools/perf/util/thread.h                 |  27 +-
>>>  tools/perf/util/tool.h                   |   7 +-
>>>  tools/perf/util/unwind-libdw.c           |   6 +-
>>>  tools/perf/util/unwind-libunwind-local.c |  39 +-
>>>  tools/perf/util/unwind-libunwind.c       |   9 +-
>>>  tools/perf/util/unwind.h                 |   7 +-
>>>  tools/perf/util/util.c                   |   2 +-
>>>  tools/perf/util/util.h                   |   2 +
>>>  63 files changed, 2608 insertions(+), 392 deletions(-)
>>>  create mode 100644 tools/perf/tests/thread-comm.c
>>>  create mode 100644 tools/perf/tests/thread-lookup-time.c
>>>  create mode 100644 tools/perf/tests/thread-map-time.c
>>>  create mode 100644 tools/perf/tests/thread-mg-time.c
>>>
> 
