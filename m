Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeDBIWQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 04:22:16 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:41467 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeDBIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 04:22:12 -0400
X-Google-Smtp-Source: AIpwx4/eQjGqeud3SS+GsslofY7oM3DTQwWAf620qgs1KdTSP822iInnfLoWzR+48zgy4w7zHMPUSA==
Date: Mon, 2 Apr 2018 10:22:07 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf changes for v4.17
Message-ID: <20180402082207.ufcsnhcmuzjwuyqm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

   # HEAD: 1159e09476536250c2a0173d4298d15114df7a89 perf/x86/intel: Enable C-state residency events for Cannon Lake

The main kernel side changes were:

 - Modernize the kprobe and uprobe creation/destruction tooling ABIs:

    The existing text based APIs (kprobe_events and uprobe_events in tracefs),
    are naive, limited ABIs in that they require user-space to clean up after
    themselves, which is both difficult and fragile if the tool is buggy or exits 
    unexpectedly. In other words they are not really suited for modern, robust 
    tooling.

    So introduce a modern, file descriptor based ABI that does not have these 
    limitations: introduce the 'perf_kprobe' and 'perf_uprobe' PMUs and extend
    the perf_event_open() syscall to create events with a kprobe/uprobe
    attached to them. These [k,u]probe are associated with this file descriptor, 
    so they are not available in tracefs.

    (Song Liu)

 - Intel Cannon Lake CPU support (Harry Pan)

 - Intel PT cleanups (Alexander Shishkin)

 - Improve the performance of pinned/flexible event groups by using RB trees
   (Alexey Budankov)

 - Add PERF_EVENT_IOC_MODIFY_ATTRIBUTES which allows the modification of hardware 
   breakpoints, which new ABI variant massively speeds up existing tooling that 
   uses hardware breakpoints to instrument (and debug) memory usage.

   (Milind Chabbi, Jiri Olsa)

 - Various Intel PEBS handling fixes and improvements, and other Intel PMU 
   improvements (Kan Liang)

 - Various perf core improvements and optimizations (Peter Zijlstra)

 - ... misc cleanups, fixes and updates.

There's over 200 tooling commits, here's an (imperfect) list of highlights:

 - 'perf annotate' improvements:

     - Recognize and handle jumps to other functions as calls,
       which improves the navigation along jumps and back.

                                             (Arnaldo Carvalho de Melo)

     - Add the 'P' hotkey in TUI annotation to dump annotation output
       into a file, to ease e-mail reporting of annotation details.

                                             (Arnaldo Carvalho de Melo)

     - Add an IPC/cycles column to the TUI   (Jin Yao)

     - Improve s390 assembly annotation      (Thomas Richter)

     - Refactor the output formatting logic to better separate it into
       interactive and non-interactive features and add the --stdio2
       output variant to demonstrate this.
                                             (Arnaldo Carvalho de Melo)

 - 'perf script' improvements:
     - Add Python 3 support                  (Jaroslav Škarvada)
     - Add --show-round-event                (Jiri Olsa)

 - 'perf c2c' improvements:
     - Add NUMA analysis support             (Jiri Olsa)

 - 'perf trace' improvements:
     - Improve PowerPC support               (Ravi Bangoria)

 - 'perf inject' improvements:
     - Integrate ARM CoreSight traces        (Robert Walker)

 - 'perf stat' improvements:
     - Add the --interval-count option       (yuzhoujian)
     - Add the --timeout option              (yuzhoujian)

 - 'perf sched' improvements                 (Changbin Du)

 - Vendor events improvements :
     - Add IBM s390 vendor events            (Thomas Richter)
     - Add and improve arm64 vendor events   (John Garry, Ganapatrao Kulkarni)
     - Update POWER9 vendor events           (Sukadev Bhattiprolu)

 - Intel PT tooling improvements             (Adrian Hunter)

 - PMU handling improvements                 (Agustin Vega-Frias)

 - Record machine topology in perf.data      (Jiri Olsa)

 - Various overwrite related cleanups        (Kan Liang)

 - Add arm64 dwarf post unwind support       (Kim Phillips, Jean Pihet)

 - ... and lots of other changes, cleanups and fixes, see the shortlog and
   Git history for details.

 Thanks,

	Ingo

