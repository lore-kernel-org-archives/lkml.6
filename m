Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeCEO3s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:29:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbeCEO3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:29:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9E3206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: [GIT PULL 00/28] perf/core improvements and fixes
Date: Mon,  5 Mar 2018 11:29:04 -0300
Message-Id: <20180305142932.16921-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling, I'll cherry pick some into a separate
perf/urgent pull request, like the jump-to-another-function one, after
the usual round of tests, but since I've been working on then in my
perf/core branch, lets flush them now.

- Arnaldo

Test results at the end of this message, as usual.
  
The following changes since commit ddc4becca1409541c2ebb7ecb99b5cef44cf17e4:

  Merge tag 'perf-core-for-mingo-4.17-20180220' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-02-21 08:50:45 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180305

for you to fetch changes up to 6afad54d2f0ddebacfcf3b829147d7fed8dab298:

  perf mmap: Discard legacy interfaces for mmap read forward (2018-03-05 10:51:10 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Be more robust when drawing arrows in the annotation TUI, avoiding a
  segfault when jump instructions have as a target addresses in functions
  other that the one currently being annotated. The full fix will come in
  the following days, when jumping to other functions will work as call
  instructions (Arnaldo Carvalho de Melo)

- Allow asking for the maximum allowed sample rate in 'top' and
  'record', i.e. 'perf record -F max' will read the
  kernel.perf_event_max_sample_rate sysctl and use it (Arnaldo Carvalho de Melo)

- When the user specifies a freq above kernel.perf_event_max_sample_rate,
  Throttle it down to that max freq, and warn the user about it, add as
  well --strict-freq so that the previous behaviour of not starting the
  session when the desired freq can't be used can be selected (Arnaldo Carvalho de Melo)

- Find 'call' instruction target symbol at parsing time, used so far in
  the TUI, part of the infrastructure changes that will end up allowing
  for jumps to navigate to other functions, just like 'call'
  instructions. (Arnaldo Carvalho de Melo)

- Use xyarray dimensions to iterate fds in 'perf stat' (Andi Kleen)

- Ignore threads for which the current user hasn't permissions when
  enabling system-wide --per-thread (Jin Yao)

- Fix some backtrace perf test cases to use 'perf record' + 'perf script'
  instead, till 'perf trace' starts using ordered_events or equivalent
  to avoid symbol resolving artifacts due to reordering of
  PERF_RECORD_MMAP events (Jiri Olsa)

- Fix crash in 'perf record' pipe mode, it needs to allocate the ID
  array even for a single event, unlike non-pipe mode (Jiri Olsa)

- Make annoying fallback message on older kernels with newer 'perf top'
  binaries trying to use overwrite mode and that not being present
  in the older kernels (Kan Liang)

- Switch last users of old APIs to the newer perf_mmap__read_event()
  one, then discard those old mmap read forward APIs (Kan Liang)

- Fix the usage on the 'perf kallsyms' man page (Sangwon Hong)

- Simplify cgroup arguments when tracking multiple events (weiping zhang)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (1):
      perf stat: Use xyarray dimensions to iterate fds

Arnaldo Carvalho de Melo (6):
      perf annotate browser: Be more robust when drawing jump arrows
      perf record: Allow asking for the maximum allowed sample rate
      perf top browser: Show sample_freq in browser title line
      perf top: Allow asking for the maximum allowed sample rate
      perf record: Throttle user defined frequencies to the maximum allowed
      perf annotate: Find 'call' instruction target symbol at parsing time

Jin Yao (1):
      perf stat: Ignore error thread when enabling system-wide --per-thread

Jiri Olsa (3):
      perf tests: Switch trace+probe_libc_inet_pton to use record
      perf tests: Rename trace+probe_libc_inet_pton to record+probe_libc_inet_pton
      perf record: Fix crash in pipe mode

Kan Liang (15):
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

Sangwon Hong (1):
      perf kallsyms: Fix the usage on the man page

weiping zhang (1):
      perf cgroup: Simplify arguments when tracking multiple events

 tools/perf/Documentation/perf-kallsyms.txt         |  2 +-
 tools/perf/Documentation/perf-record.txt           | 15 ++++++-
 tools/perf/Documentation/perf-stat.txt             |  6 ++-
 tools/perf/Documentation/perf-top.txt              |  4 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       | 11 ++++-
 tools/perf/builtin-kvm.c                           | 17 ++++++--
 tools/perf/builtin-record.c                        | 18 +++++++-
 tools/perf/builtin-stat.c                          | 25 ++++++++---
 tools/perf/builtin-top.c                           |  6 ++-
 tools/perf/builtin-trace.c                         | 11 ++++-
 tools/perf/perf.h                                  |  4 ++
 tools/perf/tests/bpf.c                             |  9 +++-
 tools/perf/tests/code-reading.c                    | 11 ++++-
 tools/perf/tests/keep-tracking.c                   | 10 ++++-
 tools/perf/tests/mmap-basic.c                      | 12 ++++-
 tools/perf/tests/openat-syscall-tp-fields.c        | 11 ++++-
 tools/perf/tests/perf-record.c                     | 11 ++++-
 ...inet_pton.sh => record+probe_libc_inet_pton.sh} | 30 ++++++-------
 tools/perf/tests/sw-clock.c                        | 12 ++++-
 tools/perf/tests/switch-tracking.c                 | 11 ++++-
 tools/perf/tests/task-exit.c                       | 12 ++++-
 tools/perf/ui/browsers/annotate.c                  | 42 +++++++++++++-----
 tools/perf/ui/browsers/hists.c                     | 10 +++--
 tools/perf/util/annotate.c                         | 38 ++++++++--------
 tools/perf/util/annotate.h                         |  1 +
 tools/perf/util/cgroup.c                           | 17 +++++++-
 tools/perf/util/evlist.c                           | 25 +----------
 tools/perf/util/evlist.h                           |  4 --
 tools/perf/util/evsel.c                            |  3 ++
 tools/perf/util/mmap.c                             | 21 +--------
 tools/perf/util/python.c                           | 12 +++--
 tools/perf/util/record.c                           | 51 +++++++++++++++++++---
 tools/perf/util/thread_map.c                       |  1 +
 tools/perf/util/thread_map.h                       |  1 +
 34 files changed, 328 insertions(+), 146 deletions(-)
 rename tools/perf/tests/shell/{trace+probe_libc_inet_pton.sh => record+probe_libc_inet_pton.sh} (61%)

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support.  Where clang is available, it is also used to build
perf with/without libelf.

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

