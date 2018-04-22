Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48elZMj734RWHJaTL6KHv3WewypNL99nSQku34Vaqlk8rfMc+97ojCcE9pWabq2k3aOoRou
ARC-Seal: i=1; a=rsa-sha256; t=1524405708; cv=none;
        d=google.com; s=arc-20160816;
        b=yoOs81g742ABmZ8BUk5ZpCBh+PVVwD7mqer8YiJzqwV80rGl10zFeaQwu7nAM5AcB7
         TFd5UEMBZL7ZNh5uf7n4Fn3HTT80Btq0LavF4KKhQHhIhIER4KeULBCAFLO+TXgeSONG
         Dy7nuXW84jsqWjpG+pFNdxQ8JscWcpNbGrtqBY6C1xLz93PDz13gxpZWV3yaDllzHyr2
         u43Pdkm1L4XOB76VhO0f6w1bUg9hCk0TuOhez1h11dS/l0GvEObVGcDngsRZip57rpex
         UL/MW0+w6tAElng28NQhBYe2n4nut5W79/K7wX0lV6ftAC1UC27zho+VRPTrzDzXj1/7
         lUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pxhDh2TKOouIfvlNJ3tXa0esNlQ8ljQeUNc2S6QUZ0A=;
        b=rYXoi033xY8gvjjFqG+Fl6cUdjIxpyRK55P8ig532M8gpt4nsR6tjHA8W292qDKk4e
         v9qLcIJE36nlbNmkivQzYpk8ddROm9x1Fh21yZL10yMRhkhI7E0BuybtcucAFtuvPge8
         PvdtZSjQ/ZKSHlp3El5EYApw+bZ3v5utQoYu35oLOOqqaY3ZQZ9rAGtmtaDDU23byhsG
         uDHmX5zl8XsLUgIQFfF/er3rdyRKOkmDpIuKhzq0azVlvc6WLyc8CqwQtABalw7y1GAS
         XEeDuEyvVPewoopKkskVWPZerPwB/1Hl4w5QtIUN3+Px4N4WgnT+zQMNdKH3z6alp42k
         3hVw==
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
Subject: [PATCH 4.16 166/196] random: crng_reseed() should lock the crng instance that it is modifying
Date: Sun, 22 Apr 2018 15:53:06 +0200
Message-Id: <20180422135112.860567110@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455239599364242?=
X-GMAIL-MSGID: =?utf-8?q?1598455239599364242?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
