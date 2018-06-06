Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E97F606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeFFMze (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:55:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:9650 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeFFMzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:55:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="55204277"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH V4 0/3] perf tools and x86 PTI entry trampolines
Date: Wed,  6 Jun 2018 15:54:08 +0300
Message-Id: <1528289651-4113-1-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is V4 of patches to support x86 PTI entry trampolines in perf tools.

Patches also here:
	http://git.infradead.org/users/ahunter/linux-perf.git/shortlog/refs/heads/perf-tools-kpti-v4
	git://git.infradead.org/users/ahunter/linux-perf.git perf-tools-kpti-v4

V3 patches also here:
	http://git.infradead.org/users/ahunter/linux-perf.git/shortlog/refs/heads/perf-tools-kpti-v3
	git://git.infradead.org/users/ahunter/linux-perf.git perf-tools-kpti-v3

V2 patches also here:
	http://git.infradead.org/users/ahunter/linux-perf.git/shortlog/refs/heads/perf-tools-kpti-v2
	git://git.infradead.org/users/ahunter/linux-perf.git perf-tools-kpti-v2

V1 patches also here:
	http://git.infradead.org/users/ahunter/linux-perf.git/shortlog/refs/heads/perf-tools-kpti-v1
	git://git.infradead.org/users/ahunter/linux-perf.git perf-tools-kpti-v1


Changes Since V3:
	kallsyms: Simplify update_iter_mod()
		Added comment
		Added Andi's Ack

	kallsyms, x86: Export addresses of PTI entry trampolines
		Expanded commit message
		Used for_each_possible_cpu()
		Added Andi's Ack even though logic changed slightly

	x86: Add entry trampolines to kcore
		Re-based
		Added Andi's Ack

	perf tools: Add machine__nr_cpus_avail()
	perf tools: Workaround missing maps for x86 PTI entry trampolines
	perf tools: Fix map_groups__split_kallsyms() for entry trampoline symbols
	perf tools: Allow for extra kernel maps
	perf tools: Create maps for x86 PTI entry trampolines
	perf tools: Synthesize and process mmap events for x86 PTI entry trampolines
	perf buildid-cache: kcore_copy: Keep phdr data in a list
	perf buildid-cache: kcore_copy: Keep a count of phdrs
	perf buildid-cache: kcore_copy: Calculate offset from phnum
	perf buildid-cache: kcore_copy: Layout sections
	perf buildid-cache: kcore_copy: Iterate phdrs
	perf buildid-cache: kcore_copy: Get rid of kernel_map
	perf buildid-cache: kcore_copy: Copy x86 PTI entry trampoline sections
	perf buildid-cache: kcore_copy: Amend the offset of sections that remap kernel text
		Dropped because they have been applied

Changes Since V2:

	x86: Add entry trampolines to kcore
	x86: kcore: Give entry trampolines all the same offset in kcore
		Combined into a single patch
		Added comment
		Expand commit message

	perf tools: Add machine__is() to identify machine arch
		Dropped because it has been applied

	perf tools: Fix kernel_start for PTI on x86
		Dropped because it has been applied

Changes Since V1:

	perf tools: Use the _stest symbol to identify the kernel map when loading kcore
		Dropped because it has been applied

	perf tools: Add machine__is() to identify machine arch
		New patch

	perf tools: Fix kernel_start for PTI on x86
		Moved definition of machine__is() to a separate patch

	perf tools: Add machine__nr_cpus_avail()
		New patch

	perf tools: Workaround missing maps for x86 PTI entry trampolines
		Use machine__nr_cpus_avail()

	perf tools: Create maps for x86 PTI entry trampolines
		Re-based

Changes Since RFC:

	Change description 'x86_64 KPTI' to 'x86 PTI'

	Rename 'special' kernel map to 'extra' kernel map etc

	kallsyms: Simplify update_iter_mod()
		Expand commit message

	perf tools: Fix kernel_start for PTI on x86
		Amend machine__is() to check if machine is NULL

	perf tools: Workaround missing maps for x86 PTI entry trampolines
		Simplify find_entry_trampoline()
		Add comment before struct extra_kernel_map /* Kernel-space
		maps for symbols that are outside the main kernel map and
		module maps */

	perf tools: Create maps for x86 PTI entry trampolines
		Move code presently only used by x86_64 into arch

	perf tools: Synthesize and process mmap events for x86 PTI entry
	trampolines
		Fix spelling 'kernal' -> 'kernel'
		Rename 'special' kernel map to 'extra' kernel map etc
		Move code presently only used by x86_64 into arch

	perf buildid-cache: kcore_copy: Keep phdr data in a list
		Expand commit message
		Rename 'list' -> 'node'

	perf buildid-cache: kcore_copy: Get rid of kernel_map
		Expand commit message
		Add phdr_data__new()
		Rename 'kcore_copy__new_phdr' -> 'kcore_copy_info__addnew'


Original Cover email:

Perf tools do not know about x86 PTI entry trampolines - see example
below.  These patches add a workaround, namely "perf tools: Workaround
missing maps for x86 PTI entry trampolines", which has the limitation
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


Adrian Hunter (2):
      kallsyms: Simplify update_iter_mod()
      x86: Add entry trampolines to kcore

Alexander Shishkin (1):
      kallsyms, x86: Export addresses of PTI entry trampolines

 arch/x86/mm/cpu_entry_area.c | 33 ++++++++++++++++++++++++++++
 fs/proc/kcore.c              |  7 ++++--
 include/linux/kcore.h        | 13 +++++++++++
 kernel/kallsyms.c            | 51 ++++++++++++++++++++++++++++++++------------
 4 files changed, 88 insertions(+), 16 deletions(-)


Regards
Adrian
