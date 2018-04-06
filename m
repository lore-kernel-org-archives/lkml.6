Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeDFREl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:04:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeDFREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:04:39 -0400
Date: Fri, 6 Apr 2018 10:04:24 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-0d75f123a6dcdacb3550b0c3c44a283f7259289e@git.kernel.org>
Cc: jolsa@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
        tglx@linutronix.de, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
        jolsa@redhat.com
In-Reply-To: <1520327598-1317-7-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-7-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf auxtrace: Make auxtrace_queues__add_buffer()
 allocate struct buffer
Git-Commit-ID: 0d75f123a6dcdacb3550b0c3c44a283f7259289e
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

Commit-ID:  0d75f123a6dcdacb3550b0c3c44a283f7259289e
Gitweb:     https://git.kernel.org/tip/0d75f123a6dcdacb3550b0c3c44a283f7259289e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Mar 2018 11:13:17 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 5 Apr 2018 11:03:33 -0300

perf auxtrace: Make auxtrace_queues__add_buffer() allocate struct buffer

In preparation for supporting AUX area sampling buffers,
auxtrace_queues__add_buffer() needs to be more generic. To that end,
move memory allocation for struct buffer into it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-7-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 54 +++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index fb357a00dd86..e1aff91c54a8 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -308,7 +308,11 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 				       struct auxtrace_buffer *buffer,
 				       struct auxtrace_buffer **buffer_ptr)
 {
-	int err;
+	int err = -ENOMEM;
+
+	buffer = memdup(buffer, sizeof(*buffer));
+	if (!buffer)
+		return -ENOMEM;
 
 	if (session->one_mmap) {
 		buffer->data = buffer->data_offset - session->one_mmap_offset +
@@ -316,24 +320,28 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 	} else if (perf_data__is_pipe(session->data)) {
 		buffer->data = auxtrace_copy_data(buffer->size, session);
 		if (!buffer->data)
-			return -ENOMEM;
+			goto out_free;
 		buffer->data_needs_freeing = true;
 	} else if (BITS_PER_LONG == 32 &&
 		   buffer->size > BUFFER_LIMIT_FOR_32_BIT) {
 		err = auxtrace_queues__split_buffer(queues, idx, buffer);
 		if (err)
-			return err;
+			goto out_free;
 	}
 
 	err = auxtrace_queues__queue_buffer(queues, idx, buffer);
 	if (err)
-		return err;
+		goto out_free;
 
 	/* FIXME: Doesn't work for split buffer */
 	if (buffer_ptr)
 		*buffer_ptr = buffer;
 
 	return 0;
+
+out_free:
+	auxtrace_buffer__free(buffer);
+	return err;
 }
 
 static bool filter_cpu(struct perf_session *session, int cpu)
@@ -348,36 +356,22 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 			       union perf_event *event, off_t data_offset,
 			       struct auxtrace_buffer **buffer_ptr)
 {
-	struct auxtrace_buffer *buffer;
-	unsigned int idx;
-	int err;
+	struct auxtrace_buffer buffer = {
+		.pid = -1,
+		.tid = event->auxtrace.tid,
+		.cpu = event->auxtrace.cpu,
+		.data_offset = data_offset,
+		.offset = event->auxtrace.offset,
+		.reference = event->auxtrace.reference,
+		.size = event->auxtrace.size,
+	};
+	unsigned int idx = event->auxtrace.idx;
 
 	if (filter_cpu(session, event->auxtrace.cpu))
 		return 0;
 
-	buffer = zalloc(sizeof(struct auxtrace_buffer));
-	if (!buffer)
-		return -ENOMEM;
-
-	buffer->pid = -1;
-	buffer->tid = event->auxtrace.tid;
-	buffer->cpu = event->auxtrace.cpu;
-	buffer->data_offset = data_offset;
-	buffer->offset = event->auxtrace.offset;
-	buffer->reference = event->auxtrace.reference;
-	buffer->size = event->auxtrace.size;
-	idx = event->auxtrace.idx;
-
-	err = auxtrace_queues__add_buffer(queues, session, idx, buffer,
-					  buffer_ptr);
-	if (err)
-		goto out_err;
-
-	return 0;
-
-out_err:
-	auxtrace_buffer__free(buffer);
-	return err;
+	return auxtrace_queues__add_buffer(queues, session, idx, &buffer,
+					   buffer_ptr);
 }
 
 static int auxtrace_queues__add_indexed_event(struct auxtrace_queues *queues,
