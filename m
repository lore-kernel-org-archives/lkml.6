Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B43BC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AB7206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfAIQlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:41:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:57712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726623AbfAIQkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AEFAB017;
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
Subject: [RFC PATCH 12/15] epoll: support polling from userspace for ep_remove()
Date:   Wed,  9 Jan 2019 17:40:22 +0100
Message-Id: <20190109164025.24554-13-rpenyaev@suse.de>
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

When epfd is polled from userspace and item is being removed:

1. Mark user item as freed.  If userspace has not been yet consumed
   ready event - route all events to kernel lists.
2. If shrink is required - route all events to kernel lists.
3. On unregistration of epoll entries do not forget to flush item worker,
   which can be just submitted from ep_poll_callback()

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
 fs/eventpoll.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2af849e6c7a5..7732a8029a1c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -780,6 +780,14 @@ static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *epi)
 		ep_remove_wait_queue(pwq);
 		kmem_cache_free(pwq_cache, pwq);
 	}
+	if (ep_polled_by_user(ep)) {
+		/*
+		 * Events polled by user require offloading to a work,
+		 * thus we have to be sure everything which was queued
+		 * has run to a completion.
+		 */
+		flush_work(&epi->work);
+	}
 }
 
 /* call only when ep->mtx is held */
@@ -1168,6 +1176,7 @@ static bool ep_add_event_to_uring(struct epitem *epi, __poll_t pollflags)
 static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 {
 	struct file *file = epi->ffd.file;
+	bool events_to_klists = false;
 
 	lockdep_assert_irqs_enabled();
 
@@ -1183,9 +1192,14 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
+	if (ep_polled_by_user(ep))
+		events_to_klists = ep_free_user_item(epi);
+
 	write_lock_irq(&ep->lock);
 	if (ep_is_linked(epi))
 		list_del_init(&epi->rdllink);
+	if (events_to_klists)
+		ep_route_events_to_klists(ep);
 	write_unlock_irq(&ep->lock);
 
 	wakeup_source_unregister(ep_wakeup_source(epi));
-- 
2.19.1

