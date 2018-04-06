Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeDFMtu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:49:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:7881 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbeDFMts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:49:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="48510095"
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1]: perf/x86: store user space frame-pointer value on a
 sample
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Organization: Intel Corp.
Message-ID: <086d45fb-a099-4ae9-2854-943447e86010@linux.intel.com>
Date: Fri, 6 Apr 2018 15:49:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Store user space frame-pointer value (BP register) into Perf trace 
on a sample for x86_64 process so the value becomes available when 
unwinding call stacks for functions gaining event samples.

Test executable for the example below was compiled with frame pointer 
support enabled:

g++ -o futex-fp -fpermissive --no-omit-frame-pointer futex.c

and profiled using:

tools/perf/perf record --user-regs=IP,SP,BP \
	-g --call-graph=dwarf,1024 -e cycles -- ./futex-fp

Output of

tools/perf/perf report -i perf.data --stdio 

demonstrates the effect of the patch change so before saving BP 
value on a sample we have several frames missing above main 
function frame:

# Samples: 138K of event 'cpu-cycles'
# Event count (approx.): 92713835335
#
# Children      Self  Command   Shared Object     Symbol                                        
# ........  ........  ........  ................  ..........................
#
    96.15%     0.72%  futex-fp  futex-fp          [.] main
            |          
            |--95.43%--main
            |          |          
            |          |--71.56%--syscall
            |          |          |          
            |          |          |--57.28%--entry_SYSCALL_64_after_hwframe
            |          |          |          |          
            |          |          |           --56.95%--do_syscall_64
            |          |          |                     |          
            |          |          |                      --55.77%--sys_futex

and after saving BP value on a sample we have expected 

	_start
	__libc_start_main 

frames unwound:

# Samples: 128K of event 'cpu-cycles'
# Event count (approx.): 85349981034
#
# Children      Self  Command   Shared Object     Symbol                                        
# ........  ........  ........  ................  ..................
#
    95.83%     0.00%  futex-fp  futex-fp          [.] _start
            |
==>         ---_start
==>            __libc_start_main
               main
               |          
               |--71.28%--syscall
               |          |          
               |          |--55.67%--entry_SYSCALL_64
               |          |          |          
               |          |           --55.40%--do_syscall_64
               |          |                     |          
               |          |                      --54.21%--sys_futex

perf test

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
16: Setup struct perf_event_attr                          : Skip
17: Match and link multiple hists                         : Ok
18: 'import perf' in python                               : FAILED!
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
38.1: Basic BPF llvm compile                              : Skip
38.2: kbuild searching                                    : Skip
38.3: Compile source for BPF prologue generation          : Skip
38.4: Compile source for BPF relocation                   : Skip
39: Session topology                                      : Ok
40: BPF filter                                            :
40.1: Basic BPF filtering                                 : Skip
40.2: BPF pinning                                         : Skip
40.3: BPF prologue generation                             : Skip
40.4: BPF relocation checker                              : Skip
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
63: Add vfs_getname probe to get syscall args filenames   : Ok
64: Check open filename arg using perf trace + vfs_getname: Ok
65: probe libc's inet_pton & backtrace it with ping       : Ok

