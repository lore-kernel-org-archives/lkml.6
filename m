Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeCIIlc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:41:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeCIIla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:41:30 -0500
Date: Fri, 9 Mar 2018 00:41:23 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4c4548437c5722effcaf5b2dea85abd321935627@git.kernel.org>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, acme@redhat.com, hpa@zytor.com,
        adrian.hunter@intel.com
Reply-To: acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        mingo@kernel.org
In-Reply-To: <1520327598-1317-6-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-6-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf auxtrace: Make auxtrace_queues__add_buffer()
 return buffer_ptr
Git-Commit-ID: 4c4548437c5722effcaf5b2dea85abd321935627
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

Commit-ID:  4c4548437c5722effcaf5b2dea85abd321935627
Gitweb:     https://git.kernel.org/tip/4c4548437c5722effcaf5b2dea85abd321935627
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Mar 2018 11:13:16 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:27 -0300

perf auxtrace: Make auxtrace_queues__add_buffer() return buffer_ptr

In preparation for supporting AUX area sampling buffers,
auxtrace_queues__add_buffer() needs to be more generic. To that end, make
it return buffer_ptr instead of the caller.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-6-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 6ea840ec5b7f..fb357a00dd86 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -305,8 +305,11 @@ static int auxtrace_queues__split_buffer(struct auxtrace_queues *queues,
 static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 				       struct perf_session *session,
 				       unsigned int idx,
-				       struct auxtrace_buffer *buffer)
+				       struct auxtrace_buffer *buffer,
+				       struct auxtrace_buffer **buffer_ptr)
 {
+	int err;
+
 	if (session->one_mmap) {
 		buffer->data = buffer->data_offset - session->one_mmap_offset +
 			       session->one_mmap_addr;
@@ -317,14 +320,20 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 		buffer->data_needs_freeing = true;
 	} else if (BITS_PER_LONG == 32 &&
 		   buffer->size > BUFFER_LIMIT_FOR_32_BIT) {
-		int err;
-
 		err = auxtrace_queues__split_buffer(queues, idx, buffer);
 		if (err)
 			return err;
 	}
 
-	return auxtrace_queues__queue_buffer(queues, idx, buffer);
+	err = auxtrace_queues__queue_buffer(queues, idx, buffer);
+	if (err)
+		return err;
+
+	/* FIXME: Doesn't work for split buffer */
+	if (buffer_ptr)
+		*buffer_ptr = buffer;
+
+	return 0;
 }
 
 static bool filter_cpu(struct perf_session *session, int cpu)
@@ -359,13 +368,11 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 	buffer->size = event->auxtrace.size;
 	idx = event->auxtrace.idx;
 
-	err = auxtrace_queues__add_buffer(queues, session, idx, buffer);
+	err = auxtrace_queues__add_buffer(queues, session, idx, buffer,
+					  buffer_ptr);
 	if (err)
 		goto out_err;
 
-	if (buffer_ptr)
-		*buffer_ptr = buffer;
-
 	return 0;
 
 out_err:
