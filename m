Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965970AbeEXJZE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:25:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:50991 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965875AbeEXJZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:25:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="58087573"
Subject: Re: [PATCH V3 00/17] perf tools and x86 PTI entry trampolines
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
 <20180523193546.GA8907@kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e94515c9-0f90-5457-c7f6-43793efe311d@intel.com>
Date: Thu, 24 May 2018 12:23:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523193546.GA8907@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/18 22:35, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 22, 2018 at 01:54:28PM +0300, Adrian Hunter escreveu:
>> Original Cover email:
>>
>> Perf tools do not know about x86 PTI entry trampolines - see example
>> below.  These patches add a workaround, namely "perf tools: Workaround
>> missing maps for x86 PTI entry trampolines", which has the limitation
>> that it hard codes the addresses.  Note that the workaround will work for
>> old kernels and old perf.data files, but not for future kernels if the
>> trampoline addresses are ever changed.
>>
>> At present, perf tools uses /proc/kallsyms to construct a memory map for
>> the kernel.  Recording such a map in the perf.data file is necessary to
>> deal with kernel relocation and KASLR.
>>
>> While it is reasonable on its own terms, to add symbols for the trampolines
>> to /proc/kallsyms, the motivation here is to have perf tools use them to
>> create memory maps in the same fashion as is done for the kernel text.
>>
>> So the first 2 patches add symbols to /proc/kallsyms for the trampolines:
>>
>>       kallsyms: Simplify update_iter_mod()
>>       kallsyms, x86: Export addresses of syscall trampolines
>>
>> perf tools have the ability to use /proc/kcore (in conjunction with
>> /proc/kallsyms) as the kernel image. So the next 2 patches add program
>> headers for the trampolines to the kcore ELF:
>>
>>       x86: Add entry trampolines to kcore
>>       x86: kcore: Give entry trampolines all the same offset in kcore
>>
>> It is worth noting that, with the kcore changes alone, perf tools require
>> no changes to recognise the trampolines when using /proc/kcore.
>>
>> Similarly, if perf tools are used with a matching kallsyms only (by denying
>> access to /proc/kcore or a vmlinux image), then the kallsyms patches are
>> sufficient to recognise the trampolines with no changes needed to the
>> tools.
>>
>> However, in the general case, when using vmlinux or dealing with
>> relocations, perf tools needs memory maps for the trampolines.  Because the
>> kernel text map is constructed as a special case, using the same approach
>> for the trampolines means treating them as a special case also, which
>> requires a number of changes to perf tools, and the remaining patches deal
>> with that.
>>
>>
>> Example: make a program that does lots of small syscalls e.g.
>>
>> 	$ cat uname_x_n.c
>>
>> 	#include <sys/utsname.h>
>> 	#include <stdlib.h>
>>
>> 	int main(int argc, char *argv[])
>> 	{
>> 		long n = argc > 1 ? strtol(argv[1], NULL, 0) : 0;
>> 		struct utsname u;
>>
>> 		while (n--)
>> 			uname(&u);
>>
>> 		return 0;
>> 	}
>>
>> and then:
>>
>> 	sudo perf record uname_x_n 100000
>> 	sudo perf report --stdio
>>
>> Before the changes, there are unknown symbols:
>>
>>  # Overhead  Command    Shared Object     Symbol
>>  # ........  .........  ................  ..................................
>>  #
>>     41.91%  uname_x_n  [kernel.vmlinux]  [k] syscall_return_via_sysret
>>     19.22%  uname_x_n  [kernel.vmlinux]  [k] copy_user_enhanced_fast_string
>>     18.70%  uname_x_n  [unknown]         [k] 0xfffffe00000e201b
>>      4.09%  uname_x_n  libc-2.19.so      [.] __GI___uname
>>      3.08%  uname_x_n  [kernel.vmlinux]  [k] do_syscall_64
>>      3.02%  uname_x_n  [unknown]         [k] 0xfffffe00000e2025
>>      2.32%  uname_x_n  [kernel.vmlinux]  [k] down_read
>>      2.27%  uname_x_n  ld-2.19.so        [.] _dl_start
>>      1.97%  uname_x_n  [unknown]         [k] 0xfffffe00000e201e
>>      1.25%  uname_x_n  [kernel.vmlinux]  [k] up_read
>>      1.02%  uname_x_n  [unknown]         [k] 0xfffffe00000e200c
>>      0.99%  uname_x_n  [kernel.vmlinux]  [k] entry_SYSCALL_64
>>      0.16%  uname_x_n  [kernel.vmlinux]  [k] flush_signal_handlers
>>      0.01%  perf       [kernel.vmlinux]  [k] native_sched_clock
>>      0.00%  perf       [kernel.vmlinux]  [k] native_write_msr
>>
>> After the changes there are not:
>>
>>  # Overhead  Command    Shared Object     Symbol
>>  # ........  .........  ................  ..................................
>>  #
>>     41.91%  uname_x_n  [kernel.vmlinux]  [k] syscall_return_via_sysret
>>     24.70%  uname_x_n  [kernel.vmlinux]  [k] entry_SYSCALL_64_trampoline
>>     19.22%  uname_x_n  [kernel.vmlinux]  [k] copy_user_enhanced_fast_string
>>      4.09%  uname_x_n  libc-2.19.so      [.] __GI___uname
>>      3.08%  uname_x_n  [kernel.vmlinux]  [k] do_syscall_64
>>      2.32%  uname_x_n  [kernel.vmlinux]  [k] down_read
>>      2.27%  uname_x_n  ld-2.19.so        [.] _dl_start
>>      1.25%  uname_x_n  [kernel.vmlinux]  [k] up_read
>>      0.99%  uname_x_n  [kernel.vmlinux]  [k] entry_SYSCALL_64
>>      0.16%  uname_x_n  [kernel.vmlinux]  [k] flush_signal_handlers
>>      0.01%  perf       [kernel.vmlinux]  [k] native_sched_clock
>>      0.00%  perf       [kernel.vmlinux]  [k] native_write_msr
> 
> So, with just the userspace patches I get, recording with the new tool,
> and then report'ing with old and new tools:
> 
> Before:
> 
> [root@seventh c]# perf-4.17.rc6.ga048a0-torvalds.master report --stdio
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 83  of event 'cycles:ppp'
> # Event count (approx.): 86724689
> #
> # Overhead  Command    Shared Object     Symbol                            
> # ........  .........  ................  ..................................
> #
>     35.12%  uname_x_n  [kernel.vmlinux]  [k] syscall_return_via_sysret
>     20.86%  uname_x_n  [unknown]         [k] 0xfffffe000005e01b
>     11.09%  uname_x_n  [kernel.vmlinux]  [k] copy_user_enhanced_fast_string
>      8.58%  uname_x_n  [kernel.vmlinux]  [k] __x64_sys_newuname
>      4.93%  uname_x_n  libc-2.26.so      [.] __GI___uname
>      2.92%  uname_x_n  ld-2.26.so        [.] dl_main
>      2.66%  uname_x_n  [kernel.vmlinux]  [k] __x86_indirect_thunk_rax
>      2.46%  uname_x_n  [kernel.vmlinux]  [k] do_syscall_64
>      2.18%  uname_x_n  [unknown]         [k] 0xfffffe000005e01e
>      2.17%  uname_x_n  uname_x_n         [.] main
>      2.14%  uname_x_n  [unknown]         [k] 0xfffffe000005e00c
>      1.98%  uname_x_n  [unknown]         [k] 0xfffffe000005e025
>      1.37%  uname_x_n  [kernel.vmlinux]  [k] down_read
>      1.27%  uname_x_n  [kernel.vmlinux]  [k] entry_SYSCALL_64
>      0.23%  uname_x_n  [kernel.vmlinux]  [k] get_random_u64
>      0.01%  perf       [kernel.vmlinux]  [k] end_repeat_nmi
>      0.00%  perf       [kernel.vmlinux]  [k] native_write_msr
> 
> 
> #
> # (Tip: Use --symfs <dir> if your symbol files are in non-standard locations)
> #
> 
> After:
> 
> [root@seventh c]# perf report --stdio
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 83  of event 'cycles:ppp'
> # Event count (approx.): 86724689
> #
> # Overhead  Command    Shared Object     Symbol                            
> # ........  .........  ................  ..................................
> #
>     35.12%  uname_x_n  [kernel.vmlinux]  [k] syscall_return_via_sysret
>     27.18%  uname_x_n  [kernel.vmlinux]  [k] entry_SYSCALL_64_trampoline
>     11.09%  uname_x_n  [kernel.vmlinux]  [k] copy_user_enhanced_fast_string
>      8.58%  uname_x_n  [kernel.vmlinux]  [k] __x64_sys_newuname
>      4.93%  uname_x_n  libc-2.26.so      [.] __GI___uname
>      2.92%  uname_x_n  ld-2.26.so        [.] dl_main
>      2.66%  uname_x_n  [kernel.vmlinux]  [k] __x86_indirect_thunk_rax
>      2.46%  uname_x_n  [kernel.vmlinux]  [k] do_syscall_64
>      2.17%  uname_x_n  uname_x_n         [.] main
>      1.37%  uname_x_n  [kernel.vmlinux]  [k] down_read
>      1.27%  uname_x_n  [kernel.vmlinux]  [k] entry_SYSCALL_64
>      0.23%  uname_x_n  [kernel.vmlinux]  [k] get_random_u64
>      0.01%  perf       [kernel.vmlinux]  [k] end_repeat_nmi
>      0.00%  perf       [kernel.vmlinux]  [k] native_write_msr
> 
> 
> #
> # (Tip: Generate a script for your data: perf script -g <lang>)
> #
> [root@seventh c]# 
> [root@seventh c]# 
> 
> What am I missing while testing this,

perf.data maps come from reading kallsyms, so you need a new kernel to get
the maps recorded into perf.data.

If you use old tools with a new perf.data file and new kernel, then it will
work for kallsyms or kcore but not vmlinux.  This is because the old tools
do not know how to use the maps to calculate the _entry_trampoline offset
for vmlinux.
