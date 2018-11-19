Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37FA20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37FA20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeKSWn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:43:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbeKSWn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:43:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B83453082B56;
        Mon, 19 Nov 2018 12:20:28 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FD2A5C8A1;
        Mon, 19 Nov 2018 12:20:26 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 03/12] perf tools: Add private data to struct ordered_events
Date:   Mon, 19 Nov 2018 13:20:07 +0100
Message-Id: <20181119122016.22423-4-jolsa@kernel.org>
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
References: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 19 Nov 2018 12:20:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will need it in following patch, where we can't use the
container_of trick to get higher level object.

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
index df5e12b22905..922d24cfba6a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -125,7 +125,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
 	session->tool   = tool;
 	INIT_LIST_HEAD(&session->auxtrace_index);
 	machines__init(&session->machines);
-	ordered_events__init(&session->ordered_events, ordered_events__deliver_event);
+	ordered_events__init(&session->ordered_events,
+			     ordered_events__deliver_event, NULL);
 
 	if (data) {
 		if (perf_data__open(data))
-- 
2.17.2

