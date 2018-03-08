Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751493AbeCHTv2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:51:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751313AbeCHTv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8D62177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/54] perf auxtrace: Rename some buffer-queuing functions
Date: Thu,  8 Mar 2018 16:49:51 -0300
Message-Id: <20180308195029.14991-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Rename some buffer-queuing functions in preparation for supporting AUX area
sampling buffers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-5-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 6470ea2aa25e..6ea840ec5b7f 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -233,9 +233,9 @@ static void *auxtrace_copy_data(u64 size, struct perf_session *session)
 	return p;
 }
 
-static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
-				       unsigned int idx,
-				       struct auxtrace_buffer *buffer)
+static int auxtrace_queues__queue_buffer(struct auxtrace_queues *queues,
+					 unsigned int idx,
+					 struct auxtrace_buffer *buffer)
 {
 	struct auxtrace_queue *queue;
 	int err;
@@ -286,7 +286,7 @@ static int auxtrace_queues__split_buffer(struct auxtrace_queues *queues,
 			return -ENOMEM;
 		b->size = BUFFER_LIMIT_FOR_32_BIT;
 		b->consecutive = consecutive;
-		err = auxtrace_queues__add_buffer(queues, idx, b);
+		err = auxtrace_queues__queue_buffer(queues, idx, b);
 		if (err) {
 			auxtrace_buffer__free(b);
 			return err;
@@ -302,10 +302,10 @@ static int auxtrace_queues__split_buffer(struct auxtrace_queues *queues,
 	return 0;
 }
 
-static int auxtrace_queues__add_event_buffer(struct auxtrace_queues *queues,
-					     struct perf_session *session,
-					     unsigned int idx,
-					     struct auxtrace_buffer *buffer)
+static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
+				       struct perf_session *session,
+				       unsigned int idx,
+				       struct auxtrace_buffer *buffer)
 {
 	if (session->one_mmap) {
 		buffer->data = buffer->data_offset - session->one_mmap_offset +
@@ -324,7 +324,7 @@ static int auxtrace_queues__add_event_buffer(struct auxtrace_queues *queues,
 			return err;
 	}
 
-	return auxtrace_queues__add_buffer(queues, idx, buffer);
+	return auxtrace_queues__queue_buffer(queues, idx, buffer);
 }
 
 static bool filter_cpu(struct perf_session *session, int cpu)
@@ -359,7 +359,7 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 	buffer->size = event->auxtrace.size;
 	idx = event->auxtrace.idx;
 
-	err = auxtrace_queues__add_event_buffer(queues, session, idx, buffer);
+	err = auxtrace_queues__add_buffer(queues, session, idx, buffer);
 	if (err)
 		goto out_err;
 
-- 
2.14.3
