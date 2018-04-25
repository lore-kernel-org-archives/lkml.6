Return-Path: <opendmb@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524699653; cv=none;
        d=google.com; s=arc-20160816;
        b=yF0EA35gXQ/eNpWKDOzBGhKqCd4aA4DzwSK1f/3ghnIMyU5/z1OKcp3qJQIYsnKMpv
         yzQzBvtJaM3xbh0VV38ONPjnToxbf+glZawxJdVig4zZ6RTCsidolUyoL58EHIyCwsYQ
         pF/WBzYOHnPn4tHmMnhY++wDxzz0Px0CUOPgM/qwrczu3euDo9ZZTnhdmULu0jgvCXBn
         v7X5uIJIYP2q38bcGw7+oiXe7valFd/CjfxsgcI++NrrZqeOa0G7Sg3iIukXgtY7AXry
         0ug7kposusv393TRehHNBpjaGbI2KH5DKsI4FM4y69Y/Kt/Fw3s0mMCW02hQW319AIW6
         Rj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=57ZcBhPMO/Mv73uLpTyizcSpI54Kkqk+NugqTChZEEA=;
        b=yb1j7DH8yIA6MoO46Q4/cXI0oBYm19mtt99Duy8SC4DzkUVwvnxD1sz3xmSAkHJoeZ
         jItkD9PvZIzm7mrrMURcmRPIu6Sc1c7lwPk5mEAuty7ChYbXNBKv9c6Vgh0c3FJ4T9w5
         8g8Y6rsrGV/9a8kZ3uh+cxWy/kVwg7jUnIfA8aIoZTOlHxoFgdYyMt7AriC3TWaO2pAx
         lywH7nm7xTz5tKtdCGeFrK+4zLmSyythzoG5MvWXN9ycpgSxyPTYaITHxI9M5rBXnR/F
         c4BD/mfN/xMWxVZusaAoCOp38NJMu/XNcU16pLT+pMWec/sq3d78x9Rk9urW5o88MJ2J
         /VVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WJLKtBoX;
       spf=pass (google.com: domain of opendmb@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opendmb@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WJLKtBoX;
       spf=pass (google.com: domain of opendmb@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opendmb@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+uhe7sTOtNGZs4wWhLlvSwx01wVmmC804pKa8Mddg8pzoH/KyTd9Q1pzTXEtAaGQCFw85TXg==
From: Doug Berger <opendmb@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH] PM / Sleep: only update last time for active wakeup sources
Date: Wed, 25 Apr 2018 16:40:30 -0700
Message-Id: <1524699630-30573-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598763463471847580?=
X-GMAIL-MSGID: =?utf-8?q?1598763463471847580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When wakelock support was added, the wakeup_source_add() function
was updated to set the last_time value of the wakeup source. This
has the unintended side effect of producing confusing output from
pm_print_active_wakeup_sources() when a wakeup source is added
prior to a sleep that is blocked by a different wakeup source.

The function pm_print_active_wakeup_sources() will search for the
most recently active wakeup source when no active source is found.
If a wakeup source is added after a different wakeup source blocks
the system from going to sleep it may have a later last_time value
than the blocking source and be output as the last active wakeup
source even if it has never actually been active.

It looks to me like the change to wakeup_source_add() was made to
prevent the wakelock garbage collection from accidentally dropping
a wakelock during the narrow window between adding the wakelock to
the wakelock list in wakelock_lookup_add() and the activation of
the wakeup source in pm_wake_lock().

This commit changes the behavior so that only the last_time of the
wakeup source used by a wakelock is initialized prior to adding it
to the wakeup source list. This preserves the meaning of the
last_time value as the last time the wakeup source was active and
allows a wakeup source that has never been active to have a
last_time value of 0.

Fixes: b86ff982 ("PM / Sleep: Add user space interface for manipulating wakeup sources, v3")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/base/power/wakeup.c | 1 -
 kernel/power/wakelock.c     | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index ea01621..230160e 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -183,7 +183,6 @@ void wakeup_source_add(struct wakeup_source *ws)
 	spin_lock_init(&ws->lock);
 	timer_setup(&ws->timer, pm_wakeup_timer_fn, 0);
 	ws->active = false;
-	ws->last_time = ktime_get();
 
 	spin_lock_irqsave(&events_lock, flags);
 	list_add_rcu(&ws->entry, &wakeup_sources);
diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index dfba59b..4210152 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -188,6 +188,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 		return ERR_PTR(-ENOMEM);
 	}
 	wl->ws.name = wl->name;
+	wl->ws.last_time = ktime_get();
 	wakeup_source_add(&wl->ws);
 	rb_link_node(&wl->node, parent, node);
 	rb_insert_color(&wl->node, &wakelocks_tree);
-- 
2.7.4