------------------>
Adrian Hunter (13):
      perf record: Combine some auxtrace initialization into a single function
      perf auxtrace: Add missing parameters from kernel-doc comments
      perf auxtrace: Rename some buffer-queuing functions
      perf auxtrace: Make auxtrace_queues__add_buffer() return buffer_ptr
      perf intel-pt: Fix overlap detection to identify consecutive buffers correctly
      perf intel-pt: Fix sync_switch
      perf intel-pt: Fix error recovery from missing TIP packet
      perf intel-pt: Fix timestamp following overflow
      perf intel-pt/bts: In auxtrace_record__init_intel() evlist is never NULL
      perf intel-pt: Get rid of intel_pt_use_buffer_pid_tid()
      perf intel-pt: Tidy old_buffer handling in intel_pt_get_trace()
      perf intel-pt: Remove a check for sampling mode
      perf intel-pt: Adjust overlap-checking to support sampling mode

Agustin Vega-Frias (3):
      perf pmu: Support wildcards on pmu name in dynamic pmu events
      perf pmu: Display pmu name when printing unmerged events in stat
      perf pmu: Auto-merge PMU events created by prefix or glob match

Alexander Shishkin (1):
      perf/x86/pt, coresight: Clean up address filter structure

Alexey Budankov (1):
      perf/cor: Use RB trees for pinned/flexible groups

Andi Kleen (2):
      perf report: Fix description for --mem-mode
      perf stat: Use xyarray dimensions to iterate fds

Arnaldo Carvalho de Melo (66):
      perf tests shell lib: Use a wildcard to remove the vfs_getname probe
      perf python: Make twatch.py work with both python2 and python3
      perf annotate browser: Be more robust when drawing jump arrows
      perf record: Allow asking for the maximum allowed sample rate
      perf top browser: Show sample_freq in browser title line
      perf top: Allow asking for the maximum allowed sample rate
      perf record: Throttle user defined frequencies to the maximum allowed
      perf annotate: Find 'call' instruction target symbol at parsing time
      perf cgroup: Remove misplaced __maybe_unused
      perf cgroup: Rename 'struct cgroup_sel' to 'struct cgroup'
      perf cgroup: Introduce cgroup__delete()
      perf cgroup: Rename close_cgroup() to cgroup__put()
      perf cgroup: Introduce cgroup__get()
      perf cgroup: Introduce find_cgroup() method
      perf cgroup: Introduce cgroup__new() out of open coded equivalent
      perf cgroup: Add evlist__findnew_cgroup()
      perf cgroup: Add evlist__add_default_cgroup()
      perf cgroup: Make the cgroup name be const char *
      perf trace: Support setting cgroups as targets
      perf annotate: Use asprintf when formatting objdump command line
      perf top: Document --ignore-vmlinux
      perf annotate: Use ops->target.name when available for unresolved call targets
      perf tests bp_account: Fix build with clang-6
      perf annotate: Move annotation_options out of the TUI browser
      perf annotate: Move cycles/IPC formatting width constants outside TUI
      perf annotate tui: Use annotate_browser__cycles_width() mroe
      perf annotate tui: Move have_cycles to struct annotation
      perf annotate: Move annotation_line array from TUI to generic code
      perf annotate: Move compute_ipc() to annotation library
      perf annotate: Move nr_events from annotate_browser to annotation struct
      perf annotate: Stop using a global config struct
      perf annotate: Move pcnt_with() to the annotation library
      perf annotate tui: Add browser__annotation() helper
      perf annotate: Move max_jump_sources to struct annotation
      perf annotate: Move jumps_percent_color to ui_browser
      perf annotate: Move nr_jumps to struct annotation
      perf annotate: Move mark_jump_targets from the TUI to the annotation library
      perf annotate: Nuke struct browser_line
      perf annotate: Move 'start' to struct annotation
      perf annotate: Move nr_{asm_}entries to struct annotation
      perf annotate: Introduce set_offsets() method out of TUI code
      perf annotate: Move the column widths from the TUI to generic lib
      perf annotate: Move update_column_widths() to the generic lib
      perf annotate: Introduce init_column_widths() method out of TUI code
      perf annotate: Introduce symbol__annotate2 method
      perf annotate: Introduce annotation_line__max_percent()
      perf ui browser: Add vprintf() method
      perf annotate: Introduce annotation_line__print_start() out of TUI code
      perf annotate: Finish the generalization of annotate_browser__write()
      perf annotate: Use a ops table for annotation_line__write()
      perf annotate: Introduce annotation_line__filter()
      perf annotate: Introduce the --stdio2 output mode
      perf annotate: Move the default annotate options to the library
      perf annotate: Use the default annotation options for --stdio2
      perf annotate: Add function header to --stdio2
      perf annotate: Introduce --ignore-vmlinux command line option
      perf report: Introduce --ignore-vmlinux command line option
      perf annotate browser: Add 'P' hotkey to dump annotation to file
      perf annotate: No need to calculate notes->start twice
      perf annotate: Pass function descriptor to its instruction parsing routines
      perf annotate: Mark jumps to outher functions with the call arrow
      perf annotate: Add "_local" to jump/offset validation routines
      perf annotate: Support jumping from one function to another
      perf annotate: Defer searching for comma in raw line till it is needed
      perf annotate: Use absolute addresses to calculate jump target offsets
      perf mmap: Be consistent when checking for an unmaped ring buffer

