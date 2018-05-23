Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934788AbeEWUVW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933619AbeEWUVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:21:18 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/18] perf/core improvements
Date: Wed, 23 May 2018 17:20:48 -0300
Message-Id: <20180523202106.17286-1-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 2996123e7e589d78e73cfeb7e7f14d49127eb1b0:

  Merge tag 'perf-core-for-mingo-4.18-20180519' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-05-19 13:32:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.18-20180523

for you to fetch changes up to 22916fdb9c50e8fb303bdcedca88fd8798a85844:

  perf kcore_copy: Amend the offset of sections that remap kernel text (2018-05-23 10:26:44 -0300)

----------------------------------------------------------------
perf/core improvements:

. Create extra kernel maps to help in decoding samples in x86 PTI entry
  trampolines (Adrian Hunter)

. Copy x86 PTI entry trampoline sections in the kcore copy used for
  annotation and intel_pt CPU traces decoding (Adrian Hunter)

- Support 'perf annotate --group' for non-explicit recorded event
  "groups", showing multiple columns, one for each event, just like
  when dealing with explicit event groups (those enclosed with {}) (Jin Yao)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (14):
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

Jin Yao (4):
      perf evlist: Introduce force_leader() method
      perf report: Use perf_evlist__force_leader to support '--group'
      perf annotate: Support '--group' option
      perf annotate: Show group event string for stdio

 tools/perf/arch/x86/util/Build     |   2 +
 tools/perf/arch/x86/util/event.c   |  76 +++++++++++++
 tools/perf/arch/x86/util/machine.c | 103 +++++++++++++++++
 tools/perf/builtin-annotate.c      |   7 ++
 tools/perf/builtin-report.c        |  13 +--
 tools/perf/util/annotate.c         |   6 +-
 tools/perf/util/env.c              |  13 +++
 tools/perf/util/env.h              |   1 +
 tools/perf/util/event.c            |  36 ++++--
 tools/perf/util/event.h            |   8 ++
 tools/perf/util/evlist.c           |  15 +++
 tools/perf/util/evlist.h           |   3 +
 tools/perf/util/machine.c          | 175 +++++++++++++++++++++++++++--
 tools/perf/util/machine.h          |  23 ++++
 tools/perf/util/map.c              |  22 +++-
 tools/perf/util/map.h              |  15 ++-
 tools/perf/util/symbol-elf.c       | 219 +++++++++++++++++++++++++++++++------
 tools/perf/util/symbol.c           |  49 +++++++--
 18 files changed, 711 insertions(+), 75 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/event.c
 create mode 100644 tools/perf/arch/x86/util/machine.c

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
  12 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
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

  # uname -a
  Linux seventh 4.17.0-rc6-00152-ga048a07d7f45 #3 SMP Wed May 23 11:43:04 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # perf --version
  perf version 4.17.rc5.g22916fd
  # git log --oneline -1
  22916fdb9c50 (HEAD -> perf/core, jouet/perf/core) perf kcore_copy: Amend the offset of sections that remap kernel text
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
  24: Object code reading                                   : FAILED!
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
                 make_perf_o_O: make perf.o
           make_no_libunwind_O: make NO_LIBUNWIND=1
                   make_help_O: make help
                  make_debug_O: make DEBUG=1
              make_no_libbpf_O: make NO_LIBBPF=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_no_libperl_O: make NO_LIBPERL=1
                make_no_newt_O: make NO_NEWT=1
                    make_doc_O: make doc
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                   make_tags_O: make tags
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
              make_clean_all_O: make clean all
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
             make_util_map_o_O: make util/map.o
            make_no_libaudit_O: make NO_LIBAUDIT=1
                 make_cscope_O: make cscope
                make_no_gtk2_O: make NO_GTK2=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                make_install_O: make install
             make_no_libnuma_O: make NO_LIBNUMA=1
                 make_static_O: make LDFLAGS=-static
         make_install_prefix_O: make install prefix=/tmp/krava
              make_no_libelf_O: make NO_LIBELF=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
            make_install_bin_O: make install-bin
                   make_pure_O: make
           make_no_backtrace_O: make NO_BACKTRACE=1
               make_no_slang_O: make NO_SLANG=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
