Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeCHTvb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:51:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbeCHTv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBE5205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/54] perf auxtrace: Make auxtrace_queues__add_buffer() return buffer_ptr
Date: Thu,  8 Mar 2018 16:49:52 -0300
Message-Id: <20180308195029.14991-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation for supporting AUX area sampling buffers,
auxtrace_queues__add_buffer() needs to be more generic. To that end, make
it return buffer_ptr instead of the caller.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-6-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
