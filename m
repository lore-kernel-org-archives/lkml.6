Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208B9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D999920989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131782;
	bh=ijQMJtFCwiJUoAmL4TzD3h2Ti4ZpOAkjY1p1aJ9/pN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=loyrW3ATocZQp+dX4ruG4rc/Gz/jj5oLqq+8xWosC7HfTX7to6q54Lna5xJi/jIJI
	 yKXxqKC8GeyV14xEKvsnPxl/zQjSkw3QJIfYiRiob9KjpGk4Gjb4YtJ5NpdNXsvKZe
	 lu097kvsAsdcfUENgicx9DImU5BV6iOOOKnuYEy0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D999920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeLFV3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:29:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbeLFV3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:29:38 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F9A21479;
        Thu,  6 Dec 2018 21:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131777;
        bh=ijQMJtFCwiJUoAmL4TzD3h2Ti4ZpOAkjY1p1aJ9/pN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnFFXSxhcKZYtL94Xg8zFC5ktUIi4rhZh4HDgdym2g5JwrkQFu/NCeHU++QBTV/v5
         CiAgTfB+c0IXUBHiAgFHmnzJUhjYeN0MgB3F48UgcSCS9agCxs4CIuZ+yTQb65Jtpt
         OqwX01TtZb1hrjR2YlPQ6YQYFCJol9nB2G5GkSGU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 47/75] perf ordered_events: Add private data member
Date:   Thu,  6 Dec 2018 18:25:34 -0300
Message-Id: <20181206212602.20474-48-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We will need it in following patch, where we can't use the
container_of() trick to get the higher level object.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-vgs9aoek21v14o3obza586yy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
-- 
2.19.2