Ran on a Thinkpad t450s (Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz)

  # dm
   1    84.32 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2    91.48 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3    88.85 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4    95.11 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   5    83.60 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   6    94.16 amazonlinux:2                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
   7   122.03 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   8    57.09 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9    45.20 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  10    65.78 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  11    86.03 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  12    72.97 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  13    84.25 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  14   137.70 debian:9                      : Ok   gcc (Debian 6.3.0-18) 6.3.0 20170516
  15   151.22 debian:experimental           : Ok   gcc (Debian 7.2.0-17) 7.2.1 20171205
  16    85.40 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  17    83.49 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  18    77.44 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
  19    89.35 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  20    79.55 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  21    97.67 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  22    84.82 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  23    86.14 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24    88.66 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  25    76.55 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  26   163.16 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  27   166.89 fedora:26                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  28   160.95 fedora:27                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  29   159.80 fedora:rawhide                : Ok   gcc (GCC) 7.2.1 20170829 (Red Hat 7.2.1-1)
  30    83.86 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  31    87.20 mageia:5                      : Ok   gcc (GCC) 4.9.2
  32    89.17 mageia:6                      : Ok   gcc (Mageia 5.4.0-5.mga6) 5.4.0
  33    81.88 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  34    80.75 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  35    82.94 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  36   165.47 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.0
  37    66.79 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  38    78.03 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  39    63.00 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  40    77.96 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  41    68.39 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  42    79.03 ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  43   126.72 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
  44    68.22 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  45    66.60 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  46    67.14 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  47    67.40 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  48    69.12 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  49    66.66 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  50   135.05 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  51   136.33 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  52   137.14 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  53   136.01 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.2.0-16ubuntu1) 7.2.0

  # uname -a
  Linux jouet 4.16.0-rc3-00097-gf3afe530d644 #1 SMP Wed Feb 28 10:04:12 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
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
  21: Number of exit events of a simple workload            : Ok
  22: Software clock events period values                   : Ok
  23: Object code reading                                   : Ok
  24: Sample parsing                                        : Ok
  25: Use a dummy software event to keep tracking           : Ok
  26: Parse with no sample_id_all bit set                   : Ok
  27: Filter hist entries                                   : Ok
  28: Lookup mmap thread                                    : Ok
  29: Share thread mg                                       : Ok
  30: Sort output of hist entries                           : Ok
  31: Cumulate child hist entries                           : Ok
  32: Track with sched_switch                               : Ok
  33: Filter fds with revents mask in a fdarray             : Ok
  34: Add fd to a fdarray, making it autogrow               : Ok
  35: kmod_path__parse                                      : Ok
  36: Thread map                                            : Ok
  37: LLVM search and compile                               :
  37.1: Basic BPF llvm compile                              : Ok
  37.2: kbuild searching                                    : Ok
  37.3: Compile source for BPF prologue generation          : Ok
  37.4: Compile source for BPF relocation                   : Ok
  38: Session topology                                      : Ok
  39: BPF filter                                            :
  39.1: Basic BPF filtering                                 : Ok
  39.2: BPF pinning                                         : Ok
  39.3: BPF prologue generation                             : Ok
  39.4: BPF relocation checker                              : Ok
  40: Synthesize thread map                                 : Ok
  41: Remove thread map                                     : Ok
  42: Synthesize cpu map                                    : Ok
  43: Synthesize stat config                                : Ok
  44: Synthesize stat                                       : Ok
  45: Synthesize stat round                                 : Ok
  46: Synthesize attr update                                : Ok
  47: Event times                                           : Ok
  48: Read backward ring buffer                             : Ok
  49: Print cpu map                                         : Ok
  50: Probe SDT events                                      : Ok
  51: is_printable_array                                    : Ok
  52: Print bitmap                                          : Ok
  53: perf hooks                                            : Ok
  54: builtin clang support                                 : Skip (not compiled in)
  55: unit_number__scnprintf                                : Ok
  56: x86 rdpmc                                             : Ok
  57: Convert perf time to TSC                              : Ok
  58: DWARF unwind                                          : Ok
  59: x86 instruction decoder - new instructions            : Ok
  60: Use vfs_getname probe to get syscall args filenames   : Ok
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: Ok
  63: probe libc's inet_pton & backtrace it with ping       : Ok
  64: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_pure_O: cd . && make
                 make_static_O: cd . && make LDFLAGS=-static
                   make_tags_O: cd . && make tags
        make_with_babeltrace_O: cd . && make LIBBABELTRACE=1
               make_no_slang_O: cd . && make NO_SLANG=1
                make_install_O: cd . && make install
                   make_help_O: cd . && make help
            make_no_libaudit_O: cd . && make NO_LIBAUDIT=1
       make_util_pmu_bison_o_O: cd . && make util/pmu-bison.o
           make_no_libpython_O: cd . && make NO_LIBPYTHON=1
             make_no_scripts_O: cd . && make NO_LIBPYTHON=1 NO_LIBPERL=1
                    make_doc_O: cd . && make doc
                  make_debug_O: cd . && make DEBUG=1
                make_no_gtk2_O: cd . && make NO_GTK2=1
              make_no_libbpf_O: cd . && make NO_LIBBPF=1
           make_no_libunwind_O: cd . && make NO_LIBUNWIND=1
                  make_no_ui_O: cd . && make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
  make_no_libdw_dwarf_unwind_O: cd . && make NO_LIBDW_DWARF_UNWIND=1
           make_no_backtrace_O: cd . && make NO_BACKTRACE=1
            make_no_demangle_O: cd . && make NO_DEMANGLE=1
           make_no_libbionic_O: cd . && make NO_LIBBIONIC=1
            make_no_auxtrace_O: cd . && make NO_AUXTRACE=1
             make_no_libperl_O: cd . && make NO_LIBPERL=1
                make_no_newt_O: cd . && make NO_NEWT=1
              make_clean_all_O: cd . && make clean all
              make_no_libelf_O: cd . && make NO_LIBELF=1
             make_util_map_o_O: cd . && make util/map.o
   make_install_prefix_slash_O: cd . && make install prefix=/tmp/krava/
                 make_perf_o_O: cd . && make perf.o
         make_install_prefix_O: cd . && make install prefix=/tmp/krava
            make_install_bin_O: cd . && make install-bin
             make_no_libnuma_O: cd . && make NO_LIBNUMA=1
         make_with_clangllvm_O: cd . && make LIBCLANGLLVM=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $ 
