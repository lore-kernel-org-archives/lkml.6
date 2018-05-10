Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeEJUT1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752008AbeEJUTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:19:25 -0400
Date: Thu, 10 May 2018 17:19:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Hunter, Adrian" <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFC 07/19] perf tools: Workaround missing maps for x86_64
 KPTI entry trampolines
Message-ID: <20180510201922.GE4311@kernel.org>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-8-git-send-email-adrian.hunter@intel.com>
 <20180509170717.GI13491@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C13DE9E@IRSMSX106.ger.corp.intel.com>
 <20180510201542.GD4311@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510201542.GD4311@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 10, 2018 at 05:15:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, May 10, 2018 at 07:08:37PM +0000, Hunter, Adrian escreveu:
> > > -----Original Message-----
> > > From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> > > Sent: Wednesday, May 9, 2018 8:07 PM
> > > To: Hunter, Adrian <adrian.hunter@intel.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> > > <mingo@redhat.com>; Peter Zijlstra <peterz@infradead.org>; Andy
> > > Lutomirski <luto@kernel.org>; H. Peter Anvin <hpa@zytor.com>; Andi Kleen
> > > <ak@linux.intel.com>; Alexander Shishkin
> > > <alexander.shishkin@linux.intel.com>; Dave Hansen
> > > <dave.hansen@linux.intel.com>; Joerg Roedel <joro@8bytes.org>; Jiri Olsa
> > > <jolsa@redhat.com>; linux-kernel@vger.kernel.org; x86@kernel.org
> > > Subject: Re: [PATCH RFC 07/19] perf tools: Workaround missing maps for
> > > x86_64 KPTI entry trampolines
> > > 
> > > Em Wed, May 09, 2018 at 02:43:36PM +0300, Adrian Hunter escreveu:
> > > > On x86_64 the KPTI entry trampolines are not in the kernel map created
> > > > by perf tools. That results in the addresses having no symbols and
> > > > prevents annotation. It also causes Intel PT to have decoding errors
> > > > at the trampoline addresses. Workaround that by creating maps for the
> > > trampolines.
> > > > At present the kernel does not export information revealing where the
> > > > trampolines are. Until that happens, the addresses are hardcoded.
> > > >
> > > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > > > ---
> > > >  tools/perf/util/machine.c | 104
> > > ++++++++++++++++++++++++++++++++++++++++++++++
> > > >  tools/perf/util/machine.h |   3 ++
> > > >  tools/perf/util/symbol.c  |  12 +++---
> > > >  3 files changed, 114 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > > index 22047ff3cf2a..1bf15aa0b099 100644
> > > > --- a/tools/perf/util/machine.c
> > > > +++ b/tools/perf/util/machine.c
> > > > @@ -851,6 +851,110 @@ static int
> > > machine__get_running_kernel_start(struct machine *machine,
> > > >  	return 0;
> > > >  }
> > > >
> > > > +struct special_kernal_map {
> > > 
> > > s/kernal/kernel/
> > > 
> > > And "special"?
> > 
> > I have added comment:
> > 
> > /* Kernel-space maps that are not the main kernel map nor a module map */
> 
> Perhaps:
> 
>   /* Kernel-space maps for symbols that are outside the main kernel map and module maps */
> 
>   struct extra_kernel_map;
> 
> What do you think?
> 
> > And fixed kernal, and changed machine__is()
> 
> Thanks
>  
> > Revised patch set is here:
> > 
> > 	http://git.infradead.org/users/ahunter/linux-perf.git/shortlog/refs/heads/perf-tools-kpti
> > 
> > which is the perf-tools-kpti branch of:
> > 
> > 	git://git.infradead.org/users/ahunter/linux-perf.git
> > 
> > Let me know if you want me to post the workaround patches separately,
> > otherwise I will wait a bit before sending the patches again.
> 
> I'll see if I went thru all of the patches already...

So I looked at the patches posted and one comment is about the terse
commit logs for some of the kcore_copy patches, for instance:

--------------------
 In preparation to add more program headers, get rid of kernel_map and
modules_map.
--------------------

Can't this be made a bit more verbose? Lemme re-read the patch...

- Arnaldo
