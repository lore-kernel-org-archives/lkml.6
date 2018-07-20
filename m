Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6525CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4C220671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4C220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388213AbeGTSTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:19:45 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:57339 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387868AbeGTSTk (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 20 Jul 2018 14:19:40 -0400
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 20 Jul 2018 11:30:19 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/2] fs/epoll: loosen irq safety in epoll_insert() and epoll_remove()
Date:   Fri, 20 Jul 2018 10:29:56 -0700
Message-Id: <20180720172956.2883-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180720172956.2883-1-dave@stgolabs.net>
References: <20180720172956.2883-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both functions are similar to the context of ep_modify(), called via
epoll_ctl(2). Just like ep_modify(), saving and restoring interrupts
is an overkill in these calls as it will never be called with irqs
disabled. While ep_remove() can be called directly from EPOLL_CTL_DEL,
it can also be called when releasing the file, but this also complies
with the above.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2247769eb941..1b1abc461fc0 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -762,7 +762,6 @@ static void epi_rcu_free(struct rcu_head *head)
  */
 static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 {
-	unsigned long flags;
 	struct file *file = epi->ffd.file;
 
 	/*
@@ -777,10 +776,10 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
-	spin_lock_irqsave(&ep->wq.lock, flags);
+	spin_lock_irq(&ep->wq.lock);
 	if (ep_is_linked(&epi->rdllink))
 		list_del_init(&epi->rdllink);
-	spin_unlock_irqrestore(&ep->wq.lock, flags);
+	spin_unlock_irq(&ep->wq.lock);
 
 	wakeup_source_unregister(ep_wakeup_source(epi));
 	/*
@@ -1409,7 +1408,6 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 {
 	int error, pwake = 0;
 	__poll_t revents;
-	unsigned long flags;
 	long user_watches;
 	struct epitem *epi;
 	struct ep_pqueue epq;
@@ -1476,7 +1474,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 		goto error_remove_epi;
 
 	/* We have to drop the new item inside our item list to keep track of it */
-	spin_lock_irqsave(&ep->wq.lock, flags);
+	spin_lock_irq(&ep->wq.lock);
 
 	/* record NAPI ID of new item if present */
 	ep_set_busy_poll_napi_id(epi);
@@ -1493,7 +1491,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 			pwake++;
 	}
 
-	spin_unlock_irqrestore(&ep->wq.lock, flags);
+	spin_unlock_irq(&ep->wq.lock);
 
 	atomic_long_inc(&ep->user->epoll_watches);
 
@@ -1519,10 +1517,10 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * list, since that is used/cleaned only inside a section bound by "mtx".
 	 * And ep_insert() is called with "mtx" held.
 	 */
-	spin_lock_irqsave(&ep->wq.lock, flags);
+	spin_lock_irq(&ep->wq.lock);
 	if (ep_is_linked(&epi->rdllink))
 		list_del_init(&epi->rdllink);
-	spin_unlock_irqrestore(&ep->wq.lock, flags);
+	spin_unlock_irq(&ep->wq.lock);
 
 	wakeup_source_unregister(ep_wakeup_source(epi));
 
-- 
2.16.4

