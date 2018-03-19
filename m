Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtJj2f3Z/Cw05HYfThV+rq066MSa8odG3vcnIBiMV+XuBJuDlBiHgeTurk6+Mg5V4JOyOQ8
ARC-Seal: i=1; a=rsa-sha256; t=1521483091; cv=none;
        d=google.com; s=arc-20160816;
        b=qqiKmNG7NUqMgVtys+HsP3B8Z4P0w52s2p8TIpi1WkblJB+Ou0AlfmLfDIFb+UHgNm
         8EMqmNVnwlFyZuTDcrKT4iYbcX4RbBEn+Rtgdx9B20v4XGCqhb+RTtu4fJmbZ53ux1sH
         UefTLG7j/zjyILMN/daeTjexdwrJFDh6RAWxAiYPQYid+atqgxCT9qtRxnhtkDGxNpeq
         ZlN5+xX2S6jEQuL9ysfL4o49lhl0CRlBi+4hzLCywABhDPqTsXdvZYlzgDWfDmRmDpdR
         w3yERtomqVLIIoESQXAkuEBi3umRIMi9Z3ycfncwiC7wF0i+jIyupTnjrsjuqFiMH6HH
         0XXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A++OfpP+qgV0tR8uHuJ2dcK8E+QTe6RzO5QJiHUapxc=;
        b=0THTtfD7uxwCD4MQb7L3Tb3PIcI5ULmpZFXdtsyHnkdKLHMeNo2S2cSwHob6tWcu0f
         df+cb8EggiPsL6X7PjJRxKkqBozjXdWGcc8nDdX8BWMA8tYApVdqCsbb/AxVnwFWtniY
         RYc05oSiG8BQ6WAeTwXbwgZbFHWotiQ81wN2NnuV4WMoOj8A2uxVMqTgpb/KSuJ+GDpn
         tN4DttMwUcnZm14RaPu8t+pu6lpv4qanwvzj3UmfOq0ON6wAqfCs/M/LagW/Nw0o9vTS
         tUSZm/WkpbkGXaRgbVwOqPJxgrsCZbyIQ4mY80UvgF8plOra7hHIHMj0NlSQR5WoKbv2
         XxhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Jann Horn <jannh@google.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 64/68] fs/aio: Add explicit RCU grace period when freeing kioctx
Date: Mon, 19 Mar 2018 19:06:42 +0100
Message-Id: <20180319171836.857305687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390653676229913?=
X-GMAIL-MSGID: =?utf-8?q?1595390653676229913?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit a6d7cff472eea87d96899a20fa718d2bab7109f3 upstream.

While fixing refcounting, e34ecee2ae79 ("aio: Fix a trinity splat")
incorrectly removed explicit RCU grace period before freeing kioctx.
The intention seems to be depending on the internal RCU grace periods
of percpu_ref; however, percpu_ref uses a different flavor of RCU,
sched-RCU.  This can lead to kioctx being freed while RCU read
protected dereferences are still in progress.

Fix it by updating free_ioctx() to go through call_rcu() explicitly.

v2: Comment added to explain double bouncing.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jann Horn <jannh@google.com>
Fixes: e34ecee2ae79 ("aio: Fix a trinity splat")
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org # v3.13+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/aio.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -110,7 +110,8 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
-	struct work_struct	free_work;
+	struct rcu_head		free_rcu;
+	struct work_struct	free_work;	/* see free_ioctx() */
 
 	/*
 	 * signals when all in-flight requests are done
@@ -505,6 +506,12 @@ static int kiocb_cancel(struct kiocb *ki
 	return cancel(kiocb);
 }
 
+/*
+ * free_ioctx() should be RCU delayed to synchronize against the RCU
+ * protected lookup_ioctx() and also needs process context to call
+ * aio_free_ring(), so the double bouncing through kioctx->free_rcu and
+ * ->free_work.
+ */
 static void free_ioctx(struct work_struct *work)
 {
 	struct kioctx *ctx = container_of(work, struct kioctx, free_work);
@@ -518,6 +525,14 @@ static void free_ioctx(struct work_struc
 	kmem_cache_free(kioctx_cachep, ctx);
 }
 
+static void free_ioctx_rcufn(struct rcu_head *head)
+{
+	struct kioctx *ctx = container_of(head, struct kioctx, free_rcu);
+
+	INIT_WORK(&ctx->free_work, free_ioctx);
+	schedule_work(&ctx->free_work);
+}
+
 static void free_ioctx_reqs(struct percpu_ref *ref)
 {
 	struct kioctx *ctx = container_of(ref, struct kioctx, reqs);
@@ -526,8 +541,8 @@ static void free_ioctx_reqs(struct percp
 	if (ctx->requests_done)
 		complete(ctx->requests_done);
 
-	INIT_WORK(&ctx->free_work, free_ioctx);
-	schedule_work(&ctx->free_work);
+	/* Synchronize against RCU protected table->table[] dereferences */
+	call_rcu(&ctx->free_rcu, free_ioctx_rcufn);
 }
 
 /*
@@ -749,7 +764,7 @@ static int kill_ioctx(struct mm_struct *
 	table->table[ctx->id] = NULL;
 	spin_unlock(&mm->ioctx_lock);
 
-	/* percpu_ref_kill() will do the necessary call_rcu() */
+	/* free_ioctx_reqs() will do the necessary RCU synchronization */
 	wake_up_all(&ctx->wait);
 
 	/*
