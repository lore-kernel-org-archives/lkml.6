Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeEBAn2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 20:43:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45540 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeEBAnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 20:43:22 -0400
X-Google-Smtp-Source: AB8JxZrPtPd78kmtPf5mvS3S45ivL83pa4NAQOh4xeq6upO4z7rwuK7tILpg0fAETCyAIefpIDplFA==
Date: Tue, 1 May 2018 17:43:17 -0700
From: Sultan Alsawaf <sultanxda@gmail.com>
To: Justin Forbes <jmforbes@linuxtx.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jeremy Cline <jeremy@jcline.org>,
        Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180502004317.kxwiu2oephgbi6ok@sultan-box>
References: <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
 <01000163186628e6-3fe4abfc-eaaf-470c-90c8-2d8ad91db8f1-000000@email.amazonses.com>
 <CAFxkdAogN0S9vgQhKoO+Zpp07bXveDQYPLvwjULoTRv3Or83qQ@mail.gmail.com>
 <20180501125518.GI20585@thunk.org>
 <CAFxkdArLwrG8x6fNtLUfHedKrH_0d97V6UEzOCBgK8Shkir9pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFxkdArLwrG8x6fNtLUfHedKrH_0d97V6UEzOCBgK8Shkir9pQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 05:35:56PM -0500, Justin Forbes wrote:
> 
> I have not reproduced in GCE myself.  We did get some confirmation
> that removing dracut-fips does make the problem less dire (but I
> wouldn't call a 4 minute boot a win, but booting in 4 minutes is
> better than not booting at all).  Specifically systemd calls libgcrypt
> before it even opens the log with fips there, and this is before
> virtio-rng modules could even load. Right now though, we are looking
> at pretty much any possible options as the majority of people are
> calling for me to backout the patches completely from rawhide.

I've attached what I think is a reasonable stopgap solution until this is
actually fixed. If you're willing to revert the CVE-2018-1108 patches
completely, then I don't think you'll mind using this patch in the meantime.

Sultan

>From 5be2efdde744d3c55db3df81c0493fc67dc35620 Mon Sep 17 00:00:00 2001
From: Sultan Alsawaf <sultanxda@gmail.com>
Date: Tue, 1 May 2018 17:36:17 -0700
Subject: [PATCH] random: use urandom instead of random for now and speed up
 crng init

With the fixes for CVE-2018-1108, /dev/random now requires user-provided
entropy on quite a few machines lacking high levels of boot entropy
in order to complete its initialization. This causes issues on environments
where userspace depends on /dev/random in order to finish booting
completely (i.e., userspace will remain stuck, unable to boot, waiting for
entropy more-or-less indefinitely until the user provides it via something
like keystrokes or mouse movements).

As a temporary workaround, redirect /dev/random to /dev/urandom instead,
and speed up the initialization process by slightly relaxing the
threshold for interrupts to go towards adding one bit of entropy credit
(only until initialization is complete).

Signed-off-by: Sultan Alsawaf <sultanxda@gmail.com>
---
 drivers/char/mem.c    | 3 ++-
 drivers/char/random.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index ffeb60d3434c..cc9507f01c79 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -870,7 +870,8 @@ static const struct memdev {
 #endif
 	 [5] = { "zero", 0666, &zero_fops, 0 },
 	 [7] = { "full", 0666, &full_fops, 0 },
-	 [8] = { "random", 0666, &random_fops, 0 },
+	 /* Redirect /dev/random to /dev/urandom until /dev/random is fixed */
+	 [8] = { "random", 0666, &urandom_fops, 0 },
 	 [9] = { "urandom", 0666, &urandom_fops, 0 },
 #ifdef CONFIG_PRINTK
 	[11] = { "kmsg", 0644, &kmsg_fops, 0 },
diff --git a/drivers/char/random.c b/drivers/char/random.c
index d9e38523b383..bce3b43cdd3b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1200,9 +1200,12 @@ void add_interrupt_randomness(int irq)
 		return;
 	}
 
-	if ((fast_pool->count < 64) &&
-	    !time_after(now, fast_pool->last + HZ))
-		return;
+	if (fast_pool->count < 64) {
+		unsigned long timeout = crng_ready() ? HZ : HZ / 4;
+
+		if (!time_after(now, fast_pool->last + timeout))
+			return;
+	}
 
 	r = &input_pool;
 	if (!spin_trylock(&r->lock))
-- 
2.14.1
