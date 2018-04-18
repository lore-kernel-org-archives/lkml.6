Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeDRPC1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:02:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbeDRPCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:02:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE8E2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 18 Apr 2018 12:02:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Wang Nan <wangnan0@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2] tracing/x86: Update syscall trace events to handle
 new x86 syscall func names
Message-ID: <20180418150212.GA10084@kernel.org>
References: <20180417130702.01575029@gandalf.local.home>
 <20180417172236.GA17342@light.dominikbrodowski.net>
 <20180417180430.GF3625@kernel.org>
 <20180417181304.GA2895@kernel.org>
 <20180417174128.0f3457f0@gandalf.local.home>
 <20180418125322.GB2895@kernel.org>
 <20180418103606.4118b35f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418103606.4118b35f@gandalf.local.home>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 18, 2018 at 10:36:06AM -0400, Steven Rostedt escreveu:
> On Wed, 18 Apr 2018 09:53:22 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Tue, Apr 17, 2018 at 05:41:28PM -0400, Steven Rostedt escreveu:
> > > On Tue, 17 Apr 2018 15:13:04 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:  
> > > > Yeah, failing:  

> > > > [root@jouet ~]# strace -e openat -e file perf test -F -v "mmap interface" |& grep syscalls
> > > > openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getsid/format", O_RDONLY) = 3
> > > > openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getppid/format", O_RDONLY) = -1 ENOENT (No such file or directory)  
> >  
> > > It doesn't have to do with the number of parameters, not everything
> > > has "__x64" on it.  

> > > Try this patch:  

> > Trying...
 
> You're keeping me in suspense!

I switched locations, had trouble reconnecting, those tests are ok now,
there is just one case left, related to the syscall routines renames,
but not related to the syscalls:sys_{enter,exit}_NAME tracepoints:

[root@jouet ~]# perf test
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
40.1: Basic BPF filtering                                 : FAILED!
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
63: probe libc's inet_pton & backtrace it with ping       : Ok
64: Check open filename arg using perf trace + vfs_getname: Ok
65: probe libc's inet_pton & backtrace it with ping       : Ok
66: Add vfs_getname probe to get syscall args filenames   : Ok
[root@jouet ~]# 

If we use -v for that test we see the problem:

To the point:

  Probe point 'SyS_epoll_pwait' not found.

This is not there anymore, I'll change this test to first figure out
what is the syscall routine for the epoll_pwait syscall so that it works
with pre-syscall-routines-rename and after that.

- Arnaldo

all details:

[root@jouet ~]# perf test -v BPF
40: BPF filter                                            :
40.1: Basic BPF filtering                                 :
--- start ---
test child forked, pid 13225
Kernel build dir is set to /lib/modules/4.17.0-rc1-00024-g7e4e440a91c8-dirty/build
set env: KBUILD_DIR=/lib/modules/4.17.0-rc1-00024-g7e4e440a91c8-dirty/build
unset env: KBUILD_OPTS
include option is set to  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h 
set env: NR_CPUS=4
set env: LINUX_VERSION_CODE=0x41100
set env: CLANG_EXEC=/usr/lib64/ccache/clang
set env: CLANG_OPTIONS=-xc 
set env: KERNEL_INC_OPTIONS= -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h 
set env: WORKING_DIR=/lib/modules/4.17.0-rc1-00024-g7e4e440a91c8-dirty/build
set env: CLANG_SOURCE=-
llvm compiling command template: echo '/*
 * bpf-script-example.c
 * Test basic LLVM building
 */
#ifndef LINUX_VERSION_CODE
# error Need LINUX_VERSION_CODE
# error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
#endif
#define BPF_ANY 0
#define BPF_MAP_TYPE_ARRAY 2
#define BPF_FUNC_map_lookup_elem 1
#define BPF_FUNC_map_update_elem 2

static void *(*bpf_map_lookup_elem)(void *map, void *key) =
	(void *) BPF_FUNC_map_lookup_elem;
static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
	(void *) BPF_FUNC_map_update_elem;

struct bpf_map_def {
	unsigned int type;
	unsigned int key_size;
	unsigned int value_size;
	unsigned int max_entries;
};

#define SEC(NAME) __attribute__((section(NAME), used))
struct bpf_map_def SEC("maps") flip_table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 1,
};

SEC("func=SyS_epoll_pwait")
int bpf_func__SyS_epoll_pwait(void *ctx)
{
	int ind =0;
	int *flag = bpf_map_lookup_elem(&flip_table, &ind);
	int new_flag;
	if (!flag)
		return 0;
	/* flip flag and store back */
	new_flag = !*flag;
	bpf_map_update_elem(&flip_table, &ind, &new_flag, BPF_ANY);
	return new_flag;
}
char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;
' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS -DLINUX_VERSION_CODE=$LINUX_VERSION_CODE $CLANG_OPTIONS $KERNEL_INC_OPTIONS -Wno-unused-value -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -target bpf -O2 -o -
llvm compiling command : echo '/*
 * bpf-script-example.c
 * Test basic LLVM building
 */
