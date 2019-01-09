Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732ABC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9BF206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfAIQlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:41:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfAIQkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A596B012;
        Wed,  9 Jan 2019 16:40:39 +0000 (UTC)
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
Subject: [RFC PATCH 07/15] epoll: extend epitem struct with new members for polling from userspace
Date:   Wed,  9 Jan 2019 17:40:17 +0100
Message-Id: <20190109164025.24554-8-rpenyaev@suse.de>
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

 ->bit
       every epitem has an element inside user item array, this bit is
       actually an index position of that user item array and also a
       bit inside ep->items_bm

 ->ready_events
       received events in the period when descriptor can't be polled
       from userspace and ep->rdllist is used for keeping list of
       ready items

 ->work
      work for offloading polling from task context if epfd is polled
      from userspace but driver does not provide pollflags on wakeup

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
 fs/eventpoll.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ae288f62aa4c..637b463587c1 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -9,6 +9,8 @@
  *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
+ *  Polling from userspace support by Roman Penyaev <rpenyaev@suse.de>
+ *  (C) Copyright 2019 SUSE, All Rights Reserved
  */
 
 #include <linux/init.h>
@@ -42,6 +44,7 @@
 #include <linux/seq_file.h>
 #include <linux/compat.h>
 #include <linux/rculist.h>
+#include <linux/workqueue.h>
 #include <net/busy_poll.h>
 
 /*
@@ -176,6 +179,18 @@ struct epitem {
 
 	/* The structure that describe the interested events and the source fd */
 	struct epoll_event event;
+
+	/* Bit in user bitmap for user polling */
+	unsigned int bit;
+
+	/*
+	 * Collect ready events for the period when descriptor is polled by user
+	 * but events are routed to klists.
+	 */
+	__poll_t ready_events;
+
+	/* Work for offloading event callback */
+	struct work_struct work;
 };
 
 #define EPOLL_USER_HEADER_SIZE  128
@@ -2557,12 +2572,6 @@ static int __init eventpoll_init(void)
 	ep_nested_calls_init(&poll_safewake_ncalls);
 #endif
 
-	/*
-	 * We can have many thousands of epitems, so prevent this from
-	 * using an extra cache line on 64-bit (and smaller) CPUs
-	 */
-	BUILD_BUG_ON(sizeof(void *) <= 8 && sizeof(struct epitem) > 128);
-
 	/* Allocates slab cache used to allocate "struct epitem" items */
 	epi_cache = kmem_cache_create("eventpoll_epi", sizeof(struct epitem),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
-- 
2.19.1

