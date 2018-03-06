Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeCFJPP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:15:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:28963 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932408AbeCFJOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:14:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="25575393"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] perf auxtrace: Make auxtrace_queues__add_buffer() return buffer_ptr
Date: Tue,  6 Mar 2018 11:13:16 +0200
Message-Id: <1520327598-1317-6-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting AUX area sampling buffers,
auxtrace_queues__add_buffer() needs to be more generic. To that end, make
it return buffer_ptr instead of the caller.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 6ea840ec5b7f..fb357a00dd86 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -305,8 +305,11 @@ static int auxtrace_queues__split_buffer(struct auxtrace_queues *queues,
 static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 				       struct perf_session *session,
 				       unsigned int idx,
-				       struct auxtrace_buffer *buffer)
+				       struct auxtrace_buffer *buffer,
+				       struct auxtrace_buffer **buffer_ptr)
 {
+	int err;
+
 	if (session->one_mmap) {
 		buffer->data = buffer->data_offset - session->one_mmap_offset +
 			       session->one_mmap_addr;
@@ -317,14 +320,20 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 		buffer->data_needs_freeing = true;
 	} else if (BITS_PER_LONG == 32 &&
 		   buffer->size > BUFFER_LIMIT_FOR_32_BIT) {
-		int err;
-
 		err = auxtrace_queues__split_buffer(queues, idx, buffer);
 		if (err)
 			return err;
 	}
 
-	return auxtrace_queues__queue_buffer(queues, idx, buffer);
+	err = auxtrace_queues__queue_buffer(queues, idx, buffer);
+	if (err)
+		return err;
+
+	/* FIXME: Doesn't work for split buffer */
+	if (buffer_ptr)
+		*buffer_ptr = buffer;
+
+	return 0;
 }
 
 static bool filter_cpu(struct perf_session *session, int cpu)
@@ -359,13 +368,11 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 	buffer->size = event->auxtrace.size;
 	idx = event->auxtrace.idx;
 
-	err = auxtrace_queues__add_buffer(queues, session, idx, buffer);
+	err = auxtrace_queues__add_buffer(queues, session, idx, buffer,
+					  buffer_ptr);
 	if (err)
 		goto out_err;
 
-	if (buffer_ptr)
-		*buffer_ptr = buffer;
-
 	return 0;
 
 out_err:
-- 
1.9.1
