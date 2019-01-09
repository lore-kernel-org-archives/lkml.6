Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B7DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C74206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfAIQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:42:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:57620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfAIQkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE35CAF91;
        Wed,  9 Jan 2019 16:40:38 +0000 (UTC)
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
Subject: [RFC PATCH 06/15] epoll: introduce various of helpers for user structure lengths calculations
Date:   Wed,  9 Jan 2019 17:40:16 +0100
Message-Id: <20190109164025.24554-7-rpenyaev@suse.de>
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

Helpers for lengths-from-number and number-from-lengths calculations.
Among them:

  ep_polled_by_user()
	- returns true if epoll was created with EPOLL_USERPOLL

  ep_user_ring_events_available()
	- returns true if there is something in user ring buffer

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
 fs/eventpoll.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9ec682b6488f..ae288f62aa4c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -438,6 +438,65 @@ static void ep_nested_calls_init(struct nested_calls *ncalls)
 	spin_lock_init(&ncalls->lock);
 }
 
+static inline unsigned int to_items_length(unsigned int nr)
+{
+	struct eventpoll *ep;
+
+	return (sizeof(*ep->user_header) +
+		(nr << ilog2(sizeof(ep->user_header->items[0]))));
+}
+
+static inline unsigned int to_index_length(unsigned int nr)
+{
+	struct eventpoll *ep;
+
+	return nr << ilog2(sizeof(*ep->user_index));
+}
+
+static inline unsigned int to_items_bm_length(unsigned int nr)
+{
+	return ALIGN(nr, 8) >> 3;
+}
+
+static inline unsigned int to_items_nr(unsigned int len)
+{
+	struct eventpoll *ep;
+
+	return (len - sizeof(*ep->user_header)) >>
+		ilog2(sizeof(ep->user_header->items[0]));
+}
+
+static inline unsigned int to_items_bm_nr(unsigned int len)
+{
+	return len << 3;
+}
+
+static inline unsigned int ep_max_items_nr(struct eventpoll *ep)
+{
+	return to_items_nr(ep->header_length);
+}
+
+static inline unsigned int ep_max_index_nr(struct eventpoll *ep)
+{
+	return ep->index_length >> ilog2(sizeof(*ep->user_index));
+}
+
+static inline unsigned int ep_max_items_bm_nr(struct eventpoll *ep)
+{
+	return to_items_bm_nr(ep->items_bm_length);
+}
+
+static inline bool ep_polled_by_user(struct eventpoll *ep)
+{
+	return !!ep->user_header;
+}
+
+static inline bool ep_user_ring_events_available(struct eventpoll *ep)
+{
+	return ep_polled_by_user(ep) &&
+		ep->user_header->head != ep->user_header->tail;
+}
+
 /**
  * ep_events_available - Checks if ready events might be available.
  *
-- 
2.19.1

