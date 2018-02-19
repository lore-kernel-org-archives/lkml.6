Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeBSCUk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:20:40 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:39025 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeBSCUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:20:39 -0500
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 19 Feb 2018 11:20:36 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Subject: Re: [PATCH 6/9] perf tools: Don't search for active kernel start in
 __machine__create_kernel_maps
Message-ID: <20180219022036.GB1583@sejong>
References: <20180215122635.24029-1-jolsa@kernel.org>
 <20180215122635.24029-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180215122635.24029-7-jolsa@kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri and Arnaldo,

On Thu, Feb 15, 2018 at 01:26:32PM +0100, Jiri Olsa wrote:
> We should not search for kernel start address in
> __machine__create_kernel_maps function, because it's being
> used in 'report' code path, where we are interested in kernel
> MMAP data address instead of in current kernel address
> 
> The __machine__create_kernel_maps serves purely for creating
> the machines kernel maps and setting up the kmap group. The
> report code path then sets the address based on the data from
> kernel MMAP event in machine__set_kernel_mmap function.
> 
> The kallsyms search address logic is used for test code, that
> calls machine__create_kernel_maps to get current maps and calls
> machine__get_running_kernel_start to get kernel starting address.
> 
> Using machine__set_kernel_mmap to se the kernel maps start
> address and moving map_groups__fixup_end to be call when
> all maps are in place.
> 
> Also making __machine__create_kernel_maps static, because there's
> no external user.
> 
> Link: http://lkml.kernel.org/n/tip-37lmdjzh8dwq03golnk7hgkd@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/machine.c | 55 ++++++++++++++++++++++-------------------------
>  tools/perf/util/machine.h |  1 -
>  2 files changed, 26 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 292e70c774bd..2db8d7dd0f80 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -856,13 +856,10 @@ static int machine__get_running_kernel_start(struct machine *machine,
>  	return 0;
>  }
>  
> -int __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
> +static int
> +__machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
>  {
>  	int type;
> -	u64 start = 0;
> -
> -	if (machine__get_running_kernel_start(machine, NULL, &start))
> -		return -1;
>  
>  	/* In case of renewal the kernel map, destroy previous one */
>  	machine__destroy_kernel_maps(machine);
> @@ -871,7 +868,7 @@ int __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
>  		struct kmap *kmap;
>  		struct map *map;
>  
> -		machine->vmlinux_maps[type] = map__new2(start, kernel, type);
> +		machine->vmlinux_maps[type] = map__new2(0, kernel, type);
>  		if (machine->vmlinux_maps[type] == NULL)
>  			return -1;
>  
> @@ -1222,6 +1219,24 @@ static int machine__create_modules(struct machine *machine)
>  	return 0;
>  }
>  
> +static void machine__set_kernel_mmap(struct machine *machine,
> +				     u64 start, u64 end)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAP__NR_TYPES; i++) {
> +		machine->vmlinux_maps[i]->start = start;
> +		machine->vmlinux_maps[i]->end   = end;
> +
> +		/*
> +		 * Be a bit paranoid here, some perf.data file came with
> +		 * a zero sized synthesized MMAP event for the kernel.
> +		 */
> +		if (machine->vmlinux_maps[i]->end == 0)
> +			machine->vmlinux_maps[i]->end = ~0ULL;

Hmm.. this will make map_groups__fixup_end() below not working since
it only updates if the end address of a map is zero.

And about the paranoid check, AFAIK the only case it cares is the
machine__process_kernel_mmap_event() which calls it with
event->mmap.start and event->mmap.start + event->mmap.len.  Thus, in
order for the end to be zero, both start and len should be zero.  Then
I think this condition can be changed like below:

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fe27ef55cbb9..c8acb603c359 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1226,7 +1226,7 @@ static void machine__set_kernel_mmap(struct machine *machine,
                 * Be a bit paranoid here, some perf.data file came with
                 * a zero sized synthesized MMAP event for the kernel.
                 */
-               if (machine->vmlinux_maps[i]->end == 0)
+               if (start == 0 && end == 0)
                        machine->vmlinux_maps[i]->end = ~0ULL;
        }
 }



