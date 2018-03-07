Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754270AbeCGI2I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:28:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54839 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeCGI2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:28:05 -0500
Date: Wed, 7 Mar 2018 00:27:59 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-2e2967f4c398e0f984a6c04daa3a79512e2bb74e@git.kernel.org>
Cc: hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        jolsa@redhat.com
Reply-To: adrian.hunter@intel.com, jolsa@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
In-Reply-To: <1520327598-1317-3-git-send-email-adrian.hunter@intel.com>
References: <1520327598-1317-3-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf auxtrace: Prevent decoding when --no-itrace
Git-Commit-ID: 2e2967f4c398e0f984a6c04daa3a79512e2bb74e
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

Commit-ID:  2e2967f4c398e0f984a6c04daa3a79512e2bb74e
Gitweb:     https://git.kernel.org/tip/2e2967f4c398e0f984a6c04daa3a79512e2bb74e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Mar 2018 11:13:13 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Mar 2018 11:05:47 -0300

perf auxtrace: Prevent decoding when --no-itrace

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
@@ -892,12 +901,6 @@ out_free:
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
