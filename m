Return-Path: <linux@rasmusvillemoes.dk>
ARC-Seal: i=1; a=rsa-sha256; t=1519860181; cv=none;
        d=google.com; s=arc-20160816;
        b=b7UOrkfngbGb7VzJIUPNLm9u2oCb4QQYTlN2UKVxPaZ61W0O2FABdmBXlHkE0+uGb6
         YDW5sTWX+FLa4I/V9sa9Q1En7+xJtsg2J7ntt24v4P2THBWpXjDKxh2JjG75qm7ayynk
         ImBLwHEUmu1tybnF8v3hhSrJeCZMHEMhuCHvas8YqLtSO+LJ1dkwIdIxx0g6B+Rlh4hS
         Wc1tiSaFstLua3Z83Sot/irbPnkdJjAWU9vERV30FTEuuMC4BgJ6KFxwM5CGErXvfiaD
         jVKHDb1f2C6kVr95SzZ/dPN8lTHamPca8MOCUoXBjilTezQfv6roSFFoamiJWCMqCgEh
         889w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=y4lIwZBy83kkAtY3JWGGMiDSThgTEzVLEUw27b5wT4I=;
        b=fxrLT15MJTgpevpBBpB914iAnnWioE0AD2n2dFzllKZWWaqvNqB6FeSJd/wPaocL0T
         Ui9jYx6/1QPNmsOiYT3l+a6RGimquhwPO5SY7Bq5tIINRJbVMDYorzxh/mSWlNbBxVfs
         HlnxPy/alvynbsShS2bRSxSWABHba3mAvi+qg+M9CizL3EbGPFOERQ4sb7vPSy4mQKHu
         E3YLUoFtODKqM+pKJTVPzS1RV7d58FLcendF4A17oRPY1ZviVa7Gc9KuOYN1KkVHaLHP
         3JVw32uzHMlL6cksNnMOqcBurz0UFR2zBp8wip4esCn018FIHM1J/aDXTe2kXl6FbHDd
         ehZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=T0ZAYtt5;
       spf=pass (google.com: domain of linux@rasmusvillemoes.dk designates 209.85.220.65 as permitted sender) smtp.mailfrom=linux@rasmusvillemoes.dk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=T0ZAYtt5;
       spf=pass (google.com: domain of linux@rasmusvillemoes.dk designates 209.85.220.65 as permitted sender) smtp.mailfrom=linux@rasmusvillemoes.dk
X-Google-Smtp-Source: AG47ELufW4cBhinitqkFKK+tTrXKvqgAREsZJvzkQ2ts16CewFMmVsVa8i5MA+By6defXlTkiJlr0w==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH resend] drivers/char/random.c: remove unused dont_count_entropy
Date: Thu,  1 Mar 2018 00:22:47 +0100
Message-Id: <20180228232247.16368-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593688909749149990?=
X-GMAIL-MSGID: =?utf-8?q?1593688909749149990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ever since "random: kill dead extract_state struct" [1], the
dont_count_entropy member of struct timer_rand_state has been
effectively unused. Since it hasn't found a new use in 12 years, it's
probably safe to finally kill it.

[1] Pre-git, https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=c1c48e61c251f57e7a3f1bf11b3c462b2de9dcb5

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/char/random.c | 53 ++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e5b3d3ba4660..767c6c10f9a3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -963,7 +963,6 @@ static ssize_t extract_crng_user(void __user *buf, size_t nbytes)
 struct timer_rand_state {
 	cycles_t last_time;
 	long last_delta, last_delta2;
-	unsigned dont_count_entropy:1;
 };
 
 #define INIT_TIMER_RAND_STATE { INITIAL_JIFFIES, };
@@ -1029,35 +1028,33 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 	 * We take into account the first, second and third-order deltas
 	 * in order to make our estimate.
 	 */
+	delta = sample.jiffies - state->last_time;
+	state->last_time = sample.jiffies;
+
+	delta2 = delta - state->last_delta;
+	state->last_delta = delta;
+
+	delta3 = delta2 - state->last_delta2;
+	state->last_delta2 = delta2;
+
+	if (delta < 0)
+		delta = -delta;
+	if (delta2 < 0)
+		delta2 = -delta2;
+	if (delta3 < 0)
+		delta3 = -delta3;
+	if (delta > delta2)
+		delta = delta2;
+	if (delta > delta3)
+		delta = delta3;
 
-	if (!state->dont_count_entropy) {
-		delta = sample.jiffies - state->last_time;
-		state->last_time = sample.jiffies;
-
-		delta2 = delta - state->last_delta;
-		state->last_delta = delta;
-
-		delta3 = delta2 - state->last_delta2;
-		state->last_delta2 = delta2;
-
-		if (delta < 0)
-			delta = -delta;
-		if (delta2 < 0)
-			delta2 = -delta2;
-		if (delta3 < 0)
-			delta3 = -delta3;
-		if (delta > delta2)
-			delta = delta2;
-		if (delta > delta3)
-			delta = delta3;
+	/*
+	 * delta is now minimum absolute delta.
+	 * Round down by 1 bit on general principles,
+	 * and limit entropy entimate to 12 bits.
+	 */
+	credit_entropy_bits(r, min_t(int, fls(delta>>1), 11));
 
-		/*
-		 * delta is now minimum absolute delta.
-		 * Round down by 1 bit on general principles,
-		 * and limit entropy entimate to 12 bits.
-		 */
-		credit_entropy_bits(r, min_t(int, fls(delta>>1), 11));
-	}
 	preempt_enable();
 }
 
-- 
2.15.1
