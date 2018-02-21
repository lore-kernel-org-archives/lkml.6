Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932593AbeBUMyN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:54:13 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38366 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeBUMyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:54:11 -0500
X-Google-Smtp-Source: AH8x227nzcm5g9E481puoiEgpy10vfYHg6MFLq5U0sdryUoztt6OgAzRsBLLBGbwLdSARs2aSA/a7w==
Date: Wed, 21 Feb 2018 18:24:07 +0530
From: gaurav jindal <gauravjindal1104@gmail.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]sched: completion: use bool in try_wait_for_completion
Message-ID: <20180221125407.GA14292@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable ret in try_wait_for_completion can have only true/false values. Since
the return type of the function is also bool, variable ret should have data
type as bool in place of int.
Moreover, the size of bool in many platforms is 1 byte whereas size of int is
4 bytes(though architecture dependent). Modifying the data type reduces the 
size consumed for the stack.

Signed-off-by: Gaurav Jindal<gauravjindal1104@gmail.com>

---

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 0926aef..3e15e8d 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -283,7 +283,7 @@ int __sched wait_for_completion_killable(struct completion *x)
 bool try_wait_for_completion(struct completion *x)
 {
 	unsigned long flags;
-	int ret = 1;
+	bool ret = true;

 	/*
 	 * Since x->done will need to be locked only
@@ -292,11 +292,11 @@ bool try_wait_for_completion(struct completion *x)
 	 * return early in the blocking case.
 	 */
 	if (!READ_ONCE(x->done))
-		return 0;
+		return false;

 	spin_lock_irqsave(&x->wait.lock, flags);
 	if (!x->done)
-		ret = 0;
+		ret = false;
 	else if (x->done != UINT_MAX)
 		x->done--;
 	spin_unlock_irqrestore(&x->wait.lock, flags);
