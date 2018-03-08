Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeCHTwX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:52:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752232AbeCHTwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946EB2177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 36/54] perf intel-pt: Tidy old_buffer handling in intel_pt_get_trace()
Date: Thu,  8 Mar 2018 16:50:11 -0300
Message-Id: <20180308195029.14991-37-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

intel_pt_get_trace() fixes overlaps between the current buffer and the
previous buffer ('old_buffer').

However the previous buffer might not have had usable data (no PSB) so
the comparison must be made against the previous buffer that had usable
data.

Tidy that by keeping a pointer for that purpose in struct intel_pt_queue.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520431349-30689-8-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index cfb3614f5def..9a4f9cdb752f 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -132,6 +132,7 @@ struct intel_pt_queue {
 	struct intel_pt *pt;
 	unsigned int queue_nr;
 	struct auxtrace_buffer *buffer;
+	struct auxtrace_buffer *old_buffer;
 	void *decoder;
 	const struct intel_pt_state *state;
 	struct ip_callchain *chain;
@@ -226,7 +227,8 @@ static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *
 static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 {
 	struct intel_pt_queue *ptq = data;
-	struct auxtrace_buffer *buffer = ptq->buffer, *old_buffer = buffer;
+	struct auxtrace_buffer *buffer = ptq->buffer;
+	struct auxtrace_buffer *old_buffer = ptq->old_buffer;
 	struct auxtrace_queue *queue;
 
 	if (ptq->stop) {
@@ -235,7 +237,7 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 	}
 
 	queue = &ptq->pt->queues.queue_array[ptq->queue_nr];
-next:
+
 	buffer = auxtrace_buffer__next(queue, buffer);
 	if (!buffer) {
 		if (old_buffer)
@@ -267,16 +269,6 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 	}
 	b->ref_timestamp = buffer->reference;
 
-	/*
-	 * If in snapshot mode and the buffer has no usable data, get next
-	 * buffer and again check overlap against old_buffer.
-	 */
-	if (ptq->pt->snapshot_mode && !b->len)
-		goto next;
-
-	if (old_buffer)
-		auxtrace_buffer__drop_data(old_buffer);
-
 	if (!old_buffer || ptq->pt->sampling_mode || (ptq->pt->snapshot_mode &&
 						      !buffer->consecutive)) {
 		b->consecutive = false;
@@ -288,8 +280,14 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 	if (ptq->step_through_buffers)
 		ptq->stop = true;
 
-	if (!b->len)
+	if (b->len) {
+		if (old_buffer)
+			auxtrace_buffer__drop_data(old_buffer);
+		ptq->old_buffer = buffer;
+	} else {
+		auxtrace_buffer__drop_data(buffer);
 		return intel_pt_get_trace(b, data);
+	}
 
 	return 0;
 }
-- 
2.14.3
