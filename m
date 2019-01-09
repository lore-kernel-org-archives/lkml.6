Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D3AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAEC206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfAIQlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:41:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:57650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726625AbfAIQkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7531B01B;
        Wed,  9 Jan 2019 16:40:41 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/15] epoll: support polling from userspace for ep_modify()
Date:   Wed,  9 Jan 2019 17:40:23 +0100
Message-Id: <20190109164025.24554-14-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190109164025.24554-1-rpenyaev@suse.de>
References: <20190109164025.24554-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When epfd is polled from userspace and item is being modified:

1. Update user item with new pointer or poll flags.
2. Add event to user ring if needed.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7732a8029a1c..2b38a3d884e8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2237,6 +2237,8 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 		     const struct epoll_event *event)
 {
+	struct user_epitem *uitem;
+	__poll_t revents;
 	int pwake = 0;
 	poll_table pt;
 
@@ -2251,6 +2253,13 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 */
 	epi->event.events = event->events; /* need barrier below */
 	epi->event.data = event->data; /* protected by mtx */
+
+	/* Update user item, barrier is below */
+	if (ep_polled_by_user(ep)) {
+		uitem = &ep->user_header->items[epi->bit];
+		uitem->event = *event;
+	}
+
 	if (epi->event.events & EPOLLWAKEUP) {
 		if (!ep_has_wakeup_source(epi))
 			ep_create_wakeup_source(epi);
@@ -2284,12 +2293,19 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 * If the item is "hot" and it is not registered inside the ready
 	 * list, push it inside.
 	 */
-	if (ep_item_poll(epi, &pt, 1)) {
+	revents = ep_item_poll(epi, &pt, 1);
+	if (revents) {
+		bool added = false;
+
 		write_lock_irq(&ep->lock);
-		if (!ep_is_linked(epi)) {
+		if (ep_events_routed_to_uring(ep))
+			added = ep_add_event_to_uring(epi, revents);
+		else if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
 			ep_pm_stay_awake(epi);
-
+			added = true;
+		}
+		if (added) {
 			/* Notify waiting tasks that events are available */
 			if (waitqueue_active(&ep->wq))
 				wake_up(&ep->wq);
-- 
2.19.1

