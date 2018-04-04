Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeDDOxq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:53:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:6629 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbeDDOxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:53:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,406,1517904000";
   d="scan'208";a="30655942"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Markus Metzger <markus.t.metzger@intel.com>
Subject: [PATCH v2] perf: Suppress AUX/OVERWRITE records
Date: Wed,  4 Apr 2018 17:53:23 +0300
Message-Id: <20180404145323.28651-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180403173207.GA8921@arm.com>
References: <20180403173207.GA8921@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been pointed out to me many times that it is useful to be able
to switch off AUX records to save the bandwidth for records that actually
matter, for example, in AUX overwrite mode.

The usefulness of PERF_RECORD_AUX is in some of its flags, like the
TRUNCATED flag that tells the decoder where exactly gaps in the trace are.
The OVERWRITE flag, on the other hand will be set on every single record
in overwrite mode. However, a PERF_RECORD_AUX[flags=OVERWRITE] is
generated on every target task's sched_out, which over time adds up to
a lot of useless information.

If any folks out there have userspace that depends on a constant stream of
OVERWRITE records for a good reason, they'll have to let us know.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Markus Metzger <markus.t.metzger@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/ring_buffer.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 6c6b3c48db71..c4edd8fbc5d9 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -458,10 +458,20 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 	if (size || handle->aux_flags) {
 		/*
 		 * Only send RECORD_AUX if we have something useful to communicate
+		 *
+		 * Note: the OVERWRITE records by themselves are not considered
+		 * useful, as they don't communicate any *new* information,
+		 * aside from the short-lived offset, that becomes history at
+		 * the next event sched-in and therefore isn't useful.
+		 * The userspace that needs to copy out AUX data in overwrite
+		 * mode should know to use user_page::aux_head for the actual
+		 * offset. So, from now on we don't output AUX records that
+		 * have *only* OVERWRITE flag set.
 		 */
 
-		perf_event_aux_event(handle->event, aux_head, size,
-		                     handle->aux_flags);
+		if (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE)
+			perf_event_aux_event(handle->event, aux_head, size,
+			                     handle->aux_flags);
 	}
 
 	rb->user_page->aux_head = rb->aux_head;
-- 
2.16.3
