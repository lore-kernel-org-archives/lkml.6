Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDCDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726BD20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yqpBdgK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726BD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbeKFE5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387693AbeKFE5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:57:44 -0500
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E2CB20700;
        Mon,  5 Nov 2018 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541446587;
        bh=5CsF3LZxVX6u2adx9GegquViSEsxxpYnlq0KC1BOZXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqpBdgK5UERzUxGsIcmh4gW55tBLZ/Bh5O/rSYXgHnHah/5xCImh0gWiyLSnjLwTp
         jALctBwyN1rz8rBBqKrK+/cwL7RDrYdJ80FSyyuZCbaPaZpmPmysEcKPVMCFKr3bXy
         pCp5efMCv8Ch6YFLCFvXzAOXc0bMKMV0AupNBu8M=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 2C9C4142D18; Mon,  5 Nov 2018 16:36:15 -0300 (-03)
Date:   Mon, 5 Nov 2018 16:36:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 1/5] perf tools: Add fallback functions for cases where
 cpumode is insufficient
Message-ID: <20181105193615.GG7077@kernel.org>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
 <20181031091043.23465-2-adrian.hunter@intel.com>
 <20181105172946.GH11147@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C313381@IRSMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C313381@IRSMSX106.ger.corp.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 05, 2018 at 07:21:44PM +0000, Hunter, Adrian escreveu:
> > In Monday, November 5, 2018 7:30 PM, Arnaldo Carvalho de Melo wrote
<SNIP>
> > > +struct map *thread__find_map_fallback(struct thread *thread, u8
> > cpumode,
> > > +				      u64 addr, struct addr_location *al) {

> > You named one as _fallback...

> > > +	struct map *map = thread__find_map(thread, cpumode, addr, al);
> > > +	struct machine *machine = thread->mg->machine;
> > > +	u8 addr_cpumode = machine__addr_cpumode(machine, cpumode,
> > addr);
> > > +
> > > +	if (map || addr_cpumode == cpumode)
> > > +		return map;
> > > +
> > > +	return thread__find_map(thread, addr_cpumode, addr, al); }
> > > +
> > >  struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
> > >  				   u64 addr, struct addr_location *al)  { @@ -
> > 1585,6 +1603,15 @@
> > > struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
> > >  	return al->sym;
> > >  }

> > > +struct symbol *thread__find_symbol_fb(struct thread *thread, u8
> > cpumode,
> > > +				      u64 addr, struct addr_location *al)

> > ... and the other as _fb, make it consistent, please.

> ok

> > > +{
> > > +	al->sym = NULL;
> > > +	if (thread__find_map_fallback(thread, cpumode, addr, al))
> > > +		al->sym = map__find_symbol(al->map, al->addr);
> > > +	return al->sym;
> > > +}

> > >  /*
> > >   * Callers need to drop the reference to al->thread, obtained in
> > >   * machine__findnew_thread()
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index 111ae858cbcb..04edc0eac376 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -2542,6 +2542,46 @@ int machine__get_kernel_start(struct machine
> > *machine)
> > >  	return err;
> > >  }

> > > +/*
> > > + * machine__single_ku_as - Machine has same address space for kernel
> > and user.
> > > + * @machine: machine object
> > > + *
> > > + * Some architectures have a single address space for kernel and user
> > > +addresses,
> > > + * which makes it possible to determine if an address is in kernel
> > > +space or user
> > > + * space.
> > > + */
> > > +static bool machine__single_ku_as(struct machine *machine) {
> > > +	return strcmp(perf_env__arch(machine->env), "sparc"); }

> > Can we avoid having this strcmp be done repeatedly?
 
> It is only done if there are mapping errors
 
>  > Can we avoid having this strcmp be done repeatedly? I.e. just make this a
> > boolean initialized at session start, when machine->env is setup, so we'd
> > have:

> >    machine->single_address_space

> > Instead of a function?
 
> Sure  thing.

Thanks
 
> > 
> > Also have you considered making this fallback to be performed only from
> > code that is that arch specific?
> > 
> > I.e. the code that supports branch samples/stacks is x86_86 specific at this
> > point and thus only in that case we would call the routines that perform the
> > fallback, which, in turn, wouldn't need to check for "sparc"?
 
> I will look at it, but theoretically someone could be processing x86 data but
> doing it on a machine of a different architecture.

Right, that should be supported, yes. What I meant was that when
processing perf.data file with samples where the cpumode can't be
inferred, we should use the fallback routines.

It is super unfortunate that we have addresses without a accompanying
cpumode :-\ Don't you think those coulde be fixed somehow? If this comes
from things synthesized from Intel PT traces, then we can use the
address ranges for kernel/userspace to derive that before hitting the
core code, that would be fed with addr/cpumode pairs, just like we have
hdr.misc & USER/KERNEL and the PERF_CONTEXT_ markers in callchains.

- Arnaldo
