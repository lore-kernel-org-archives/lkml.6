Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759231AbeD0UKk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:10:40 -0400
Received: from imap.thunk.org ([74.207.234.97]:40254 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759212AbeD0UKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:10:39 -0400
Date: Fri, 27 Apr 2018 16:10:36 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180427201036.GL5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 10:20:44PM -0700, Sultan Alsawaf wrote:
> 
> I noted at least 20,000 mmc interrupts before I intervened in the boot process to provide entropy
> myself. That's just for mmc, so I'm sure there were even more interrupts elsewhere. Is 20k+ interrupts
> really not sufficient?

How did you determine that there were 20,000 mmc interrupts before you
had logged in?  Did you have access to the machine w/o having access
to the login prompt?

I can send a patch (see attached) that will spew large amounts of logs
as each interrupt comes in and the entropy pool is getting intialized.
That's how I test things on QEMU, and Jann did something similar on a
(physical) test machine, so I'm pretty confident that if you were
getting interrupts, it would result in them contributing into the
pool.

You will need a serial console, or build a kernel with a much larger
dmesg buffer, since if you really are getting that many interrupts it
will cause a lot of log spew.

> There are lots of other sources of entropy available as well, like
> the ever-changing CPU frequencies reported by any recent Intel chip
> (i.e., they report precision down to 1 kHz).

That's something we could look at, but the problem is if there is some
systemd unit during early boot that blocks waiting for the entropy
pool to be initalized, the system will come to a dead halt, and even
the CPU frequency shifts will probably not move much --- just as there
weren't any interrupts while some system startup on the boot path
wedges the system startup waiting for entropy.

This is why ultimately, we do need to attack this problem from both
ends, which means teaching userspace programs to only request
cryptographic-grade randomness when it is really needed --- and most
of the time, if the user has not logged in yet, you probably don't
need cryptographic-grade randomness....

						- Ted

diff --git a/drivers/char/random.c b/drivers/char/random.c
index cd888d4ee605..69bd29f039e7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -916,6 +916,10 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 		__u32	key[8];
 	} buf;
 
+	if (crng == &primary_crng)
+		pr_notice("random: crng_reseed primary from %px\n", r);
+	else
+		pr_notice("random: crng_reseed crng %px from %px\n", crng, r);
 	if (r) {
 		num = extract_entropy(r, &buf, 32, 16, 0);
 		if (num == 0)
@@ -1241,6 +1245,10 @@ void add_interrupt_randomness(int irq, int irq_flags)
 	fast_pool->pool[2] ^= ip;
 	fast_pool->pool[3] ^= (sizeof(ip) > 4) ? ip >> 32 :
 		get_reg(fast_pool, regs);
+	if (crng_init < 2)
+		pr_notice("random: add_interrupt(cycles=0x%08llx, now=%ld, "
+			  "irq=%d, ip=0x%08lx)\n",
+			  cycles, now, irq, _RET_IP_);
 
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
@@ -1282,6 +1290,9 @@ void add_interrupt_randomness(int irq, int irq_flags)
 
 	/* award one bit for the contents of the fast pool */
 	credit_entropy_bits(r, credit + 1);
+	if (crng_init < 2)
+		pr_notice("random: batched into pool in stage %d, bits now %d",
+			  crng_init, ENTROPY_BITS(r));
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
