Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeDJPkK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:40:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:32739 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbeDJPkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:40:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,432,1517904000";
   d="scan'208";a="32580296"
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2]: perf/x86: expose user space frame-pointer value on a
 sample
Message-ID: <e702f8c9-1bb4-e9fd-cc53-452ed9a82762@linux.intel.com>
Date: Tue, 10 Apr 2018 18:40:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Store user space frame-pointer value (BP register) into Perf trace 
on a sample for a process so the value becomes available when 
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


Testing results:

tools/perf/perf test
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

make -C tools/perf/ build-test
make: Entering directory '/root/abudanko/kernel/tip/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
- /root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
cd . && make FEATURE_DUMP_COPY=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
           make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.hCniCh5IOV DESTDIR=/tmp/tmp.pE0ZNthwCF
 make_install_prefix_slash_O: cd . && make install prefix=/tmp/krava/ FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.aug1Rs4tNf DESTDIR=/tmp/tmp.Nr57uRH4a7
         make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.K6mNdV9ny7 DESTDIR=/tmp/tmp.rJ4MiEneK3
          make_install_bin_O: cd . && make install-bin FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.4qmyWxqRIq DESTDIR=/tmp/tmp.fQ9pvBSPbK
         make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.Ja0slX338A DESTDIR=/tmp/tmp.QoqYxqLoLM
            make_no_libbpf_O: cd . && make NO_LIBBPF=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.M4cGuRET89 DESTDIR=/tmp/tmp.yRbVHtN25b
                  make_doc_O: cd . && make doc FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.vit59hhoQw DESTDIR=/tmp/tmp.Pdf8YRdUZ6
             make_no_slang_O: cd . && make NO_SLANG=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.HVyxNOBsAd DESTDIR=/tmp/tmp.a0faga36nq
make_no_libdw_dwarf_unwind_O: cd . && make NO_LIBDW_DWARF_UNWIND=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.wmv42sG9uM DESTDIR=/tmp/tmp.QqGhSX5KBD
            make_clean_all_O: cd . && make clean all FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.EXQULIs1Lz DESTDIR=/tmp/tmp.R7rWtWOfbj
              make_no_gtk2_O: cd . && make NO_GTK2=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.Ic7nrL0sJw DESTDIR=/tmp/tmp.CG4zzMpTRo
     make_util_pmu_bison_o_O: cd . && make util/pmu-bison.o FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.SlTUvMOKNC DESTDIR=/tmp/tmp.EPHTxRCqhZ
                 make_help_O: cd . && make help FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.8ERtFQpSgy DESTDIR=/tmp/tmp.qm6slgq3vY
         make_no_libpython_O: cd . && make NO_LIBPYTHON=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.nBDottRklF DESTDIR=/tmp/tmp.wa3Y3kbyuj
          make_no_auxtrace_O: cd . && make NO_AUXTRACE=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.DUdGkNlbTo DESTDIR=/tmp/tmp.hCudQY48Pl
          make_no_libaudit_O: cd . && make NO_LIBAUDIT=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.R881i6xKAm DESTDIR=/tmp/tmp.93owQPSDcX
           make_no_scripts_O: cd . && make NO_LIBPYTHON=1 NO_LIBPERL=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.reGc8rOYV1 DESTDIR=/tmp/tmp.B6QViKjMvW
      make_with_babeltrace_O: cd . && make LIBBABELTRACE=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.FhQXwacUez DESTDIR=/tmp/tmp.I3nVzmrMkw
- /root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC: cd . && make FEATURE_DUMP_COPY=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC  LDFLAGS='-static' feature-dump
cd . && make FEATURE_DUMP_COPY=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC LDFLAGS='-static' feature-dump
               make_static_O: cd . && make LDFLAGS=-static FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC -j8 O=/tmp/tmp.WAd4qqaobf DESTDIR=/tmp/tmp.HQGv9RVti6
                 make_tags_O: cd . && make tags FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.4exbvnNqL7 DESTDIR=/tmp/tmp.egmegRFPBa
         make_no_backtrace_O: cd . && make NO_BACKTRACE=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.EVUZhEZdL1 DESTDIR=/tmp/tmp.IU2Hw5iXV9
                make_debug_O: cd . && make DEBUG=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.82NeGzBeKh DESTDIR=/tmp/tmp.0nDEL657DW
                make_no_ui_O: cd . && make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.WPsaGPykuA DESTDIR=/tmp/tmp.BE2i6xrlcz
              make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.mqwTCtkYMZ DESTDIR=/tmp/tmp.HAE2gO2Qcc
       make_install_prefix_O: cd . && make install prefix=/tmp/krava FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.i9spzN3Ffn DESTDIR=/tmp/tmp.HZaM1gdpnX
            make_no_libelf_O: cd . && make NO_LIBELF=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.yXvEPnLS3l DESTDIR=/tmp/tmp.wDVGcoV12j
                 make_pure_O: cd . && make FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.Lyk3dyMDUS DESTDIR=/tmp/tmp.X7yG8O8oPZ
              make_no_newt_O: cd . && make NO_NEWT=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.u2rAAJ77BP DESTDIR=/tmp/tmp.ZO73ixWJ4R
               make_perf_o_O: cd . && make perf.o FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.PzkhlImKTo DESTDIR=/tmp/tmp.9Z5E1d0ADO
              make_install_O: cd . && make install FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.LeTMZGGxYu DESTDIR=/tmp/tmp.i0QyvEIrk0
           make_no_libnuma_O: cd . && make NO_LIBNUMA=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.FBhx6NatXS DESTDIR=/tmp/tmp.1LrUcc5i7s
           make_no_libperl_O: cd . && make NO_LIBPERL=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.iPoY2Rkjbw DESTDIR=/tmp/tmp.kUsnd09yOc
       make_with_clangllvm_O: cd . && make LIBCLANGLLVM=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.yA8pvPEJHH DESTDIR=/tmp/tmp.XwY7J5Etvy
          make_no_demangle_O: cd . && make NO_DEMANGLE=1 FEATURES_DUMP=/root/abudanko/kernel/tip/tools/perf/BUILD_TEST_FEATURE_DUMP -j8 O=/tmp/tmp.NARFUtnpY0 DESTDIR=/tmp/tmp.dR62bKhig0
OK
make: Leaving directory '/root/abudanko/kernel/tip/tools/perf'


Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v2:
- lifted restriction on frame pointer architecture so it's value is provided
  as for i386 as for x86_64 processes

MAINTAINERS file lacks references to appropriate folks for reviewing 
  changes at arch/x86/kernel/perf_regs.c so probably it makes sense to 
  update the file as well in this respect. 
---
 arch/x86/kernel/perf_regs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index e47b2dbbdef3..8d68658eff7f 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -156,7 +156,13 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 	 * Most system calls don't save these registers, don't report them.
 	 */
 	regs_user_copy->bx = -1;
-	regs_user_copy->bp = -1;
+	/*
+	 * Store user space frame-pointer value on sample
+	 * to facilitate stack unwinding for cases when
+	 * user space executable code has such support
+	 * enabled at compile time;
+	 */
+	regs_user_copy->bp = user_regs->bp;
 	regs_user_copy->r12 = -1;
 	regs_user_copy->r13 = -1;
 	regs_user_copy->r14 = -1;
