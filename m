Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8686721741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298096;
	bh=sGeXjetAN/o5FwEA3AA+u7FS6RNUMpzI+Sz8BcgDhzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vVyGRLwRmw4/6yeHZlbLilb+kfFjHgIGSJ/Sf6jdFkHTpYStPevO9zUxlwaQLvkPF
	 Yd6xMAobLpHSDVLXrnrMwiaE6s6tLsM+H3rmahhQledsrk0JiOmsg4/q/2m36PTX9d
	 U/t8OIyrag38K6j8f4XtXi/5xhIrM2vKoZZIWcPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbeLTJ2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbeLTJ2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:28:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620B421741;
        Thu, 20 Dec 2018 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298088;
        bh=sGeXjetAN/o5FwEA3AA+u7FS6RNUMpzI+Sz8BcgDhzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXA6w6BBJnDV5jUoHbaCVTMQxyl00nSoIYVGvKRKfsytkqToLwnX6DgY09R/K8Y0U
         PmkD6W6lih+MKRPTSwe4vPQopLk/ZSKLrUCTP3z5RU1lvPsqyL+6Mbvl5Hndtf3p17
         7fzsTLM2PivA9gskKC+J5fIAIIZFGrshQTawnCI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 30/72] elevator: lookup mq vs non-mq elevators
Date:   Thu, 20 Dec 2018 10:18:29 +0100
Message-Id: <20181220085923.526153054@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2527d99789e248576ac8081530cd4fd88730f8c7 ]

If an IO scheduler is selected via elevator= and it doesn't match
the driver in question wrt blk-mq support, then we fail to boot.

The elevator= parameter is deprecated and only supported for
non-mq devices. Augment the elevator lookup API so that we
pass in if we're looking for an mq capable scheduler or not,
so that we only ever return a valid type for the queue in
question.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=196695
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/elevator.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 153926a90901..8320d97240be 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -83,12 +83,15 @@ bool elv_bio_merge_ok(struct request *rq, struct bio *bio)
 }
 EXPORT_SYMBOL(elv_bio_merge_ok);
 
-static struct elevator_type *elevator_find(const char *name)
+/*
+ * Return scheduler with name 'name' and with matching 'mq capability
+ */
+static struct elevator_type *elevator_find(const char *name, bool mq)
 {
 	struct elevator_type *e;
 
 	list_for_each_entry(e, &elv_list, list) {
-		if (!strcmp(e->elevator_name, name))
+		if (!strcmp(e->elevator_name, name) && (mq == e->uses_mq))
 			return e;
 	}
 
@@ -100,25 +103,25 @@ static void elevator_put(struct elevator_type *e)
 	module_put(e->elevator_owner);
 }
 
-static struct elevator_type *elevator_get(const char *name, bool try_loading)
+static struct elevator_type *elevator_get(struct request_queue *q,
+					  const char *name, bool try_loading)
 {
 	struct elevator_type *e;
 
 	spin_lock(&elv_list_lock);
 
-	e = elevator_find(name);
+	e = elevator_find(name, q->mq_ops != NULL);
 	if (!e && try_loading) {
 		spin_unlock(&elv_list_lock);
 		request_module("%s-iosched", name);
 		spin_lock(&elv_list_lock);
-		e = elevator_find(name);
+		e = elevator_find(name, q->mq_ops != NULL);
 	}
 
 	if (e && !try_module_get(e->elevator_owner))
 		e = NULL;
 
 	spin_unlock(&elv_list_lock);
-
 	return e;
 }
 
@@ -144,8 +147,12 @@ void __init load_default_elevator_module(void)
 	if (!chosen_elevator[0])
 		return;
 
+	/*
+	 * Boot parameter is deprecated, we haven't supported that for MQ.
+	 * Only look for non-mq schedulers from here.
+	 */
 	spin_lock(&elv_list_lock);
-	e = elevator_find(chosen_elevator);
+	e = elevator_find(chosen_elevator, false);
 	spin_unlock(&elv_list_lock);
 
 	if (!e)
@@ -202,7 +209,7 @@ int elevator_init(struct request_queue *q, char *name)
 	q->boundary_rq = NULL;
 
 	if (name) {
-		e = elevator_get(name, true);
+		e = elevator_get(q, name, true);
 		if (!e)
 			return -EINVAL;
 	}
@@ -214,7 +221,7 @@ int elevator_init(struct request_queue *q, char *name)
 	 * allowed from async.
 	 */
 	if (!e && !q->mq_ops && *chosen_elevator) {
-		e = elevator_get(chosen_elevator, false);
+		e = elevator_get(q, chosen_elevator, false);
 		if (!e)
 			printk(KERN_ERR "I/O scheduler %s not found\n",
 							chosen_elevator);
@@ -229,17 +236,17 @@ int elevator_init(struct request_queue *q, char *name)
 		 */
 		if (q->mq_ops) {
 			if (q->nr_hw_queues == 1)
-				e = elevator_get("mq-deadline", false);
+				e = elevator_get(q, "mq-deadline", false);
 			if (!e)
 				return 0;
 		} else
-			e = elevator_get(CONFIG_DEFAULT_IOSCHED, false);
+			e = elevator_get(q, CONFIG_DEFAULT_IOSCHED, false);
 
 		if (!e) {
 			printk(KERN_ERR
 				"Default I/O scheduler not found. " \
 				"Using noop.\n");
-			e = elevator_get("noop", false);
+			e = elevator_get(q, "noop", false);
 		}
 	}
 
@@ -905,7 +912,7 @@ int elv_register(struct elevator_type *e)
 
 	/* register, don't allow duplicate names */
 	spin_lock(&elv_list_lock);
-	if (elevator_find(e->elevator_name)) {
+	if (elevator_find(e->elevator_name, e->uses_mq)) {
 		spin_unlock(&elv_list_lock);
 		if (e->icq_cache)
 			kmem_cache_destroy(e->icq_cache);
@@ -1066,7 +1073,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 		return elevator_switch(q, NULL);
 
 	strlcpy(elevator_name, name, sizeof(elevator_name));
-	e = elevator_get(strstrip(elevator_name), true);
+	e = elevator_get(q, strstrip(elevator_name), true);
 	if (!e)
 		return -EINVAL;
 
@@ -1076,15 +1083,6 @@ static int __elevator_change(struct request_queue *q, const char *name)
 		return 0;
 	}
 
-	if (!e->uses_mq && q->mq_ops) {
-		elevator_put(e);
-		return -EINVAL;
-	}
-	if (e->uses_mq && !q->mq_ops) {
-		elevator_put(e);
-		return -EINVAL;
-	}
-
 	return elevator_switch(q, e);
 }
 
-- 
2.19.1



