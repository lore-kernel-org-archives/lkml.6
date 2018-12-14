Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C0BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D195206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbeLNUqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:46:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37977 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbeLNUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:46:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKk0Wr1457380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:46:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKk04F1457377;
        Fri, 14 Dec 2018 12:46:00 -0800
Date:   Fri, 14 Dec 2018 12:46:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-vgs9aoek21v14o3obza586yy@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, davem@davemloft.net,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          davem@davemloft.net, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ordered_events: Add private data member
Git-Commit-ID: 4bc8acb7e06b8bc882fc3ca42e0980275f6e629e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4bc8acb7e06b8bc882fc3ca42e0980275f6e629e
Gitweb:     https://git.kernel.org/tip/4bc8acb7e06b8bc882fc3ca42e0980275f6e629e
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Nov 2018 16:58:36 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:32 -0300

perf ordered_events: Add private data member

We will need it in following patch, where we can't use the
container_of() trick to get the higher level object.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-vgs9aoek21v14o3obza586yy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/ordered-events.c | 6 ++++--
 tools/perf/util/ordered-events.h | 4 +++-
 tools/perf/util/session.c        | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 28f0f5c95024..d053aa0a7582 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -326,7 +326,8 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 	return err;
 }
 
-void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver)
+void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
+			  void *data)
 {
 	INIT_LIST_HEAD(&oe->events);
 	INIT_LIST_HEAD(&oe->cache);
@@ -334,6 +335,7 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
 	oe->max_alloc_size = (u64) -1;
 	oe->cur_alloc_size = 0;
 	oe->deliver	   = deliver;
+	oe->data	   = data;
 }
 
 static void
@@ -377,5 +379,5 @@ void ordered_events__reinit(struct ordered_events *oe)
 
 	ordered_events__free(oe);
 	memset(oe, '\0', sizeof(*oe));
-	ordered_events__init(oe, old_deliver);
+	ordered_events__init(oe, old_deliver, oe->data);
 }
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 1338d5c345dc..507b4e4df79e 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -47,13 +47,15 @@ struct ordered_events {
 	enum oe_flush			 last_flush_type;
 	u32				 nr_unordered_events;
 	bool				 copy_on_queue;
+	void				*data;
 };
 
 int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 			  u64 timestamp, u64 file_offset);
 void ordered_events__delete(struct ordered_events *oe, struct ordered_event *event);
 int ordered_events__flush(struct ordered_events *oe, enum oe_flush how);
-void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver);
+void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
+			  void *data);
 void ordered_events__free(struct ordered_events *oe);
 void ordered_events__reinit(struct ordered_events *oe);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f8eab197f35c..78a067777144 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -126,7 +126,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
 	session->tool   = tool;
 	INIT_LIST_HEAD(&session->auxtrace_index);
 	machines__init(&session->machines);
-	ordered_events__init(&session->ordered_events, ordered_events__deliver_event);
+	ordered_events__init(&session->ordered_events,
+			     ordered_events__deliver_event, NULL);
 
 	if (data) {
 		if (perf_data__open(data))
