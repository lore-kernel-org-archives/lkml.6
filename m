Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeDKRBB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 13:01:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753599AbeDKRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 13:00:59 -0400
Date: Wed, 11 Apr 2018 19:00:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
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
Message-ID: <20180411170049.GR4082@hirez.programming.kicks-ass.net>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
 <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
 <20180410123305.GF4082@hirez.programming.kicks-ass.net>
 <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
 <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
 <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
 <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
 <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
 <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
 <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 09:29:59AM -0700, Andrew Morton wrote:
> 
> OK.  I guess.  But I'm not really seeing some snappy description which
> helps people understand why checkpatch is warning about this. 

 "Results in architecture dependent layout."

is the best short sentence I can come up with.

> We already have some 500 bools-in-structs and the owners of that code
> will be wondering whether they should change them, and whether they
> should apply those remove-bool-in-struct patches which someone sent
> them.

I still have room in my /dev/null mailbox for pure checkpatch patches.

> (ooh, https://lkml.org/lkml/2017/11/21/384 is working this morning)

Yes, we really should not use lkml.org for references. Sadly google
displays it very prominently when you search for something.

> hm, Linus suggests that instead of using
> 
> 	bool mybool;
> 
> we should use
> 
> 	unsigned mybool:1;
> 
> However that introduces the risk that alterations of mybool will use
> nonatomic rmw operations.
> 
> 	unsigned myboolA:1;
> 	unsigned myboolB:1;
> 
> so
> 
> 	foo->myboolA = 1;
> 
> could scribble on concurrent alterations of foo->myboolB.  I think.

So that is true of u8 on Alpha <EV56 too. If you want concurrent, you
had better know what you're doing.

> I guess that risk is also present if myboolA and myboolB were `bool',
> too.  The compiler could do any old thing with them including, perhaps,
> using a single-bit bitfield(?).

The smallest addressable type in C is a byte, so while _Bool may be
larger than a byte, it cannot be smaller. Otherwise we could not write:

	_Bool var;
	_Boll *ptr = &var;

Which is something that comes apart with bitfields.
