Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C944C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595FF20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595FF20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbeKFEm6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:42:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:16032 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387980AbeKFEm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 11:21:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,469,1534834800"; 
   d="scan'208";a="103636423"
Received: from irsmsx151.ger.corp.intel.com ([163.33.192.59])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2018 11:21:45 -0800
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.163]) by
 IRSMSX151.ger.corp.intel.com ([169.254.4.122]) with mapi id 14.03.0415.000;
 Mon, 5 Nov 2018 19:21:45 +0000
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
Thread-Index: AQHUcPn4AJzKnLLQPUuuQOazd3tPPKVBeFYAgAAcsBA=
Date:   Mon, 5 Nov 2018 19:21:44 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C313381@IRSMSX106.ger.corp.intel.com>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
 <20181031091043.23465-2-adrian.hunter@intel.com>
 <20181105172946.GH11147@kernel.org>
In-Reply-To: <20181105172946.GH11147@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2ZlZDlkNWEtN2U1Zi00ODk1LTgxOTAtZDcwOTlkMzIyMzNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK3JDK1ErdFI2bnN1bHVYR3h2MEJJbG5ieVVLTlR3akViTjd1ZWFUMW1hcVJoNSsyS2tkWjVsYnEyNEpGXC9vZksifQ==
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
> Sent: Monday, November 5, 2018 7:30 PM
> To: Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>; Andi Kleen <ak@linux.intel.com>; linux-
> kernel@vger.kernel.org; leo.yan@linaro.org; David Miller
> <davem@davemloft.net>; Mathieu Poirier <mathieu.poirier@linaro.org>
> Subject: Re: [PATCH 1/5] perf tools: Add fallback functions for cases where
> cpumode is insufficient
> 
> Em Wed, Oct 31, 2018 at 11:10:39AM +0200, Adrian Hunter escreveu:
> > For branch stacks or branch samples, the sample cpumode might not be
> > correct because it applies only to the sample 'ip' and not necessary
> > to 'addr' or branch stack addresses. Add fallback functions that can
> > be used to deal with those cases
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: stable@vger.kernel.org # 4.19
> > ---
> >  tools/perf/util/event.c   | 27 ++++++++++++++++++++++++++
> >  tools/perf/util/machine.c | 40
> > +++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/machine.h |  2 ++
> >  tools/perf/util/thread.h  |  4 ++++
> >  4 files changed, 73 insertions(+)
> >
> > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c index
> > bc646185f8d9..52b24b8ce29e 100644
> > --- a/tools/perf/util/event.c
> > +++ b/tools/perf/util/event.c
> > @@ -1576,6 +1576,24 @@ struct map *thread__find_map(struct thread
> *thread, u8 cpumode, u64 addr,
> >  	return al->map;
> >  }
> >
> > +/*
> > + * For branch stacks or branch samples, the sample cpumode might not
> > +be correct
> > + * because it applies only to the sample 'ip' and not necessary to
> > +'addr' or
> > + * branch stack addresses. If possible, use a fallback to deal with those
> cases.
> > + */
> > +struct map *thread__find_map_fallback(struct thread *thread, u8
> cpumode,
> > +				      u64 addr, struct addr_location *al) {
> 
> You named one as _fallback...
> 
> > +	struct map *map = thread__find_map(thread, cpumode, addr, al);
> > +	struct machine *machine = thread->mg->machine;
> > +	u8 addr_cpumode = machine__addr_cpumode(machine, cpumode,
> addr);
> > +
> > +	if (map || addr_cpumode == cpumode)
> > +		return map;
> > +
> > +	return thread__find_map(thread, addr_cpumode, addr, al); }
> > +
> >  struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
> >  				   u64 addr, struct addr_location *al)  { @@ -
> 1585,6 +1603,15 @@
> > struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
> >  	return al->sym;
> >  }
> >
> > +struct symbol *thread__find_symbol_fb(struct thread *thread, u8
> cpumode,
> > +				      u64 addr, struct addr_location *al)
> 
> ... and the other as _fb, make it consistent, please.

ok

