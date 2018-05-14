Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753337AbeENMYY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752539AbeENMXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:23:41 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/5] perf cs-etm: Support unknown_thread in cs_etm_auxtrace
Date: Mon, 14 May 2018 09:23:19 -0300
Message-Id: <20180514122321.27304-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180514122321.27304-1-acme@kernel.org>
References: <20180514122321.27304-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

CoreSight doesn't allocate thread structure for unknown_thread in ETM
auxtrace, so unknown_thread is NULL pointer.  If the perf data doesn't
contain valid tid and then cs_etm__mem_access() uses unknown_thread
instead as thread handler, this results in a segmentation fault when
thread__find_addr_map() accesses the thread handler.

This commit creates a new thread data which is used by unknown_thread, so
CoreSight tracing can roll back to use unknown_thread if perf data
doesn't include valid thread info.  This commit also releases thread
data for initialization failure case and for normal auxtrace free flow.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1525924920-4381-1-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 40020b1ca54f..2bf28b5acc08 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -239,6 +239,7 @@ static void cs_etm__free(struct perf_session *session)
 	for (i = 0; i < aux->num_cpu; i++)
 		zfree(&aux->metadata[i]);
 
+	thread__zput(aux->unknown_thread);
 	zfree(&aux->metadata);
 	zfree(&aux);
 }
@@ -1357,6 +1358,23 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	etm->auxtrace.free = cs_etm__free;
 	session->auxtrace = &etm->auxtrace;
 
+	etm->unknown_thread = thread__new(999999999, 999999999);
+	if (!etm->unknown_thread)
+		goto err_free_queues;
+
+	/*
+	 * Initialize list node so that at thread__zput() we can avoid
+	 * segmentation fault at list_del_init().
+	 */
+	INIT_LIST_HEAD(&etm->unknown_thread->node);
+
+	err = thread__set_comm(etm->unknown_thread, "unknown", 0);
+	if (err)
+		goto err_delete_thread;
+
+	if (thread__init_map_groups(etm->unknown_thread, etm->machine))
+		goto err_delete_thread;
+
 	if (dump_trace) {
 		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
 		return 0;
@@ -1371,16 +1389,18 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 
 	err = cs_etm__synth_events(etm, session);
 	if (err)
-		goto err_free_queues;
+		goto err_delete_thread;
 
 	err = auxtrace_queues__process_index(&etm->queues, session);
 	if (err)
-		goto err_free_queues;
+		goto err_delete_thread;
 
 	etm->data_queued = etm->queues.populated;
 
 	return 0;
 
+err_delete_thread:
+	thread__zput(etm->unknown_thread);
 err_free_queues:
 	auxtrace_queues__free(&etm->queues);
 	session->auxtrace = NULL;
-- 
2.14.3
