Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeEPNAe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeEPNAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:00:32 -0400
Date: Wed, 16 May 2018 10:00:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V1 06/19] perf tools: Fix kernel_start for PTI on x86
Message-ID: <20180516130029.GA18538@kernel.org>
References: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
 <1526388213-30696-7-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526388213-30696-7-git-send-email-adrian.hunter@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 15, 2018 at 03:43:20PM +0300, Adrian Hunter escreveu:
> On x86_64, PTI entry trampolines are less than the start of kernel text,
> but still above 2^63. So leave kernel_start = 1ULL << 63 for x86_64.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/machine.c | 16 +++++++++++++++-
>  tools/perf/util/machine.h |  2 ++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 72a351613d85..2f39a4d014de 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2296,6 +2296,15 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
>  	return 0;
>  }
>  
> +/*
> + * Compares the raw arch string. N.B. see instead perf_env__arch() if a
> + * normalized arch is needed.
> + */
> +bool machine__is(struct machine *machine, const char *arch)
> +{
> +	return machine && machine->env && !strcmp(machine->env->arch, arch);
> +}
> +

Broke 'perf top':

gdb perf
bt
bt
#0  __strcmp_sse2_unaligned () at ../sysdeps/x86_64/multiarch/strcmp-sse2-unaligned.S:31
#1  0x0000000000528b1e in machine__is (machine=0xc55548, arch=0x7d9058 "x86_64") at util/machine.c:2305
#2  0x0000000000528bbb in machine__get_kernel_start (machine=0xc55548) at util/machine.c:2329
#3  0x00000000004df894 in machine__kernel_start (machine=0xc55548) at util/machine.h:90
#4  0x00000000004df8e0 in machine__kernel_ip (machine=0xc55548, ip=140352692842292) at util/machine.h:96
#5  0x00000000004e3a9c in thread__find_map (thread=0x21f9de0, cpumode=2 '\002', addr=140352692842292, al=0x7fffffff8160)
    at util/event.c:1550
#6  0x00000000004e3c51 in machine__resolve (machine=0xc55548, al=0x7fffffff8160, sample=0x7fffffff8360) at util/event.c:1591
#7  0x000000000045a274 in perf_event__process_sample (tool=0x7fffffffa720, event=0x7fffea662878, evsel=0xc120e0, 
    sample=0x7fffffff8360, machine=0xc55548) at builtin-top.c:734
#8  0x000000000045a91c in perf_top__mmap_read_idx (top=0x7fffffffa720, idx=3) at builtin-top.c:872
#9  0x000000000045aa6b in perf_top__mmap_read (top=0x7fffffffa720) at builtin-top.c:898
#10 0x000000000045b460 in __cmd_top (top=0x7fffffffa720) at builtin-top.c:1167
#11 0x000000000045c973 in cmd_top (argc=0, argv=0x7fffffffe0e0) at builtin-top.c:1509
#12 0x00000000004ce403 in run_builtin (p=0xac5670 <commands+336>, argc=1, argv=0x7fffffffe0e0) at perf.c:303
#13 0x00000000004ce670 in handle_internal_command (argc=1, argv=0x7fffffffe0e0) at perf.c:355
#14 0x00000000004ce7c2 in run_argv (argcp=0x7fffffffdf3c, argv=0x7fffffffdf30) at perf.c:399
#15 0x00000000004ceb90 in main (argc=1, argv=0x7fffffffe0e0) at perf.c:543
(gdb) fr 1
#1  0x0000000000528b1e in machine__is (machine=0xc55548, arch=0x7d9058 "x86_64") at util/machine.c:2305
2305		return machine && machine->env && !strcmp(machine->env->arch, arch);
(gdb) list
2300	 * Compares the raw arch string. N.B. see instead perf_env__arch() if a
2301	 * normalized arch is needed.
2302	 */
2303	bool machine__is(struct machine *machine, const char *arch)
2304	{
2305		return machine && machine->env && !strcmp(machine->env->arch, arch);
2306	}
2307	
2308	int machine__get_kernel_start(struct machine *machine)
2309	{
(gdb) p machine
$1 = (struct machine *) 0xc55548
(gdb) p machine->env
$2 = (struct perf_env *) 0xc06400 <perf_env>
(gdb) p machine-env->arch
No symbol "env" in current context.
(gdb) p machine->env->arch
$3 = 0x0
(gdb)