Changbin Du (3):
      perf ftrace: Append an EOL when write tracing files
      perf sched: Move thread::shortname to thread_runtime
      perf sched map: Re-annotate shortname if thread comm changed

Colin Ian King (1):
      perf tests: Fix out of bounds access on array fd when cnt is 100

Davidlohr Bueso (1):
      perf/x86: Update rdpmc_always_available static key to the modern API

Ganapatrao Kulkarni (1):
      perf vendor events arm64: Enable JSON events for ThunderX2 B0

Harry Pan (2):
      perf/x86/intel: Add Cannon Lake support for RAPL profiling
      perf/x86/intel: Enable C-state residency events for Cannon Lake

Ingo Molnar (1):
      perf report: Show zero counters as well in 'perf report --stat'

Jaecheol Shin (1):
      perf annotate: Add missing arguments in Man page

Jaroslav Škarvada (1):
      perf tools: Add Python 3 support

Jin Yao (4):
      perf tools: Use target->per_thread and target->system_wide flags
      perf report: Fix wrong jump arrow
      perf stat: Ignore error thread when enabling system-wide --per-thread
      perf annotate: Support to display the IPC/Cycle in TUI mode

Jiri Olsa (55):
      perf record: Put new line after target override warning
      perf script: Add --show-round-event to display PERF_RECORD_FINISHED_ROUND
      tools lib api fs: Add filename__read_xll function
      tools lib api fs: Add sysfs__read_xll function
      perf tests: Fix dwarf unwind for stripped binaries
      perf tools: Fix comment for sort__* compare functions
      perf report: Ask for ordered events for --tasks option
      perf report: Add support to display group output for non group events
      tools lib symbol: Skip non-address kallsyms line
      perf symbols: Check if we read regular file in dso__load()
      perf machine: Free root_dir in machine__init() error path
      perf machine: Move kernel mmap name into struct machine
      perf machine: Generalize machine__set_kernel_mmap()
      perf machine: Don't search for active kernel start in __machine__create_kernel_maps
      perf machine: Remove machine__load_kallsyms()
      perf tools: Do not create kernel maps in sample__resolve()
      perf tests: Use arch__compare_symbol_names to compare symbols
      perf report: Fix memory corruption in --branch-history mode --branch-history
      perf tests: Switch trace+probe_libc_inet_pton to use record
      perf tests: Rename trace+probe_libc_inet_pton to record+probe_libc_inet_pton
      perf record: Fix crash in pipe mode
      perf report: Fix the output for stdio events list
      perf report: Display perf.data header info
      perf record: Move machine variable down the function
      perf record: Remove progname from struct record
      perf tools: Add refcnt into struct mem_info
      perf c2c: Use mem_info refcnt logic
      perf tools: Add MEM_TOPOLOGY feature to perf data file
      perf tools: Update tags with .cpp files
      perf build: Add llvm/clang/cxx make tests into FEATURE_TESTS_EXTRA
      perf build: Add llvm/clang make targets to FILES
      perf build: Force llvm/clang test compile output to .make.output
      hw_breakpoint: Pass bp_type directly as find_slot_idx() argument
      hw_breakpoint: Pass bp_type argument to __reserve_bp_slot|__release_bp_slot()
      hw_breakpoint: Add modify_bp_slot() function
      hw_breakpoint: Factor out __modify_user_hw_breakpoint() function
      hw_breakpoint: Add perf_event_attr fields check in __modify_user_hw_breakpoint()
      perf/core: Move perf_event_attr::sample_max_stack into perf_copy_attr()
      perf tests: Add breakpoint accounting/modify test
      perf env: Free memory nodes data
      perf tools: Add mem2node object
      perf tests: Add mem2node object test
      perf c2c record: Record physical addresses in samples
      perf c2c report: Make calc_width work with struct c2c_hist_entry
      perf c2c report: Call calc_width() only for displayed entries
      perf c2c report: Display node for cacheline address
      perf c2c report: Add span header over cacheline data
      perf c2c report: Add cacheline address count column
      perf llvm: Display eBPF compiling command in debug output
      perf machine: Fix mmap name setup
      perf record: Synthesize features before events in pipe mode
      perf report: Support forced leader feature in pipe mode
      perf tools: Fix snprint warnings for gcc 8
      perf tools: Fix python extension build for gcc 8
      perf build: Fix check-headers.sh opts assignment

