Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932444AbeCFJOO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:14:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:28963 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752483AbeCFJOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:14:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="25575387"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] perf auxtrace: Rename some buffer-queuing functions
Date: Tue,  6 Mar 2018 11:13:15 +0200
Message-Id: <1520327598-1317-5-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename some buffer-queuing functions in preparation for supporting AUX area
sampling buffers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
1.9.1
