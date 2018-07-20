Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8010AECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D19220671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D19220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388193AbeGTSTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:19:40 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:41980 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbeGTSTk (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 20 Jul 2018 14:19:40 -0400
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 20 Jul 2018 11:30:19 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] fs/epoll: loosen irq safety in ep_scan_ready_list()
Date:   Fri, 20 Jul 2018 10:29:55 -0700
Message-Id: <20180720172956.2883-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180720172956.2883-1-dave@stgolabs.net>
References: <20180720172956.2883-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saving and restoring interrupts in ep_scan_ready_list() is an
overkill as it is never called with interrupts disabled. Loosen
this to simply disabling local irqs such that archs where managing
irqs is expensive or virtual environments. This patch yields
some throughput improvements on a workload that is epoll intensive
running on a single Xen DomU.

1 Job	 7500	-->    8800 enq/s  (+17%)
2 Jobs	14000   -->   15200 enq/s  (+8%)
3 Jobs	20500	-->   22300 enq/s  (+8%)
4 Jobs	25000   -->   28000 enq/s  (+8-12)%

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2737ef591b3e..2247769eb941 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -667,7 +667,6 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 {
 	__poll_t res;
 	int pwake = 0;
-	unsigned long flags;
 	struct epitem *epi, *nepi;
 	LIST_HEAD(txlist);
 
@@ -687,17 +686,17 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	 * because we want the "sproc" callback to be able to do it
 	 * in a lockless way.
 	 */
-	spin_lock_irqsave(&ep->wq.lock, flags);
+	spin_lock_irq(&ep->wq.lock);
 	list_splice_init(&ep->rdllist, &txlist);
 	ep->ovflist = NULL;
-	spin_unlock_irqrestore(&ep->wq.lock, flags);
+	spin_unlock_irq(&ep->wq.lock);
 
 	/*
 	 * Now call the callback function.
 	 */
 	res = (*sproc)(ep, &txlist, priv);
 
-	spin_lock_irqsave(&ep->wq.lock, flags);
+	spin_lock_irq(&ep->wq.lock);
 	/*
 	 * During the time we spent inside the "sproc" callback, some
 	 * other events might have been queued by the poll callback.
@@ -739,7 +738,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 		if (waitqueue_active(&ep->poll_wait))
 			pwake++;
 	}
-	spin_unlock_irqrestore(&ep->wq.lock, flags);
+	spin_unlock_irq(&ep->wq.lock);
 
 	if (!ep_locked)
 		mutex_unlock(&ep->mtx);
-- 
2.16.4

