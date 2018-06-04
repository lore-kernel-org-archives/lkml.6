Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeFDL7I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:59:08 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34461 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFDL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:58:56 -0400
X-Google-Smtp-Source: ADUXVKKBRbwbJE+Fh/kj3BSFNgrv1DZnH/iAQ2nnsWuvSVWJhWbght1rd9edV3/0LsdVTkkrLef27A==
Date: Mon, 4 Jun 2018 13:58:52 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf changes for v4.18
Message-ID: <20180604115852.GA19136@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

   # HEAD: 9aae1780e7e81e54edfb70ba33ead5b0b48be009 perf/x86/intel/uncore: Clean up client IMC uncore

Kernel side changes:

 - x86 Intel uncore driver cleanups and enhancements (Kan Liang)

 - group scheduling and other fixes (Song Liu

 - store frame pointer in the sample traces for better profiling (Alexey Budankov)

 - compat fixes/enhancements (Eugene Syromiatnikov)

Tooling side changes, which you can build and install in a single step via:

  make -C tools/perf clean install

perf annotate:

 - Support 'perf annotate --group' for non-explicit recorded event
   "groups", showing multiple columns, one for each event, just like
   when dealing with explicit event groups (those enclosed with {}) (Jin Yao)

 - Record min/max LBR cycles (>= Skylake) and add 'perf annotate' TUI
   hotkey to show it (c) (Jin Yao)

perf bpf:

 - Add infrastructure to help in writing eBPF C programs to be used
   with '-e name.c' type events in tools such as 'record' and 'trace',
   with headers for common constructs and an examples directory that
   will get populated as we add more such helpers and the 'perf bpf'
   (Arnaldo Carvalho de Melo)

perf stat:

 - Display time in precision based on std deviation (Jiri Olsa)
 - Add --table option to display time of each run (Jiri Olsa)
 - Display length strings of each run for --table option (Jiri Olsa)

perf buildid-cache:

 - Add --list and --purge-all options (Ravi Bangoria)

perf test:

 - Let 'perf test list' display subtests (Hendrik Brueckner)

perf pti:

 - Create extra kernel maps to help in decoding samples in x86 PTI entry
   trampolines (Adrian Hunter)

 - Copy x86 PTI entry trampoline sections in the kcore copy used for
   annotation and intel_pt CPU traces decoding (Adrian Hunter)

... and I lot of other fixes, enhancements and cleanups I did not list, see the 
shortlog and git log for details.

Thanks,

	Ingo

------------------>
Adrian Hunter (17):
      perf tools: Use the "_stest" symbol to identify the kernel map when loading kcore
      perf machine: Add machine__is() to identify machine arch
      perf tools: Fix kernel_start for PTI on x86
      perf machine: Add nr_cpus_avail()
      perf machine: Workaround missing maps for x86 PTI entry trampolines
      perf machine: Fix map_groups__split_kallsyms() for entry trampoline symbols
      perf machine: Allow for extra kernel maps
      perf machine: Create maps for x86 PTI entry trampolines
      perf machine: Synthesize and process mmap events for x86 PTI entry trampolines
      perf kcore_copy: Keep phdr data in a list
      perf kcore_copy: Keep a count of phdrs
      perf kcore_copy: Calculate offset from phnum
      perf kcore_copy: Layout sections
      perf kcore_copy: Iterate phdrs
      perf kcore_copy: Get rid of kernel_map
      perf kcore_copy: Copy x86 PTI entry trampoline sections
      perf kcore_copy: Amend the offset of sections that remap kernel text

Alexey Budankov (1):
      perf/x86: Store user space frame-pointer value on a sample

Arnaldo Carvalho de Melo (61):
      perf top: Use __map__is_kernel()
      perf symbols: Use __map__is_kernel() instead of ad-hoc equivalent code
      perf dso: Add dso__has_symbols() method
      perf map: Introduce map__has_symbols()
      perf thread: Introduce thread__find_map()
      perf thread: Introduce thread__find_symbol()
      perf script: Use thread__find_symbol() instead of ad-hoc equivalent
      perf thread: Make thread__find_map() return the map
      perf thread: Make thread__find_symbol() return the symbol searched
      perf map: Shorten map_groups__find_by_name() signature
      perf machine: Introduce machine__kernel_maps()
      perf machine: Shorten machine__load_kallsyms() signature
      perf machine: Remove needless map_type from machine__load_vmlinux_path()
      perf tests vmlinux-kallsyms: Use machine__find_kernel_function(_by_name)
      perf tests vmlinux-kallsyms: Use map__for_each_symbol() instead of open coded equivalent
      perf map: Shorten map_groups__find() signature
      perf ui stdio: Use map_groups__fprintf()
      perf symbols: Shorten dso__(first|last)_symbol()
      tools lib symbols: Introduce kallsyms__is_function()
      perf tools: Use kallsyms__is_function()
      perf symbols: Unexport symbol_type__is_a()
      perf map: Remove enum_type arg to map_groups__first()
      perf symbols: Remove map_type arg from dso__find_symbol()
      perf thread: Remove addr_type arg from thread__find_cpumode_addr_location()
      perf machine: Use machine__find_kernel_function() instead of open coded version
      perf thread: Ditch __thread__find_symbol()
      perf thread: Make thread__find_map() search all maps
      perf map: Remove map_type arg from map_groups__find()
      perf symbols: Store the ELF symbol type in the symbol struct
      perf machine: Set PROT_EXEC for executable PERF_RECORD_MMAP records
      perf sort: Use mmap->prot on "dcacheline" formatting
      perf symbols: No need to special case MAP__FUNCTION in fixup
      perf symbols: Use symbol type instead of map->type
      perf map: Use map->prot in place of type==MAP__FUNCTION
      perf symbols: Use map->prot in place of type==MAP__FUNCTION
      perf symbols: Unify symbol maps
      perf symbols: Remove needless goto
      perf symbols: Split kernel symbol processing from dso__load_sym()
      perf symbols: Remove unused dso__load_all_kallsyms() 'map' parameter
      perf symbols: kallsyms__delta() needs the kmap, not the map
      perf symbols: Move split_kallsyms to struct map_groups
      perf machine: Ditch find_kernel_function variants
      perf tests parse-events: Add intel_pt parse test
      perf llvm-utils: Add bpf include path to clang command line
      perf bpf: Add 'examples' directories
      perf bpf: Add bpf.h to be used in eBPF proggies
      perf bpf: Add kprobe example to catch 5s naps
      perf bpf: Add license(NAME) helper
      perf bpf: Add probe() helper to reduce kprobes boilerplate
      perf config: Call perf_config__init() lazily
      tools lib api: The tracing_mnt variable doesn't need to be global
      tools lib api: Unexport 'tracing_path' variable
      tools lib api fs tracing_path: Introduce get/put_events_file() helpers
      perf tools: Reuse the path to the tracepoint /events/ directory
      perf parse-events: Use get/put_events_file()
      tools lib api fs tracing_path: Introduce opendir() method
      tools lib api fs tracing_path: Make tracing_events_path private
      tools include compiler-gcc: Add __pure attribute helper
      perf tools: Read the cache line size lazily
      perf tools: No need to unconditionally read the max_stack sysctls
      perf bpf: Fixup include and examples install messages

Colin Ian King (1):
      perf tools: Fix spelling mistake: "builid" -> "buildid"

Eugene Syromiatnikov (1):
      perf/core: Wire up compat PERF_EVENT_IOC_QUERY_BPF, PERF_EVENT_IOC_MODIFY_ATTRIBUTES

Hendrik Brueckner (1):
      perf tests: Let 'perf test list' display subtests

Jin Yao (6):
      perf annotate: Record the min/max cycles
      perf annotate: Create hotkey 'c' to show min/max cycles
      perf evlist: Introduce force_leader() method
      perf report: Use perf_evlist__force_leader to support '--group'
      perf annotate: Support '--group' option
      perf annotate: Show group event string for stdio

Jiri Olsa (5):
      perf check-headers.sh: Simplify arguments passing
      perf check-headers.sh: Add support to check 2 independent files
      perf stat: Display time in precision based on std deviation
      perf stat: Add --table option to display time of each run
      perf stat: Display length strings of each run for --table option

Kan Liang (9):
      perf parse-events: Handle uncore event aliases in small groups properly
      perf/x86/intel/uncore: Introduce customized event_read() for client IMC uncore
      perf/x86/intel/uncore: Correct fixed counter index check for NHM
      perf/x86/intel/uncore: Correct fixed counter index check in generic code
      perf/x86/intel/uncore: Add new data structures for free running counters
      perf/x86/intel/uncore: Add infrastructure for free running counters
      perf/x86/intel/uncore: Support IIO free-running counters on SKX
      perf/x86/intel/uncore: Expose uncore_pmu_event*() functions
      perf/x86/intel/uncore: Clean up client IMC uncore

Ravi Bangoria (3):
      perf buildid-cache: Support --list option
      perf buildid-cache: Support --purge-all option
      perf buildid-cache: Warn --purge-all failures

Sandipan Das (2):
      perf script: Show virtual addresses instead of offsets
      perf script: Show symbol offsets by default

Song Liu (2):
      perf/core: Fix group scheduling with mixed hw and sw events
      perf/core: Fix bad use of igrab()

Takashi Iwai (1):
      perf Documentation: Support for asciidoctor

YueHaibing (1):
      perf bpf: Fix NULL return handling in bpf__prepare_load()


 arch/x86/events/intel/pt.c                         |   4 +-
 arch/x86/events/intel/uncore.c                     |  76 +++-
 arch/x86/events/intel/uncore.h                     | 127 +++++-
 arch/x86/events/intel/uncore_nhmex.c               |   2 +-
 arch/x86/events/intel/uncore_snb.c                 | 101 +----
 arch/x86/events/intel/uncore_snbep.c               |  82 ++++
 arch/x86/kernel/perf_regs.c                        |  10 +-
 include/linux/perf_event.h                         |  10 +-
 kernel/events/core.c                               |  44 +-
 tools/include/linux/compiler-gcc.h                 |   3 +
 tools/lib/api/fs/tracing_path.c                    |  40 +-
 tools/lib/api/fs/tracing_path.h                    |   9 +-
 tools/lib/symbol/kallsyms.c                        |   6 +
 tools/lib/symbol/kallsyms.h                        |   2 +
 tools/perf/Documentation/Makefile                  |  29 +-
 tools/perf/Documentation/asciidoctor-extensions.rb |  29 ++
 tools/perf/Documentation/perf-buildid-cache.txt    |   7 +-
 tools/perf/Documentation/perf-stat.txt             |  16 +
 tools/perf/Makefile.config                         |  14 +
 tools/perf/Makefile.perf                           |  10 +
 tools/perf/arch/arm/tests/dwarf-unwind.c           |   2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c         |   2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |   2 +-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |   3 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c           |   2 +-
 tools/perf/arch/x86/util/Build                     |   2 +
 tools/perf/arch/x86/util/event.c                   |  76 ++++
 tools/perf/arch/x86/util/machine.c                 | 103 +++++
 tools/perf/builtin-annotate.c                      |   9 +-
 tools/perf/builtin-buildid-cache.c                 |  81 +++-
 tools/perf/builtin-inject.c                        |   4 +-
 tools/perf/builtin-kallsyms.c                      |   2 +-
 tools/perf/builtin-kmem.c                          |   6 +-
 tools/perf/builtin-report.c                        |  27 +-
 tools/perf/builtin-script.c                        |  56 ++-
 tools/perf/builtin-stat.c                          |  92 +++-
 tools/perf/builtin-timechart.c                     |   8 +-
 tools/perf/builtin-top.c                           |   9 +-
 tools/perf/builtin-trace.c                         |  11 +-
 tools/perf/check-headers.sh                        |  30 +-
 tools/perf/examples/bpf/5sec.c                     |  49 ++
 tools/perf/examples/bpf/empty.c                    |   3 +
 tools/perf/include/bpf/bpf.h                       |  13 +
 tools/perf/perf.c                                  |  24 +-
 tools/perf/tests/builtin-test.c                    |   9 +
 tools/perf/tests/code-reading.c                    |   5 +-
 tools/perf/tests/hists_common.c                    |   6 +-
 tools/perf/tests/mmap-thread-lookup.c              |   7 +-
 tools/perf/tests/parse-events.c                    |  22 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |  12 +-
 tools/perf/tests/vmlinux-kallsyms.c                |  20 +-
 tools/perf/ui/browsers/annotate.c                  |   8 +
 tools/perf/ui/browsers/map.c                       |   2 +-
 tools/perf/ui/stdio/hist.c                         |   3 +-
 tools/perf/util/Build                              |   2 +
 tools/perf/util/annotate.c                         |  57 ++-
 tools/perf/util/annotate.h                         |  11 +-
 tools/perf/util/auxtrace.c                         |  12 +-
 tools/perf/util/bpf-loader.c                       |   6 +-
 tools/perf/util/build-id.c                         |   4 +-
 tools/perf/util/config.c                           |  16 +-
 tools/perf/util/config.h                           |   1 -
 tools/perf/util/cs-etm.c                           |   4 +-
 tools/perf/util/db-export.c                        |   7 +-
 tools/perf/util/dso.c                              |  34 +-
 tools/perf/util/dso.h                              |  37 +-
 tools/perf/util/env.c                              |  31 ++
 tools/perf/util/env.h                              |   3 +
 tools/perf/util/event.c                            |  73 +--
 tools/perf/util/event.h                            |   8 +
 tools/perf/util/evlist.c                           |  15 +
 tools/perf/util/evlist.h                           |   3 +
 tools/perf/util/evsel.c                            |   2 +-
 tools/perf/util/evsel.h                            |   1 +
 tools/perf/util/genelf.c                           |   2 +-
 tools/perf/util/intel-bts.c                        |   3 +-
 tools/perf/util/intel-pt.c                         |   8 +-
 tools/perf/util/llvm-utils.c                       |  19 +-
 tools/perf/util/machine.c                          | 355 ++++++++++-----
 tools/perf/util/machine.h                          |  72 +--
 tools/perf/util/map.c                              | 121 +++--
 tools/perf/util/map.h                              |  74 ++-
 tools/perf/util/parse-events.c                     | 203 +++++++--
 tools/perf/util/parse-events.h                     |   7 +-
 tools/perf/util/parse-events.y                     |   8 +-
 tools/perf/util/probe-event.c                      |  29 +-
 tools/perf/util/probe-file.c                       |   3 +-
 tools/perf/util/session.c                          |  13 +-
 tools/perf/util/sort.c                             |  10 +-
 tools/perf/util/sort.h                             |   4 +-
 tools/perf/util/srcline.c                          |   1 +
 tools/perf/util/stat.h                             |   3 +-
 tools/perf/util/symbol-elf.c                       | 494 +++++++++++++--------
 tools/perf/util/symbol-minimal.c                   |   3 +-
 tools/perf/util/symbol.c                           | 264 +++++------
 tools/perf/util/symbol.h                           |  24 +-
 tools/perf/util/symbol_fprintf.c                   |   4 +-
 tools/perf/util/thread.c                           |  35 +-
 tools/perf/util/thread.h                           |  13 +-
 tools/perf/util/trace-event-info.c                 |  11 +-
 tools/perf/util/trace-event.c                      |   8 +-
 tools/perf/util/unwind-libdw.c                     |  23 +-
 tools/perf/util/unwind-libunwind-local.c           |  19 +-
 tools/perf/util/util.c                             |  34 +-
 tools/perf/util/util.h                             |   4 +-
 tools/perf/util/vdso.c                             |   6 +-
 106 files changed, 2384 insertions(+), 1151 deletions(-)
 create mode 100644 tools/perf/Documentation/asciidoctor-extensions.rb
 create mode 100644 tools/perf/arch/x86/util/event.c
 create mode 100644 tools/perf/arch/x86/util/machine.c
 create mode 100644 tools/perf/examples/bpf/5sec.c
 create mode 100644 tools/perf/examples/bpf/empty.c
 create mode 100644 tools/perf/include/bpf/bpf.h
