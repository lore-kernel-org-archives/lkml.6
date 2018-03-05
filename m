Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeCEVvY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:51:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932084AbeCEVvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:51:22 -0500
Date: Mon, 5 Mar 2018 22:51:18 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
Subject: Re: [RFC V2 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
Message-ID: <20180305215118.GB31349@krava>
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
 <1520034092-35275-2-git-send-email-agustinv@codeaurora.org>
 <20180303143436.GA14563@krava>
 <20180304171245.GB25017@tassilo.jf.intel.com>
 <20180304181010.GA7030@krava>
 <1ddac3f4900267b0c9a69ef4c598be51@codeaurora.org>
 <20180305190937.GA31349@krava>
 <94ecc9b1337d15fe4634da56cb428738@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94ecc9b1337d15fe4634da56cb428738@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 03:10:43PM -0500, Agustin Vega-Frias wrote:
> On 2018-03-05 14:09, Jiri Olsa wrote:
> > On Mon, Mar 05, 2018 at 10:08:18AM -0500, Agustin Vega-Frias wrote:
> > > On 2018-03-04 13:10, Jiri Olsa wrote:
> > > > On Sun, Mar 04, 2018 at 09:12:45AM -0800, Andi Kleen wrote:
> > > > > > > +#include <fnmatch.h>
> > > > > > >  #include <linux/compiler.h>
> > > > > > >  #include <linux/list.h>
> > > > > > >  #include <linux/types.h>
> > > > > > > @@ -241,7 +242,7 @@ PE_NAME opt_event_config
> > > > > > >  			if (!strncmp(name, "uncore_", 7) &&
> > > > > > >  			    strncmp($1, "uncore_", 7))
> > > > > > >  				name += 7;
> > > > > > > -			if (!strncmp($1, name, strlen($1))) {
> > > > > > > +			if (!strncmp($1, name, strlen($1)) || !fnmatch($1, name, 0)) {
> > > > > >
> > > > > > could we now get rid of the strncmp in here and keep the
> > > > > > glob matching only?
> > > > >
> > > > > That would break existing command lines. Not a good idea.
> > > >
> > > > I hoped that only you guys are using this and would rewrite your scripts
> > > > ;-)
> > > >
> > > > I had no idea there's fnmatch func before.. too bad, ok
> > > >
> > > > jirka
> > > 
> > > An option to keep backward compatibility and consistency would be
> > > to wrap the pattern/string passed in *'s, that way we can just use
> > > fnmatch and have all the examples Jiri brought up work the same.
> > > With that in place we can actually also drop the explicit ignoring
> > > of the uncore_ prefix since the globbing would take care of that.
> > 
> > I don't mind the strcmp as such, I wanted to get rid of the wildcard
> > matching without using '*' ... but as Andi said it's been out
> > there and it's been a while, so let's keep it
> > 
> > but if there's a way to make it simpler, let's go for it
> > 
> > thanks,
> > jirka
> 
> Sounds good. I have a new version ready (see sample output below).
> But I wanted to ping about the other two patches before submitting.
> Any feedback on those?

the rest looks ok to me, so does the output below

thanks,
jirka

> 
> Thanks,
> Agustín
> 
> PS:
> Sample output:
> 
> $ ./perf stat -a -e imc/umask=0x3,event=0x4/ --no-merge ls -l > /dev/null
> 
>  Performance counter stats for 'system wide':
> 
>              2,613      uncore_imc_0/umask=0x3,event=0x4/
>              2,736      uncore_imc_1/umask=0x3,event=0x4/
>              2,671      uncore_imc_2/umask=0x3,event=0x4/
>              2,508      uncore_imc_3/umask=0x3,event=0x4/
>              2,439      uncore_imc_4/umask=0x3,event=0x4/
>              2,465      uncore_imc_5/umask=0x3,event=0x4/
> 
>        0.004159243 seconds time elapsed
> 
> $ ./perf stat -a -e *imc/umask=0x3,event=0x4/ --no-merge ls -l > /dev/null
> 
>  Performance counter stats for 'system wide':
> 
>              2,704      uncore_imc_0/umask=0x3,event=0x4/
>              2,601      uncore_imc_1/umask=0x3,event=0x4/
>              2,625      uncore_imc_2/umask=0x3,event=0x4/
>              2,370      uncore_imc_3/umask=0x3,event=0x4/
>              2,485      uncore_imc_4/umask=0x3,event=0x4/
>              2,431      uncore_imc_5/umask=0x3,event=0x4/
> 
>        0.002716763 seconds time elapsed
> 
> $ ./perf stat -a -e imc*/umask=0x3,event=0x4/ --no-merge ls -l > /dev/null
> 
>  Performance counter stats for 'system wide':
> 
>              1,294      uncore_imc_0/umask=0x3,event=0x4/
>              1,303      uncore_imc_1/umask=0x3,event=0x4/
>              1,242      uncore_imc_2/umask=0x3,event=0x4/
>              1,125      uncore_imc_3/umask=0x3,event=0x4/
>              1,137      uncore_imc_4/umask=0x3,event=0x4/
>              1,159      uncore_imc_5/umask=0x3,event=0x4/
> 
>        0.002790441 seconds time elapsed
> 
> $ ./perf stat -a -e *imc*/umask=0x3,event=0x4/ --no-merge ls -l > /dev/null
> 
>  Performance counter stats for 'system wide':
> 
>              1,524      uncore_imc_0/umask=0x3,event=0x4/
>              1,508      uncore_imc_1/umask=0x3,event=0x4/
>              1,501      uncore_imc_2/umask=0x3,event=0x4/
>              1,405      uncore_imc_3/umask=0x3,event=0x4/
>              1,427      uncore_imc_4/umask=0x3,event=0x4/
>              1,450      uncore_imc_5/umask=0x3,event=0x4/
> 
>        0.002720907 seconds time elapsed
> 
> -- 
> Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm
> Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
> Foundation Collaborative Project.
