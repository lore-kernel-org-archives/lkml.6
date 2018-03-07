Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933757AbeCGODx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:03:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:30695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933701AbeCGODb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:03:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="36206864"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] perf intel-pt: Adjust overlap-checking to support sampling mode
Date: Wed,  7 Mar 2018 16:02:29 +0200
Message-Id: <1520431349-30689-10-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust overlap-checking to support sampling mode.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 5c5c155fba78..0effaff57020 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -230,6 +230,7 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 	struct auxtrace_buffer *buffer = ptq->buffer;
 	struct auxtrace_buffer *old_buffer = ptq->old_buffer;
 	struct auxtrace_queue *queue;
+	bool might_overlap;
 
 	if (ptq->stop) {
 		b->len = 0;
@@ -256,7 +257,8 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 			return -ENOMEM;
 	}
 
-	if (ptq->pt->snapshot_mode && !buffer->consecutive && old_buffer &&
+	might_overlap = ptq->pt->snapshot_mode || ptq->pt->sampling_mode;
+	if (might_overlap && !buffer->consecutive && old_buffer &&
 	    intel_pt_do_fix_overlap(ptq->pt, old_buffer, buffer))
 		return -ENOMEM;
 
@@ -269,8 +271,7 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 	}
 	b->ref_timestamp = buffer->reference;
 
-	if (!old_buffer || ptq->pt->sampling_mode || (ptq->pt->snapshot_mode &&
-						      !buffer->consecutive)) {
+	if (!old_buffer || (might_overlap && !buffer->consecutive)) {
 		b->consecutive = false;
 		b->trace_nr = buffer->buffer_nr + 1;
 	} else {
-- 
1.9.1
