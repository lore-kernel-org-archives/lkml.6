Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HCTqOKhNGVvycgAAmS7hNA
	; Thu, 07 Jun 2018 15:22:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 61B43607E7; Thu,  7 Jun 2018 15:22:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D89A1606DD;
	Thu,  7 Jun 2018 15:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D89A1606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935756AbeFGPWX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:22:23 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41241 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935494AbeFGO7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:00 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbG-0005Zl-68; Thu, 07 Jun 2018 15:09:14 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003FG-PG; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Oleg Nesterov" <oleg@redhat.com>,
        "Benjamin LaHaise" <bcrl@kvack.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.458161244@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 355/410] aio: kill the misleading rcu read locks in
 ioctx_add_table() and kill_ioctx()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Oleg Nesterov <oleg@redhat.com>

commit 855ef0dec7271ff7be7381feaaf3f4aed80bd503 upstream.

ioctx_add_table() is the writer, it does not need rcu_read_lock() to
protect ->ioctx_table. It relies on mm->ioctx_lock and rcu locks just
add the confusion.

And it doesn't need rcu_dereference() by the same reason, it must see
any updates previously done under the same ->ioctx_lock. We could use
rcu_dereference_protected() but the patch uses rcu_dereference_raw(),
the function is simple enough.

The same for kill_ioctx(), although it does not update the pointer.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Benjamin LaHaise <bcrl@kvack.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/aio.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -563,8 +563,7 @@ static int ioctx_add_table(struct kioctx
 	struct aio_ring *ring;
 
 	spin_lock(&mm->ioctx_lock);
-	rcu_read_lock();
-	table = rcu_dereference(mm->ioctx_table);
+	table = rcu_dereference_raw(mm->ioctx_table);
 
 	while (1) {
 		if (table)
@@ -572,7 +571,6 @@ static int ioctx_add_table(struct kioctx
 				if (!table->table[i]) {
 					ctx->id = i;
 					table->table[i] = ctx;
-					rcu_read_unlock();
 					spin_unlock(&mm->ioctx_lock);
 
 					/* While kioctx setup is in progress,
@@ -586,8 +584,6 @@ static int ioctx_add_table(struct kioctx
 				}
 
 		new_nr = (table ? table->nr : 1) * 4;
-
-		rcu_read_unlock();
 		spin_unlock(&mm->ioctx_lock);
 
 		table = kzalloc(sizeof(*table) + sizeof(struct kioctx *) *
@@ -598,8 +594,7 @@ static int ioctx_add_table(struct kioctx
 		table->nr = new_nr;
 
 		spin_lock(&mm->ioctx_lock);
-		rcu_read_lock();
-		old = rcu_dereference(mm->ioctx_table);
+		old = rcu_dereference_raw(mm->ioctx_table);
 
 		if (!old) {
 			rcu_assign_pointer(mm->ioctx_table, table);
@@ -749,12 +744,9 @@ static int kill_ioctx(struct mm_struct *
 
 
 	spin_lock(&mm->ioctx_lock);
-	rcu_read_lock();
-	table = rcu_dereference(mm->ioctx_table);
-
+	table = rcu_dereference_raw(mm->ioctx_table);
 	WARN_ON(ctx != table->table[ctx->id]);
 	table->table[ctx->id] = NULL;
-	rcu_read_unlock();
 	spin_unlock(&mm->ioctx_lock);
 
 	/* percpu_ref_kill() will do the necessary call_rcu() */
