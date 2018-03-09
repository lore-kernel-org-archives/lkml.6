Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932462AbeCIRfq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:35:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932189AbeCIRfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:35:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD4A205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 9 Mar 2018 14:34:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 9/9] perf c2c report: Add cacheline address count column
Message-ID: <20180309173441.GG8347@kernel.org>
References: <20180309101442.9224-1-jolsa@kernel.org>
 <20180309101442.9224-10-jolsa@kernel.org>
 <20180309145643.GA8347@kernel.org>
 <20180309162828.GA16890@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309162828.GA16890@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 09, 2018 at 05:28:28PM +0100, Jiri Olsa escreveu:
> On Fri, Mar 09, 2018 at 11:56:43AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Mar 09, 2018 at 11:14:42AM +0100, Jiri Olsa escreveu:
> > > Adding the 'PA cnt' column grouped under data cacheline address.
> > > 
> > > It shows how many times the physical addresses changed for the
> > > hist entry. It does not show the number of different physical
> > > addresses for entry, because we don't store those. We only track
> > > the number of times we got different address than we currently
> > > hold, which is not expensive and gives similar info.
> > > 
> > >   $ perf c2c report --stdio
> > > 
> > >   #        ----------- Cacheline ----------    Total      Tot  ----- LLC Load Hitm -----
> > >   # Index             Address  Node  PA cnt  records     Hitm    Total      Lcl      Rmt
> > >   # .....  ..................  ....  ......  .......  .......  .......  .......  .......
> > >   #
> > 
> > 
> > I'm adding this to the docs, ack?
> 
> nope.. those fields are c2c report only.. hardcoded
> 
> I'm preparing a change to share c2c fields with the
> general report.. should come with other perf mem
> changes later

Ok, dropping that then
 
> jirka
> 
> > 
> > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> > index cba16d8a970e..f4a280428e28 100644
> > --- a/tools/perf/Documentation/perf-report.txt
> > +++ b/tools/perf/Documentation/perf-report.txt
> > @@ -127,7 +127,7 @@ OPTIONS
> >  
> >  	If the --mem-mode option is used, the following sort keys are also available
> >  	(incompatible with --branch-stack):
> > -	symbol_daddr, dso_daddr, locked, tlb, mem, snoop, dcacheline.
> > +	symbol_daddr, dso_daddr, locked, tlb, mem, snoop, dcacheline, dcacheline_count.
> >  
> >  	- symbol_daddr: name of data symbol being executed on at the time of sample
> >  	- dso_daddr: name of library or module containing the data being executed
> > @@ -137,6 +137,7 @@ OPTIONS
> >  	- mem: type of memory access for the data at the time of the sample
> >  	- snoop: type of snoop (if any) for the data at the time of the sample
> >  	- dcacheline: the cacheline the data address is on at the time of the sample
> > +	- dcacheline_count: the number of physical addresses sampled for this dcacheline
> >  	- phys_daddr: physical address of data being executed on at the time of sample
> >  
> >  	And the default sort keys are changed to local_weight, mem, sym, dso,
