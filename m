Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsRQsgsUxkf4DFuFFfXVrI8MarwiDmu/zm+PtTM/QiIe5QAp1YB5sUlkgDL+RuV6xHN5iEn
ARC-Seal: i=1; a=rsa-sha256; t=1521483433; cv=none;
        d=google.com; s=arc-20160816;
        b=O+dLlzza0hdifKARKGcrl8xPngLdDnykhZ5UUdJ5DGgQhmyn4JedMLNE3ylF93GIax
         4RYjEouQroJ/xQ7hExLz73Wm/rhLeBpDcXHg/EMIVbmUwMZe26LNRANf84mXQdf1Hopv
         tE0LvGnfVxcAHFETBOYLRq8L8Lm9dG83Bt+RmrDj4cP5CvgZ6FynOb4HU38auJActFYK
         L61ldEtUROeRj6a29mgbZ+pib0LI6BG2SSu7es+W0qCKBIcqiczlC7sS3ckCaXuuKGiv
         mflicfoSZpwterfr5Zpzcartu7x0H6zuKMOQ5qbWpo7eqTCQObvIKM2RFFhiYfe+8cO5
         m5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d/XgSZ17ffe6brS00XHyihrcV9XMZB9W46RNwfSrKYg=;
        b=vn4K7v0LEp/cRxBxUV5Rk05tptDjAAK054Os9U8m5Cee2pb9yorr9PlijCQ+INlXw4
         NOK6pawQqxROxVpopLyxwYqF7dkK1mhpi0LoeCbedaK4SdwwsdWOim6SwZdKeYI3ZJxN
         QspT6F3Wnv8vWd3x2gnAOZaKAJ37hN3Swf8D60akpOBLSxDLwEagy4PIpc+1+ISUQ7qa
         m40Ahoeqf6aX8/ln1rU6vQa7RwRf6zosueimS+rc6+WpbfT5pHVqh/HaDMb8V8ZEYlaO
         zzjuLYAK8AdJkyJvLmNvKq67+/ZRAvfVi/eA6H88WBRtQRJNSn9x/bB4Ioi1ywvHe888
         t6kw==
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
Subject: [PATCH 4.4 123/134] fs/aio: Add explicit RCU grace period when freeing kioctx
Date: Mon, 19 Mar 2018 19:06:46 +0100
Message-Id: <20180319171907.024713687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390653676229913?=
X-GMAIL-MSGID: =?utf-8?q?1595391012964153878?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -115,7 +115,8 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
-	struct work_struct	free_work;
+	struct rcu_head		free_rcu;
+	struct work_struct	free_work;	/* see free_ioctx() */
 
 	/*
 	 * signals when all in-flight requests are done
@@ -573,6 +574,12 @@ static int kiocb_cancel(struct aio_kiocb
 	return cancel(&kiocb->common);
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
@@ -586,6 +593,14 @@ static void free_ioctx(struct work_struc
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
@@ -594,8 +609,8 @@ static void free_ioctx_reqs(struct percp
 	if (ctx->rq_wait && atomic_dec_and_test(&ctx->rq_wait->count))
 		complete(&ctx->rq_wait->comp);
 
-	INIT_WORK(&ctx->free_work, free_ioctx);
-	schedule_work(&ctx->free_work);
+	/* Synchronize against RCU protected table->table[] dereferences */
+	call_rcu(&ctx->free_rcu, free_ioctx_rcufn);
 }
 
 /*
@@ -817,7 +832,7 @@ static int kill_ioctx(struct mm_struct *
 	table->table[ctx->id] = NULL;
 	spin_unlock(&mm->ioctx_lock);
 
-	/* percpu_ref_kill() will do the necessary call_rcu() */
+	/* free_ioctx_reqs() will do the necessary RCU synchronization */
 	wake_up_all(&ctx->wait);
 
 	/*
