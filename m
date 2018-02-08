Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBHAeW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 19:34:22 -0500
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:39040 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeBHAeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 19:34:21 -0500
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Thu, 8 Feb 2018 09:34:18 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Subject: Re: [PATCH 06/10] perf tools: Use machine__set_kernel_mmap instead
 of map_groups__fixup_end
Message-ID: <20180208003418.GA24686@sejong>
References: <20180207144838.16823-1-jolsa@kernel.org>
 <20180207144838.16823-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180207144838.16823-7-jolsa@kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Wed, Feb 07, 2018 at 03:48:34PM +0100, Jiri Olsa wrote:
> The machine__set_kernel_mmap does the same job as map_groups__fixup_end
> when used on kernel maps within machine__create_kernel_maps call.

I'm not sure.  Modules have end address after machine__create_module()
but vmlinux_maps is not.  So map_groups__fixup() will set the end of
vmlinux_maps but with this change it will have ~0ULL.

Thanks,
Namhyung


> 
> This way we can also remove map_groups__fixup_end function, because there's
> no user to it. Also moving machine__set_kernel_mmap up in code, so we don't
> need forward declaration.
> 
> Link: http://lkml.kernel.org/n/tip-9kqrs3bsojwe4ktwpnkxc6g4@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/machine.c | 49 ++++++++++++++++++-----------------------------
>  1 file changed, 19 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 7563b750137d..49ebd451151a 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1028,13 +1028,6 @@ int machine__load_vmlinux_path(struct machine *machine, enum map_type type)
>  	return ret;
>  }
>  
> -static void map_groups__fixup_end(struct map_groups *mg)
> -{
> -	int i;
> -	for (i = 0; i < MAP__NR_TYPES; ++i)
> -		__map_groups__fixup_end(mg, i);
> -}
> -
>  static char *get_kernel_version(const char *root_dir)
>  {
>  	char version[PATH_MAX];
> @@ -1220,6 +1213,24 @@ static int machine__create_modules(struct machine *machine)
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
> +	}
> +}
> +
>  int machine__create_kernel_maps(struct machine *machine)
>  {
>  	struct dso *kernel = machine__get_kernel(machine);
> @@ -1244,11 +1255,6 @@ int machine__create_kernel_maps(struct machine *machine)
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
> @@ -1257,27 +1263,10 @@ int machine__create_kernel_maps(struct machine *machine)
>  		}
>  	}
>  
> +	machine__set_kernel_mmap(machine, addr, 0);
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
> -- 
> 2.13.6
> 
