Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeCIIvK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:51:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40425 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeCIIvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:51:09 -0500
Date: Fri, 9 Mar 2018 00:51:03 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-599a5beb78ad95181677e7919f54dbd64b404cf7@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@redhat.com,
        adrian.hunter@intel.com, hpa@zytor.com, mingo@kernel.org,
        acme@redhat.com, tglx@linutronix.de
Reply-To: acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
In-Reply-To: <1520431349-30689-10-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-10-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Adjust overlap-checking to support
 sampling mode
Git-Commit-ID: 599a5beb78ad95181677e7919f54dbd64b404cf7
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

Commit-ID:  599a5beb78ad95181677e7919f54dbd64b404cf7
Gitweb:     https://git.kernel.org/tip/599a5beb78ad95181677e7919f54dbd64b404cf7
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 7 Mar 2018 16:02:29 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:58 -0300

perf intel-pt: Adjust overlap-checking to support sampling mode

Adjust overlap-checking to support sampling mode.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520431349-30689-10-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
