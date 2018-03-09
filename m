Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCIIuQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:50:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeCIIuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:50:15 -0500
Date: Fri, 9 Mar 2018 00:50:08 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-9c6650647de430a6ad9707c51b3342f23af0d2ee@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com,
        adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
        tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com, acme@redhat.com,
        tglx@linutronix.de
In-Reply-To: <1520431349-30689-8-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-8-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Tidy old_buffer handling in
 intel_pt_get_trace()
Git-Commit-ID: 9c6650647de430a6ad9707c51b3342f23af0d2ee
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9c6650647de430a6ad9707c51b3342f23af0d2ee
Gitweb:     https://git.kernel.org/tip/9c6650647de430a6ad9707c51b3342f23af0d2ee
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 7 Mar 2018 16:02:27 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:57 -0300

perf intel-pt: Tidy old_buffer handling in intel_pt_get_trace()

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
@@ -267,16 +269,6 @@ next:
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
@@ -288,8 +280,14 @@ next:
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
