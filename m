Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+k8zfKkrppC9Yrd2iLMuBX/CDSOSxhFPvlWAH6nY5b1/ZYiW+UuGVqUEW4bcKr5UZp+Ozv
ARC-Seal: i=1; a=rsa-sha256; t=1524405800; cv=none;
        d=google.com; s=arc-20160816;
        b=oBfsjyjHEveVdQTj40GgGgIBNmpWHptQ3fEQFMXQGzEaQ7GWLWO0SWegOD2l9SdfWO
         YtOO6zPbCtGJfjTbbwcoARKCtmXe2kQLbqcf98AoHodgLcUtFzFwlU1Wd2eS3pL+/IkH
         mMrf3X+POzgD2YuHsEjGOOf/yhXls47LpUmyG9Lwdf7a+3nBSjTAtlUkmWY3mgPSQkBY
         YfXsNSrsc5RB1TCRkI5NCVt27Vnhr+m+ojUv3g+lVdRNmfSGMPi4E4ETesTSqCKjgdde
         LwNQ2ezYRQgcWa0fnVBzMm0+GCA9c3f1YJiCvoqMV/K+R36o4pTAMMOfZE7jgiA6+Uh4
         iFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9rN2lu/tiiKWYhfLQi4k3qph+GV1gtjVTUrWkwtc8Xg=;
        b=QjOdR5F49XfqBnPkMxeG+r07A+tz4B3g/0GnrtHTKIcQd9l5GDYktys2qZDgjT0SrG
         ZM3riSQkOnIqenjPsfRrg+NLLCyXOYPuMT7lnLon3BKWVJxq1iJagFFqCGDVsw05nFIO
         bY3v6fF+ghEJsoSr2pxmZbgV1DvlH1U5+M1T5KmfLjWMbog38jakCqv7nCLe2DAhuO3X
         ttXngHc+DY//iC1d+MeOC4Ves03R9M+wOge3dPJu3U3tywPf/jXopTMjSsYE0SO3LNsA
         5YEaHl2cCLPU4BqBbyxIsW6EirLM1fVNuH5P3Kx7KemQks9Y0sDCkIJ96CGaPZU7CNYv
         +6Yw==
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
Subject: [PATCH 4.16 164/196] random: use a different mixing algorithm for add_device_randomness()
Date: Sun, 22 Apr 2018 15:53:04 +0200
Message-Id: <20180422135112.744932103@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455336747684985?=
X-GMAIL-MSGID: =?utf-8?q?1598455336747684985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit dc12baacb95f205948f64dc936a47d89ee110117 upstream.

add_device_randomness() use of crng_fast_load() was highly
problematic.  Some callers of add_device_randomness() can pass in a
large amount of static information.  This would immediately promote
the crng_init state from 0 to 1, without really doing much to
initialize the primary_crng's internal state with something even
vaguely unpredictable.

Since we don't have the speed constraints of add_interrupt_randomness(),
we can do a better job mixing in the what unpredictability a device
driver or architecture maintainer might see fit to give us, and do it
in a way which does not bump the crng_init_cnt variable.

Also, since add_device_randomness() doesn't bump any entropy
accounting in crng_init state 0, mix the device randomness into the
input_pool entropy pool as well.  This is related to CVE-2018-1108.

Reported-by: Jann Horn <jannh@google.com>
Fixes: ee7998c50c26 ("random: do not ignore early device randomness")
Cc: stable@kernel.org # 4.13+
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -786,6 +786,10 @@ static void crng_initialize(struct crng_
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
 
+/*
+ * crng_fast_load() can be called by code in the interrupt service
+ * path.  So we can't afford to dilly-dally.
+ */
 static int crng_fast_load(const char *cp, size_t len)
 {
 	unsigned long flags;
@@ -812,6 +816,51 @@ static int crng_fast_load(const char *cp
 	return 1;
 }
 
+/*
+ * crng_slow_load() is called by add_device_randomness, which has two
+ * attributes.  (1) We can't trust the buffer passed to it is
+ * guaranteed to be unpredictable (so it might not have any entropy at
+ * all), and (2) it doesn't have the performance constraints of
+ * crng_fast_load().
+ *
+ * So we do something more comprehensive which is guaranteed to touch
+ * all of the primary_crng's state, and which uses a LFSR with a
+ * period of 255 as part of the mixing algorithm.  Finally, we do
+ * *not* advance crng_init_cnt since buffer we may get may be something
+ * like a fixed DMI table (for example), which might very well be
+ * unique to the machine, but is otherwise unvarying.
+ */
+static int crng_slow_load(const char *cp, size_t len)
+{
+	unsigned long		flags;
+	static unsigned char	lfsr = 1;
+	unsigned char		tmp;
+	unsigned		i, max = CHACHA20_KEY_SIZE;
+	const char *		src_buf = cp;
+	char *			dest_buf = (char *) &primary_crng.state[4];
+
+	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
+		return 0;
+	if (crng_init != 0) {
+		spin_unlock_irqrestore(&primary_crng.lock, flags);
+		return 0;
+	}
+	if (len > max)
+		max = len;
+
+	for (i = 0; i < max ; i++) {
+		tmp = lfsr;
+		lfsr >>= 1;
+		if (tmp & 1)
+			lfsr ^= 0xE1;
+		tmp = dest_buf[i % CHACHA20_KEY_SIZE];
+		dest_buf[i % CHACHA20_KEY_SIZE] ^= src_buf[i % len] ^ lfsr;
+		lfsr += (tmp << 3) | (tmp >> 5);
+	}
+	spin_unlock_irqrestore(&primary_crng.lock, flags);
+	return 1;
+}
+
 static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 {
 	unsigned long	flags;
@@ -981,10 +1030,8 @@ void add_device_randomness(const void *b
 	unsigned long time = random_get_entropy() ^ jiffies;
 	unsigned long flags;
 
-	if (!crng_ready()) {
-		crng_fast_load(buf, size);
-		return;
-	}
+	if (!crng_ready() && size)
+		crng_slow_load(buf, size);
 
 	trace_add_device_randomness(size, _RET_IP_);
 	spin_lock_irqsave(&input_pool.lock, flags);