John Garry (11):
      perf vendor events: Drop incomplete multiple mapfile support
      perf vendor events: Fix error code in json_events()
      perf vendor events: Drop support for unused topic directories
      perf vendor events: Add support for pmu events vendor subdirectory
      perf vendor events arm64: Relocate ThunderX2 JSON to cavium subdirectory
      perf vendor events arm64: Relocate Cortex A53 JSONs to arm subdirectory
      perf vendor events: Add support for arch standard events
      perf vendor events arm64: Add armv8-recommended.json
      perf vendor events arm64: Fixup ThunderX2 to use recommended events
      perf vendor events arm64: fixup A53 to use recommended events
      perf vendor events arm64: add HiSilicon hip08 JSON file

Josh Poimboeuf (1):
      objtool, perf: Fix GCC 8 -Wrestrict error

Kan Liang (31):
      perf top: Fix annoying fallback message on older kernels
      perf kvm: Switch to new perf_mmap__read_event() interface
      perf trace: Switch to new perf_mmap__read_event() interface
      perf python: Switch to new perf_mmap__read_event() interface
      perf test: Switch to new perf_mmap__read_event() interface for bpf
      perf test: Switch to new perf_mmap__read_event() interface for 'code reading' test
      perf test: Switch to new perf_mmap__read_event() interface for "keep tracking" test
      perf test: Switch to new perf_mmap__read_event() interface for mmap-basic
      perf test: Switch to new perf_mmap__read_event() interface for tp fields
      perf test: Switch to new perf_mmap__read_event() interface for perf-record
      perf test: Switch to new perf_mmap__read_event() interface for time-to-tsc
      perf test: Switch to new perf_mmap__read_event() interface for sw-clock
      perf test: Switch to new perf_mmap__read_event() interface for switch-tracking
      perf test: Switch to new perf_mmap__read_event() interface for task-exit
      perf mmap: Discard legacy interfaces for mmap read forward
      perf evlist: Store 'overwrite' in struct perf_mmap
      perf mmap: Store mmap scope in struct perf_mmap()
      perf mmap: Use the stored scope data in perf_mmap__push()
      perf mmap: Use the stored data in perf_mmap__read_event()
      perf mmap: Use stored 'overwrite' in perf_mmap__consume()
      perf mmap: Simplify perf_mmap__consume()
      perf mmap: Simplify perf_mmap__read_event()
      perf mmap: Simplify perf_mmap__read_init()
      perf/x86/intel: Fix large period handling on Broadwell CPUs
      perf/x86/intel: Properly save/restore the PMU state in the NMI handler
      perf/x86/intel: Fix event update for auto-reload
      perf/x86: Introduce a ->read() callback in 'struct x86_pmu'
      perf/x86/intel/ds: Introduce ->read() function for auto-reload events and flush the PEBS buffer there
      perf/x86/intel: Fix PMU read for auto-reload
      perf/x86/intel: Disable userspace RDPMC usage for large PEBS
      perf mmap: Fix accessing unmapped mmap in perf_mmap__read_done()

Kim Phillips (1):
      perf tools arm64: Add libdw DWARF post unwind support for ARM64

Mark Rutland (2):
      perf/core: Clear sibling list of detached events
      perf/core: Clear sibling list of detached events

Martin Vuille (2):
      perf unwind: Unwind with libdw doesn't take symfs into account
      perf unwind: Report error from dwfl_attach_state

Masami Hiramatsu (1):
      perf probe: Use right type to access array elements

Mathieu Poirier (3):
      perf cs-etm: Freeing allocated memory
      perf auxtrace arm: Fixing uninitialised variable
      perf cs-etm: Properly deal with cpu maps

Milind Chabbi (1):
      perf/core: Implement fast breakpoint modification via _IOC_MODIFY_ATTRIBUTES

Namhyung Kim (1):
      perf machine: Fix paranoid check in machine__set_kernel_mmap()

