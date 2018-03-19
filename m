Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtbl653JsX04uYKImZa/jDGvaTaICXOWzZmdq6DIm762ydKd4oaKcmle1/m155TvXkrSPkW
ARC-Seal: i=1; a=rsa-sha256; t=1521484254; cv=none;
        d=google.com; s=arc-20160816;
        b=NjeY42yajED0Ee+/+cSx2ss4ZQrQPLqAvYtw13k61rYBDpTxEOHHAGRFd1SZxsJdfy
         OlfRov0UhyRu/s/h8kDwauuDUpcS9zrXSQWMNSB5Tm85PCUMqa8q1l2CwZsQ8/5IjiVn
         hs5POX/Gwy16JmN+qYC9R9lKfdL2stsZvY0OCpRhv3VIpDn3vwlfRraJMaTjDTUhkT8+
         rBA3ETsVKPhgo9ecjJF41SytHeYHQjwezOInZRubGVnsQqfl/P/t5ItMFalkSmEaS4UC
         m+BVQEehbeRWglRVcTzjPhSUJqc4XOLFn/ZI438VIrJ9bIWvrkZNbc9qtkYbUCWj2PQF
         xk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KuwoqJ8v4Ecs1mhtC9IU9hsd+vkXRqV78m3cda4xHMA=;
        b=LHdlgg7PvG4CemR6mDhg1zuyp53y7gYBubHxJ0NyDBDxRQgTeGv7kv3V0QMMdlX43O
         GG3fffy2EG1FVSirU/DTifMwb7nPd8NrLY5KscG9TwR5sZxoVLb5KOYMqTuREUOvsVoj
         LQNI+jpalOytfJq/8aIic2bS8IDe3PNEHxmVLduYs7gXdfTbBGbBppXvaMn9QhZ63qva
         4SfYiMk7dtHPj4vAQA5XpnvgP5FRhMmiQX4TD6hUXTT4owv3fa+kBQt3XSRd+u55jyJH
         1c0PGIiM86P9MiXi0+it8J7UIn9s0nGecQlmpqAqJcatiVKopWM1+73QDUxHAlFAWE2U
         K/aQ==
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
Subject: [PATCH 4.14 27/41] fs/aio: Use RCU accessors for kioctx_table->table[]
Date: Mon, 19 Mar 2018 19:08:27 +0100
Message-Id: <20180319180734.010640992@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390659140496650?=
X-GMAIL-MSGID: =?utf-8?q?1595391874004660990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -666,9 +666,9 @@ static int ioctx_add_table(struct kioctx
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
@@ -849,8 +849,8 @@ static int kill_ioctx(struct mm_struct *
 	}
 
 	table = rcu_dereference_raw(mm->ioctx_table);
-	WARN_ON(ctx != table->table[ctx->id]);
-	table->table[ctx->id] = NULL;
+	WARN_ON(ctx != rcu_access_pointer(table->table[ctx->id]));
+	RCU_INIT_POINTER(table->table[ctx->id], NULL);
 	spin_unlock(&mm->ioctx_lock);
 
 	/* free_ioctx_reqs() will do the necessary RCU synchronization */
@@ -895,7 +895,8 @@ void exit_aio(struct mm_struct *mm)
 
 	skipped = 0;
 	for (i = 0; i < table->nr; ++i) {
-		struct kioctx *ctx = table->table[i];
+		struct kioctx *ctx =
+			rcu_dereference_protected(table->table[i], true);
 
 		if (!ctx) {
 			skipped++;
@@ -1084,7 +1085,7 @@ static struct kioctx *lookup_ioctx(unsig
 	if (!table || id >= table->nr)
 		goto out;
 
-	ctx = table->table[id];
+	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
 		percpu_ref_get(&ctx->users);
 		ret = ctx;
