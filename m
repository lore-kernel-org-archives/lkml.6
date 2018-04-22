Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49s8WALoVBUiVZnOieD52SBEBwimPlQZZJy0/ueFoyN1X5TOOjPGWHGCm4LHXC9dSITvSdR
ARC-Seal: i=1; a=rsa-sha256; t=1524406166; cv=none;
        d=google.com; s=arc-20160816;
        b=Mx/sFONoQ18tKlUF4EZ5kcyUhKDNrb7Cw/jQxehkrQbNEL/dGUkv4dYN8lJJD2hnVm
         SsXY/H+ip1zrWme6vnAqngY1Iz04fY4W1/J0lyeBhKmKZGHhZ8zBfTe5kGtI7p30jhXq
         d9xk3jaBvg3trxWMjwdiluteGa2IeAa+qMG2WWohOOZkZLMhkSNJk+WVm6Xhe6YtpURf
         +LUOOI/Qt6Lp/oJX+yiUpMlGlvxMft4xrwYVc4PQzK1OJB7nNQZHkT0xoEEypOrZgUdu
         0yHQ0BUUxVx0uN+3FgRtQFsQu4jGMeDcZp0cp4giOGt4YmHc82e1+M+s1Eljk8M8tAnq
         C6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=610ypDWWP6RJf/+0WfbbhA+w06LQQIbb2bzvPkin1LY=;
        b=R8M/HPf2Wxy83SFlBiMhJIga2YOBG6wgnBZx54cu3L6T+aNEH/NLkAAeWY0Bww1Owq
         QyTq/xWjaeRfVhgqpeyEoOgs/EyrDT2PDdI40vUr7C85vdXPe9/EMBLU5AogYLyF4Quy
         11cnSxqMiAV8p8NGt9YiLThSGIcL+OhFFsKCiRnelU3f+WmNyD+H351FpID95OnX3xno
         iszktPTLuk50cUFyPrYAdSKLbjcKGSK/glnyn38DzCSntUtwaI3N0BdJhQjd73Ud82+/
         sBh5r7X0Cr4Hh+324FYeNZRqKQb9x2eF9oY7wMCTY+N17ESNQbabmK79wZxRCwlFxFrQ
         9eqw==
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
Subject: [PATCH 4.14 136/164] random: crng_reseed() should lock the crng instance that it is modifying
Date: Sun, 22 Apr 2018 15:53:23 +0200
Message-Id: <20180422135140.963679620@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455239599364242?=
X-GMAIL-MSGID: =?utf-8?q?1598455720877486387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -905,7 +905,7 @@ static void crng_reseed(struct crng_stat
 		_crng_backtrack_protect(&primary_crng, buf.block,
 					CHACHA20_KEY_SIZE);
 	}
-	spin_lock_irqsave(&primary_crng.lock, flags);
+	spin_lock_irqsave(&crng->lock, flags);
 	for (i = 0; i < 8; i++) {
 		unsigned long	rv;
 		if (!arch_get_random_seed_long(&rv) &&
@@ -915,7 +915,7 @@ static void crng_reseed(struct crng_stat
 	}
 	memzero_explicit(&buf, sizeof(buf));
 	crng->init_time = jiffies;
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
+	spin_unlock_irqrestore(&crng->lock, flags);
 	if (crng == &primary_crng && crng_init < 2) {
 		invalidate_batched_entropy();
 		numa_crng_init();