Peter Zijlstra (10):
      perf/core: Fix perf_output_read_group()
      perf/core: Cleanup the rb-tree code
      perf/core: Fix event schedule order
      perf/core: Remove perf_event::group_entry
      perf/core: Optimize ctx_sched_out()
      perf/core: Simpify perf_event_groups_for_each()
      perf/core: Fix tree based event rotation
      perf/core: Optimize perf_rotate_context() event scheduling
      perf: Fix sibling iteration
      perf: Fix sibling iteration

Petr Machata (1):
      perf python: Reference Py_None before returning it

Ravi Bangoria (3):
      tools include powerpc: Grab a copy of arch/powerpc/include/uapi/asm/unistd.h
      perf powerpc: Generate system call table from asm/unistd.h
      perf trace powerpc: Use generated syscall table

Robert Walker (3):
      perf cs-etm: Inject capabilitity for CoreSight traces
      perf inject: Emit instruction records on ETM trace discontinuity
      coresight: Update documentation for perf usage

Sandipan Das (1):
      perf test: Fix exit code for record+probe_libc_inet_pton.sh

Sangwon Hong (3):
      perf kmem: Document a missing option & an argument
      perf mem: Document a missing option
      perf kallsyms: Fix the usage on the man page

Song Liu (4):
      perf/core: Prepare perf_event.h for new types: 'perf_kprobe' and 'perf_uprobe'
      perf/headers: Sync new perf_event.h with the tools/include/uapi version
      perf/core: Implement the 'perf_kprobe' PMU
      perf/core: Implement the 'perf_uprobe' PMU

Stephane Eranian (1):
      perf tools: Update quipper information

Sukadev Bhattiprolu (1):
      perf vendor events: Update POWER9 events

Takashi Iwai (1):
      perf tools: Correct title markers for asciidoctor

Thomas Richter (15):
      perf record: Provide detailed information on s390 CPU
      perf annotate: Scan cpuid for s390 and save machine type
      perf cpuid: Introduce a platform specific cpuid compare function
      perf test: Fix test case 23 for s390 z/VM or KVM guests
      perf test: Fix test case inet_pton to accept inlines.
      perf s390: Fix reading cpuid model information
      perf annotate: Fix s390 target function disassembly
      perf annotate: Handle s390 PC relative load and store instruction.
      perf stat: Fix core dump when flag T is used
      perf stat: Make function perf_stat_evsel_id_init static
      perf vendor events s390: Add JSON files for IBM z10EC z10BC
      perf vendor events s390: Add JSON files for IBM z196
      perf vendor events s390: Add JSON files for IBM zEC12 zBC12
      perf vendor events s390: Add JSON files for IBM z13
      perf vendor events s390: Add JSON files for IBM z14

Wang YanQing (1):
      perf report: Provide libtraceevent with a kernel symbol resolver

Yisheng Xie (4):
      perf record: Avoid duplicate call of perf_default_config()
      perf top: Fix top.call-graph config option reading
      perf mmap: Discard head in overwrite_rb_find_range()
      perf debug: Avoid setting 'quiet' to 'true' unnecessarily

leilei.lin (1):
      perf/core: Fix installing cgroup events on CPU

weiping zhang (1):
      perf cgroup: Simplify arguments when tracking multiple events

