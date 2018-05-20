Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbeETId4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:33:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbeETIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:33:55 -0400
Date: Sun, 20 May 2018 10:33:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf fixes for 4.17
Message-ID: <alpine.DEB.2.21.1805201031320.1599@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus


Address issues on the perf tooling side:

 - Fix segfault when processing unknown threads in cs-etm
    
 - Fix "perf test inet_pton" on s390 failing due to missing inline
    
 - Display all available events on 'perf annotate --stdio'
    
 - Add missing newline when parsing an empty BPF program


Thanks,

	tglx

------------------>
Arnaldo Carvalho de Melo (1):
      perf tools: Add missing newline when parsing empty BPF proggie

Jin Yao (1):
      perf annotate: Display all available events on --stdio

Leo Yan (2):
      perf cs-etm: Support unknown_thread in cs_etm_auxtrace
      perf cs-etm: Remove redundant space

Thomas Richter (1):
      perf test: "probe libc's inet_pton" fails on s390 due to missing inline


 .../tests/shell/record+probe_libc_inet_pton.sh     |  2 +-
 tools/perf/util/annotate.c                         |  3 +++
 tools/perf/util/cs-etm.c                           | 28 ++++++++++++++++++----
 tools/perf/util/parse-events.c                     |  2 +-
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 016882dbbc16..ee86473643be 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -16,7 +16,7 @@ nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 trace_libc_inet_pton_backtrace() {
 	idx=0
 	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
-	expected[1]=".*inet_pton[[:space:]]\($libc\)$"
+	expected[1]=".*inet_pton[[:space:]]\($libc|inlined\)$"
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 536ee148bff8..5d74a30fe00f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1263,6 +1263,9 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 				max_percent = sample->percent;
 		}
 
+		if (al->samples_nr > nr_percent)
+			nr_percent = al->samples_nr;
+
 		if (max_percent < min_pcnt)
 			return -1;
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 40020b1ca54f..bf16dc9ee507 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -239,6 +239,7 @@ static void cs_etm__free(struct perf_session *session)
 	for (i = 0; i < aux->num_cpu; i++)
 		zfree(&aux->metadata[i]);
 
+	thread__zput(aux->unknown_thread);
 	zfree(&aux->metadata);
 	zfree(&aux);
 }
@@ -612,8 +613,8 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 	return buff->len;
 }
 
-static void  cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
-				     struct auxtrace_queue *queue)
+static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
+				    struct auxtrace_queue *queue)
 {
 	struct cs_etm_queue *etmq = queue->priv;
 
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
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2fb0272146d8..b8b8a9558d32 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1715,7 +1715,7 @@ int parse_events(struct perf_evlist *evlist, const char *str,
 		struct perf_evsel *last;
 
 		if (list_empty(&parse_state.list)) {
-			WARN_ONCE(true, "WARNING: event parser found nothing");
+			WARN_ONCE(true, "WARNING: event parser found nothing\n");
 			return -1;
 		}
 
