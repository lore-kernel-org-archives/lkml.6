Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751621AbeD3Eew (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 00:34:52 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:42642 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbeD3Eeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 00:34:50 -0400
X-Google-Smtp-Source: AB8JxZqarNrkenKTvZMqMTmOdhml+Q/3Nj4KN71JXzfIgBm3hDrIiP98WVFHbJyf7Krkp+a3PgUccQ==
Date: Sun, 29 Apr 2018 21:34:45 -0700
From: Sultan Alsawaf <sultanxda@gmail.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180430043445.t7wkykxzkhex2isi@sultan-box>
References: <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
 <20180429222625.35tedjzkizchudcm@sultan-box>
 <CAHmME9r5XNS_AU234vKbt9PoHGN3PooFSA8EqNfDRpBHREdQAQ@mail.gmail.com>
 <20180429224928.teg6zyfjxndbcnsn@sultan-box>
 <20180430001106.GS5965@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430001106.GS5965@thunk.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 08:11:07PM -0400, Theodore Y. Ts'o wrote:
>
> What your patch does is assume that there is a full bit of uncertainty
> that can be obtained from the information gathered from each
> interrupt.  I *might* be willing to assume that to be valid on x86
> systems that have a high resolution cycle counter.  But on ARM
> platforms, especially during system bootup when the user isn't typing
> anything and SSD's and flash storage tend to have very predictable
> timing patterns?  Not a bet I'd be willing to take.  Even with a cycle
> counter, there's a reason why we assumed that we need to mix in timing
> results from 64 interrupts or one second's worth before we would give
> a single bit's worth of entropy credit.
> 
> 							- Ted

What about abusing high-resolution timers to get entropy? Since hrtimers can't
make guarantees down to the nanosecond, there's always a skew between the
requested expiry time and the actual expiry time.

Please see the attached patch and let me know just how horrible it is.

Sultan

>From b0d21c38558c661531d4cb46816fbb36b874a169 Mon Sep 17 00:00:00 2001
From: Sultan Alsawaf <sultanxda@gmail.com>
Date: Sun, 29 Apr 2018 21:28:08 -0700
Subject: [PATCH] random: use high-res timers to generate entropy until crng
 init is done

---
 drivers/char/random.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d9e38523b383..af2d60bbcec3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -286,6 +286,7 @@
 #define OUTPUT_POOL_WORDS	(1 << (OUTPUT_POOL_SHIFT-5))
 #define SEC_XFER_SIZE		512
 #define EXTRACT_SIZE		10
+#define ENTROPY_GEN_INTVL_NS	(1 * NSEC_PER_MSEC)
 
 
 #define LONGS(x) (((x) + sizeof(unsigned long) - 1)/sizeof(unsigned long))
@@ -408,6 +409,8 @@ static struct fasync_struct *fasync;
 static DEFINE_SPINLOCK(random_ready_list_lock);
 static LIST_HEAD(random_ready_list);
 
+static struct hrtimer entropy_gen_hrtimer;
+
 struct crng_state {
 	__u32		state[16];
 	unsigned long	init_time;
@@ -2287,3 +2290,47 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 	credit_entropy_bits(poolp, entropy);
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
+
+/*
+ * Generate entropy on init using high-res timers. Although high-res timers
+ * provide nanosecond precision, they don't actually honor requests to the
+ * nanosecond. The skew between the expected time difference in nanoseconds and
+ * the actual time difference can be used as a way to generate entropy on boot
+ * for machines that lack sufficient boot-time entropy.
+ */
+static enum hrtimer_restart entropy_timer_cb(struct hrtimer *timer)
+{
+	static u64 prev_ns;
+	u64 curr_ns, delta;
+
+	if (crng_ready())
+		return HRTIMER_NORESTART;
+
+	curr_ns = ktime_get_mono_fast_ns();
+	delta = curr_ns - prev_ns;
+
+	add_interrupt_randomness(delta);
+
+	/* Use the hrtimer skew to make the next interval more unpredictable */
+	if (likely(prev_ns))
+		hrtimer_add_expires_ns(timer, delta);
+	else
+		hrtimer_add_expires_ns(timer, ENTROPY_GEN_INTVL_NS);
+
+	prev_ns = curr_ns;
+	return HRTIMER_RESTART;
+}
+
+static int entropy_gen_hrtimer_init(void)
+{
+	if (!IS_ENABLED(CONFIG_HIGH_RES_TIMERS))
+		return 0;
+
+	hrtimer_init(&entropy_gen_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
+	entropy_gen_hrtimer.function = entropy_timer_cb;
+	hrtimer_start(&entropy_gen_hrtimer, ns_to_ktime(ENTROPY_GEN_INTVL_NS),
+		HRTIMER_MODE_REL);
+	return 0;
+}
+core_initcall(entropy_gen_hrtimer_init);
-- 
2.14.1
