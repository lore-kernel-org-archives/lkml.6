Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeCFJOU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:14:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:28982 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932629AbeCFJOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:14:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="25575407"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] perf auxtrace: Make auxtrace_queues__add_buffer() do CPU filtering
Date: Tue,  6 Mar 2018 11:13:18 +0200
Message-Id: <1520327598-1317-8-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting AUX area sampling buffers,
auxtrace_queues__add_buffer() needs to be more generic. To that end, move
CPU filtering into it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e1aff91c54a8..857de69a5361 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -302,6 +302,13 @@ static int auxtrace_queues__split_buffer(struct auxtrace_queues *queues,
 	return 0;
 }
 
+static bool filter_cpu(struct perf_session *session, int cpu)
+{
+	unsigned long *cpu_bitmap = session->itrace_synth_opts->cpu_bitmap;
+
+	return cpu_bitmap && cpu != -1 && !test_bit(cpu, cpu_bitmap);
+}
+
 static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 				       struct perf_session *session,
 				       unsigned int idx,
@@ -310,6 +317,9 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 {
 	int err = -ENOMEM;
 
+	if (filter_cpu(session, buffer->cpu))
+		return 0;
+
 	buffer = memdup(buffer, sizeof(*buffer));
 	if (!buffer)
 		return -ENOMEM;
@@ -344,13 +354,6 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 	return err;
 }
 
-static bool filter_cpu(struct perf_session *session, int cpu)
-{
-	unsigned long *cpu_bitmap = session->itrace_synth_opts->cpu_bitmap;
-
-	return cpu_bitmap && cpu != -1 && !test_bit(cpu, cpu_bitmap);
-}
-
 int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 			       struct perf_session *session,
 			       union perf_event *event, off_t data_offset,
@@ -367,9 +370,6 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 	};
 	unsigned int idx = event->auxtrace.idx;
 
-	if (filter_cpu(session, event->auxtrace.cpu))
-		return 0;
-
 	return auxtrace_queues__add_buffer(queues, session, idx, &buffer,
 					   buffer_ptr);
 }
-- 
1.9.1
