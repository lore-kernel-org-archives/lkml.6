Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeCYIkO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 04:40:14 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44122 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeCYIkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 04:40:11 -0400
X-Google-Smtp-Source: AG47ELt68cRnvtA5tmW8oxZJB306hiw87HqhbKJqFcaJUI1v6UOD2VI6LLDiBYuQiqo9Lwar+1AtSg==
Date: Sun, 25 Mar 2018 10:40:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Vuille <jpmv27@aim.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Machata <petrm@mellanox.com>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/44] perf/core improvements and fixes
Message-ID: <20180325084006.gbwscxn7mu5dfibg@gmail.com>
References: <20180324200211.21326-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Mostly a 'perf annotate' refactoring to allow reusing the TUI
> formatting routines in a --stdio2 mode for 'perf annotate' that at some
> point should replace --stdio, leaving that old code deprecated for a
> while, then ditching it.
> 
> 	That will take a while yet because there is some stuff in the
> --stdio code that needs to be done in the annotation UI agnostic core to
> then get used in --tui and --stdio2.
> 
> 	There is also some improvements for issues Linus reported in the
> TUI annotation code for ASM functions.
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit ecd380b8dead1bad67e3af87e2ddfe826c3da79d:
> 
>   Merge tag 'perf-core-for-mingo-4.17-20180319' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-03-19 20:37:48 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180323
> 
> for you to fetch changes up to 980b68ec0694f250e967cb18c5705ef5de10fdd5:
> 
>   perf annotate: Use absolute addresses to calculate jump target offsets (2018-03-23 16:46:53 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Move non-TUI specific annotation routines out of the TUI browser so
>   that it can be used in other UIs, and to demonstrate that introduce
>   a 'perf annotate --stdio2' option that will apply those formatting
>   routines to provide a non-interactive annotation mode (Arnaldo Carvalho de Melo)
> 
> - Add 'P' hotkey to the annotation TUI, so dump the current annotated
>   symbol to a file, easing report thru e-mail, by getting rid of the
>   spaces + right hand side scrollbar chars (Arnaldo Carvalho de Melo)
> 
> - Support --ignore-vmlinux to 'perf report' and 'perf annotate', that
>   was already present in 'perf top', to use /proc/{kcore,kallsyms},
>   allowing to see what is in fact running (patched stuff, alternatives,
>   ftrace, etc), not the initial state of the kernel (vmlinux) (Arnaldo Carvalho de Melo)
> 
> - Support 'jump' instructions to a different function, treating them
>   as 'call' instructions (Arnaldo Carvalho de Melo)
> 
> - Fix some jump artifacts when using vmlinux + ASM functions, where
>   the ELF symtab for instance, for entry_SYSCALL_64 includes that and
>   what comes after the 'syscall_return_via_sysret' label, but the
>   objdump -dS prints the jump targets + offsets using the
>   syscall_return_via_sysret address, which was confusing 'perf annotate'.
>   See the cset comments for further info (Arnaldo Carvalho de Melo)
> 
> - Report error from dwfl_attach_state() in the unwind code (Martin Vuille)
> 
> - Reference Py_None before returning it in the python extension (Petr Machata)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (42):
>       perf annotate: Move annotation_options out of the TUI browser
>       perf annotate: Move cycles/IPC formatting width constants outside TUI
>       perf annotate tui: Use annotate_browser__cycles_width() mroe
>       perf annotate tui: Move have_cycles to struct annotation
>       perf annotate: Move annotation_line array from TUI to generic code
>       perf annotate: Move compute_ipc() to annotation library
>       perf annotate: Move nr_events from annotate_browser to annotation struct
>       perf annotate: Stop using a global config struct
>       perf annotate: Move pcnt_with() to the annotation library
>       perf annotate tui: Add browser__annotation() helper
>       perf annotate: Move max_jump_sources to struct annotation
>       perf annotate: Move jumps_percent_color to ui_browser
>       perf annotate: Move nr_jumps to struct annotation
>       perf annotate: Move mark_jump_targets from the TUI to the annotation library
>       perf annotate: Nuke struct browser_line
>       perf annotate: Move 'start' to struct annotation
>       perf annotate: Move nr_{asm_}entries to struct annotation
>       perf annotate: Introduce set_offsets() method out of TUI code
>       perf annotate: Move the column widths from the TUI to generic lib
>       perf annotate: Move update_column_widths() to the generic lib
>       perf annotate: Introduce init_column_widths() method out of TUI code
>       perf annotate: Introduce symbol__annotate2 method
>       perf annotate: Introduce annotation_line__max_percent()
>       perf ui browser: Add vprintf() method
>       perf annotate: Introduce annotation_line__print_start() out of TUI code
>       perf annotate: Finish the generalization of annotate_browser__write()
>       perf annotate: Use a ops table for annotation_line__write()
>       perf annotate: Introduce annotation_line__filter()
>       perf annotate: Introduce the --stdio2 output mode
>       perf annotate: Move the default annotate options to the library
>       perf annotate: Use the default annotation options for --stdio2
>       perf annotate: Add function header to --stdio2
>       perf annotate: Introduce --ignore-vmlinux command line option
>       perf report: Introduce --ignore-vmlinux command line option
>       perf annotate browser: Add 'P' hotkey to dump annotation to file
>       perf annotate: No need to calculate notes->start twice
>       perf annotate: Pass function descriptor to its instruction parsing routines
>       perf annotate: Mark jumps to outher functions with the call arrow
>       perf annotate: Add "_local" to jump/offset validation routines
>       perf annotate: Support jumping from one function to another
>       perf annotate: Defer searching for comma in raw line till it is needed
>       perf annotate: Use absolute addresses to calculate jump target offsets
> 
> Martin Vuille (1):
>       perf unwind: Report error from dwfl_attach_state
> 
> Petr Machata (1):
>       perf python: Reference Py_None before returning it
> 
>  tools/perf/Documentation/perf-annotate.txt   |   5 +
>  tools/perf/Documentation/perf-report.txt     |   3 +
>  tools/perf/arch/s390/annotate/instructions.c |   5 +-
>  tools/perf/builtin-annotate.c                |  27 +-
>  tools/perf/builtin-report.c                  |   3 +
>  tools/perf/builtin-top.c                     |   2 +
>  tools/perf/ui/browser.c                      |   9 +-
>  tools/perf/ui/browser.h                      |   3 +-
>  tools/perf/ui/browsers/annotate.c            | 686 ++++++---------------------
>  tools/perf/util/annotate.c                   | 679 +++++++++++++++++++++++++-
>  tools/perf/util/annotate.h                   | 102 +++-
>  tools/perf/util/python.c                     |   4 +-
>  tools/perf/util/unwind-libdw.c               |   3 +-
>  13 files changed, 944 insertions(+), 587 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
