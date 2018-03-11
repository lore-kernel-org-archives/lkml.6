Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbeCKTtT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:49:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932161AbeCKTtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:49:18 -0400
Date: Sun, 11 Mar 2018 20:49:12 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2] perf machine: Fix load kernel symbol with '-k' option
Message-ID: <20180311194912.GA13895@krava>
References: <1520575523-3838-1-git-send-email-leo.yan@linaro.org>
 <20180309205600.GB16890@krava>
 <20180310095056.GA10251@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310095056.GA10251@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 05:50:56PM +0800, Leo Yan wrote:

SNIP

> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index 12b7427..3125871 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -1299,9 +1299,18 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
> > >  	else
> > >  		kernel_type = DSO_TYPE_GUEST_KERNEL;
> > >  
> > > -	is_kernel_mmap = memcmp(event->mmap.filename,
> > > -				machine->mmap_name,
> > > -				strlen(machine->mmap_name) - 1) == 0;
> > > +	/*
> > > +	 * When symbol_conf.vmlinux_name is not NULL, it includes the specified
> > > +	 * kernel vmlinux path with option '-k'.  So set 'is_kernel_mmap' to
> > > +	 * true for creating machine symbol map.
> > > +	 */
> > > +	if (symbol_conf.vmlinux_name)
> > > +		is_kernel_mmap = true;
> > > +	else
> > > +		is_kernel_mmap = memcmp(event->mmap.filename,
> > > +					machine->mmap_name,
> > > +					strlen(machine->mmap_name) - 1) == 0;
> > > +
> > >  	if (event->mmap.filename[0] == '/' ||
> > >  	    (!is_kernel_mmap && event->mmap.filename[0] == '[')) {
> > >  		map = machine__findnew_module_map(machine, event->mmap.start,
> > 
> > right, the mmap gets confused with the vmlinux path, but I wonder
> > the fix should be not to include symbol_conf.vmlinux_name in the
> > mmap_name like below.. untested
> 
> I tested below fixing at my side, and confirm your fixing also can
> resolve this issue.  After reviewing the change, it's more neat than my
> own change .  So you could add my test tag :)
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>

thanks

SNIP

>  static int machine__set_mmap_name(struct machine *machine)
>  {
> -       if (machine__is_host(machine)) {
> -               if (symbol_conf.vmlinux_name)
> -                       machine->mmap_name = strdup(symbol_conf.vmlinux_name);
> -               else
> -                       machine->mmap_name = strdup("[kernel.kallsyms]");
> -       } else if (machine__is_default_guest(machine)) {
> -               if (symbol_conf.default_guest_vmlinux_name)
> -                       machine->mmap_name = strdup(symbol_conf.default_guest_vmlinux_name);
> -               else
> -                       machine->mmap_name = strdup("[guest.kernel.kallsyms]");
> -       } else {
> -               if (asprintf(&machine->mmap_name, "[guest.kernel.kallsyms.%d]",
> -                        machine->pid) < 0)
> -                       machine->mmap_name = NULL;
> -       }
> +       if (machine__is_host(machine))
> +               machine->mmap_name = strdup("[kernel.kallsyms]");
> +       else if (machine__is_default_guest(machine))
> +               machine->mmap_name = strdup("[guest.kernel.kallsyms]");
> +       else if (asprintf(&machine->mmap_name, "[guest.kernel.kallsyms.%d]",
> +                machine->pid) < 0)
> +               machine->mmap_name = NULL;

yea, that looks better.. will change

jirka
