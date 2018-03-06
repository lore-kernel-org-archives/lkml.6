Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750897AbeCFGfY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:35:24 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38199 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeCFGfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:35:22 -0500
X-Google-Smtp-Source: AG47ELvIfIvemo30+NCi5U8j67DOMJNBPX4SQC40MnYmsc3LS95nmEe1mqkmyzG/cxFPp6AHWm8h4g==
Date: Tue, 6 Mar 2018 07:35:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Sangwon Hong <qpakzk@gmail.com>,
        Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>,
        weiping zhang <zhangweiping@didichuxing.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/28] perf/core improvements and fixes
Message-ID: <20180306063517.47az4nz7el3jp4we@gmail.com>
References: <20180305142932.16921-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, I'll cherry pick some into a separate
> perf/urgent pull request, like the jump-to-another-function one, after
> the usual round of tests, but since I've been working on then in my
> perf/core branch, lets flush them now.
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
>   
> The following changes since commit ddc4becca1409541c2ebb7ecb99b5cef44cf17e4:
> 
>   Merge tag 'perf-core-for-mingo-4.17-20180220' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-02-21 08:50:45 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180305
> 
> for you to fetch changes up to 6afad54d2f0ddebacfcf3b829147d7fed8dab298:
> 
>   perf mmap: Discard legacy interfaces for mmap read forward (2018-03-05 10:51:10 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Be more robust when drawing arrows in the annotation TUI, avoiding a
>   segfault when jump instructions have as a target addresses in functions
>   other that the one currently being annotated. The full fix will come in
>   the following days, when jumping to other functions will work as call
>   instructions (Arnaldo Carvalho de Melo)
> 
> - Allow asking for the maximum allowed sample rate in 'top' and
>   'record', i.e. 'perf record -F max' will read the
>   kernel.perf_event_max_sample_rate sysctl and use it (Arnaldo Carvalho de Melo)
> 
> - When the user specifies a freq above kernel.perf_event_max_sample_rate,
>   Throttle it down to that max freq, and warn the user about it, add as
>   well --strict-freq so that the previous behaviour of not starting the
>   session when the desired freq can't be used can be selected (Arnaldo Carvalho de Melo)
> 
> - Find 'call' instruction target symbol at parsing time, used so far in
>   the TUI, part of the infrastructure changes that will end up allowing
>   for jumps to navigate to other functions, just like 'call'
>   instructions. (Arnaldo Carvalho de Melo)
> 
> - Use xyarray dimensions to iterate fds in 'perf stat' (Andi Kleen)
> 
> - Ignore threads for which the current user hasn't permissions when
>   enabling system-wide --per-thread (Jin Yao)
> 
> - Fix some backtrace perf test cases to use 'perf record' + 'perf script'
>   instead, till 'perf trace' starts using ordered_events or equivalent
>   to avoid symbol resolving artifacts due to reordering of
>   PERF_RECORD_MMAP events (Jiri Olsa)
> 
> - Fix crash in 'perf record' pipe mode, it needs to allocate the ID
>   array even for a single event, unlike non-pipe mode (Jiri Olsa)
> 
> - Make annoying fallback message on older kernels with newer 'perf top'
>   binaries trying to use overwrite mode and that not being present
>   in the older kernels (Kan Liang)
> 
> - Switch last users of old APIs to the newer perf_mmap__read_event()
>   one, then discard those old mmap read forward APIs (Kan Liang)
> 
> - Fix the usage on the 'perf kallsyms' man page (Sangwon Hong)
> 
> - Simplify cgroup arguments when tracking multiple events (weiping zhang)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (1):
>       perf stat: Use xyarray dimensions to iterate fds
> 
> Arnaldo Carvalho de Melo (6):
>       perf annotate browser: Be more robust when drawing jump arrows
>       perf record: Allow asking for the maximum allowed sample rate
>       perf top browser: Show sample_freq in browser title line
>       perf top: Allow asking for the maximum allowed sample rate
>       perf record: Throttle user defined frequencies to the maximum allowed
>       perf annotate: Find 'call' instruction target symbol at parsing time
> 
> Jin Yao (1):
>       perf stat: Ignore error thread when enabling system-wide --per-thread
> 
> Jiri Olsa (3):
>       perf tests: Switch trace+probe_libc_inet_pton to use record
>       perf tests: Rename trace+probe_libc_inet_pton to record+probe_libc_inet_pton
>       perf record: Fix crash in pipe mode
> 
> Kan Liang (15):
>       perf top: Fix annoying fallback message on older kernels
>       perf kvm: Switch to new perf_mmap__read_event() interface
>       perf trace: Switch to new perf_mmap__read_event() interface
>       perf python: Switch to new perf_mmap__read_event() interface
>       perf test: Switch to new perf_mmap__read_event() interface for bpf
>       perf test: Switch to new perf_mmap__read_event() interface for 'code reading' test
>       perf test: Switch to new perf_mmap__read_event() interface for "keep tracking" test
>       perf test: Switch to new perf_mmap__read_event() interface for mmap-basic
>       perf test: Switch to new perf_mmap__read_event() interface for tp fields
>       perf test: Switch to new perf_mmap__read_event() interface for perf-record
>       perf test: Switch to new perf_mmap__read_event() interface for time-to-tsc
>       perf test: Switch to new perf_mmap__read_event() interface for sw-clock
>       perf test: Switch to new perf_mmap__read_event() interface for switch-tracking
>       perf test: Switch to new perf_mmap__read_event() interface for task-exit
>       perf mmap: Discard legacy interfaces for mmap read forward
> 
> Sangwon Hong (1):
>       perf kallsyms: Fix the usage on the man page
> 
> weiping zhang (1):
>       perf cgroup: Simplify arguments when tracking multiple events
> 
>  tools/perf/Documentation/perf-kallsyms.txt         |  2 +-
>  tools/perf/Documentation/perf-record.txt           | 15 ++++++-
>  tools/perf/Documentation/perf-stat.txt             |  6 ++-
>  tools/perf/Documentation/perf-top.txt              |  4 +-
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c       | 11 ++++-
>  tools/perf/builtin-kvm.c                           | 17 ++++++--
>  tools/perf/builtin-record.c                        | 18 +++++++-
>  tools/perf/builtin-stat.c                          | 25 ++++++++---
>  tools/perf/builtin-top.c                           |  6 ++-
>  tools/perf/builtin-trace.c                         | 11 ++++-
>  tools/perf/perf.h                                  |  4 ++
>  tools/perf/tests/bpf.c                             |  9 +++-
>  tools/perf/tests/code-reading.c                    | 11 ++++-
>  tools/perf/tests/keep-tracking.c                   | 10 ++++-
>  tools/perf/tests/mmap-basic.c                      | 12 ++++-
>  tools/perf/tests/openat-syscall-tp-fields.c        | 11 ++++-
>  tools/perf/tests/perf-record.c                     | 11 ++++-
>  ...inet_pton.sh => record+probe_libc_inet_pton.sh} | 30 ++++++-------
>  tools/perf/tests/sw-clock.c                        | 12 ++++-
>  tools/perf/tests/switch-tracking.c                 | 11 ++++-
>  tools/perf/tests/task-exit.c                       | 12 ++++-
>  tools/perf/ui/browsers/annotate.c                  | 42 +++++++++++++-----
>  tools/perf/ui/browsers/hists.c                     | 10 +++--
>  tools/perf/util/annotate.c                         | 38 ++++++++--------
>  tools/perf/util/annotate.h                         |  1 +
>  tools/perf/util/cgroup.c                           | 17 +++++++-
>  tools/perf/util/evlist.c                           | 25 +----------
>  tools/perf/util/evlist.h                           |  4 --
>  tools/perf/util/evsel.c                            |  3 ++
>  tools/perf/util/mmap.c                             | 21 +--------
>  tools/perf/util/python.c                           | 12 +++--
>  tools/perf/util/record.c                           | 51 +++++++++++++++++++---
>  tools/perf/util/thread_map.c                       |  1 +
>  tools/perf/util/thread_map.h                       |  1 +
>  34 files changed, 328 insertions(+), 146 deletions(-)
>  rename tools/perf/tests/shell/{trace+probe_libc_inet_pton.sh => record+probe_libc_inet_pton.sh} (61%)

Pulled, thanks a lot Arnaldo!

	Ingo
