Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeDJF2Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:28:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54725 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeDJF2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:28:24 -0400
Date: Mon, 9 Apr 2018 22:28:13 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b238db655796e74b59d9ece58b645ad0b494d615@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com, acme@redhat.com,
        tglx@linutronix.de
Reply-To: acme@redhat.com, tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
In-Reply-To: <1520327598-1317-8-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-8-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf auxtrace: Make auxtrace_queues__add_buffer()
 do CPU filtering
Git-Commit-ID: b238db655796e74b59d9ece58b645ad0b494d615
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

Commit-ID:  b238db655796e74b59d9ece58b645ad0b494d615
Gitweb:     https://git.kernel.org/tip/b238db655796e74b59d9ece58b645ad0b494d615
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Mar 2018 11:13:18 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 6 Apr 2018 09:40:41 -0300

perf auxtrace: Make auxtrace_queues__add_buffer() do CPU filtering

In preparation for supporting AUX area sampling buffers,
auxtrace_queues__add_buffer() needs to be more generic. To that end, move
CPU filtering into it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-8-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
@@ -344,13 +354,6 @@ out_free:
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