yuzhoujian (2):
      perf stat: Add support to print counts for fixed times
      perf stat: Add support to print counts after a period of time


 Documentation/trace/coresight.txt                  |  51 ++
 arch/alpha/kernel/perf_event.c                     |   2 +-
 arch/arm/mach-imx/mmdc.c                           |   2 +-
 arch/arm/mm/cache-l2x0-pmu.c                       |   2 +-
 arch/mips/kernel/perf_event_mipsxx.c               |   2 +-
 arch/powerpc/perf/core-book3s.c                    |   2 +-
 arch/powerpc/perf/core-fsl-emb.c                   |   2 +-
 arch/sparc/kernel/perf_event.c                     |   2 +-
 arch/x86/events/core.c                             |  25 +-
 arch/x86/events/intel/core.c                       |  21 +-
 arch/x86/events/intel/cstate.c                     |  44 +-
 arch/x86/events/intel/ds.c                         | 101 ++-
 arch/x86/events/intel/pt.c                         |  13 +-
 arch/x86/events/intel/rapl.c                       |   2 +
 arch/x86/events/intel/uncore.c                     |   2 +-
 arch/x86/events/perf_event.h                       |   5 +-
 arch/x86/include/asm/mmu_context.h                 |   5 +-
 drivers/bus/arm-cci.c                              |   2 +-
 drivers/bus/arm-ccn.c                              |   4 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  59 +-
 drivers/perf/arm_dsu_pmu.c                         |   2 +-
 drivers/perf/arm_pmu.c                             |   2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |   3 +-
 drivers/perf/qcom_l2_pmu.c                         |   7 +-
 drivers/perf/qcom_l3_pmu.c                         |   2 +-
 drivers/perf/xgene_pmu.c                           |   4 +-
 include/linux/hw_breakpoint.h                      |   7 +
 include/linux/perf_event.h                         |  44 +-
 include/linux/trace_events.h                       |   8 +
 include/uapi/linux/perf_event.h                    |  27 +-
 kernel/events/core.c                               | 779 ++++++++++++++++-----
 kernel/events/hw_breakpoint.c                      | 100 ++-
 kernel/trace/trace_event_perf.c                    | 102 +++
 kernel/trace/trace_kprobe.c                        |  91 ++-
 kernel/trace/trace_probe.h                         |  11 +
 kernel/trace/trace_uprobe.c                        |  86 ++-
 tools/arch/powerpc/include/uapi/asm/unistd.h       | 402 +++++++++++
 tools/build/Makefile.feature                       |   6 +-
 tools/build/feature/Makefile                       |  14 +-
 tools/include/linux/bitmap.h                       |   2 +-
 tools/include/uapi/linux/perf_event.h              |  27 +-
 tools/lib/api/fs/fs.c                              |  44 +-
 tools/lib/api/fs/fs.h                              |   2 +
 tools/lib/str_error_r.c                            |   2 +-
 tools/lib/symbol/kallsyms.c                        |   4 +
 tools/perf/Documentation/perf-annotate.txt         |  11 +-
 tools/perf/Documentation/perf-c2c.txt              |   2 +-
 tools/perf/Documentation/perf-data.txt             |   2 +-
 tools/perf/Documentation/perf-ftrace.txt           |   2 +-
 tools/perf/Documentation/perf-kallsyms.txt         |   2 +-
 tools/perf/Documentation/perf-kmem.txt             |   6 +-
 tools/perf/Documentation/perf-list.txt             |   8 +-
 tools/perf/Documentation/perf-mem.txt              |   4 +
 tools/perf/Documentation/perf-record.txt           |  15 +-
 tools/perf/Documentation/perf-report.txt           |   8 +-
 tools/perf/Documentation/perf-sched.txt            |   2 +-
 tools/perf/Documentation/perf-script-perl.txt      |   2 +-
 tools/perf/Documentation/perf-script.txt           |   3 +
 tools/perf/Documentation/perf-stat.txt             |  33 +-
 tools/perf/Documentation/perf-top.txt              |   7 +-
 tools/perf/Documentation/perf-trace.txt            |  25 +
 tools/perf/Documentation/perf.data-file-format.txt |   7 +-
 tools/perf/Makefile.config                         |  27 +-
 tools/perf/Makefile.perf                           |  10 +-
 tools/perf/arch/arm/util/auxtrace.c                |   2 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  51 +-
 tools/perf/arch/arm64/include/arch-tests.h         |  12 +
 tools/perf/arch/arm64/tests/Build                  |   2 +
 tools/perf/arch/arm64/tests/arch-tests.c           |  16 +
 tools/perf/arch/arm64/util/Build                   |   1 +
 tools/perf/arch/arm64/util/unwind-libdw.c          |  60 ++
 tools/perf/arch/powerpc/Makefile                   |  25 +
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  37 +
 tools/perf/arch/s390/annotate/instructions.c       | 144 +++-
 tools/perf/arch/s390/util/header.c                 | 148 +++-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |  10 +-
 tools/perf/arch/x86/util/auxtrace.c                |  14 +-
 tools/perf/builtin-annotate.c                      | 109 ++-
 tools/perf/builtin-c2c.c                           | 247 ++++++-
 tools/perf/builtin-ftrace.c                        |  18 +-
 tools/perf/builtin-kvm.c                           |  16 +-
 tools/perf/builtin-record.c                        |  82 ++-
 tools/perf/builtin-report.c                        |  65 +-
 tools/perf/builtin-sched.c                         | 133 ++--
 tools/perf/builtin-script.c                        |  39 +-
 tools/perf/builtin-stat.c                          | 116 ++-
 tools/perf/builtin-top.c                           |  19 +-
 tools/perf/builtin-trace.c                         |  60 +-
 tools/perf/check-headers.sh                        |   2 +
 tools/perf/perf.h                                  |   3 +
 tools/perf/pmu-events/Build                        |   2 +
 tools/perf/pmu-events/README                       |  15 +-
 .../arch/arm64/{ => arm}/cortex-a53/branch.json    |  14 +-
 .../pmu-events/arch/arm64/arm/cortex-a53/bus.json  |   8 +
 .../arch/arm64/arm/cortex-a53/cache.json           |  27 +
 .../arch/arm64/{ => arm}/cortex-a53/memory.json    |  14 +-
 .../arch/arm64/arm/cortex-a53/other.json           |  28 +
 .../arch/arm64/{ => arm}/cortex-a53/pipeline.json  |  20 +-
 .../pmu-events/arch/arm64/armv8-recommended.json   | 452 ++++++++++++
 .../arch/arm64/cavium/thunderx2-imp-def.json       |  62 --
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  |  32 +
 .../perf/pmu-events/arch/arm64/cortex-a53/bus.json |  22 -
 .../pmu-events/arch/arm64/cortex-a53/cache.json    |  27 -
 .../pmu-events/arch/arm64/cortex-a53/other.json    |  32 -
 .../arch/arm64/hisilicon/hip08/core-imp-def.json   | 122 ++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   6 +-
 .../perf/pmu-events/arch/powerpc/power9/cache.json |  25 -
 .../pmu-events/arch/powerpc/power9/frontend.json   |  10 -
 .../pmu-events/arch/powerpc/power9/marked.json     |   5 -
 .../pmu-events/arch/powerpc/power9/memory.json     |   5 -
 .../perf/pmu-events/arch/powerpc/power9/other.json | 241 ++++---
 .../pmu-events/arch/powerpc/power9/pipeline.json   |  50 +-
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   5 -
 .../arch/powerpc/power9/translation.json           |  10 +-
 tools/perf/pmu-events/arch/s390/cf_z10/basic.json  |  74 ++
 tools/perf/pmu-events/arch/s390/cf_z10/crypto.json |  98 +++
 .../perf/pmu-events/arch/s390/cf_z10/extended.json | 110 +++
 tools/perf/pmu-events/arch/s390/cf_z13/basic.json  |  74 ++
 tools/perf/pmu-events/arch/s390/cf_z13/crypto.json |  98 +++
 .../perf/pmu-events/arch/s390/cf_z13/extended.json | 338 +++++++++
 tools/perf/pmu-events/arch/s390/cf_z14/basic.json  |  50 ++
 tools/perf/pmu-events/arch/s390/cf_z14/crypto.json |  98 +++
 .../perf/pmu-events/arch/s390/cf_z14/extended.json | 320 +++++++++
 tools/perf/pmu-events/arch/s390/cf_z196/basic.json |  74 ++
 .../perf/pmu-events/arch/s390/cf_z196/crypto.json  |  98 +++
 .../pmu-events/arch/s390/cf_z196/extended.json     | 146 ++++
 .../perf/pmu-events/arch/s390/cf_zec12/basic.json  |  74 ++
 .../perf/pmu-events/arch/s390/cf_zec12/crypto.json |  98 +++
 .../pmu-events/arch/s390/cf_zec12/extended.json    | 212 ++++++
 tools/perf/pmu-events/arch/s390/mapfile.csv        |   6 +
 tools/perf/pmu-events/jevents.c                    | 291 ++++++--
 tools/perf/python/twatch.py                        |   8 +-
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |  34 +-
 tools/perf/tests/Build                             |   2 +
 tools/perf/tests/attr.c                            |   4 +-
 tools/perf/tests/backward-ring-buffer.c            |   5 +-
 tools/perf/tests/bp_account.c                      | 193 +++++
 tools/perf/tests/bpf.c                             |   8 +-
 tools/perf/tests/builtin-test.c                    |   8 +
 tools/perf/tests/code-reading.c                    |  43 +-
 tools/perf/tests/dwarf-unwind.c                    |  46 +-
 tools/perf/tests/keep-tracking.c                   |   9 +-
 tools/perf/tests/mem.c                             |   2 +-
 tools/perf/tests/mem2node.c                        |  75 ++
 tools/perf/tests/mmap-basic.c                      |  11 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |  10 +-
 tools/perf/tests/perf-record.c                     |  10 +-
 tools/perf/tests/pmu.c                             |   2 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |   2 +-
 ...inet_pton.sh => record+probe_libc_inet_pton.sh} |  33 +-
 tools/perf/tests/sw-clock.c                        |  11 +-
 tools/perf/tests/switch-tracking.c                 |  10 +-
 tools/perf/tests/task-exit.c                       |  11 +-
 tools/perf/tests/tests.h                           |   2 +
 tools/perf/tests/vmlinux-kallsyms.c                |   4 +-
 tools/perf/ui/browser.c                            |   9 +-
 tools/perf/ui/browser.h                            |   3 +-
 tools/perf/ui/browsers/annotate.c                  | 702 ++++---------------
 tools/perf/ui/browsers/hists.c                     |  11 +-
 tools/perf/ui/stdio/hist.c                         |   6 +-
 tools/perf/util/Build                              |   1 +
 tools/perf/util/annotate.c                         | 739 +++++++++++++++++--
 tools/perf/util/annotate.h                         | 103 ++-
 tools/perf/util/auxtrace.c                         |  37 +-
 tools/perf/util/auxtrace.h                         |   2 +
 tools/perf/util/build-id.c                         |  10 +-
 tools/perf/util/cgroup.c                           | 128 +++-
 tools/perf/util/cgroup.h                           |  13 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  74 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   2 +
 tools/perf/util/cs-etm.c                           | 478 +++++++++++--
 tools/perf/util/debug.c                            |   1 -
 tools/perf/util/env.c                              |   4 +
 tools/perf/util/env.h                              |   9 +
 tools/perf/util/event.c                            |  16 +-
 tools/perf/util/evlist.c                           |  54 +-
 tools/perf/util/evlist.h                           |   4 -
 tools/perf/util/evsel.c                            |  26 +-
 tools/perf/util/evsel.h                            |   6 +-
 tools/perf/util/header.c                           | 323 ++++++++-
 tools/perf/util/header.h                           |   2 +
 tools/perf/util/hist.c                             |   8 +-
 tools/perf/util/hist.h                             |   1 -
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  64 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   2 +-
 tools/perf/util/intel-pt.c                         | 110 ++-
 tools/perf/util/llvm-utils.c                       |  14 +
 tools/perf/util/machine.c                          | 139 ++--
 tools/perf/util/machine.h                          |   6 +-
 tools/perf/util/mem2node.c                         | 134 ++++
 tools/perf/util/mem2node.h                         |  19 +
 tools/perf/util/mmap.c                             | 114 ++-
 tools/perf/util/mmap.h                             |  16 +-
 tools/perf/util/parse-events.c                     |  25 +-
 tools/perf/util/parse-events.h                     |   2 +-
 tools/perf/util/parse-events.l                     |   2 +-
 tools/perf/util/parse-events.y                     |  18 +-
 tools/perf/util/pmu.c                              |  49 +-
 tools/perf/util/probe-finder.c                     |  13 +-
 tools/perf/util/python.c                           | 110 ++-
 tools/perf/util/record.c                           |  43 +-
 .../util/scripting-engines/trace-event-python.c    | 147 ++--
 tools/perf/util/setup.py                           |   8 +-
 tools/perf/util/sort.c                             |   7 +-
 tools/perf/util/stat.c                             |   2 +-
 tools/perf/util/stat.h                             |   4 +-
 tools/perf/util/symbol.c                           |  35 +-
 tools/perf/util/symbol.h                           |  19 +-
 tools/perf/util/syscalltbl.c                       |   8 +
 tools/perf/util/thread.h                           |   1 -
 tools/perf/util/thread_map.c                       |   5 +-
 tools/perf/util/thread_map.h                       |   3 +-
 tools/perf/util/unwind-libdw.c                     |   5 +-
 213 files changed, 9434 insertions(+), 2231 deletions(-)
 create mode 100644 tools/arch/powerpc/include/uapi/asm/unistd.h
 create mode 100644 tools/perf/arch/arm64/include/arch-tests.h
 create mode 100644 tools/perf/arch/arm64/tests/arch-tests.c
 create mode 100644 tools/perf/arch/arm64/util/unwind-libdw.c
 create mode 100755 tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/branch.json (76%)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/memory.json (50%)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/pipeline.json (97%)
 create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-recommended.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z10/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z10/extended.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/extended.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/extended.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z196/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z196/extended.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
 create mode 100644 tools/perf/pmu-events/arch/s390/mapfile.csv
 create mode 100644 tools/perf/tests/bp_account.c
 create mode 100644 tools/perf/tests/mem2node.c
 rename tools/perf/tests/shell/{trace+probe_libc_inet_pton.sh => record+probe_libc_inet_pton.sh} (58%)
 create mode 100644 tools/perf/util/mem2node.c
 create mode 100644 tools/perf/util/mem2node.h