make: Entering directory '/root/abudanko/kernel/tip/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
- /root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
cd . && make FEATURE_DUMP_COPY=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
            make_clean_all_O: cd . && make clean all FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.EB4YTtRbxL DESTDIR=/tmp/tmp.IPhLgudoxW
                 make_tags_O: cd . && make tags FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.z8RttESyW2 DESTDIR=/tmp/tmp.6Gv8JZOYx3
           make_no_libperl_O: cd . && make NO_LIBPERL=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.0pRqgxEWLe DESTDIR=/tmp/tmp.ioqNtqIWn3
                 make_help_O: cd . && make help FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.wNsijVwTQH DESTDIR=/tmp/tmp.jz1T2nM2IK
              make_no_gtk2_O: cd . && make NO_GTK2=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.nfZdzepUbZ DESTDIR=/tmp/tmp.DQZlnzHRSX
           make_no_libnuma_O: cd . && make NO_LIBNUMA=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.87R85hXnHy DESTDIR=/tmp/tmp.evxqlvqF9Q
     make_util_pmu_bison_o_O: cd . && make util/pmu-bison.o FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.uZ2uxgsHfH DESTDIR=/tmp/tmp.gK94AuyCSw
            make_no_libelf_O: cd . && make NO_LIBELF=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.SbQvlckgpr DESTDIR=/tmp/tmp.BdicQuNJ4I
         make_no_libpython_O: cd . && make NO_LIBPYTHON=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.Hs8Fgw58sM DESTDIR=/tmp/tmp.O9xJ46ivch
          make_no_libaudit_O: cd . && make NO_LIBAUDIT=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.4J4C37PEcX DESTDIR=/tmp/tmp.17KyQdjlJr
          make_no_demangle_O: cd . && make NO_DEMANGLE=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.9T7d972Iq4 DESTDIR=/tmp/tmp.OmhdemgoD0
      make_with_babeltrace_O: cd . && make LIBBABELTRACE=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.YAAQ8BJQ47 DESTDIR=/tmp/tmp.ab6vWEz2BH
         make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.PVn97i2GaD DESTDIR=/tmp/tmp.FtoNcYLuit
              make_no_newt_O: cd . && make NO_NEWT=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.vXXDkjPncA DESTDIR=/tmp/tmp.6C1TxNjEsK
               make_perf_o_O: cd . && make perf.o FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.41vLM9THKV DESTDIR=/tmp/tmp.iRNmuH6HhX
 make_install_prefix_slash_O: cd . && make install prefix=/tmp/krava/ FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.s7QM9fH857 DESTDIR=/tmp/tmp.5ksvTXOKFS
              make_install_O: cd . && make install FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.AtP0IWbb1q DESTDIR=/tmp/tmp.ALFitlnvys
       make_install_prefix_O: cd . && make install prefix=/tmp/krava FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.d7Fj07hY9t DESTDIR=/tmp/tmp.lJgh1rAlC8
                  make_doc_O: cd . && make doc FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.d8zNjEXSK9 DESTDIR=/tmp/tmp.h5deIYBlpA
              make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.kMK5kEhFxt DESTDIR=/tmp/tmp.gk2k2wXNhl
           make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.2OFaqPWKaX DESTDIR=/tmp/tmp.UISM6T2OtL
          make_no_auxtrace_O: cd . && make NO_AUXTRACE=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.8SKo9n8vWp DESTDIR=/tmp/tmp.6fwjE762L1
       make_with_clangllvm_O: cd . && make LIBCLANGLLVM=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.22nXtyLNUw DESTDIR=/tmp/tmp.iMc2ET9PEQ
         make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.9D2ef8yWWg DESTDIR=/tmp/tmp.BigQsiYWgB
make_no_libdw_dwarf_unwind_O: cd . && make NO_LIBDW_DWARF_UNWIND=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.QvQVtsyo0U DESTDIR=/tmp/tmp.35obmHcXNO
                make_no_ui_O: cd . && make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.QkDnnb6nS0 DESTDIR=/tmp/tmp.UxLWSGZcAb
             make_no_slang_O: cd . && make NO_SLANG=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.whyhxkgyt5 DESTDIR=/tmp/tmp.Sk5P3IyCfK
            make_no_libbpf_O: cd . && make NO_LIBBPF=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.kZDK82cROR DESTDIR=/tmp/tmp.AuAmKVkSJM
                 make_pure_O: cd . && make FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.CnnvrI746k DESTDIR=/tmp/tmp.iagYJmBzuk
           make_no_scripts_O: cd . && make NO_LIBPYTHON=1 NO_LIBPERL=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.GdYxbYcpa6 DESTDIR=/tmp/tmp.l2Kdlb4nw6
          make_install_bin_O: cd . && make install-bin FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.K53lCwDwuc DESTDIR=/tmp/tmp.P054EgzUVW
                make_debug_O: cd . && make DEBUG=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.URb8OKvyPH DESTDIR=/tmp/tmp.lEmNtybd4Y
         make_no_backtrace_O: cd . && make NO_BACKTRACE=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.AYhs9jZJta DESTDIR=/tmp/tmp.3utydz1YeX
- /root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC: cd . && make FEATURE_DUMP_COPY=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC  LDFLAGS='-static' feature-dump
cd . && make FEATURE_DUMP_COPY=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC LDFLAGS='-static' feature-dump
               make_static_O: cd . && make LDFLAGS=-static FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC -j8 O=/tmp/tmp.LUNSZNLI7T DESTDIR=/tmp/tmp.KEOWH9Dlum
OK
make: Leaving directory '/root/abudanko/kernel/tip/tools/perf'

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
  MAINTAINERS file lacks references to appropriate folks for reviewing 
  changes at arch/x86/kernel/perf_regs.c so probably it makes sense to 
  update the file as well in this respect. 
---
 arch/x86/kernel/perf_regs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index e47b2dbbdef3..9284048cf5b0 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -157,6 +157,15 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 	 */
 	regs_user_copy->bx = -1;
 	regs_user_copy->bp = -1;
+	if (user_64bit_mode(user_regs)) {
+		/*
+		 * Store user space frame-pointer value on sample
+		 * to facilitate stack unwinding for cases when
+		 * user space x86_64 executable code has such
+		 * support enabled at compile time;
+		 */
+		regs_user_copy->bp = user_regs->bp;
+	}
 	regs_user_copy->r12 = -1;
 	regs_user_copy->r13 = -1;
 	regs_user_copy->r14 = -1;
