Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224KysS7PUGhwchzsz8D9FOMVlQdDXfMCkgB5KchG0O97IXvd3Y9LN9PZQgNYKFO8R9tX89e
ARC-Seal: i=1; a=rsa-sha256; t=1519412186; cv=none;
        d=google.com; s=arc-20160816;
        b=nT4hqqv48YRwoOjSjERf5muLemJ8Levq9jDuh4uvfn+GS+/2GkYNAhR0ghSOCMFsms
         LM7I+qVZSGaCMcY1+WsDApEKzNWKp/38EjAap3jefE5OuePAlk+8W6uLkDjIBcGPxWAP
         g/mPYDdQ1vWVF6PLJ5kP4Z5EnhX9KvMTicxdOdTInxbJPcjLwKryjlmR6+vGyIkowCQh
         V5PMjQDbuMfcmnUiheOncLh+iR/pKnLt6XuAJJ/2MUOScoBQVSSzkq18PP3iVOqVgINc
         hAzEp/Xf6OoYgVjvWGjBBXgs5ECkezKjxgrrKHo5on+TsNQT1AXYiuJV4h8I6/YhSSI1
         SkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DOM7e+MJQ+s+aPPN+BBfOxhx9abSYXVY5ElPbUkam4M=;
        b=tGwwnSmX23AwiXnev8hNdR8UAfMQo8iyHtL6vnQc8jGG3qfsN214bsNZwykys3To7w
         v/HOBJDRREj0f4ZGAZ1Aotb2AxEu9PBzsAaKU1/HAyWwlPchiBMUxC/X4Lq3LBPg0llO
         Ta4WoheYeAcG9/vc+AU/rAVavlEYWi0H9diHm41TBh3PZeHnf8zgYTvOK4Idb42aqNg1
         LAAoXwgFtohDltuIjQNN4nHFQRrWQssOV5WndN3yC/7a2b3bR9lAUSQEXK75UcUMVpny
         AvbsOQIrLQbSXD+nHEbk9wPBgD4zuKN7SKPp/ecTzmHwbHfOiQflqTXtYK8IJo5blns0
         kqqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 117/159] locking/lockdep: Fix possible NULL deref
Date: Fri, 23 Feb 2018 19:27:05 +0100
Message-Id: <20180223170757.473100358@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219152765368041?=
X-GMAIL-MSGID: =?utf-8?q?1593219152765368041?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>


[ Upstream commit 5e351ad106997e06b2dc3da9c6b939b95f67fb88 ]

We can't invalidate xhlocks when we've not yet allocated any.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Fixes: f52be5708076 ("locking/lockdep: Untangle xhlock history save/restore from task independence")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/lockdep.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4777,7 +4777,8 @@ void lockdep_invariant_state(bool force)
 	 * Verify the former, enforce the latter.
 	 */
 	WARN_ON_ONCE(!force && current->lockdep_depth);
-	invalidate_xhlock(&xhlock(current->xhlock_idx));
+	if (current->xhlocks)
+		invalidate_xhlock(&xhlock(current->xhlock_idx));
 }
 
 static int cross_lock(struct lockdep_map *lock)
