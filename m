Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvmC3DIwy+XyUWX3d5dGkACgiI7P1S4UzeTV+gPShuXlG9hlhRjaPh0m2VXhXMBPD9XaAmJ
ARC-Seal: i=1; a=rsa-sha256; t=1521484096; cv=none;
        d=google.com; s=arc-20160816;
        b=e8CXq6wLrFV/A6x55kBhIjtk+uU/RKMtdmzq5sFondQrU2iBWi0FhruTBZw/IVz3FT
         GA90u7RyksXD831TvsAEebgpZkemA3/C+0wlKF2uU3pIYIPMIJF3IsJLhqokJEq94Uih
         nqi8IzCxeKrxrjzOMPbynlU25k58mq+7IE2XdfOOnYbf6kvCvkQZDQaawOpGZkTG0gs4
         IvwWc5blzgBMuyhSTtNYgnB3+6QaReiqXb7V8Wfr3QfpeKqFdwiR9PIr8vOCOAto5Irp
         fuJo0OK4yRameJLOrJ0Y4yJIW2mMCOKb+bxz2dJz0123JexEpFhpqwVZ5fFp8J+UvVT9
         8VkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jo3WKLPq9X/WOAUfENi+zNiTCf4baiqVqcE5ZpvmRKw=;
        b=S2rD8J+jXRJyrKSX83PLfgAnw7P4gvbsknq1j8BNrkJWY8vIlvvz6/Uu+ZT0/ZhP+6
         TdBcjHd8QLaVUxNzzr981XbJgnZsc8KJDdZrzRTxsWwEg3zgch0paIbUm6XAqTB2Cf4F
         X2FkWaCIwcBqViu0QZVSgQuWqOzTxynmquXiAlq230LA+e2az7hLZiTWPFBayRDo5jVi
         SpBviRARghI/mMKV2FgJMW4AwoWICaffK9z6EmYUVY3iZcjFKshuD0KpuoYrYEVULog5
         tTq4y3X1dRI1cKGXkZGIkiQnHDZQ+0fRdrK+Z4arMfHRNahjGmQ2uMUReuPH/697WFIV
         IR8g==
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
	Benjamin LaHaise <bcrl@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 231/241] fs/aio: Use RCU accessors for kioctx_table->table[]
Date: Mon, 19 Mar 2018 19:08:16 +0100
Message-Id: <20180319180800.735068986@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390659140496650?=
X-GMAIL-MSGID: =?utf-8?q?1595391708045187081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit d0264c01e7587001a8c4608a5d1818dba9a4c11a upstream.

While converting ioctx index from a list to a table, db446a08c23d
("aio: convert the ioctx list to table lookup v3") missed tagging
kioctx_table->table[] as an array of RCU pointers and using the
appropriate RCU accessors.  This introduces a small window in the
lookup path where init and access may race.

Mark kioctx_table->table[] with __rcu and use the approriate RCU
accessors when using the field.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jann Horn <jannh@google.com>
Fixes: db446a08c23d ("aio: convert the ioctx list to table lookup v3")
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org # v3.12+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/aio.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -68,9 +68,9 @@ struct aio_ring {
 #define AIO_RING_PAGES	8
 
 struct kioctx_table {
-	struct rcu_head	rcu;
-	unsigned	nr;
-	struct kioctx	*table[];
+	struct rcu_head		rcu;
+	unsigned		nr;
+	struct kioctx __rcu	*table[];
 };
 
 struct kioctx_cpu {
@@ -330,7 +330,7 @@ static int aio_ring_mremap(struct vm_are
 	for (i = 0; i < table->nr; i++) {
 		struct kioctx *ctx;
 
-		ctx = table->table[i];
+		ctx = rcu_dereference(table->table[i]);
 		if (ctx && ctx->aio_ring_file == file) {
 			if (!atomic_read(&ctx->dead)) {
 				ctx->user_id = ctx->mmap_base = vma->vm_start;
@@ -659,9 +659,9 @@ static int ioctx_add_table(struct kioctx
 	while (1) {
 		if (table)
 			for (i = 0; i < table->nr; i++)
-				if (!table->table[i]) {
+				if (!rcu_access_pointer(table->table[i])) {
 					ctx->id = i;
-					table->table[i] = ctx;
+					rcu_assign_pointer(table->table[i], ctx);
 					spin_unlock(&mm->ioctx_lock);
 
 					/* While kioctx setup is in progress,
@@ -836,8 +836,8 @@ static int kill_ioctx(struct mm_struct *
 	}
 
 	table = rcu_dereference_raw(mm->ioctx_table);
-	WARN_ON(ctx != table->table[ctx->id]);
-	table->table[ctx->id] = NULL;
+	WARN_ON(ctx != rcu_access_pointer(table->table[ctx->id]));
+	RCU_INIT_POINTER(table->table[ctx->id], NULL);
 	spin_unlock(&mm->ioctx_lock);
 
 	/* free_ioctx_reqs() will do the necessary RCU synchronization */
@@ -882,7 +882,8 @@ void exit_aio(struct mm_struct *mm)
 
 	skipped = 0;
 	for (i = 0; i < table->nr; ++i) {
-		struct kioctx *ctx = table->table[i];
+		struct kioctx *ctx =
+			rcu_dereference_protected(table->table[i], true);
 
 		if (!ctx) {
 			skipped++;
@@ -1071,7 +1072,7 @@ static struct kioctx *lookup_ioctx(unsig
 	if (!table || id >= table->nr)
 		goto out;
 
-	ctx = table->table[id];
+	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
 		percpu_ref_get(&ctx->users);
 		ret = ctx;
