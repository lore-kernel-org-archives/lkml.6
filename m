Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754495AbeD2W0c (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 18:26:32 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:37064 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754117AbeD2W0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 18:26:30 -0400
X-Google-Smtp-Source: AB8JxZpIKQ3pNzBD6/o8x3Z4XQxVzBHhzXk8p0nB5BvTqPzEW6R6ZJOvG4OkbkNYyTQYws+E7rz53g==
Date: Sun, 29 Apr 2018 15:26:25 -0700
From: Sultan Alsawaf <sultanxda@gmail.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429222625.35tedjzkizchudcm@sultan-box>
References: <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429220519.GQ5965@thunk.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 06:05:19PM -0400, Theodore Y. Ts'o wrote:
> It's more accurate to say that using /dev/urandom is no worse than
> before (from a few years ago).  There are, alas, plenty of
> distributions and user space application programmers that basically
> got lazy using /dev/urandom, and assumed that there would be plenty of
> entropy during early system startup.
> 
> When they switched over the getrandom(2), the most egregious examples
> of this caused pain (and they got fixed), but due to a bug in
> drivers/char/random.c, if getrandom(2) was called after the entropy
> pool was "half initialized", it would not block, but proceed.
> 
> Is that exploitable?  Well, Jann and I didn't find an _obvious_ way to
> exploit the short coming, which is this wasn't treated like an
> emergency situation ala the embarassing situation we had five years
> ago[1].
> 
> [1] https://factorable.net/paper.html
> 
> However, it was enough to make us be uncomfortable, which is why I
> pushed the changes that I did.  At least on the devices we had at
> hand, using the distributions that we typically use, the impact seemed
> minimal.  Unfortuantely, there is no way to know for sure without
> rolling out change and seeing who screams.  In the ideal world,
> software would not require cryptographic randomness immediately after
> boot, before the user logs in.  And ***really***, as in [1], softwaret
> should not be generating long-term public keys that are essential to
> the security of the box a few seconds immediately after the device is
> first unboxed and plugged in.i
> 
> What would be useful is if people gave reports that listed exactly
> what laptop and distributions they are using.  Just "a high spec x86
> laptop" isn't terribly useful, because *my* brand-new Dell XPS 13
> running Debian testing is working just fine.  The year, model, make,
> and CPU type plus what distribution (and distro version number) you
> are running is useful, so I can assess how wide spread the unhappiness
> is going to be, and what mitigation steps make sense.
> 
> 
> What mitigations steps can be taken?
> 
> If you believe in security-through-complexity (the cache architecture
> of x86 is *sooooo* complicated no one can understand it, so
> Jitterentropy / Haveged *must* be secure), or security-through-secrecy
> (the cache architecture of x86 is only avilable to internal architects
> inside Intel, so Jitterentropy / Haveged *must* be secure, never mind
> that the Intel CPU architects who were asked about it were "nervous"),
> then wiring up CONFIG_JITTERENTROPY or using haveged might be one
> approach.
> 
> If you believe that Intel hasn't backdoored RDRAND, then installing
> rng-tools and running rngd with --enable-drng will enable RDRAND.
> That seems to be popular with various defense contractors, perhaps on
> the assumption that if it _was_ backdoored (no one knows for sure), it
> was probably with the connivance or request of the US government, who
> doesn't need to worry about spying on itself.
> 
> Or you can use some kind of open hardware design RNG, such as
> ChoasKey[2] from Altus Metrum.  But that requires using specially
> ordered hardware plugged into a USB slot, and it's probably not a mass
> solution.
> 
> [2] https://altusmetrum.org/ChaosKey/
> 
> 
> Personally, I prefer fixing the software to simply not require
> cryptographic grade entropy before the user has logged in.  Because
> it's better than the alternatives.
> 
> 					- Ted
> 

The attached patch fixes my crng init woes. With it, crng init completes 0.86
seconds into boot, but I can't help but feel like a solution this obvious would
just expose my Richard Stallman photo collection to prying eyes at the NSA.

Thoughts on the patch?

Sultan

>From 597b0f2b3c986f853bf1d30a7fb9d76869e47fe8 Mon Sep 17 00:00:00 2001
From: Sultan Alsawaf <sultanxda@gmail.com>
Date: Sun, 29 Apr 2018 15:22:59 -0700
Subject: [PATCH] random: remove ratelimiting from add_interrupt_randomness()

---
 drivers/char/random.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38729baed6ee..5b38277b104a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -574,7 +574,6 @@ static void mix_pool_bytes(struct entropy_store *r, const void *in,
 
 struct fast_pool {
 	__u32		pool[4];
-	unsigned long	last;
 	unsigned short	reg_idx;
 	unsigned char	count;
 };
@@ -1195,20 +1194,14 @@ void add_interrupt_randomness(int irq, int irq_flags)
 		    crng_fast_load((char *) fast_pool->pool,
 				   sizeof(fast_pool->pool))) {
 			fast_pool->count = 0;
-			fast_pool->last = now;
 		}
 		return;
 	}
 
-	if ((fast_pool->count < 64) &&
-	    !time_after(now, fast_pool->last + HZ))
-		return;
-
 	r = &input_pool;
 	if (!spin_trylock(&r->lock))
 		return;
 
-	fast_pool->last = now;
 	__mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool));
 
 	/*
-- 
2.14.1
