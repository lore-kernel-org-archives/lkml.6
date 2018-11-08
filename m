Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534C4C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2807E2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2807E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbeKHOoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:44:07 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:56621 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbeKHOoG (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 8 Nov 2018 09:44:06 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 07 Nov 2018 22:10:18 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk, dave@stgolabs.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/6] fs/epoll: simplify ep_send_events_proc() ready-list loop
Date:   Wed,  7 Nov 2018 21:10:02 -0800
Message-Id: <20181108051006.18751-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181108051006.18751-1-dave@stgolabs.net>
References: <20181108051006.18751-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current logic is a bit convoluted. Lets simplify this with
a standard list_for_each_entry_safe() loop instead and just
break out after maxevents is reached.

While at it, remove an unnecessary indentation level in the loop
when there are in fact ready events.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 73 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7ad020f1353b..101d46b81f64 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1624,21 +1624,22 @@ static __poll_t ep_send_events_proc(struct eventpoll *ep, struct list_head *head
 {
 	struct ep_send_events_data *esed = priv;
 	__poll_t revents;
-	struct epitem *epi;
-	struct epoll_event __user *uevent;
+	struct epitem *epi, *tmp;
+	struct epoll_event __user *uevent = esed->events;
 	struct wakeup_source *ws;
 	poll_table pt;
 
 	init_poll_funcptr(&pt, NULL);
+	esed->res = 0;
 
 	/*
 	 * We can loop without lock because we are passed a task private list.
 	 * Items cannot vanish during the loop because ep_scan_ready_list() is
 	 * holding "mtx" during this call.
 	 */
-	for (esed->res = 0, uevent = esed->events;
-	     !list_empty(head) && esed->res < esed->maxevents;) {
-		epi = list_first_entry(head, struct epitem, rdllink);
+	list_for_each_entry_safe(epi, tmp, head, rdllink) {
+		if (esed->res >= esed->maxevents)
+			break;
 
 		/*
 		 * Activate ep->ws before deactivating epi->ws to prevent
@@ -1658,42 +1659,42 @@ static __poll_t ep_send_events_proc(struct eventpoll *ep, struct list_head *head
 
 		list_del_init(&epi->rdllink);
 
-		revents = ep_item_poll(epi, &pt, 1);
-
 		/*
 		 * If the event mask intersect the caller-requested one,
 		 * deliver the event to userspace. Again, ep_scan_ready_list()
-		 * is holding "mtx", so no operations coming from userspace
+		 * is holding ep->mtx, so no operations coming from userspace
 		 * can change the item.
 		 */
-		if (revents) {
-			if (__put_user(revents, &uevent->events) ||
-			    __put_user(epi->event.data, &uevent->data)) {
-				list_add(&epi->rdllink, head);
-				ep_pm_stay_awake(epi);
-				if (!esed->res)
-					esed->res = -EFAULT;
-				return 0;
-			}
-			esed->res++;
-			uevent++;
-			if (epi->event.events & EPOLLONESHOT)
-				epi->event.events &= EP_PRIVATE_BITS;
-			else if (!(epi->event.events & EPOLLET)) {
-				/*
-				 * If this file has been added with Level
-				 * Trigger mode, we need to insert back inside
-				 * the ready list, so that the next call to
-				 * epoll_wait() will check again the events
-				 * availability. At this point, no one can insert
-				 * into ep->rdllist besides us. The epoll_ctl()
-				 * callers are locked out by
-				 * ep_scan_ready_list() holding "mtx" and the
-				 * poll callback will queue them in ep->ovflist.
-				 */
-				list_add_tail(&epi->rdllink, &ep->rdllist);
-				ep_pm_stay_awake(epi);
-			}
+		revents = ep_item_poll(epi, &pt, 1);
+		if (!revents)
+			continue;
+
+		if (__put_user(revents, &uevent->events) ||
+		    __put_user(epi->event.data, &uevent->data)) {
+			list_add(&epi->rdllink, head);
+			ep_pm_stay_awake(epi);
+			if (!esed->res)
+				esed->res = -EFAULT;
+			return 0;
+		}
+		esed->res++;
+		uevent++;
+		if (epi->event.events & EPOLLONESHOT)
+			epi->event.events &= EP_PRIVATE_BITS;
+		else if (!(epi->event.events & EPOLLET)) {
+			/*
+			 * If this file has been added with Level
+			 * Trigger mode, we need to insert back inside
+			 * the ready list, so that the next call to
+			 * epoll_wait() will check again the events
+			 * availability. At this point, no one can insert
+			 * into ep->rdllist besides us. The epoll_ctl()
+			 * callers are locked out by
+			 * ep_scan_ready_list() holding "mtx" and the
+			 * poll callback will queue them in ep->ovflist.
+			 */
+			list_add_tail(&epi->rdllink, &ep->rdllist);
+			ep_pm_stay_awake(epi);
 		}
 	}
 
-- 
2.16.4

