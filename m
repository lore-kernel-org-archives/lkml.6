Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932837AbeCFJQF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:16:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:28963 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753245AbeCFJOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:14:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="25575379"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] perf auxtrace: Prevent decoding when --no-itrace
Date: Tue,  6 Mar 2018 11:13:13 +0200
Message-Id: <1520327598-1317-3-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent auxtrace_queues__process_index() from queuing AUX area data for
decoding when the --no-itrace option has been used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
1.9.1