> +	}
> +}
> +
>  int machine__create_kernel_maps(struct machine *machine)
>  {
>  	struct dso *kernel = machine__get_kernel(machine);
> @@ -1246,40 +1261,22 @@ int machine__create_kernel_maps(struct machine *machine)
>  				 "continuing anyway...\n", machine->pid);
>  	}
>  
> -	/*
> -	 * Now that we have all the maps created, just set the ->end of them:
> -	 */
> -	map_groups__fixup_end(&machine->kmaps);
> -
>  	if (!machine__get_running_kernel_start(machine, &name, &addr)) {
>  		if (name &&
>  		    maps__set_kallsyms_ref_reloc_sym(machine->vmlinux_maps, name, addr)) {
>  			machine__destroy_kernel_maps(machine);
>  			return -1;
>  		}
> +		machine__set_kernel_mmap(machine, addr, 0);
>  	}
>  
> +	/*
> +	 * Now that we have all the maps created, just set the ->end of them:
> +	 */
> +	map_groups__fixup_end(&machine->kmaps);

With above change, I think it work.  But the whole point of the above
is to set the end address of vmlinux and modules.  And now we don't
need it for modules thanks to modules__parse() for passing the size.

So we only needs to update the end address of vmlinux using the start
address of the first module.  What about this then?

Thanks,
Namhyung


diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fe27ef55cbb9..022f0539b750 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1021,13 +1021,6 @@ int machine__load_vmlinux_path(struct machine *machine, enum map_type type)
        return ret;
 }
 
-static void map_groups__fixup_end(struct map_groups *mg)
-{
-       int i;
-       for (i = 0; i < MAP__NR_TYPES; ++i)
-               __map_groups__fixup_end(mg, i);
-}
-
 static char *get_kernel_version(const char *root_dir)
 {
        char version[PATH_MAX];
@@ -1235,6 +1228,7 @@ int machine__create_kernel_maps(struct machine *machine)
 {
        struct dso *kernel = machine__get_kernel(machine);
        const char *name = NULL;
+       struct map *map;
        u64 addr = 0;
        int ret;
 
@@ -1261,13 +1255,13 @@ int machine__create_kernel_maps(struct machine *machine)
                        machine__destroy_kernel_maps(machine);
                        return -1;
                }
-               machine__set_kernel_mmap(machine, addr, 0);
        }
 
-       /*
-        * Now that we have all the maps created, just set the ->end of them:
-        */
-       map_groups__fixup_end(&machine->kmaps);
+       /* update end address of the kernel map using adjacent module address */
+       map = map__next(machine__kernel_map(machine));
+       if (map)
+               machine__set_kernel_mmap(machine, addr, map->start);
+
        return 0;
 }
 


>  	return 0;
>  }
>  
> -static void machine__set_kernel_mmap(struct machine *machine,
> -				     u64 start, u64 end)
> -{
> -	int i;
> -
> -	for (i = 0; i < MAP__NR_TYPES; i++) {
> -		machine->vmlinux_maps[i]->start = start;
> -		machine->vmlinux_maps[i]->end   = end;
> -
> -		/*
> -		 * Be a bit paranoid here, some perf.data file came with
> -		 * a zero sized synthesized MMAP event for the kernel.
> -		 */
> -		if (machine->vmlinux_maps[i]->end == 0)
> -			machine->vmlinux_maps[i]->end = ~0ULL;
> -	}
> -}
> -
>  static bool machine__uses_kcore(struct machine *machine)
>  {
>  	struct dso *dso;
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index cb0a20f3a96b..50d587d34459 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -238,7 +238,6 @@ size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
>  				     bool (skip)(struct dso *dso, int parm), int parm);
>  
>  void machine__destroy_kernel_maps(struct machine *machine);
> -int __machine__create_kernel_maps(struct machine *machine, struct dso *kernel);
>  int machine__create_kernel_maps(struct machine *machine);
>  
>  int machines__create_kernel_maps(struct machines *machines, pid_t pid);
> -- 
> 2.13.6
> 
