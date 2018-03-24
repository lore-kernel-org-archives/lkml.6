Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeCXUC7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752633AbeCXUC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:02:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10182172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: [GIT PULL 00/44] perf/core improvements and fixes
Date: Sat, 24 Mar 2018 17:01:27 -0300
Message-Id: <20180324200211.21326-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Mostly a 'perf annotate' refactoring to allow reusing the TUI
formatting routines in a --stdio2 mode for 'perf annotate' that at some
point should replace --stdio, leaving that old code deprecated for a
while, then ditching it.

	That will take a while yet because there is some stuff in the
--stdio code that needs to be done in the annotation UI agnostic core to
then get used in --tui and --stdio2.

	There is also some improvements for issues Linus reported in the
TUI annotation code for ASM functions.

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit ecd380b8dead1bad67e3af87e2ddfe826c3da79d:

  Merge tag 'perf-core-for-mingo-4.17-20180319' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-03-19 20:37:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180323

for you to fetch changes up to 980b68ec0694f250e967cb18c5705ef5de10fdd5:

  perf annotate: Use absolute addresses to calculate jump target offsets (2018-03-23 16:46:53 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Move non-TUI specific annotation routines out of the TUI browser so
  that it can be used in other UIs, and to demonstrate that introduce
  a 'perf annotate --stdio2' option that will apply those formatting
  routines to provide a non-interactive annotation mode (Arnaldo Carvalho de Melo)

- Add 'P' hotkey to the annotation TUI, so dump the current annotated
  symbol to a file, easing report thru e-mail, by getting rid of the
  spaces + right hand side scrollbar chars (Arnaldo Carvalho de Melo)

- Support --ignore-vmlinux to 'perf report' and 'perf annotate', that
  was already present in 'perf top', to use /proc/{kcore,kallsyms},
  allowing to see what is in fact running (patched stuff, alternatives,
  ftrace, etc), not the initial state of the kernel (vmlinux) (Arnaldo Carvalho de Melo)

- Support 'jump' instructions to a different function, treating them
  as 'call' instructions (Arnaldo Carvalho de Melo)

- Fix some jump artifacts when using vmlinux + ASM functions, where
  the ELF symtab for instance, for entry_SYSCALL_64 includes that and
  what comes after the 'syscall_return_via_sysret' label, but the
  objdump -dS prints the jump targets + offsets using the
  syscall_return_via_sysret address, which was confusing 'perf annotate'.
  See the cset comments for further info (Arnaldo Carvalho de Melo)

- Report error from dwfl_attach_state() in the unwind code (Martin Vuille)

- Reference Py_None before returning it in the python extension (Petr Machata)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (42):
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

Martin Vuille (1):
      perf unwind: Report error from dwfl_attach_state

Petr Machata (1):
      perf python: Reference Py_None before returning it

 tools/perf/Documentation/perf-annotate.txt   |   5 +
 tools/perf/Documentation/perf-report.txt     |   3 +
 tools/perf/arch/s390/annotate/instructions.c |   5 +-
 tools/perf/builtin-annotate.c                |  27 +-
 tools/perf/builtin-report.c                  |   3 +
 tools/perf/builtin-top.c                     |   2 +
 tools/perf/ui/browser.c                      |   9 +-
 tools/perf/ui/browser.h                      |   3 +-
 tools/perf/ui/browsers/annotate.c            | 686 ++++++---------------------
 tools/perf/util/annotate.c                   | 679 +++++++++++++++++++++++++-
 tools/perf/util/annotate.h                   | 102 +++-
 tools/perf/util/python.c                     |   4 +-
 tools/perf/util/unwind-libdw.c               |   3 +-
 13 files changed, 944 insertions(+), 587 deletions(-)

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

  # dm
   1  alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2  alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3  alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4  alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5  alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   6  amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   7  amazonlinux:2                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
   8  android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9  android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10  centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  11  centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  12  centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  13  debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  14  debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  15  debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16  debian:experimental           : Ok   gcc (Debian 7.3.0-12) 7.3.0
  17  debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.3.0-12) 7.3.0
  18  debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.3.0-12) 7.3.0
  19  debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.3.0-11) 7.3.0
  20  debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  21  fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22  fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23  fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24  fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25  fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26  fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27  fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28  fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  29  fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30  fedora:rawhide                : Ok   gcc (GCC) 8.0.1 20180222 (Red Hat 8.0.1-0.16)
  31  gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  32  mageia:5                      : Ok   gcc (GCC) 4.9.2
  33  mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  34  opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  35  opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  36  opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  37  opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.0
  38  oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  39  oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16.0.3)
  40  ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  41  ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  42  ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  43  ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  44  ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  45  ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  46  ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  47  ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  48  ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48  ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49  ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50  ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51  ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  52  ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  53  ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  54  ubuntu:18.04                  : Ok   gcc (Ubuntu 7.2.0-16ubuntu1) 7.2.0

  # uname -a
  Linux jouet 4.16.0-rc5-00086-gdf09348f78dc #1 SMP Fri Mar 16 09:46:40 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
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
  21: Breakpoint accounting                                 : Skip
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
  63: probe libc's inet_pton & backtrace it with ping       : Ok
  64: Check open filename arg using perf trace + vfs_getname: Ok
  65: probe libc's inet_pton & backtrace it with ping       : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok
  #
  
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_libpython_O: make NO_LIBPYTHON=1
              make_no_libelf_O: make NO_LIBELF=1
                 make_perf_o_O: make perf.o
                    make_doc_O: make doc
           make_no_libunwind_O: make NO_LIBUNWIND=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_install_bin_O: make install-bin
           make_no_libbionic_O: make NO_LIBBIONIC=1
                  make_debug_O: make DEBUG=1
                 make_static_O: make LDFLAGS=-static
               make_no_slang_O: make NO_SLANG=1
              make_no_libbpf_O: make NO_LIBBPF=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                make_no_newt_O: make NO_NEWT=1
                   make_tags_O: make tags
             make_util_map_o_O: make util/map.o
            make_no_auxtrace_O: make NO_AUXTRACE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
         make_install_prefix_O: make install prefix=/tmp/krava
             make_no_libnuma_O: make NO_LIBNUMA=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                make_install_O: make install
                   make_pure_O: make
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
            make_no_demangle_O: make NO_DEMANGLE=1
                   make_help_O: make help
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                make_no_gtk2_O: make NO_GTK2=1
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_no_libperl_O: make NO_LIBPERL=1
              make_clean_all_O: make clean all
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
