Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsY4DWlfqQYRa1dM5Ng3u5JJiWnpnWrYFcmpQKNTVRVTzAIePlv9r5IhxWxtcF5x8ggyBWB
ARC-Seal: i=1; a=rsa-sha256; t=1521483436; cv=none;
        d=google.com; s=arc-20160816;
        b=efWCEDyhGQm345ApxpoREs60apCMA8I6E+Gp7cyoPkUy3P4j8KfsySbzSL8LMXBquL
         DszcbqHBnpuwF3odfIShkMGGoTgfZzwGFe/ovV2CDXvddK+Yty86ziQIiJ6hulY2ujS2
         nML8wk7WS0rOCbyojWW1C0FbWYUINMuBLJ8h3gFQtrZycH0GZOBnku1kdP7P9hHL9xTs
         x7B+yqIWIP59yrqQB77TCQwUDMzFgfds/ND1NL1LiTBjWGah8EepTOAm7McKURVmNY8s
         hCJMuc+WgNnJIVd/09JndEUSviDGUFM+J2YXB8wZOORmqgI55W1hXcnN2pKZDm5JlCxC
         Z73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hEFsK66u/qvAcu2RNzaj+6Bfl7+Y+Vs2iQK967iWSc4=;
        b=WoeVOg/Nrjs3xH5levZw7Bpfs2al07plyJMu7AXvodH1x1OhBuH5mjqIH+dXKv2b3z
         C4yXuTO875SDzap/vI81EjdsLTY1j2FYmXoohR4z5hdGvEpSgQudfxKKOdRGP75G+teC
         sqg9VSmbvEFta14gK97Cxi2lftClObtMthYtRScrsNWhOV9T1AiIAJoeiNaUeKMBYd32
         vNCx9P8QSBYhb7dhxjzMerrDY3cPs9hshghR1tJqVqrEbq9Hqe56nizP1d5aIa/uZy03
         wBJXoyhrlK6Slr/C4WulUnRKJga+jE4KAArSoIOpoS0hQKfaeBUeS+aOirzZHZK6cafz
         R7Ew==
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
Subject: [PATCH 4.4 124/134] fs/aio: Use RCU accessors for kioctx_table->table[]
Date: Mon, 19 Mar 2018 19:06:47 +0100
Message-Id: <20180319171907.175053555@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390659140496650?=
X-GMAIL-MSGID: =?utf-8?q?1595391015812212519?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -327,7 +327,7 @@ static int aio_ring_mremap(struct vm_are
 	for (i = 0; i < table->nr; i++) {
 		struct kioctx *ctx;
 
-		ctx = table->table[i];
+		ctx = rcu_dereference(table->table[i]);
 		if (ctx && ctx->aio_ring_file == file) {
 			if (!atomic_read(&ctx->dead)) {
 				ctx->user_id = ctx->mmap_base = vma->vm_start;
@@ -651,9 +651,9 @@ static int ioctx_add_table(struct kioctx
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
@@ -828,8 +828,8 @@ static int kill_ioctx(struct mm_struct *
 	}
 
 	table = rcu_dereference_raw(mm->ioctx_table);
-	WARN_ON(ctx != table->table[ctx->id]);
-	table->table[ctx->id] = NULL;
+	WARN_ON(ctx != rcu_access_pointer(table->table[ctx->id]));
+	RCU_INIT_POINTER(table->table[ctx->id], NULL);
 	spin_unlock(&mm->ioctx_lock);
 
 	/* free_ioctx_reqs() will do the necessary RCU synchronization */
@@ -874,7 +874,8 @@ void exit_aio(struct mm_struct *mm)
 
 	skipped = 0;
 	for (i = 0; i < table->nr; ++i) {
-		struct kioctx *ctx = table->table[i];
+		struct kioctx *ctx =
+			rcu_dereference_protected(table->table[i], true);
 
 		if (!ctx) {
 			skipped++;
@@ -1063,7 +1064,7 @@ static struct kioctx *lookup_ioctx(unsig
 	if (!table || id >= table->nr)
 		goto out;
 
-	ctx = table->table[id];
+	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
 		percpu_ref_get(&ctx->users);
 		ret = ctx;
