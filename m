Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeCJJvN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 04:51:13 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37715 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeCJJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 04:51:11 -0500
X-Google-Smtp-Source: AG47ELug+iXAS6IARS+QUiCdBlbrRzQHhZxSkUs+buKcBm2pQO71a3YJ7YZf3L0i3b0pKW9zSg7kQg==
Date: Sat, 10 Mar 2018 17:50:56 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2] perf machine: Fix load kernel symbol with '-k' option
Message-ID: <20180310095056.GA10251@leoy-ThinkPad-X240s>
References: <1520575523-3838-1-git-send-email-leo.yan@linaro.org>
 <20180309205600.GB16890@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309205600.GB16890@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Fri, Mar 09, 2018 at 09:56:00PM +0100, Jiri Olsa wrote:
> On Fri, Mar 09, 2018 at 02:05:23PM +0800, Leo Yan wrote:
> > On Hikey arm64 octa A53 platform, when use command './perf report -v
> > -k vmlinux --stdio' it outputs below error info, and it skips to load
> > kernel symbol and doesn't print symbol for event:
> > Failed to open [kernel.kallsyms]_text, continuing without symbols.
> > 
> > The regression is introduced by commit ("8c7f1bb37b29 perf machine: Move
> > kernel mmap name into struct machine"), which changes the logic for
> > machine mmap_name by removing function machine__mmap_name() and always
> > use 'machine->mmap_name'.  Comparing difference between
> > machine__mmap_name() and 'machine->mmap_name', the later one includes
> > the string for specified kernel vmlinux string with option '-k' in
> > command, but the old function machine__mmap_name() ignores vmlinux
> > path string.  As result, event's mmap file name doesn't match with
> > machine mmap file name anymore and it skips to load kernel symbol from
> > vmlinux file.
> > 
> > To resolve this issue, this patch adds extra checking for
> > 'symbol_conf.vmlinux_name', when it has been set string so we can know
> > it includes vmlinux path string specified for option '-k'. For this
> > case it sets 'is_kernel_mmap' to true and run into flow to load kernel
> > symbol from vmlinux.
> > 
> > This patch has been verified with two commands: './perf report -v
> > -k vmlinux --stdio' and './perf script -v -F cpu,event,ip,sym,symoff
> > -k vmlinux'.
> > 
> > Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/machine.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 12b7427..3125871 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -1299,9 +1299,18 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
> >  	else
> >  		kernel_type = DSO_TYPE_GUEST_KERNEL;
> >  
> > -	is_kernel_mmap = memcmp(event->mmap.filename,
> > -				machine->mmap_name,
> > -				strlen(machine->mmap_name) - 1) == 0;
> > +	/*
> > +	 * When symbol_conf.vmlinux_name is not NULL, it includes the specified
> > +	 * kernel vmlinux path with option '-k'.  So set 'is_kernel_mmap' to
> > +	 * true for creating machine symbol map.
> > +	 */
> > +	if (symbol_conf.vmlinux_name)
> > +		is_kernel_mmap = true;
> > +	else
> > +		is_kernel_mmap = memcmp(event->mmap.filename,
> > +					machine->mmap_name,
> > +					strlen(machine->mmap_name) - 1) == 0;
> > +
> >  	if (event->mmap.filename[0] == '/' ||
> >  	    (!is_kernel_mmap && event->mmap.filename[0] == '[')) {
> >  		map = machine__findnew_module_map(machine, event->mmap.start,
> 
> right, the mmap gets confused with the vmlinux path, but I wonder
> the fix should be not to include symbol_conf.vmlinux_name in the
> mmap_name like below.. untested

I tested below fixing at my side, and confirm your fixing also can
resolve this issue.  After reviewing the change, it's more neat than my
own change .  So you could add my test tag :)

Tested-by: Leo Yan <leo.yan@linaro.org>

BTW, I have a minor comment for code refactoring, it's up to you if
need or not and if need use a new patch for refactoring, please see below
inline comment.

Thanks,
Leo Yan

> ---
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 43fbbee409ec..f0cb72022177 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -51,15 +51,9 @@ static void machine__threads_init(struct machine *machine)
>  static int machine__set_mmap_name(struct machine *machine)
>  {
>  	if (machine__is_host(machine)) {
> -		if (symbol_conf.vmlinux_name)
> -			machine->mmap_name = strdup(symbol_conf.vmlinux_name);
> -		else
> -			machine->mmap_name = strdup("[kernel.kallsyms]");
> +		machine->mmap_name = strdup("[kernel.kallsyms]");
>  	} else if (machine__is_default_guest(machine)) {
> -		if (symbol_conf.default_guest_vmlinux_name)
> -			machine->mmap_name = strdup(symbol_conf.default_guest_vmlinux_name);
> -		else
> -			machine->mmap_name = strdup("[guest.kernel.kallsyms]");
> +		machine->mmap_name = strdup("[guest.kernel.kallsyms]");
>  	} else {
>  		if (asprintf(&machine->mmap_name, "[guest.kernel.kallsyms.%d]",
>  			 machine->pid) < 0)

Do you think below format is better or not?

 static int machine__set_mmap_name(struct machine *machine)
 {
-       if (machine__is_host(machine)) {
-               if (symbol_conf.vmlinux_name)
-                       machine->mmap_name = strdup(symbol_conf.vmlinux_name);
-               else
-                       machine->mmap_name = strdup("[kernel.kallsyms]");
-       } else if (machine__is_default_guest(machine)) {
-               if (symbol_conf.default_guest_vmlinux_name)
-                       machine->mmap_name = strdup(symbol_conf.default_guest_vmlinux_name);
-               else
-                       machine->mmap_name = strdup("[guest.kernel.kallsyms]");
-       } else {
-               if (asprintf(&machine->mmap_name, "[guest.kernel.kallsyms.%d]",
-                        machine->pid) < 0)
-                       machine->mmap_name = NULL;
-       }
+       if (machine__is_host(machine))
+               machine->mmap_name = strdup("[kernel.kallsyms]");
+       else if (machine__is_default_guest(machine))
+               machine->mmap_name = strdup("[guest.kernel.kallsyms]");
+       else if (asprintf(&machine->mmap_name, "[guest.kernel.kallsyms.%d]",
+                machine->pid) < 0)
+               machine->mmap_name = NULL;
 
        return machine->mmap_name ? 0 : -ENOMEM;
 }

> @@ -794,9 +788,15 @@ static struct dso *machine__get_kernel(struct machine *machine)
>  	struct dso *kernel;
>  
>  	if (machine__is_host(machine)) {
> +		if (symbol_conf.vmlinux_name)
> +			vmlinux_name = symbol_conf.vmlinux_name;
> +
>  		kernel = machine__findnew_kernel(machine, vmlinux_name,
>  						 "[kernel]", DSO_TYPE_KERNEL);
>  	} else {
> +		if (symbol_conf.default_guest_vmlinux_name)
> +			vmlinux_name = symbol_conf.default_guest_vmlinux_name;
> +
>  		kernel = machine__findnew_kernel(machine, vmlinux_name,
>  						 "[guest.kernel]",
>  						 DSO_TYPE_GUEST_KERNEL);
