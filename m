Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeCEPGT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:06:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbeCEPGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:06:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF4C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 5 Mar 2018 12:06:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitri Prokhorov <Dmitry.Prohorov@intel.com>
Subject: Re: [PATCH v1 0/3] perf: expose thread context switch out event type
 to user space
Message-ID: <20180305150610.GB22849@kernel.org>
References: <6db586f3-36da-285c-b008-f2722419fbf8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db586f3-36da-285c-b008-f2722419fbf8@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 05, 2018 at 02:35:02PM +0300, Alexey Budankov escreveu:
> 
> Here is a series of small patches that implement exposing type of 
> context-switch-out event as a part of PERF_RECORD_SWITCH[_CPU_WIDE] record.
> 
> Introduced types of context-switch-out events assumed to be:
> a) preempt: task->state == TASK_RUNNING
> 	misc &= PERF_RECORD_MISC_SWITCH_OUT
> 	
> b) yield: !preempt - using new bit PERF_RECORD_MISC_SWITCH_OUT_YIELD:
 	misc &= PERF_RECORD_MISC_SWITCH_OUT|PERF_RECORD_MISC_SWITCH_OUT_YIELD
> 
> Perf tool report and script commands output has been extended to decode 
> new yield bit and the updated output looks like in the examples below.

I'm just waiting for the current reviewers to be satisfied with this,
but I think this is a great addition and 'perf trace' is another tool
that should jump into this, showing forced context switches together
with syscalls.

- Arnaldo
 
> The documentation has been updated to mention yield switch out events and its 
> decoding symbols in perf script output.
> 
> The changes have been manually tested on Fedora 27 with the patched kernel:
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> 
> perf report -D -i system-wide.perf: 
> 
> 0x1b9c50 [0x30]: event: 15
> .
> . ... raw event: size 48 bytes
> .  0000:  0f 00 00 00 00 20 30 00 01 1e 00 00 01 1e 00 00  ..... 0.........
> .  0010:  00 00 00 00 00 00 00 00 85 ae d4 e3 3e 0e 00 00  ............>...
> .  0020:  54 00 00 00 00 00 00 00 05 00 00 00 00 00 00 00  T...............
> 
> 5 15663273127557 0x1b9c50 [0x30]: PERF_RECORD_SWITCH_CPU_WIDE OUT  next pid/tid:  7681/7681 
> 
> 0x2646c0 [0x30]: event: 15
> .
> . ... raw event: size 48 bytes
> .  0000:  0f 00 00 00 00 60 30 00 00 00 00 00 00 00 00 00  .....`0.........
> .  0010:  00 1e 00 00 00 1e 00 00 29 1e d5 e3 3e 0e 00 00  ........)...>...
> .  0020:  56 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00  V...............
> 
> 7 15663273156137 0x2646c0 [0x30]: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0
> 
> perf script --show-switch-events -F +misc -I -i system-wide.perf:
> 
> amplxe-perf  7681 [005] S     15663.273151: PERF_RECORD_SWITCH_CPU_WIDE OUT  next pid/tid:    39/39   
> migration/5    39 [005]       15663.273152: PERF_RECORD_SWITCH_CPU_WIDE IN   prev pid/tid:  7681/7681 
> amplxe-perf  7680 [007] K     15663.273153:          1                                                                                                                                       context-switch: 
>                   aaa488 schedule ([kernel.kallsyms])
>                   1a9f50 __poll_nocancel (inlined)
> 
> amplxe-perf  7680 [007] Sy    15663.273156: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0    
> migration/5    39 [005] K     15663.273157:
> 
> ---
>  Alexey Budankov (3):
> 	perf/core: store context switch out type into Perf trace
> 	perf report: extend raw dump (-D) out with switch out event type
> 	perf script: extend misc field decoding with switch out event type
>   
>  include/uapi/linux/perf_event.h          |  5 +++++
>  kernel/events/core.c                     |  4 +++-
>  tools/include/uapi/linux/perf_event.h    |  5 +++++
>  tools/perf/Documentation/perf-script.txt | 17 +++++++++--------
>  tools/perf/builtin-script.c              |  5 ++++-
>  tools/perf/util/event.c                  |  4 +++-
>  6 files changed, 29 insertions(+), 11 deletions(-)
