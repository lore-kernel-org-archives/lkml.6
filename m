Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeDKQaD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:30:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeDKQaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:30:01 -0400
Date: Wed, 11 Apr 2018 09:29:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
Message-Id: <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
In-Reply-To: <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
        <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
        <20180410123305.GF4082@hirez.programming.kicks-ass.net>
        <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
        <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
        <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
        <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
        <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
        <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 10:15:02 +0200 Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Apr 10, 2018 at 03:00:11PM -0700, Andrew Morton wrote:
> > On Tue, 10 Apr 2018 14:53:51 -0700 Joe Perches <joe@perches.com> wrote:
> > 
> > > On Tue, 2018-04-10 at 14:39 -0700, Andrew Morton wrote:
> > > > On Tue, 10 Apr 2018 11:19:54 -0700 Joe Perches <joe@perches.com> wrote:
> > > > 
> > > > > A struct with a bool member can have different sizes on various
> > > > > architectures because neither bool size nor alignment is standardized.
> > > > 
> > > > What's wrong with bools in structs?
> > > 
> > > See above.
> > 
> > Yeah, but so what?  `long' has different sizes on different
> > architectures too.
> 
> Right, so we have ILP32/LP64 for all our 32/64 bit archs respectively.
> So only 2 possible variations to consider, and if you know your bitness
> you know your layout.
> 
> (+- some really unfortunate alignment exceptions, the worst of which
> Arnd recently removed, hooray!)
> 
> But neither says anything about sizeof(_Bool), and the standard leaves
> it undefined and only mandates it is large enough to store either 0 or
> 1 (and I suspect this vagueness is because there are architectures that
> either have no byte addressibility or it's more expensive than word
> addressibility).
> 
> Typically GCC chooses a single byte to represent _Bool, but there are no
> guarantees. This means that when you care about structure layout (as we
> all really should) things go wobbly when you use _Bool.
> 
> If GCC were to guarantee a 1 byte _Bool for all Linux ABIs we could
> reconsider.

OK.  I guess.  But I'm not really seeing some snappy description which
helps people understand why checkpatch is warning about this.  We
already have some 500 bools-in-structs and the owners of that code will
be wondering whether they should change them, and whether they should
apply those remove-bool-in-struct patches which someone sent them.

So... can we please get some clarity here?

...

(ooh, https://lkml.org/lkml/2017/11/21/384 is working this morning)

hm, Linus suggests that instead of using

	bool mybool;

we should use

	unsigned mybool:1;

However that introduces the risk that alterations of mybool will use
nonatomic rmw operations.

	unsigned myboolA:1;
	unsigned myboolB:1;

so

	foo->myboolA = 1;

could scribble on concurrent alterations of foo->myboolB.  I think.

I guess that risk is also present if myboolA and myboolB were `bool',
too.  The compiler could do any old thing with them including, perhaps,
using a single-bit bitfield(?).