> 
> > +{
> > +	al->sym = NULL;
> > +	if (thread__find_map_fallback(thread, cpumode, addr, al))
> > +		al->sym = map__find_symbol(al->map, al->addr);
> > +	return al->sym;
> > +}
> > +
> >  /*
> >   * Callers need to drop the reference to al->thread, obtained in
> >   * machine__findnew_thread()
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 111ae858cbcb..04edc0eac376 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -2542,6 +2542,46 @@ int machine__get_kernel_start(struct machine
> *machine)
> >  	return err;
> >  }
> >
> > +/*
> > + * machine__single_ku_as - Machine has same address space for kernel
> and user.
> > + * @machine: machine object
> > + *
> > + * Some architectures have a single address space for kernel and user
> > +addresses,
> > + * which makes it possible to determine if an address is in kernel
> > +space or user
> > + * space.
> > + */
> > +static bool machine__single_ku_as(struct machine *machine) {
> > +	return strcmp(perf_env__arch(machine->env), "sparc"); }
> 
> Can we avoid having this strcmp be done repeatedly?

It is only done if there are mapping errors

 > Can we avoid having this strcmp be done repeatedly? I.e. just make this a
> boolean initialized at session start, when machine->env is setup, so we'd
> have:
> 
>    machine->single_address_space
> 
> Instead of a function?

Sure  thing.

> 
> Also have you considered making this fallback to be performed only from
> code that is that arch specific?
> 
> I.e. the code that supports branch samples/stacks is x86_86 specific at this
> point and thus only in that case we would call the routines that perform the
> fallback, which, in turn, wouldn't need to check for "sparc"?

I will look at it, but theoretically someone could be processing x86 data but
doing it on a machine of a different architecture.

> 
> > +
> > +u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64
> > +addr) {
> > +	u8 addr_cpumode = cpumode;
> > +	bool kernel_ip;
> > +
> > +	if (!machine__single_ku_as(machine))
> > +		goto out;
> > +
> > +	kernel_ip = machine__kernel_ip(machine, addr);
> > +	switch (cpumode) {
> > +	case PERF_RECORD_MISC_KERNEL:
> > +	case PERF_RECORD_MISC_USER:
> > +		addr_cpumode = kernel_ip ? PERF_RECORD_MISC_KERNEL :
> > +					   PERF_RECORD_MISC_USER;
> > +		break;
> > +	case PERF_RECORD_MISC_GUEST_KERNEL:
> > +	case PERF_RECORD_MISC_GUEST_USER:
> > +		addr_cpumode = kernel_ip ?
> PERF_RECORD_MISC_GUEST_KERNEL :
> > +					   PERF_RECORD_MISC_GUEST_USER;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +out:
> > +	return addr_cpumode;
> > +}
> > +
> >  struct dso *machine__findnew_dso(struct machine *machine, const char
> > *filename)  {
> >  	return dsos__findnew(&machine->dsos, filename); diff --git
> > a/tools/perf/util/machine.h b/tools/perf/util/machine.h index
> > d856b85862e2..20d464135ed1 100644
> > --- a/tools/perf/util/machine.h
> > +++ b/tools/perf/util/machine.h
> > @@ -99,6 +99,8 @@ static inline bool machine__kernel_ip(struct machine
> *machine, u64 ip)
> >  	return ip >= kernel_start;
> >  }
> >
> > +u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64
> > +addr);
> > +
> >  struct thread *machine__find_thread(struct machine *machine, pid_t pid,
> >  				    pid_t tid);
> >  struct comm *machine__thread_exec_comm(struct machine *machine,
> diff
> > --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h index
> > 36c09a9904e6..e28f9dc1110a 100644
> > --- a/tools/perf/util/thread.h
> > +++ b/tools/perf/util/thread.h
> > @@ -96,9 +96,13 @@ struct thread *thread__main_thread(struct machine
> > *machine, struct thread *threa
> >
> >  struct map *thread__find_map(struct thread *thread, u8 cpumode, u64
> addr,
> >  			     struct addr_location *al);
> > +struct map *thread__find_map_fallback(struct thread *thread, u8
> cpumode,
> > +				      u64 addr, struct addr_location *al);
> >
> >  struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
> >  				   u64 addr, struct addr_location *al);
> > +struct symbol *thread__find_symbol_fb(struct thread *thread, u8
> cpumode,
> > +				      u64 addr, struct addr_location *al);
> >
> >  void thread__find_cpumode_addr_location(struct thread *thread, u64
> addr,
> >  					struct addr_location *al);
> > --
> > 2.17.1
