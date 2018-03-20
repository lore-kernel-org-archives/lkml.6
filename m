Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbeCTMdN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:33:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:14990 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752781AbeCTMdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:33:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="29602119"
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1 0/3] perf/core: expose thread context switch out event type
 to user space
Organization: Intel Corp.
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <4857e3ba-a42f-a9a2-2668-91ca9b44727c@linux.intel.com>
Date: Tue, 20 Mar 2018 15:33:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implementation of exposing context-switch-out type event as a part 
of PERF_RECORD_SWITCH[_CPU_WIDE] record.

Introduced types of events assumed to be:
a) preempt: when task->state == TASK_RUNNING
b) yield: !preempt, encoding is done using new bit 
   PERF_RECORD_MISC_SWITCH_OUT_YIELD like this:
   
   event_header->misc &= 
	PERF_RECORD_MISC_SWITCH_OUT|PERF_RECORD_MISC_SWITCH_OUT_YIELD

Perf tool report and script commands output has been extended to decode 
new yield bit and the updated output looks like in the examples below.

The documentation has been updated to mention yield switch out events 
and its decoding symbols in perf script output.

The changes have been manually tested on Fedora 27 with the patched kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

perf report -D -i system-wide.perf: 

0x2646c0 [0x30]: event: 15
.
. ... raw event: size 48 bytes
.  0000:  0f 00 00 00 00 60 30 00 00 00 00 00 00 00 00 00  .....`0.........
.  0010:  00 1e 00 00 00 1e 00 00 29 1e d5 e3 3e 0e 00 00  ........)...>...
.  0020:  56 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00  V...............

7 15663273156137 0x2646c0 [0x30]: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0

perf script --show-switch-events -F +misc -I -i system-wide.perf:

amplxe-perf  7680 [007] Sy    15663.273156: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0    
migration/5    39 [005] K     15663.273157:

---
 Alexey Budankov (3):
	perf/core: store context switch out type into Perf trace
	perf report: extend raw dump (-D) out with switch out event type
	perf script: extend misc field decoding with switch out event type
  
 include/uapi/linux/perf_event.h          |  5 +++++
 kernel/events/core.c                     |  4 +++-
 tools/include/uapi/linux/perf_event.h    |  5 +++++
 tools/perf/Documentation/perf-script.txt | 17 +++++++++--------
 tools/perf/builtin-script.c              |  5 ++++-
 tools/perf/util/event.c                  |  4 +++-
 6 files changed, 29 insertions(+), 11 deletions(-)
