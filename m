Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeEOGlG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:41:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbeEOGlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:41:04 -0400
Date: Mon, 14 May 2018 23:40:44 -0700
From: tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-46d53620044f7b574c0f3216f8b4f2ce3559ce31@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, mingo@kernel.org,
        leo.yan@linaro.org, tglx@linutronix.de, namhyung@kernel.org,
        acme@redhat.com, hpa@zytor.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org
Reply-To: mingo@kernel.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, tglx@linutronix.de, namhyung@kernel.org,
        leo.yan@linaro.org, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com,
        peterz@infradead.org
In-Reply-To: <1525924920-4381-1-git-send-email-leo.yan@linaro.org>
References: <1525924920-4381-1-git-send-email-leo.yan@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cs-etm: Support unknown_thread in
 cs_etm_auxtrace
Git-Commit-ID: 46d53620044f7b574c0f3216f8b4f2ce3559ce31
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

Commit-ID:  46d53620044f7b574c0f3216f8b4f2ce3559ce31
Gitweb:     https://git.kernel.org/tip/46d53620044f7b574c0f3216f8b4f2ce3559ce31
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Thu, 10 May 2018 12:01:59 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 11 May 2018 10:45:23 -0300

perf cs-etm: Support unknown_thread in cs_etm_auxtrace

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
