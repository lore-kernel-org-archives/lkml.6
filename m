Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48szBHTq2EoE0CfQuTpVI14Jjz18R0g5hzIkpKcoDfMCF/u765faORa8Z1PTODE09jE4pm5
ARC-Seal: i=1; a=rsa-sha256; t=1524406443; cv=none;
        d=google.com; s=arc-20160816;
        b=UrkHPqyTPxljKwtMzJAJ6we2mMwpH7OTaXbDOxB1WjFcYnjvNkB8LJGHTVcdAdqkNq
         3aeVokUUxjytzSm18TpbkOajOhA4ESB3f0Whs168E7xcbUxRWtYicglvSuM82eeRmOWg
         ODF/kYCGNfo+1+Go+6gEzZbmE9j7mQ2NJKgEWSlQVyk96kcAU86UfKiEEdaXsIk52JMD
         L7ckpi3runbB0mPEDNxSkN5PmxpZGo6SWxvepK5Vj6PhI2R6Te5KCJHuUMYo/XahS1Z0
         /aD5lpKCWz5UA6dBim8IXRG790fm5idpJNgyJzRffy4ufI/RYhRFA/4ll4hQNve2BP8c
         pNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HOwRFAnqPMcEgjnB6GTeSS94OJ4fDCOsRnLEoLezHNE=;
        b=Jwu9m+DeleLWme9qb1SYKGBGVh4bIjUXlPKh+Nuak1dI4bkTFSBaMdBPorQqoIKraN
         t7drDdIQQkkSUnugDBjS2v9Vj53h//MX/xhT0nRxNoeHuK9SBmWRwd7hdEeXkpw4cQgS
         YaL/FJQOuMw9AZ1Fbq8Cvpz7eb5Y8uSWoofb8PKwhNAE7pGgOWpvN2wSaTTNNv84bbOo
         GEGTFhMKt6gLF439F8bNe8ZlKXbcrOfv3yABz8hnHlP0Q0lWYSMxSNKpexRDzKClrOUg
         RM2EA3XZ0TpMQim6CQkk+W5jl+oO0OviMjSbWJc78PxN7q/i+wp+OqmJB0hlnKQVytzi
         xuUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 4.9 74/95] random: fix crng_ready() test
Date: Sun, 22 Apr 2018 15:53:43 +0200
Message-Id: <20180422135213.452755881@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455333623900338?=
X-GMAIL-MSGID: =?utf-8?q?1598456011277736908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 43838a23a05fbd13e47d750d3dfd77001536dd33 upstream.

The crng_init variable has three states:

0: The CRNG is not initialized at all
1: The CRNG has a small amount of entropy, hopefully good enough for
   early-boot, non-cryptographical use cases
2: The CRNG is fully initialized and we are sure it is safe for
   cryptographic use cases.

The crng_ready() function should only return true once we are in the
last state.  This addresses CVE-2018-1108.

Reported-by: Jann Horn <jannh@google.com>
Fixes: e192be9d9a30 ("random: replace non-blocking pool...")
Cc: stable@kernel.org # 4.8+
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -434,7 +434,7 @@ struct crng_state primary_crng = {
  * its value (from 0->1->2).
  */
 static int crng_init = 0;
-#define crng_ready() (likely(crng_init > 0))
+#define crng_ready() (likely(crng_init > 1))
 static int crng_init_cnt = 0;
 #define CRNG_INIT_CNT_THRESH (2*CHACHA20_KEY_SIZE)
 static void _extract_crng(struct crng_state *crng,
@@ -800,7 +800,7 @@ static int crng_fast_load(const char *cp
 
 	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
 		return 0;
-	if (crng_ready()) {
+	if (crng_init != 0) {
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
 		return 0;
 	}
@@ -872,7 +872,7 @@ static void _extract_crng(struct crng_st
 {
 	unsigned long v, flags;
 
-	if (crng_init > 1 &&
+	if (crng_ready() &&
 	    time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL))
 		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
 	spin_lock_irqsave(&crng->lock, flags);
@@ -1153,7 +1153,7 @@ void add_interrupt_randomness(int irq, i
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
 
-	if (!crng_ready()) {
+	if (unlikely(crng_init == 0)) {
 		if ((fast_pool->count >= 64) &&
 		    crng_fast_load((char *) fast_pool->pool,
 				   sizeof(fast_pool->pool))) {
@@ -2148,7 +2148,7 @@ void add_hwgenerator_randomness(const ch
 {
 	struct entropy_store *poolp = &input_pool;
 
-	if (!crng_ready()) {
+	if (unlikely(crng_init == 0)) {
 		crng_fast_load(buffer, count);
 		return;
 	}
