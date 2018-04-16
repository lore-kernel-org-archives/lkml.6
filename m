Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755240AbeDPNv3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754834AbeDPNv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:51:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB39D2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 16 Apr 2018 10:51:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH] perf tools: set kernel end address properly
Message-ID: <20180416135125.GA23802@kernel.org>
References: <20180416042240.21528-1-namhyung@kernel.org>
 <20180416092345.GA23274@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416092345.GA23274@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 16, 2018 at 11:23:45AM +0200, Jiri Olsa escreveu:
> On Mon, Apr 16, 2018 at 01:22:40PM +0900, Namhyung Kim wrote:
> > The map_groups__fixup_end() was called to set end addresses of kernel
> > map and module maps.  But now machine__create_modules() is set the end
> > address of modules properly so the only remaining piece is the kernel
> > map.  We can set it with adjacent module's address directly instead of
> > calling the map_groups__fixup_end().  If there's no module after the
> > kernel map, the end address will be ~0ULL.

I wonder if it wouldn't be better to have it as last symbol + PAGE_SIZE
or something like that...

But, anyway, Kim, does this fix things for you? Can I have your
Tested-by?

> > Reported-by: Kim Phillips <kim.phillips@arm.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> looks good
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/machine.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 2eca8478e24f..be328416de61 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -1019,13 +1019,6 @@ int machine__load_vmlinux_path(struct machine *machine, enum map_type type)
> >  	return ret;
> >  }
> >  
> > -static void map_groups__fixup_end(struct map_groups *mg)
> > -{
> > -	int i;
> > -	for (i = 0; i < MAP__NR_TYPES; ++i)
> > -		__map_groups__fixup_end(mg, i);
> > -}
> > -
> >  static char *get_kernel_version(const char *root_dir)
> >  {
> >  	char version[PATH_MAX];
> > @@ -1233,7 +1226,9 @@ int machine__create_kernel_maps(struct machine *machine)
> >  {
> >  	struct dso *kernel = machine__get_kernel(machine);
> >  	const char *name = NULL;
> > +	struct map *map;
> >  	u64 addr = 0;
> > +	u64 end = ~0ULL;
> >  	int ret;
> >  
> >  	if (kernel == NULL)
> > @@ -1259,13 +1254,14 @@ int machine__create_kernel_maps(struct machine *machine)
> >  			machine__destroy_kernel_maps(machine);
> >  			return -1;
> >  		}
> > -		machine__set_kernel_mmap(machine, addr, 0);
> >  	}
> >  
> > -	/*
> > -	 * Now that we have all the maps created, just set the ->end of them:
> > -	 */
> > -	map_groups__fixup_end(&machine->kmaps);
> > +	/* update end address of the kernel map using adjacent module address */
> > +	map = map__next(machine__kernel_map(machine));
> > +	if (map)
> > +		end = map->start;
> > +
> > +	machine__set_kernel_mmap(machine, addr, end);
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.16.2
> > 
