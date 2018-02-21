Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeBUBeo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 20:34:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeBUBem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 20:34:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E444214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>, David Ahern <dsahern@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 0/5] perf/core improvements and fixes
Date: Tue, 20 Feb 2018 22:34:26 -0300
Message-Id: <20180221013431.11738-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 11737ca9e3b9d84448fa405a80980aa9957bcee8:

  Merge tag 'perf-core-for-mingo-4.17-20180216' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-02-17 11:39:47 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180220

for you to fetch changes up to 66dfdff03d196e51322c6a85c0d8db8bb2bdd655:

  perf tools: Add Python 3 support (2018-02-19 12:28:23 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Initial support for linking with python3, by explicitely setting
  the PYTHON Makefile variable, python2 remains supported, more work
  needed to test the shipped python scripts used with 'perf script'
  (Jaroslav Škarvada)

- Make twatch.py, an example python script that sets up evlists and
  evsels to then parse events from mmap, to work with both python2 and
  python3 (Arnaldo Carvalho de Melo)

- Fix setting 'perf ftrace' function filter when using a non-existent
  function, which should result in an error instead of simply not setting
  the filter and showing all functions (Changbin Du)

- Fix paranoid check in machine__set_kernel_mmap(), problem introduced
  in previous perf/core batch (Namhyung Kim)

- Fix reading cpuid model information in s/390, ditto, also introduced
  in the previous perf/core batch (Thomas Richter)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      perf python: Make twatch.py work with both python2 and python3

Changbin Du (1):
      perf ftrace: Append an EOL when write tracing files

Jaroslav Škarvada (1):
      perf tools: Add Python 3 support

Namhyung Kim (1):
      perf machine: Fix paranoid check in machine__set_kernel_mmap()

Thomas Richter (1):
      perf s390: Fix reading cpuid model information

 tools/perf/Makefile.config                         |  23 +---
 tools/perf/Makefile.perf                           |   4 +-
 tools/perf/arch/s390/util/header.c                 |   2 +-
 tools/perf/builtin-ftrace.c                        |  18 ++-
 tools/perf/python/twatch.py                        |   8 +-
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |  34 ++++-
 tools/perf/util/machine.c                          |   2 +-
 tools/perf/util/python.c                           |  95 ++++++++++---
 .../util/scripting-engines/trace-event-python.c    | 147 +++++++++++++++------
 tools/perf/util/setup.py                           |   6 +-
 10 files changed, 243 insertions(+), 96 deletions(-)

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

  Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
  # dm
   1  49.10 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2  51.30 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3  53.53 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4  54.74 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   5  41.38 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   6  58.50 amazonlinux:2                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
   7  35.52 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   8  34.34 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9  31.16 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  10  40.51 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  11  50.00 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  12  40.12 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  13  41.64 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  14  69.65 debian:9                      : Ok   gcc (Debian 6.3.0-18) 6.3.0 20170516
  15  91.07 debian:experimental           : Ok   gcc (Debian 7.2.0-18) 7.2.0
  16  48.13 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  17  41.69 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  18  36.72 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
  19  52.76 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  20  49.01 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  21  54.99 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  22  39.61 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  23  42.29 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24  41.84 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  25  36.88 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  26  78.12 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  27  80.48 fedora:26                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  28  81.00 fedora:27                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  29 115.57 fedora:rawhide                : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-4)
  30  42.70 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  31  45.48 mageia:5                      : Ok   gcc (GCC) 4.9.2
  32  42.61 mageia:6                      : Ok   gcc (Mageia 5.4.0-5.mga6) 5.4.0
  33  42.05 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  34  43.63 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  35  47.48 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  36  90.12 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.0
  37  35.32 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  38  41.55 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  39  33.95 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  40  39.13 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  41  33.62 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  42  62.84 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.6) 5.4.0 20160609
  43  38.41 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  44  41.31 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  45  40.18 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  46  35.83 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  47  35.91 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  48  32.80 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  49  65.42 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  50  67.55 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  51  68.25 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  52  72.18 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-3ubuntu1) 7.3.0
  # 

  # uname -a
  Linux jouet 4.16.0-rc2 #2 SMP Mon Feb 19 14:41:03 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
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
  63: Add vfs_getname probe to get syscall args filenames   : Ok
  # 

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
              make_no_libelf_O: make NO_LIBELF=1
               make_no_slang_O: make NO_SLANG=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_install_O: make install
              make_no_libbpf_O: make NO_LIBBPF=1
                   make_pure_O: make
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_backtrace_O: make NO_BACKTRACE=1
            make_no_demangle_O: make NO_DEMANGLE=1
                   make_tags_O: make tags
             make_no_libperl_O: make NO_LIBPERL=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                make_no_newt_O: make NO_NEWT=1
           make_no_libpython_O: make NO_LIBPYTHON=1
              make_clean_all_O: make clean all
            make_no_libaudit_O: make NO_LIBAUDIT=1
                 make_static_O: make LDFLAGS=-static
                    make_doc_O: make doc
                make_no_gtk2_O: make NO_GTK2=1
         make_install_prefix_O: make install prefix=/tmp/krava
            make_no_auxtrace_O: make NO_AUXTRACE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                   make_help_O: make help
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
            make_install_bin_O: make install-bin
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
             make_util_map_o_O: make util/map.o
                  make_debug_O: make DEBUG=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                 make_perf_o_O: make perf.o
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
