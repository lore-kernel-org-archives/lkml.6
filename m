Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932108AbeD3ALN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 20:11:13 -0400
Received: from imap.thunk.org ([74.207.234.97]:43524 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932071AbeD3ALJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 20:11:09 -0400
Date: Sun, 29 Apr 2018 20:11:07 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180430001106.GS5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
 <20180429222625.35tedjzkizchudcm@sultan-box>
 <CAHmME9r5XNS_AU234vKbt9PoHGN3PooFSA8EqNfDRpBHREdQAQ@mail.gmail.com>
 <20180429224928.teg6zyfjxndbcnsn@sultan-box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429224928.teg6zyfjxndbcnsn@sultan-box>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 03:49:28PM -0700, Sultan Alsawaf wrote:
> On Mon, Apr 30, 2018 at 12:43:48AM +0200, Jason A. Donenfeld wrote:
> > > -       if ((fast_pool->count < 64) &&
> > > -           !time_after(now, fast_pool->last + HZ))
> > > -               return;
> > > -
> > 
> > I suspect you still want the rate-limiting in place. But if you _do_
> > want to cheat like this, you could instead just modify the condition
> > to only relax the rate limiting when !crng_init().
> 
> Good idea. Attached a new patch that's less intrusive. It still fixes my issue,
> of course.

What your patch does is assume that there is a full bit of uncertainty
that can be obtained from the information gathered from each
interrupt.  I *might* be willing to assume that to be valid on x86
systems that have a high resolution cycle counter.  But on ARM
platforms, especially during system bootup when the user isn't typing
anything and SSD's and flash storage tend to have very predictable
timing patterns?  Not a bet I'd be willing to take.  Even with a cycle
counter, there's a reason why we assumed that we need to mix in timing
results from 64 interrupts or one second's worth before we would give
a single bit's worth of entropy credit.

							- Ted
