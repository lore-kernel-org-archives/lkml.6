Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsEWO2Wi+6nMp4DpT9calBxzzoQdU0YgvrgQjmoVrP9rz6DQ3vPwton6Cuhb64S1OqtuUuL
ARC-Seal: i=1; a=rsa-sha256; t=1521483096; cv=none;
        d=google.com; s=arc-20160816;
        b=AFonSg+DuRV9Z0KB7VZ2OYeB6kWP/84ofKsZtquUgtqJ33RqGVUvWwyLNSaNw6F/yc
         renJNb+sRlE4ckgOmaKBm1O15xZ/wWAuDvZCJhErbIqJrnCYE3KHf0R5aftXHx1rIzOc
         DrHGM2gbpNN7alvObv2TlOSOgGNw/QLfpuw3OVBFuxNHROga80QONwUuNwRE6n7Nglh6
         aUz/ECDzf+gcCnEuVQXiujwbFZgse/KuBKOvhEif+R/U7JKnXA3Kr2vy+csreGPjW1Hp
         ygGCZuli4autJvHjfZV0ujEreDj52lmcYnzTPnF8HeD7Ih4jhqBuLHhR2l62LJooYIoj
         3TbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zLnnq6CCET0O9Xf8o4RJRA5AWknZU4uewMvMYsD3gzw=;
        b=RRq8TBt/Rbrkpjrns9COTix+q3e8Ov64odXb0MTAkHDF4TCGkqadFRuykvFvYB8jGJ
         7nY20+v6OKdM1/v7hVx/FW28Ickemlx5D1+uLoDzSWXuxTOmlb/+HQ8+2cACWLIIAcIk
         dYCwnWRtic4vjMxN1QMjRHZgbvxdwNJYydzCrsSgc2gli5FKrLXA4FPeNcagh5xZW95u
         TO0u0+ZXbKE9neTLtkIZPisXYch37wGSTiz0ijecogY6Vs6Vi2pjgpnK1AexE9MbA5z2
         +AnX4+XBzsa4BLg6cOYg8etk1gE8m7xXp8c/ySPudoy5l+OGRUsdhkoJ8lhL59D3EAUq
         E9Ug==
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
Subject: [PATCH 3.18 65/68] fs/aio: Use RCU accessors for kioctx_table->table[]
Date: Mon, 19 Mar 2018 19:06:43 +0100
Message-Id: <20180319171837.008255189@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390659140496650?=
X-GMAIL-MSGID: =?utf-8?q?1595390659140496650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 fs/aio.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

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
@@ -583,9 +583,9 @@ static int ioctx_add_table(struct kioctx
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
@@ -760,8 +760,8 @@ static int kill_ioctx(struct mm_struct *
 
 	spin_lock(&mm->ioctx_lock);
 	table = rcu_dereference_raw(mm->ioctx_table);
-	WARN_ON(ctx != table->table[ctx->id]);
-	table->table[ctx->id] = NULL;
+	WARN_ON(ctx != rcu_access_pointer(table->table[ctx->id]));
+	RCU_INIT_POINTER(table->table[ctx->id], NULL);
 	spin_unlock(&mm->ioctx_lock);
 
 	/* free_ioctx_reqs() will do the necessary RCU synchronization */
@@ -817,7 +817,8 @@ void exit_aio(struct mm_struct *mm)
 		return;
 
 	for (i = 0; i < table->nr; ++i) {
-		struct kioctx *ctx = table->table[i];
+		struct kioctx *ctx =
+			rcu_dereference_protected(table->table[i], true);
 		struct completion requests_done =
 			COMPLETION_INITIALIZER_ONSTACK(requests_done);
 
@@ -1003,7 +1004,7 @@ static struct kioctx *lookup_ioctx(unsig
 	if (!table || id >= table->nr)
 		goto out;
 
-	ctx = table->table[id];
+	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
 		percpu_ref_get(&ctx->users);
 		ret = ctx;
