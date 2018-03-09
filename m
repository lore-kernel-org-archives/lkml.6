Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeCIIlF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:41:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35433 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCIIlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:41:03 -0500
Date: Fri, 9 Mar 2018 00:40:56 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-a356a59799d376dd8e4839f29d32f4c6a5582e6d@git.kernel.org>
Cc: jolsa@redhat.com, tglx@linutronix.de, acme@redhat.com,
        adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: acme@redhat.com, jolsa@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        mingo@kernel.org
In-Reply-To: <1520327598-1317-5-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-5-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf auxtrace: Rename some buffer-queuing functions
Git-Commit-ID: a356a59799d376dd8e4839f29d32f4c6a5582e6d
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

Commit-ID:  a356a59799d376dd8e4839f29d32f4c6a5582e6d
Gitweb:     https://git.kernel.org/tip/a356a59799d376dd8e4839f29d32f4c6a5582e6d
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Mar 2018 11:13:15 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:27 -0300

perf auxtrace: Rename some buffer-queuing functions

Rename some buffer-queuing functions in preparation for supporting AUX area
sampling buffers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-5-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 6470ea2aa25e..6ea840ec5b7f 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -233,9 +233,9 @@ static void *auxtrace_copy_data(u64 size, struct perf_session *session)
 	return p;
 }
 
-static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
-				       unsigned int idx,
-				       struct auxtrace_buffer *buffer)
+static int auxtrace_queues__queue_buffer(struct auxtrace_queues *queues,
+					 unsigned int idx,
+					 struct auxtrace_buffer *buffer)
 {
 	struct auxtrace_queue *queue;
 	int err;
@@ -286,7 +286,7 @@ static int auxtrace_queues__split_buffer(struct auxtrace_queues *queues,
 			return -ENOMEM;
 		b->size = BUFFER_LIMIT_FOR_32_BIT;
 		b->consecutive = consecutive;
-		err = auxtrace_queues__add_buffer(queues, idx, b);
+		err = auxtrace_queues__queue_buffer(queues, idx, b);
 		if (err) {
 			auxtrace_buffer__free(b);
 			return err;
@@ -302,10 +302,10 @@ static int auxtrace_queues__split_buffer(struct auxtrace_queues *queues,
 	return 0;
 }
 
-static int auxtrace_queues__add_event_buffer(struct auxtrace_queues *queues,
-					     struct perf_session *session,
-					     unsigned int idx,
-					     struct auxtrace_buffer *buffer)
+static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
+				       struct perf_session *session,
+				       unsigned int idx,
+				       struct auxtrace_buffer *buffer)
 {
 	if (session->one_mmap) {
 		buffer->data = buffer->data_offset - session->one_mmap_offset +
@@ -324,7 +324,7 @@ static int auxtrace_queues__add_event_buffer(struct auxtrace_queues *queues,
 			return err;
 	}
 
-	return auxtrace_queues__add_buffer(queues, idx, buffer);
+	return auxtrace_queues__queue_buffer(queues, idx, buffer);
 }
 
 static bool filter_cpu(struct perf_session *session, int cpu)
@@ -359,7 +359,7 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 	buffer->size = event->auxtrace.size;
 	idx = event->auxtrace.idx;
 
-	err = auxtrace_queues__add_event_buffer(queues, session, idx, buffer);
+	err = auxtrace_queues__add_buffer(queues, session, idx, buffer);
 	if (err)
 		goto out_err;
 
