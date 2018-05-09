Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934489AbeEILpB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:45:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:26332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933915AbeEILpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:45:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54445790"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH RFC 00/19] perf tools and x86_64 KPTI entry trampolines
Date: Wed,  9 May 2018 14:43:29 +0300
Message-Id: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Perf tools do not know about x86_64 KPTI entry trampolines - see example
below.  These patches add a workaround, namely "perf tools: Workaround
missing maps for x86_64 KPTI entry trampolines", which has the limitation
that it hard codes the addresses.  Note that the workaround will work for
old kernels and old perf.data files, but not for future kernels if the
trampoline addresses are ever changed.

At present, perf tools uses /proc/kallsyms to construct a memory map for
the kernel.  Recording such a map in the perf.data file is necessary to
deal with kernel relocation and KASLR.

While it is reasonable on its own terms, to add symbols for the trampolines
to /proc/kallsyms, the motivation here is to have perf tools use them to
create memory maps in the same fashion as is done for the kernel text.

So the first 2 patches add symbols to /proc/kallsyms for the trampolines:

      kallsyms: Simplify update_iter_mod()
      kallsyms, x86: Export addresses of syscall trampolines

perf tools have the ability to use /proc/kcore (in conjunction with
/proc/kallsyms) as the kernel image. So the next 2 patches add program
headers for the trampolines to the kcore ELF:

      x86: Add entry trampolines to kcore
      x86: kcore: Give entry trampolines all the same offset in kcore

It is worth noting that, with the kcore changes alone, perf tools require
no changes to recognise the trampolines when using /proc/kcore.

Similarly, if perf tools are used with a matching kallsyms only (by denying
access to /proc/kcore or a vmlinux image), then the kallsyms patches are
sufficient to recognise the trampolines with no changes needed to the
tools.

However, in the general case, when using vmlinux or dealing with
relocations, perf tools needs memory maps for the trampolines.  Because the
kernel text map is constructed as a special case, using the same approach
for the trampolines means treating them as a special case also, which
requires a number of changes to perf tools, and the remaining patches deal
with that.


Example: make a program that does lots of small syscalls e.g.

	$ cat uname_x_n.c

	#include <sys/utsname.h>
	#include <stdlib.h>

	int main(int argc, char *argv[])
	{
		long n = argc > 1 ? strtol(argv[1], NULL, 0) : 0;
		struct utsname u;

		while (n--)
			uname(&u);

		return 0;
	}

and then:

	sudo perf record uname_x_n 100000
	sudo perf report --stdio

Before the changes, there are unknown symbols:

 # Overhead  Command    Shared Object     Symbol
 # ........  .........  ................  ..................................
 #
    41.91%  uname_x_n  [kernel.vmlinux]  [k] syscall_return_via_sysret
    19.22%  uname_x_n  [kernel.vmlinux]  [k] copy_user_enhanced_fast_string
    18.70%  uname_x_n  [unknown]         [k] 0xfffffe00000e201b
     4.09%  uname_x_n  libc-2.19.so      [.] __GI___uname
     3.08%  uname_x_n  [kernel.vmlinux]  [k] do_syscall_64
     3.02%  uname_x_n  [unknown]         [k] 0xfffffe00000e2025
     2.32%  uname_x_n  [kernel.vmlinux]  [k] down_read
     2.27%  uname_x_n  ld-2.19.so        [.] _dl_start
     1.97%  uname_x_n  [unknown]         [k] 0xfffffe00000e201e
     1.25%  uname_x_n  [kernel.vmlinux]  [k] up_read
     1.02%  uname_x_n  [unknown]         [k] 0xfffffe00000e200c
     0.99%  uname_x_n  [kernel.vmlinux]  [k] entry_SYSCALL_64
     0.16%  uname_x_n  [kernel.vmlinux]  [k] flush_signal_handlers
     0.01%  perf       [kernel.vmlinux]  [k] native_sched_clock
     0.00%  perf       [kernel.vmlinux]  [k] native_write_msr

After the changes there are not:

 # Overhead  Command    Shared Object     Symbol
 # ........  .........  ................  ..................................
 #
    41.91%  uname_x_n  [kernel.vmlinux]  [k] syscall_return_via_sysret
    24.70%  uname_x_n  [kernel.vmlinux]  [k] entry_SYSCALL_64_trampoline
    19.22%  uname_x_n  [kernel.vmlinux]  [k] copy_user_enhanced_fast_string
     4.09%  uname_x_n  libc-2.19.so      [.] __GI___uname
     3.08%  uname_x_n  [kernel.vmlinux]  [k] do_syscall_64
     2.32%  uname_x_n  [kernel.vmlinux]  [k] down_read
     2.27%  uname_x_n  ld-2.19.so        [.] _dl_start
     1.25%  uname_x_n  [kernel.vmlinux]  [k] up_read
     0.99%  uname_x_n  [kernel.vmlinux]  [k] entry_SYSCALL_64
     0.16%  uname_x_n  [kernel.vmlinux]  [k] flush_signal_handlers
     0.01%  perf       [kernel.vmlinux]  [k] native_sched_clock
     0.00%  perf       [kernel.vmlinux]  [k] native_write_msr


Adrian Hunter (17):
      kallsyms: Simplify update_iter_mod()
      x86: kcore: Give entry trampolines all the same offset in kcore
      perf tools: Use the _stest symbol to identify the kernel map when loading kcore
      perf tools: Fix kernel_start for KPTI on x86_64
      perf tools: Workaround missing maps for x86_64 KPTI entry trampolines
      perf tools: Fix map_groups__split_kallsyms() for entry trampoline symbols
      perf tools: Allow for special kernel maps
      perf tools: Create maps for x86_64 KPTI entry trampolines
      perf tools: Synthesize and process mmap events for x86_64 KPTI entry trampolines
      perf buildid-cache: kcore_copy: Keep phdr data in a list
      perf buildid-cache: kcore_copy: Keep a count of phdrs
      perf buildid-cache: kcore_copy: Calculate offset from phnum
      perf buildid-cache: kcore_copy: Layout sections
      perf buildid-cache: kcore_copy: Iterate phdrs
      perf buildid-cache: kcore_copy: Get rid of kernel_map
      perf buildid-cache: kcore_copy: Copy x86_64 entry trampoline sections
      perf buildid-cache: kcore_copy: Amend the offset of sections that remap kernel text

Alexander Shishkin (2):
      kallsyms, x86: Export addresses of syscall trampolines
      x86: Add entry trampolines to kcore

 arch/x86/mm/cpu_entry_area.c |  28 +++++
 fs/proc/kcore.c              |   7 +-
 include/linux/kcore.h        |  13 ++
 kernel/kallsyms.c            |  46 ++++---
 tools/perf/util/event.c      |  92 +++++++++++++-
 tools/perf/util/machine.c    | 288 ++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/machine.h    |   6 +
 tools/perf/util/map.c        |  22 +++-
 tools/perf/util/map.h        |  15 ++-
 tools/perf/util/symbol-elf.c | 209 ++++++++++++++++++++++++++-----
 tools/perf/util/symbol.c     |  65 +++++++---
 11 files changed, 709 insertions(+), 82 deletions(-)


Regards
Adrian