#ifndef LINUX_VERSION_CODE
# error Need LINUX_VERSION_CODE
# error Example: for 4.2 kernel, put 'clang-opt=-DLINUX_VERSION_CODE=0x40200 into llvm section of ~/.perfconfig'
#endif
#define BPF_ANY 0
#define BPF_MAP_TYPE_ARRAY 2
#define BPF_FUNC_map_lookup_elem 1
#define BPF_FUNC_map_update_elem 2

static void *(*bpf_map_lookup_elem)(void *map, void *key) =
	(void *) BPF_FUNC_map_lookup_elem;
static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
	(void *) BPF_FUNC_map_update_elem;

struct bpf_map_def {
	unsigned int type;
	unsigned int key_size;
	unsigned int value_size;
	unsigned int max_entries;
};

#define SEC(NAME) __attribute__((section(NAME), used))
struct bpf_map_def SEC(maps) flip_table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 1,
};

SEC(func=SyS_epoll_pwait)
int bpf_func__SyS_epoll_pwait(void *ctx)
{
	int ind =0;
	int *flag = bpf_map_lookup_elem(&flip_table, &ind);
	int new_flag;
	if (!flag)
		return 0;
	/* flip flag and store back */
	new_flag = !*flag;
	bpf_map_update_elem(&flip_table, &ind, &new_flag, BPF_ANY);
	return new_flag;
}
char _license[] SEC(license) = GPL;
int _version SEC(version) = LINUX_VERSION_CODE;
' | /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CPUS__=4 -DLINUX_VERSION_CODE=0x41100 -xc   -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/4.17.0-rc1-00024-g7e4e440a91c8-dirty/build -c - -target bpf -O2 -o -
libbpf: loading object '[basic_bpf_test]' from buffer
libbpf: section(1) .strtab, size 122, link 0, flags 0, type=3
libbpf: skip section(1) .strtab
libbpf: section(2) .text, size 0, link 0, flags 6, type=1
libbpf: skip section(2) .text
libbpf: section(3) func=SyS_epoll_pwait, size 192, link 0, flags 6, type=1
libbpf: found program func=SyS_epoll_pwait
libbpf: section(4) .relfunc=SyS_epoll_pwait, size 32, link 8, flags 0, type=9
libbpf: section(5) maps, size 16, link 0, flags 3, type=1
libbpf: section(6) license, size 4, link 0, flags 3, type=1
libbpf: license of [basic_bpf_test] is GPL
libbpf: section(7) version, size 4, link 0, flags 3, type=1
libbpf: kernel version of [basic_bpf_test] is 41100
libbpf: section(8) .symtab, size 168, link 1, flags 0, type=2
libbpf: maps in [basic_bpf_test]: 1 maps in 16 bytes
libbpf: map 0 is "flip_table"
libbpf: collecting relocating info for: 'func=SyS_epoll_pwait'
libbpf: relo for 6 value 0 name 81
libbpf: relocation: insn_idx=4
libbpf: relocation: find map 0 (flip_table) for insn 4
libbpf: relo for 6 value 0 name 81
libbpf: relocation: insn_idx=17
libbpf: relocation: find map 0 (flip_table) for insn 17
bpf: config program 'func=SyS_epoll_pwait'
symbol:SyS_epoll_pwait file:(null) line:0 offset:0 return:0 lazy:(null)
bpf: config 'func=SyS_epoll_pwait' is ok
Looking at the vmlinux_path (8 entries long)
Using /lib/modules/4.17.0-rc1-00024-g7e4e440a91c8-dirty/build/vmlinux for symbols
Open Debuginfo file: /lib/modules/4.17.0-rc1-00024-g7e4e440a91c8-dirty/build/vmlinux
Try to find probe point from debuginfo.
Probe point 'SyS_epoll_pwait' not found.
bpf_probe: failed to convert perf probe events
Failed to add events selected by BPF
test child finished with -1
---- end ----
BPF filter subtest 0: FAILED!
40.2: BPF pinning                                         :
--- force skipped ---
BPF filter subtest 1: Skip
40.3: BPF prologue generation                             :
--- force skipped ---
BPF filter subtest 2: Skip
40.4: BPF relocation checker                              :
--- force skipped ---
BPF filter subtest 3: Skip
[root@jouet ~]# 
