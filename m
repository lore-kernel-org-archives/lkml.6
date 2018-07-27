Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9890CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCED20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCED20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbeG0GzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:55:16 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:41320 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeG0GzP (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 27 Jul 2018 02:55:15 -0400
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 26 Jul 2018 23:35:00 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk, peterz@infradead.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/2] fs/eventpoll: simplify ep_is_linked callers
Date:   Thu, 26 Jul 2018 22:34:32 -0700
Message-Id: <20180727053432.16679-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180727053432.16679-1-dave@stgolabs.net>
References: <20180727053432.16679-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having each caller pass the rdllink explicitly,
just have ep_is_linked() pass it while the callers just need
the epi pointer. This helper is all about the rdllink, and
this change, furthermore, improves the function's self
documentation.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 88473e6271ef..42bbe6824b4b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -336,9 +336,9 @@ static inline int ep_cmp_ffd(struct epoll_filefd *p1,
 }
 
 /* Tells us if the item is currently linked */
-static inline int ep_is_linked(struct list_head *p)
+static inline int ep_is_linked(struct epitem *epi)
 {
-	return !list_empty(p);
+	return !list_empty(&epi->rdllink);
 }
 
 static inline struct eppoll_entry *ep_pwq_from_wait(wait_queue_entry_t *p)
@@ -721,7 +721,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 		 * queued into ->ovflist but the "txlist" might already
 		 * contain them, and the list_splice() below takes care of them.
 		 */
-		if (!ep_is_linked(&epi->rdllink)) {
+		if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
 			ep_pm_stay_awake(epi);
 		}
@@ -790,7 +790,7 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
 	spin_lock_irq(&ep->wq.lock);
-	if (ep_is_linked(&epi->rdllink))
+	if (ep_is_linked(epi))
 		list_del_init(&epi->rdllink);
 	spin_unlock_irq(&ep->wq.lock);
 
@@ -1171,7 +1171,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	}
 
 	/* If this file is already in the ready list we exit soon */
-	if (!ep_is_linked(&epi->rdllink)) {
+	if (!ep_is_linked(epi)) {
 		list_add_tail(&epi->rdllink, &ep->rdllist);
 		ep_pm_stay_awake_rcu(epi);
 	}
@@ -1495,7 +1495,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	ep_set_busy_poll_napi_id(epi);
 
 	/* If the file is already "ready" we drop it inside the ready list */
-	if (revents && !ep_is_linked(&epi->rdllink)) {
+	if (revents && !ep_is_linked(epi)) {
 		list_add_tail(&epi->rdllink, &ep->rdllist);
 		ep_pm_stay_awake(epi);
 
@@ -1533,7 +1533,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * And ep_insert() is called with "mtx" held.
 	 */
 	spin_lock_irq(&ep->wq.lock);
-	if (ep_is_linked(&epi->rdllink))
+	if (ep_is_linked(epi))
 		list_del_init(&epi->rdllink);
 	spin_unlock_irq(&ep->wq.lock);
 
@@ -1601,7 +1601,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 */
 	if (ep_item_poll(epi, &pt, 1)) {
 		spin_lock_irq(&ep->wq.lock);
-		if (!ep_is_linked(&epi->rdllink)) {
+		if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
 			ep_pm_stay_awake(epi);
 
-- 
2.16.4

