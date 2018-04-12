Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeDLGWR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:22:17 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52876
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752501AbeDLGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:22:15 -0400
X-IronPort-AV: E=Sophos;i="5.48,440,1517871600";
   d="scan'208";a="261752893"
Date: Thu, 12 Apr 2018 08:22:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
In-Reply-To: <1c9f185f6086e9d89659f93720a27b660ee17c13.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1804120816130.3559@hadrien>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>  <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>  <20180410123305.GF4082@hirez.programming.kicks-ass.net>  <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
 <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>  <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>  <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>  <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
 <20180411081502.GJ4082@hirez.programming.kicks-ass.net>  <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org> <1c9f185f6086e9d89659f93720a27b660ee17c13.camel@perches.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Apr 2018, Joe Perches wrote:

> (Adding Julia Lawall)
>
> On Wed, 2018-04-11 at 09:29 -0700, Andrew Morton wrote:
> > We already have some 500 bools-in-structs
>
> I got at least triple that only in include/
> so I expect there are at probably an order
> of magnitude more than 500 in the kernel.
>
> I suppose some cocci script could count the
> actual number of instances.  A regex can not.

I got 12667.

I'm not sure to understand the issue.  Will using a bitfield help if there
are no other bitfields in the structure?

julia

>
> > and the owners of that code will
> > be wondering whether they should change them, and whether they should
> > apply those remove-bool-in-struct patches which someone sent them.
>
> Which is why the warning is --strict only
>
> > So... can we please get some clarity here?
>
>
> > ...
> >
> > (ooh, https://lkml.org/lkml/2017/11/21/384 is working this morning)
> >
> > hm, Linus suggests that instead of using
> >
> > 	bool mybool;
> >
> > we should use
> >
> > 	unsigned mybool:1;
> >
> > However that introduces the risk that alterations of mybool will use
> > nonatomic rmw operations.
> >
> > 	unsigned myboolA:1;
> > 	unsigned myboolB:1;
> >
> > so
> >
> > 	foo->myboolA = 1;
> >
> > could scribble on concurrent alterations of foo->myboolB.  I think.
>
> Without barriers, that could happen anyway.
>
> To me, the biggest problem with conversions
> from bool to bitfield is logical.  ie:
>
> 	unsigned int.singlebitfield = 4;
>
> is not the same result as
>
> 	bool = 4;
>
> because of implicit truncation vs boolean conversion
> so a direct change of bool use in structs to unsigned
> would also require logic analysis.
>
>
