Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeEJTIn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:08:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:13930 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbeEJTIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:08:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,386,1520924400";
   d="scan'208";a="54133599"
From: "Hunter, Adrian" <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH RFC 07/19] perf tools: Workaround missing maps for
 x86_64 KPTI entry trampolines
Thread-Topic: [PATCH RFC 07/19] perf tools: Workaround missing maps for
 x86_64 KPTI entry trampolines
Thread-Index: AQHT54s87ilFYJKrpkuDghWXuk0TD6QnkIOAgAHDCbA=
Date: Thu, 10 May 2018 19:08:37 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C13DE9E@IRSMSX106.ger.corp.intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-8-git-send-email-adrian.hunter@intel.com>
 <20180509170717.GI13491@kernel.org>
In-Reply-To: <20180509170717.GI13491@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjUwNGNjNzEtNDdmMC00NDQzLWExZjAtMmQ5ZmNmNDZlYjhlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZGZZZVM1R2p1Z3o0ZklKVUw3WURCT2pvMk9HZjhFcXdZQ2hQNWlHQkdFeU0zVjdXU2t2SndOeW9cL0YwVHdJVlUifQ==
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> Sent: Wednesday, May 9, 2018 8:07 PM
> To: Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> <mingo@redhat.com>; Peter Zijlstra <peterz@infradead.org>; Andy
> Lutomirski <luto@kernel.org>; H. Peter Anvin <hpa@zytor.com>; Andi Kleen
> <ak@linux.intel.com>; Alexander Shishkin
> <alexander.shishkin@linux.intel.com>; Dave Hansen
> <dave.hansen@linux.intel.com>; Joerg Roedel <joro@8bytes.org>; Jiri Olsa
> <jolsa@redhat.com>; linux-kernel@vger.kernel.org; x86@kernel.org
> Subject: Re: [PATCH RFC 07/19] perf tools: Workaround missing maps for
> x86_64 KPTI entry trampolines
> 
> Em Wed, May 09, 2018 at 02:43:36PM +0300, Adrian Hunter escreveu:
> > On x86_64 the KPTI entry trampolines are not in the kernel map created
> > by perf tools. That results in the addresses having no symbols and
> > prevents annotation. It also causes Intel PT to have decoding errors
> > at the trampoline addresses. Workaround that by creating maps for the
> trampolines.
> > At present the kernel does not export information revealing where the
> > trampolines are. Until that happens, the addresses are hardcoded.
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/util/machine.c | 104
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/machine.h |   3 ++
> >  tools/perf/util/symbol.c  |  12 +++---
> >  3 files changed, 114 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 22047ff3cf2a..1bf15aa0b099 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -851,6 +851,110 @@ static int
> machine__get_running_kernel_start(struct machine *machine,
> >  	return 0;
> >  }
> >
> > +struct special_kernal_map {
> 
> s/kernal/kernel/
> 
> And "special"?

I have added comment:

/* Kernel-space maps that are not the main kernel map nor a module map */

And fixed kernal, and changed machine__is()

Revised patch set is here:

	http://git.infradead.org/users/ahunter/linux-perf.git/shortlog/refs/heads/perf-tools-kpti

which is the perf-tools-kpti branch of:

	git://git.infradead.org/users/ahunter/linux-perf.git

Let me know if you want me to post the workaround patches separately,
otherwise I will wait a bit before sending the patches again.

> 
> > +	u64 start;
> > +	u64 end;
> > +	u64 pgoff;
> > +};
> > +
> > +static int machine__create_special_kernel_map(struct machine
> *machine,
> > +					      struct dso *kernel,
> > +					      struct special_kernal_map *sm) {
> > +	struct kmap *kmap;
> > +	struct map *map;
> > +
> > +	map = map__new2(sm->start, kernel);
> > +	if (!map)
> > +		return -1;
> > +
> > +	map->end   = sm->end;
> > +	map->pgoff = sm->pgoff;
> > +
> > +	kmap = map__kmap(map);
> > +
> > +	kmap->kmaps = &machine->kmaps;
> > +
> > +	map_groups__insert(&machine->kmaps, map);
> > +
> > +	pr_debug2("Added special kernel map %" PRIx64 "-%" PRIx64 "\n",
> > +		  map->start, map->end);
> > +
> > +	map__put(map);
> > +
> > +	return 0;
> > +}
> > +
> > +static u64 find_entry_trampoline(struct dso *dso) {
> > +	struct {
> > +		const char *name;
> > +		u64 addr;
> > +	} syms[] = {
> > +		/* Duplicates are removed so lookup all aliases */
> > +		{"_entry_trampoline", 0},
> > +		{"__entry_trampoline_start", 0},
> > +		{"entry_SYSCALL_64_trampoline", 0},
> 
> We've been using named initializers consistently, so please change this
> to:
> 
> 	struct {
> 		const char *name;
> 		u64	   addr;
> 	} syms[] = {
> 		{ .name = "_entry_trampoline", },
> 		{ .name = "__entry_trampoline_start", },
> 		{ .name = "entry_SYSCALL_64_trampoline", },
> 	},
> 
> Also why do you have to lookup to all of them to them use just the first
> found? I.e. you say they are aliases, why not return the first symbol found,
> i.e. the above would be reduced to:
> 
> 	const char *syms[] = {
> 		"_entry_trampoline",
> 		"__entry_trampoline_start",
> 		"entry_SYSCALL_64_trampoline",
> 	},
> 
> And then:
> 
> 	struct symbol *sym = dso__first_symbol(dso);
> 	unsigned int i;
> 
> 	for (; sym; sym = dso__next_symbol(sym)) {
> 		if (sym->binding != STB_GLOBAL)
> 			continue;
> 		for (i = 0; i < ARRAY_SIZE(syms); i++) {
> 			if (!strcmp(sym->name, syms[i].name))
> 				return sym->start;
> 		}
> 	}
> 
> 	return 0;
> 
> > +	};
> > +	struct symbol *sym = dso__first_symbol(dso);
> > +	unsigned int i;
> > +
> > +	for (; sym; sym = dso__next_symbol(sym)) {
> > +		if (sym->binding != STB_GLOBAL)
> > +			continue;
> > +		for (i = 0; i < ARRAY_SIZE(syms); i++) {
> > +			if (!strcmp(sym->name, syms[i].name))
> > +				syms[i].addr = sym->start;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < ARRAY_SIZE(syms); i++) {
> > +		if (syms[i].addr)
> > +			return syms[i].addr;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * These values can be used for kernels that do not have symbols for
> > +the entry
> > + * trampolines in kallsyms.
> > + */
> > +#define X86_64_CPU_ENTRY_AREA_PER_CPU
> 	0xfffffe0000000000ULL
> > +#define X86_64_CPU_ENTRY_AREA_SIZE	0x2c000
> > +#define X86_64_ENTRY_TRAMPOLINE		0x6000
> > +
> > +/* Map x86_64 KPTI entry trampolines */ int
> > +machine__map_x86_64_entry_trampolines(struct machine *machine,
> > +					  struct dso *kernel)
> > +{
> > +	u64 pgoff = find_entry_trampoline(kernel);
> > +	int nr_cpus_avail = 0, cpu;
> > +
> > +	if (!pgoff)
> > +		return 0;
> > +
> > +	if (machine->env)
> > +		nr_cpus_avail = machine->env->nr_cpus_avail;
> > +
> > +	/* Add a 1 page map for each CPU's entry trampoline */
> > +	for (cpu = 0; cpu < nr_cpus_avail; cpu++) {
> > +		u64 va = X86_64_CPU_ENTRY_AREA_PER_CPU +
> > +			 cpu * X86_64_CPU_ENTRY_AREA_SIZE +
> > +			 X86_64_ENTRY_TRAMPOLINE;
> > +		struct special_kernal_map sm = {
> > +			.start = va,
> > +			.end   = va + page_size,
> > +			.pgoff = pgoff,
> > +		};
> > +
> > +		if (machine__create_special_kernel_map(machine, kernel,
> &sm) < 0)
> > +			return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int
> >  __machine__create_kernel_maps(struct machine *machine, struct dso
> > *kernel)  { diff --git a/tools/perf/util/machine.h
> > b/tools/perf/util/machine.h index b31d33b5aa2a..6e1c63d3a625 100644
> > --- a/tools/perf/util/machine.h
> > +++ b/tools/perf/util/machine.h
> > @@ -267,4 +267,7 @@ int machine__set_current_tid(struct machine
> *machine, int cpu, pid_t pid,
> >   */
> >  char *machine__resolve_kernel_addr(void *vmachine, unsigned long long
> > *addrp, char **modp);
> >
> > +int machine__map_x86_64_entry_trampolines(struct machine *machine,
> > +					  struct dso *kernel);
> > +
> >  #endif /* __PERF_MACHINE_H */
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c index
> > 4a39f4d0a174..c3a1a89a61cb 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1490,20 +1490,22 @@ int dso__load(struct dso *dso, struct map
> *map)
> >  		goto out;
> >  	}
> >
> > +	if (map->groups && map->groups->machine)
> > +		machine = map->groups->machine;
> > +	else
> > +		machine = NULL;
> > +
> >  	if (dso->kernel) {
> >  		if (dso->kernel == DSO_TYPE_KERNEL)
> >  			ret = dso__load_kernel_sym(dso, map);
> >  		else if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
> >  			ret = dso__load_guest_kernel_sym(dso, map);
> >
> > +		if (machine && machine__is(machine, "x86_64"))
> > +
> 	machine__map_x86_64_entry_trampolines(machine, dso);
> >  		goto out;
> >  	}
> >
> > -	if (map->groups && map->groups->machine)
> > -		machine = map->groups->machine;
> > -	else
> > -		machine = NULL;
> > -
> >  	dso->adjust_symbols = 0;
> >
> >  	if (perfmap) {
> > --
> > 1.9.1
