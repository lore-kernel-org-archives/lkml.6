Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/VWU5x/IVXft1iH1Y5KKHaZrDqxI9uiq8x1mNicLlBp2GW5Otgi0DEIFGCXt5yJg4xG43X
ARC-Seal: i=1; a=rsa-sha256; t=1524405797; cv=none;
        d=google.com; s=arc-20160816;
        b=YJsxeRVip1Xv0+SiI9cWk5MnTu16S+fWmzWfQVfFOVsi7M9GLO1SSCtIRXINpAhHQh
         L4ZydLJPcEefo41y0syLRbpy05D47QgZtZE7avEb2EFe0jXpGNl9MP32UtvSoJCCrmhB
         wHcXlGLAtw1RkT9GZhnDIcSnDofW7LCxzDdbNhQcVcja9ASDlzNbQ3hFuBlHu8zy7QEr
         g1zoTbB+RKUlXBkM0wY+6Jq6ALDr/z5RzthHVGNRXM+RPC7LtcjWikq3r5J8OWR9Pxav
         Pd117ymqBMJDp68KB24Nq1WpR9iqHEbkJpFPRK2lDWYlxfNDZFGKYCThZrnr8qg1MTFw
         Cuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YiyS+akCfS3dLayquneNw165LBcROe3T1jNOWftE5h0=;
        b=knBppO82R2PaK5eGtrz0IFzhbTbefYvLiGt8dSgF+a+NGSCSOm1RgWXOY746W5gGe1
         8NZEVHFwVm0kMB5R3EhBJllDtOxmjQDXV8fAq7U1W67UiFKS2bAqL82uhOJuRstBV83O
         I1fDQsDsPi0u/XwJ7/Ywo/0L7N+ha5Ze+HdT0KoEVbgCLJfPzJrkWypq3e+9KnYE39K9
         SAV1plK42sSM8ApQr9K0yjDDotr4lbHjamtVdvDob4igJ1iUhU0fglrx4YB0zuLDL2bT
         nj2tR3xBJUtMeljpmgO9FD30hbP1i8jL5dx7+4btpSsHEg3eHs4VZWSXgtl9SRsDSUX4
         HOyg==
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
Subject: [PATCH 4.16 163/196] random: fix crng_ready() test
Date: Sun, 22 Apr 2018 15:53:03 +0200
Message-Id: <20180422135112.655853962@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455333623900338?=
X-GMAIL-MSGID: =?utf-8?q?1598455333623900338?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -427,7 +427,7 @@ struct crng_state primary_crng = {
  * its value (from 0->1->2).
  */
 static int crng_init = 0;
-#define crng_ready() (likely(crng_init > 0))
+#define crng_ready() (likely(crng_init > 1))
 static int crng_init_cnt = 0;
 #define CRNG_INIT_CNT_THRESH (2*CHACHA20_KEY_SIZE)
 static void _extract_crng(struct crng_state *crng,
@@ -793,7 +793,7 @@ static int crng_fast_load(const char *cp
 
 	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
 		return 0;
-	if (crng_ready()) {
+	if (crng_init != 0) {
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
 		return 0;
 	}
@@ -855,7 +855,7 @@ static void _extract_crng(struct crng_st
 {
 	unsigned long v, flags;
 
-	if (crng_init > 1 &&
+	if (crng_ready() &&
 	    time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL))
 		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
 	spin_lock_irqsave(&crng->lock, flags);
@@ -1141,7 +1141,7 @@ void add_interrupt_randomness(int irq, i
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
 
-	if (!crng_ready()) {
+	if (unlikely(crng_init == 0)) {
 		if ((fast_pool->count >= 64) &&
 		    crng_fast_load((char *) fast_pool->pool,
 				   sizeof(fast_pool->pool))) {
@@ -2214,7 +2214,7 @@ void add_hwgenerator_randomness(const ch
 {
 	struct entropy_store *poolp = &input_pool;
 
-	if (!crng_ready()) {
+	if (unlikely(crng_init == 0)) {
 		crng_fast_load(buffer, count);
 		return;
 	}
