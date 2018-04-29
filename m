Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbeD2Wtf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 18:49:35 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:41711 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754526AbeD2Wtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 18:49:32 -0400
X-Google-Smtp-Source: AB8JxZoW29uxS+USKVvF9oFgX0LHtcp3mHmNxIALtyWohvLlH3mwy8yxa48W2sx7UhsMb6whVt47Jw==
Date: Sun, 29 Apr 2018 15:49:28 -0700
From: Sultan Alsawaf <sultanxda@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429224928.teg6zyfjxndbcnsn@sultan-box>
References: <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
 <20180429222625.35tedjzkizchudcm@sultan-box>
 <CAHmME9r5XNS_AU234vKbt9PoHGN3PooFSA8EqNfDRpBHREdQAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9r5XNS_AU234vKbt9PoHGN3PooFSA8EqNfDRpBHREdQAQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 12:43:48AM +0200, Jason A. Donenfeld wrote:
> > -       if ((fast_pool->count < 64) &&
> > -           !time_after(now, fast_pool->last + HZ))
> > -               return;
> > -
> 
> I suspect you still want the rate-limiting in place. But if you _do_
> want to cheat like this, you could instead just modify the condition
> to only relax the rate limiting when !crng_init().

Good idea. Attached a new patch that's less intrusive. It still fixes my issue,
of course.

Sultan

>From 6870b0383b88438d842599aa8608a260e6fb0ed2 Mon Sep 17 00:00:00 2001
From: Sultan Alsawaf <sultanxda@gmail.com>
Date: Sun, 29 Apr 2018 15:44:27 -0700
Subject: [PATCH] random: don't ratelimit add_interrupt_randomness() until crng
 is ready

---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38729baed6ee..8c00c008e797 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1201,7 +1201,7 @@ void add_interrupt_randomness(int irq, int irq_flags)
 	}
 
 	if ((fast_pool->count < 64) &&
-	    !time_after(now, fast_pool->last + HZ))
+	    !time_after(now, fast_pool->last + HZ) && crng_ready())
 		return;
 
 	r = &input_pool;
-- 
2.14.1
