Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/OljuGyJLnRWk1YHbI5K0z5JT7pC46mnlhr56sU9yIyliQUwy/uTh4GYAXojgk4ds02qlg
ARC-Seal: i=1; a=rsa-sha256; t=1524406449; cv=none;
        d=google.com; s=arc-20160816;
        b=lYSLIocxbfnzwT9PRuU+7f1L0moxx++XmXS88CHyuhSSBMO+ZCnpFyG+YgA6rOt5LO
         5sjzHoAhqvOlu8yHSst4WoNsG67MhLDBbOnKBFyoKtgjJ79Rnpe07NPemfu6pq4vZJ1t
         NdhEmaXAJmEkRq92ZwHTG2fW6UKvLKnfIWLdu2JsIAHhxdtQ9yg9OWl5PXP1V/PQOoNb
         c3xFidX/8UNAbJyRWV38XA4YbUS2ZT9nKuBj2hNkfF1oFi5tCbERR4WPmXSeb90MzOjX
         W54TAfZlHrRlsm1q1HxYkZAOO6c8MAGsjFic1wcf6wNruTyzSQ2r1Bz48MjcYN+9sD8L
         UFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8lQ3tnK5Q98EM/dj/unimxNhFyv3Vsq6oZZh39Ch5G8=;
        b=08tmCgznKRHzXMoZeEHvJPplhWzU2jKTRyb5I1K96b3rBhyqVWSY2scXkurSDWxDSk
         CZ5PjZDhmeosBpAJmcEZfTxuyP6DdgRXFlTBhmRNlwKjwfbb6GaRVMXMmuYzTKHYU0JH
         hlywAWGT8a4jIMd2qy8Xx9qy9MVPKgyNnNA+c8T0nm/aIxjmGTZnpMFV4ErCnDXe2Jbo
         lyxQsMWvsHCWXQH0croVU9ZlwuzobFGNM2mC1cotMyHd3Le7GqhoIy4PHhlNvFcF04BL
         a0p2wPvrmqE8D4/L2CwLn9iL5U+4wxv49hp454zjH4L/A/zAnEvSaXykPM6CNkjZ3Kif
         UG1A==
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
Subject: [PATCH 4.9 76/95] random: crng_reseed() should lock the crng instance that it is modifying
Date: Sun, 22 Apr 2018 15:53:45 +0200
Message-Id: <20180422135213.537529455@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455239599364242?=
X-GMAIL-MSGID: =?utf-8?q?1598456017028822641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 0bb29a849a6433b72e249eea7695477b02056e94 upstream.

Reported-by: Jann Horn <jannh@google.com>
Fixes: 1e7f583af67b ("random: make /dev/urandom scalable for silly...")
Cc: stable@kernel.org # 4.8+
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -862,7 +862,7 @@ static void crng_reseed(struct crng_stat
 		_crng_backtrack_protect(&primary_crng, buf.block,
 					CHACHA20_KEY_SIZE);
 	}
-	spin_lock_irqsave(&primary_crng.lock, flags);
+	spin_lock_irqsave(&crng->lock, flags);
 	for (i = 0; i < 8; i++) {
 		unsigned long	rv;
 		if (!arch_get_random_seed_long(&rv) &&
@@ -879,7 +879,7 @@ static void crng_reseed(struct crng_stat
 		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: crng init done\n");
 	}
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
+	spin_unlock_irqrestore(&crng->lock, flags);
 }
 
 static inline void maybe_reseed_primary_crng(void)
