Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36EDC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F0020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfAUUPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:15:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:55534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727867AbfAUUPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:15:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B45DAAFF5;
        Mon, 21 Jan 2019 20:15:12 +0000 (UTC)
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
Subject: [RFC PATCH v2 02/13] epoll: introduce user structures for polling from userspace
Date:   Mon, 21 Jan 2019 21:14:45 +0100
Message-Id: <20190121201456.28338-3-rpenyaev@suse.de>
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

This one introduces structures of user items array:

struct user_epheader -
    describes inserted epoll items.

struct user_epitem -
    single epoll item, visible to userspace.

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
 fs/eventpoll.c                 |  9 +++++++++
 include/uapi/linux/eventpoll.h | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2cc183e86a29..f598442512f3 100644
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
@@ -109,6 +111,13 @@
 
 #define EP_ITEM_COST (sizeof(struct epitem) + sizeof(struct eppoll_entry))
 
+/*
+ * That is around 1.3mb of allocated memory for one epfd.  What is more
+ * important is ->index_length, which should be ^2, so do not increase
+ * max items number to avoid size doubling of user index.
+ */
+#define EP_USERPOLL_MAX_ITEMS_NR 65536
+
 struct epoll_filefd {
 	struct file *file;
 	int fd;
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index 39dfc29f0f52..690a625ddeb2 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -79,4 +79,23 @@ struct epoll_event {
 	__u64 data;
 } EPOLL_PACKED;
 
+struct epoll_uitem {
+	__poll_t ready_events;
+	struct epoll_event event;
+};
+
+#define EPOLL_USERPOLL_HEADER_SIZE  128
+#define EPOLL_USERPOLL_HEADER_MAGIC 0xeb01eb01
+
+struct epoll_uheader {
+	u32 magic;          /* epoll user header magic */
+	u32 header_length;  /* length of the header + items */
+	u32 index_length;   /* length of the index ring, always pow2 */
+	u32 max_items_nr;   /* max number of items */
+	u32 head;           /* updated by userland */
+	u32 tail;           /* updated by kernel */
+
+	struct epoll_uitem items[] __aligned(EPOLL_USERPOLL_HEADER_SIZE);
+};
+
 #endif /* _UAPI_LINUX_EVENTPOLL_H */
-- 
2.19.1

