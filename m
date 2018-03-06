Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754076AbeCFRYc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753852AbeCFRYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:24:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661D32178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 8/9] perf auxtrace: Prevent decoding when --no-itrace
Date: Tue,  6 Mar 2018 14:23:42 -0300
Message-Id: <20180306172343.16546-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180306172343.16546-1-acme@kernel.org>
References: <20180306172343.16546-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Prevent auxtrace_queues__process_index() from queuing AUX area data for
decoding when the --no-itrace option has been used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 9faf3b5367db..6470ea2aa25e 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -60,6 +60,12 @@
 #include "sane_ctype.h"
 #include "symbol/kallsyms.h"
 
+static bool auxtrace__dont_decode(struct perf_session *session)
+{
+	return !session->itrace_synth_opts ||
+	       session->itrace_synth_opts->dont_decode;
+}
+
 int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 			struct auxtrace_mmap_params *mp,
 			void *userpg, int fd)
@@ -762,6 +768,9 @@ int auxtrace_queues__process_index(struct auxtrace_queues *queues,
 	size_t i;
 	int err;
 
+	if (auxtrace__dont_decode(session))
+		return 0;
+
 	list_for_each_entry(auxtrace_index, &session->auxtrace_index, list) {
 		for (i = 0; i < auxtrace_index->nr; i++) {
 			ent = &auxtrace_index->entries[i];
@@ -892,12 +901,6 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
 	return err;
 }
 
-static bool auxtrace__dont_decode(struct perf_session *session)
-{
-	return !session->itrace_synth_opts ||
-	       session->itrace_synth_opts->dont_decode;
-}
-
 int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
 				      union perf_event *event,
 				      struct perf_session *session)
-- 
2.14.3
