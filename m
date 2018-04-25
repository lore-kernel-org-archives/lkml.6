Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754854AbeDYPDX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:03:23 -0400
Received: from foss.arm.com ([217.140.101.70]:41046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754586AbeDYPDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:03:22 -0400
Date: Wed, 25 Apr 2018 16:03:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180425150314.jgkm4elvoylccvfp@lakrids.cambridge.arm.com>
References: <20180419051510.GA21898@mwanda>
 <20180425131958.hhapvc3b2i3b4pgy@lakrids.cambridge.arm.com>
 <20180425154852.2486f267@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425154852.2486f267@alans-desktop>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 03:48:52PM +0100, Alan Cox wrote:
> > 2) Compiler transformations can elide binary operations, so we cannot
> >    rely on source level AND (&) or MOD (%) operations to narrow the
> >    range of an expression, regardless of the types of either operand.
> > 
> >    This means that source-level AND and MOD operations cannot be relied
> >    upon under speculation.
> 
> You need to use volatiles and memory barriers if trying to do it
> explicitly in C. The compilers will do some really quite insanely
> brilliant things otherwise. That's one reason that not using fences is
> really tricky and belongs wrapped in helpers.

Sure thing -- the point is that source-level analysis tools must take
that into account.

> > I suspect this means *many* more potential spectre gadgets. :(
> 
> I expect so as well as probably a lot of false positives - the tools in
> the space are all pretty new.
> 
> Array access isn't always needed either. Remember that something as
> simple as
> 
> 	x = size_table[user];
> 	memset(buf, 0, x);
> 
> can speculatively reveal things, as can 'classical' side channels such as
> variable length instruction timings.

As discussed in the other sub-thread, the plan is to kill sequences at
the first load, which should prevent the leak via a subsequent
value-dependent sequence.

i.e. the above would be:

	user_nospec = array_index_nospec(user, ARRAY_SIZE(size_table));
	x = size_table[user_nospec];
	memset(buf, 0, x);

... which IIUC avoids the leak in this particular case.

Mark.
