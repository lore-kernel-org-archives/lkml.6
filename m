Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeFERup (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbeFERum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:50:42 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>, stable@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>, Wang Nan <wangnan0@huawei.com>
Subject: [GIT PULL 00/46] perf/core fixes and improvements
Date: Tue,  5 Jun 2018 14:49:44 -0300
Message-Id: <20180605175030.32549-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 7869e5889477e4e32e4024d665431b35e8b7b693:

  Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2018-06-04 10:28:20 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.18-20180605

for you to fetch changes up to 03ac4e71cd120d2c3411d106d00d266114575f74:

  perf intel-pt: Fix "Unexpected indirect branch" error (2018-06-05 12:28:52 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf stat:

. Display user and system time for workload targets (Jiri Olsa)

perf record:

. Enable arbitrary event names thru name= modifier (Alexey Budankov)

PowerPC:

. Add a python script for hypervisor call statistics (Ravi Bangoria)

Intel PT: (Adrian Hunter)

. Fix sync_switch INTEL_PT_SS_NOT_TRACING

. Fix decoding to accept CBR between FUP and corresponding TIP

. Fix MTC timing after overflow

. Fix "Unexpected indirect branch" error

perf test:

. record+probe_libc_inet_pton:

  .  To get the symbol table for dynamic
     shared objects on ubuntu we need to pass the -D/--dynamic command line
     option, unlike with the fedora distros (Arnaldo Carvalho de Melo)

. code-reading:

  . Fix perf_env setup for PTI entry trampolines (Adrian Hunter)

. kmod-path:

  . Add tests for vdso32 and vdsox32 (Adrian Hunter)

. Use header file util/debug.h (Thomas Richter)

perf annotate:

. Make the various UI backends (stdio, TUI, gtk) use more consistently
  structs with annotation options as specified by the user (Arnaldo Carvalho de Melo)

. Move annotation specific knobs from the symbol_conf global kitchen
  sink to the annotation option structs (Arnaldo Carvalho de Melo)

Core:

. Fix misleading error for some unparsable events mentioning PMUs when
  those are not involved in the problem (Jiri Olsa)

- Fix symbol and object code resolution for vdso32 and vdsox32 (Adrian Hunter)

. No need to check for null when passing pointers to foo__get() style
  refcount grabbing helpers, just like in the kernel and with free(),
  its safe to pass a NULL pointer to avoid having to check it before
  each and every foo__get() call (Arnaldo Carvalho de Melo)

. Remove some dead code (quote.[ch]) (Arnaldo Carvalho de Melo)

. Remove some needless globals, making them local (Arnaldo Carvalho de Melo)

. Reduce usage of symbol_conf.use_callchain, using other means of
  finding out if callchains are in use or available for specific events,
  as we evolved this codebase to allow requesting callchains for just
  a subset of the monitored events. In time it will help polish
  recording and showing mixed sets accross the various tools:

    perf record -e cycles/call-graph=fp/,cache-misses/call-graph=dwarf/,instructions

  (Arnaldo Carvalho de Melo)

. Consider PTI entry trampolines in map__rip_2objdump() (Adrian Hunter)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (8):
      perf tests kmod-path: Add tests for vdso32 and vdsox32
      perf tools: Fix symbol and object code resolution for vdso32 and vdsox32
      perf test code-reading: Fix perf_env setup for PTI entry trampolines
      perf map: Consider PTI entry trampolines in rip_2objdump()
      perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING
      perf intel-pt: Fix decoding to accept CBR between FUP and corresponding TIP
      perf intel-pt: Fix MTC timing after overflow
      perf intel-pt: Fix "Unexpected indirect branch" error

Alexey Budankov (1):
      perf record: Enable arbitrary event names thru name= modifier

Arnaldo Carvalho de Melo (33):
      perf tools: Remove dead quote.[ch] code
      perf probe: Use return of map__get() to make code more compact
      perf cgroup: Make evlist__find_cgroup() more compact
      perf tools: No need to check if the argument to __get() function is NULL
      perf annotate: Pass perf_evsel instead of just evsel->idx
      perf annotate: __symbol__acount_cycles doesn't need notes
      perf annotate: Split allocation of annotated_source struct
      perf annotate: Introduce constructor/destructor for annotated_source
      perf annotate: Introduce annotated_source__alloc_histograms
      perf annotate: __symbol__inc_addr_samples() needs just annotated_source
      perf annotate: Introduce symbol__hists()
      perf annotate: Introduce symbol__cycle_hists()
      perf annotate: Stop using symbol_conf.nr_events global in symbol__hists()
      perf annotate: Replace symbol__alloc_hists() with symbol__hists()
      perf tools: Ditch the symbol_conf.nr_events global
      perf annotate: Add comment about annotated_src->nr_histograms
      perf annotate stdio: Use annotation_options consistently
      perf srcline: Introduce map__srcline() to make code more compact
      perf sort: Introduce addr_map_symbol__srcline() to make code more compact
      perf srcline: Make hist_entry srcline helper consistent with map's
      perf annotate: Pass annotation_options to symbol__annotate()
      perf annotate: Adopt anotation options from symbol_conf
      perf annotate: Move disassembler_style global to annotation_options
      perf hists browser: Pass annotation_options from tool to browser
      perf annotate: Move objdump_path to struct annotation_options
      perf report: No need to have report_callchain_help as a global
      perf evsel: Add has_callchain() helper to make code more compact/clear
      perf script: Check if evsel has callchains before trying to use it
      perf sched: Use sched->show_callchain where appropriate
      perf hists: Do not allocate space for callchains for evsels without them
      perf hists: Introduce hist_entry__has_callchain() method
      perf hists: Check if a hist_entry has callchains before using them
      perf test record+probe_libc_inet_pton: Ask 'nm' for dynamic symbols

Jiri Olsa (2):
      perf stat: Display user and system time
      perf tools: Fix pmu events parsing rule

Ravi Bangoria (1):
      perf script powerpc: Python script for hypervisor call statistics

Thomas Richter (1):
      perf test: Use header file util/debug.h

 tools/perf/Documentation/perf-list.txt             |   6 +-
 tools/perf/Documentation/perf-record.txt           |   3 +
 tools/perf/Documentation/perf-stat.txt             |  40 +++--
 tools/perf/arch/common.c                           |   4 +-
 tools/perf/arch/common.h                           |   4 +-
 tools/perf/builtin-annotate.c                      |  36 ++--
 tools/perf/builtin-c2c.c                           |   2 +-
 tools/perf/builtin-kvm.c                           |   2 -
 tools/perf/builtin-probe.c                         |   3 +-
 tools/perf/builtin-report.c                        |  39 ++--
 tools/perf/builtin-sched.c                         |  14 +-
 tools/perf/builtin-script.c                        |  12 +-
 tools/perf/builtin-stat.c                          |  28 ++-
 tools/perf/builtin-top.c                           |  48 +++--
 tools/perf/builtin-trace.c                         |   2 +-
 tools/perf/perf.c                                  |   1 -
 .../perf/scripts/python/bin/powerpc-hcalls-record  |   2 +
 .../perf/scripts/python/bin/powerpc-hcalls-report  |   2 +
 tools/perf/scripts/python/powerpc-hcalls.py        | 200 +++++++++++++++++++++
 tools/perf/tests/code-reading.c                    |   1 +
 tools/perf/tests/kmod-path.c                       |  16 ++
 tools/perf/tests/parse-events.c                    |   4 +-
 tools/perf/tests/python-use.c                      |   3 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |   2 +-
 tools/perf/ui/browsers/annotate.c                  |  21 ++-
 tools/perf/ui/browsers/hists.c                     |  43 +++--
 tools/perf/ui/browsers/hists.h                     |   3 +
 tools/perf/ui/gtk/annotate.c                       |   2 +-
 tools/perf/ui/gtk/hists.c                          |   5 +-
 tools/perf/ui/hist.c                               |   2 +-
 tools/perf/ui/stdio/hist.c                         |   4 +-
 tools/perf/util/Build                              |   1 -
 tools/perf/util/annotate.c                         | 160 ++++++++++-------
 tools/perf/util/annotate.h                         |  53 ++++--
 tools/perf/util/cgroup.c                           |   9 +-
 tools/perf/util/dso.c                              |   2 +
 tools/perf/util/evsel.c                            |   4 +-
 tools/perf/util/evsel.h                            |   5 +
 tools/perf/util/header.c                           |  24 ++-
 tools/perf/util/hist.c                             |  23 ++-
 tools/perf/util/hist.h                             |  26 ++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  23 ++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   9 +
 tools/perf/util/intel-pt.c                         |   5 +
 tools/perf/util/map.c                              |  26 ++-
 tools/perf/util/map.h                              |   1 +
 tools/perf/util/parse-events.l                     |  18 +-
 tools/perf/util/parse-events.y                     |  14 +-
 tools/perf/util/probe-event.c                      |   3 +-
 tools/perf/util/quote.c                            |  62 -------
 tools/perf/util/quote.h                            |  31 ----
 tools/perf/util/session.c                          |   2 +-
 tools/perf/util/sort.c                             |  81 +++------
 tools/perf/util/sort.h                             |   7 +-
 tools/perf/util/symbol.c                           |   1 -
 tools/perf/util/symbol.h                           |   3 -
 tools/perf/util/top.h                              |   3 +-
 57 files changed, 731 insertions(+), 419 deletions(-)
 create mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-record
 create mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-report
 create mode 100644 tools/perf/scripts/python/powerpc-hcalls.py
 delete mode 100644 tools/perf/util/quote.c
 delete mode 100644 tools/perf/util/quote.h

Test results:

The first ones are container (docker) based builds of tools/perf with
and without libelf support.  Where clang is available, it is also used
to build perf with/without libelf, and building with LIBCLANGLLVM=1
(built-in clang) with gcc and clang when clang and its devel libraries
are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

  # dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   7 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   8 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  11 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  12 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
  13 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  14 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16 debian:experimental           : Ok   gcc (Debian 7.3.0-19) 7.3.0
  17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.3.0-19) 7.3.0
  18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.3.0-19) 7.3.0
  19 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.3.0-18) 7.3.0
  20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.3.0-19) 7.3.0
  21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  29 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180502 (Red Hat 8.1.1-1)
  31 fedora:rawhide                : Ok   gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
  32 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  33 mageia:5                      : Ok   gcc (GCC) 4.9.2
  34 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  35 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  36 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  37 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  38 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  39 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18.0.7)
  40 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
  41 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  42 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  43 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  44 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  45 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  46 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  47 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  52 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  53 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  54 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  #

  # perf version
  perf version 4.17.rc7.g03ac4e
  # git log -1 --oneline
  03ac4e71cd12 (HEAD -> perf/core, seventh/perf/core) perf intel-pt: Fix "Unexpected indirect branch" error
  # uname -a
  Linux jouet 4.17.0-rc5 #21 SMP Mon May 14 15:35:35 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Breakpoint accounting                                 : Ok
  22: Number of exit events of a simple workload            : Ok
  23: Software clock events period values                   : Ok
  24: Object code reading                                   : Ok
  25: Sample parsing                                        : Ok
  26: Use a dummy software event to keep tracking           : Ok
  27: Parse with no sample_id_all bit set                   : Ok
  28: Filter hist entries                                   : Ok
  29: Lookup mmap thread                                    : Ok
  30: Share thread mg                                       : Ok
  31: Sort output of hist entries                           : Ok
  32: Cumulate child hist entries                           : Ok
  33: Track with sched_switch                               : Ok
  34: Filter fds with revents mask in a fdarray             : Ok
  35: Add fd to a fdarray, making it autogrow               : Ok
  36: kmod_path__parse                                      : Ok
  37: Thread map                                            : Ok
  38: LLVM search and compile                               :
  38.1: Basic BPF llvm compile                              : Ok
  38.2: kbuild searching                                    : Ok
  38.3: Compile source for BPF prologue generation          : Ok
  38.4: Compile source for BPF relocation                   : Ok
  39: Session topology                                      : Ok
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : Ok
  41: Synthesize thread map                                 : Ok
  42: Remove thread map                                     : Ok
  43: Synthesize cpu map                                    : Ok
  44: Synthesize stat config                                : Ok
  45: Synthesize stat                                       : Ok
  46: Synthesize stat round                                 : Ok
  47: Synthesize attr update                                : Ok
  48: Event times                                           : Ok
  49: Read backward ring buffer                             : Ok
  50: Print cpu map                                         : Ok
  51: Probe SDT events                                      : Ok
  52: is_printable_array                                    : Ok
  53: Print bitmap                                          : Ok
  54: perf hooks                                            : Ok
  55: builtin clang support                                 : Skip (not compiled in)
  56: unit_number__scnprintf                                : Ok
  57: mem2node                                              : Ok
  58: x86 rdpmc                                             : Ok
  59: Convert perf time to TSC                              : Ok
  60: DWARF unwind                                          : Ok
  61: x86 instruction decoder - new instructions            : Ok
  62: Use vfs_getname probe to get syscall args filenames   : Ok
  63: Check open filename arg using perf trace + vfs_getname: Ok
  64: probe libc's inet_pton & backtrace it with ping       : Ok
  65: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                   make_help_O: make help
                   make_pure_O: make
            make_no_auxtrace_O: make NO_AUXTRACE=1
                  make_debug_O: make DEBUG=1
              make_clean_all_O: make clean all
             make_util_map_o_O: make util/map.o
              make_no_libelf_O: make NO_LIBELF=1
             make_no_libperl_O: make NO_LIBPERL=1
                make_no_newt_O: make NO_NEWT=1
                   make_tags_O: make tags
           make_no_libbionic_O: make NO_LIBBIONIC=1
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_libpython_O: make NO_LIBPYTHON=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                    make_doc_O: make doc
            make_no_libaudit_O: make NO_LIBAUDIT=1
                 make_perf_o_O: make perf.o
                make_install_O: make install
                 make_static_O: make LDFLAGS=-static
           make_no_libunwind_O: make NO_LIBUNWIND=1
            make_no_demangle_O: make NO_DEMANGLE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_install_bin_O: make install-bin
               make_no_slang_O: make NO_SLANG=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                make_no_gtk2_O: make NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_backtrace_O: make NO_BACKTRACE=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
