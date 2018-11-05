Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF76C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFDD204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFDD204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeKFFOi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:14:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:27046 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeKFFOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:14:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 11:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,469,1534834800"; 
   d="scan'208";a="247192229"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by orsmga004.jf.intel.com with ESMTP; 05 Nov 2018 11:53:19 -0800
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.163]) by
 irsmsx105.ger.corp.intel.com ([169.254.7.144]) with mapi id 14.03.0415.000;
 Mon, 5 Nov 2018 19:53:18 +0000
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: RE: [PATCH 1/5] perf tools: Add fallback functions for cases where
 cpumode is insufficient
Thread-Topic: [PATCH 1/5] perf tools: Add fallback functions for cases where
 cpumode is insufficient
Thread-Index: AQHUcPn4AJzKnLLQPUuuQOazd3tPPKVBeFYAgAAcsBCAAAangIAAAQmA
Date:   Mon, 5 Nov 2018 19:53:17 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C3133B4@IRSMSX106.ger.corp.intel.com>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
 <20181031091043.23465-2-adrian.hunter@intel.com>
 <20181105172946.GH11147@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C313381@IRSMSX106.ger.corp.intel.com>
 <20181105193615.GG7077@kernel.org>
In-Reply-To: <20181105193615.GG7077@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWYwZGY5NzMtNTE2Yi00NTg2LWEzZTEtOWIwNDQyZGM4ZDYyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWVphSWJFRHRmXC9RZnVyb1NkOEZNejNXb2VpZ3dUa05ScE1ZZE9qMUZxeHpob2RmVUxobzRlU1dqU00wb1lcL3RnIn0=
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> Sent: Monday, November 5, 2018 9:36 PM
> To: Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>; Andi Kleen <ak@linux.intel.com>; linux-
> kernel@vger.kernel.org; leo.yan@linaro.org; David Miller
> <davem@davemloft.net>; Mathieu Poirier <mathieu.poirier@linaro.org>
> Subject: Re: [PATCH 1/5] perf tools: Add fallback functions for cases where
> cpumode is insufficient
> 
> Em Mon, Nov 05, 2018 at 07:21:44PM +0000, Hunter, Adrian escreveu:
> > > In Monday, November 5, 2018 7:30 PM, Arnaldo Carvalho de Melo wrote
> <SNIP>
> > > > +struct map *thread__find_map_fallback(struct thread *thread, u8
> > > cpumode,
> > > > +				      u64 addr, struct addr_location *al) {
> 
> > > You named one as _fallback...
> 
> > > > +	struct map *map = thread__find_map(thread, cpumode, addr, al);
> > > > +	struct machine *machine = thread->mg->machine;
> > > > +	u8 addr_cpumode = machine__addr_cpumode(machine, cpumode,
> > > addr);
> > > > +
> > > > +	if (map || addr_cpumode == cpumode)
> > > > +		return map;
> > > > +
> > > > +	return thread__find_map(thread, addr_cpumode, addr, al); }
> > > > +
> > > >  struct symbol *thread__find_symbol(struct thread *thread, u8
> cpumode,
> > > >  				   u64 addr, struct addr_location *al)  { @@ -
> > > 1585,6 +1603,15 @@
> > > > struct symbol *thread__find_symbol(struct thread *thread, u8
> cpumode,
> > > >  	return al->sym;
> > > >  }
> 
> > > > +struct symbol *thread__find_symbol_fb(struct thread *thread, u8
> > > cpumode,
> > > > +				      u64 addr, struct addr_location *al)
> 
> > > ... and the other as _fb, make it consistent, please.
> 
> > ok
> 
> > > > +{
> > > > +	al->sym = NULL;
> > > > +	if (thread__find_map_fallback(thread, cpumode, addr, al))
> > > > +		al->sym = map__find_symbol(al->map, al->addr);
> > > > +	return al->sym;
> > > > +}
> 
> > > >  /*
> > > >   * Callers need to drop the reference to al->thread, obtained in
> > > >   * machine__findnew_thread()
> > > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > > index 111ae858cbcb..04edc0eac376 100644
> > > > --- a/tools/perf/util/machine.c
> > > > +++ b/tools/perf/util/machine.c
> > > > @@ -2542,6 +2542,46 @@ int machine__get_kernel_start(struct
> > > > machine
> > > *machine)
> > > >  	return err;
> > > >  }
> 
> > > > +/*
> > > > + * machine__single_ku_as - Machine has same address space for
> > > > +kernel
> > > and user.
> > > > + * @machine: machine object
> > > > + *
> > > > + * Some architectures have a single address space for kernel and
> > > > +user addresses,
> > > > + * which makes it possible to determine if an address is in
> > > > +kernel space or user
> > > > + * space.
> > > > + */
> > > > +static bool machine__single_ku_as(struct machine *machine) {
> > > > +	return strcmp(perf_env__arch(machine->env), "sparc"); }
> 
> > > Can we avoid having this strcmp be done repeatedly?
> 
> > It is only done if there are mapping errors
> 
> >  > Can we avoid having this strcmp be done repeatedly? I.e. just make
> > this a
> > > boolean initialized at session start, when machine->env is setup, so
> > > we'd
> > > have:
> 
> > >    machine->single_address_space
> 
> > > Instead of a function?
> 
> > Sure  thing.
> 
> Thanks
> 
> > >
> > > Also have you considered making this fallback to be performed only
> > > from code that is that arch specific?
> > >
> > > I.e. the code that supports branch samples/stacks is x86_86 specific
> > > at this point and thus only in that case we would call the routines
> > > that perform the fallback, which, in turn, wouldn't need to check for
> "sparc"?
> 
> > I will look at it, but theoretically someone could be processing x86
> > data but doing it on a machine of a different architecture.
> 
> Right, that should be supported, yes. What I meant was that when
> processing perf.data file with samples where the cpumode can't be inferred,
> we should use the fallback routines.
> 
> It is super unfortunate that we have addresses without a accompanying
> cpumode :-\ Don't you think those coulde be fixed somehow? If this comes
> from things synthesized from Intel PT traces, then we can use the address
> ranges for kernel/userspace to derive that before hitting the core code, that
> would be fed with addr/cpumode pairs, just like we have hdr.misc &
> USER/KERNEL and the PERF_CONTEXT_ markers in callchains.

Yes we will probably need to look at that, but at the moment I would like a fix for stable.
