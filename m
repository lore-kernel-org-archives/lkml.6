Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F613C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF1520861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfAUUQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:16:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:55654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728278AbfAUUPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:15:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 148FDAFFB;
        Mon, 21 Jan 2019 20:15:16 +0000 (UTC)
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
Subject: [RFC PATCH v2 09/13] epoll: support polling from userspace for ep_remove()
Date:   Mon, 21 Jan 2019 21:14:52 +0100
Message-Id: <20190121201456.28338-10-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190121201456.28338-1-rpenyaev@suse.de>
References: <20190121201456.28338-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ep_remove() simply mark a user item with EPOLLREMOVE if the item was
ready (i.e. has some bits set).  That will prevent further user index
entry creation on item ->bit reuse.

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
 fs/eventpoll.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 628a2cadfad6..b9f51f4b94e7 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1025,10 +1025,14 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
-	write_lock_irq(&ep->lock);
-	if (ep_is_linked(epi))
-		list_del_init(&epi->rdllink);
-	write_unlock_irq(&ep->lock);
+	if (ep_polled_by_user(ep)) {
+		ep_remove_user_item(epi);
+	} else {
+		write_lock_irq(&ep->lock);
+		if (ep_is_linked(epi))
+			list_del_init(&epi->rdllink);
+		write_unlock_irq(&ep->lock);
+	}
 
 	wakeup_source_unregister(ep_wakeup_source(epi));
 	/*
-- 
2.19.1

