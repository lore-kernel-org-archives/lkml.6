Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C4FC61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609D520882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609D520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIMSET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeIMSET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55B6681DE1;
        Thu, 13 Sep 2018 12:54:58 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D0AA600C6;
        Thu, 13 Sep 2018 12:54:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 02/48] perf tools: Remove perf_tool from event_op3
Date:   Thu, 13 Sep 2018 14:54:04 +0200
Message-Id: <20180913125450.21342-3-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 13 Sep 2018 12:54:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now when we keep perf_tool pointer inside perf_session,
there's no need to have perf_tool argument in the
event_op3 callback. Removing it.

Link: http://lkml.kernel.org/n/tip-78u9m0jbre3bn16l6guqfyrf@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-inject.c | 6 +++---
 tools/perf/util/auxtrace.c  | 7 +++----
 tools/perf/util/auxtrace.h  | 5 ++---
 tools/perf/util/session.c   | 8 +++-----
 tools/perf/util/tool.h      | 4 +---
 5 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d77ed2aea95a..03fc65da0657 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -131,10 +131,10 @@ static int copy_bytes(struct perf_inject *inject, int fd, off_t size)
 	return 0;
 }
 
-static s64 perf_event__repipe_auxtrace(struct perf_tool *tool,
-				       union perf_event *event,
-				       struct perf_session *session)
+static s64 perf_event__repipe_auxtrace(struct perf_session *session,
+				       union perf_event *event)
 {
+	struct perf_tool *tool = session->tool;
 	struct perf_inject *inject = container_of(tool, struct perf_inject,
 						  tool);
 	int ret;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 86f0bc445f93..3017b205a157 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -931,9 +931,8 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
 	}
 }
 
-s64 perf_event__process_auxtrace(struct perf_tool *tool,
-				 union perf_event *event,
-				 struct perf_session *session)
+s64 perf_event__process_auxtrace(struct perf_session *session,
+				 union perf_event *event)
 {
 	s64 err;
 
@@ -949,7 +948,7 @@ s64 perf_event__process_auxtrace(struct perf_tool *tool,
 	if (!session->auxtrace || event->header.type != PERF_RECORD_AUXTRACE)
 		return -EINVAL;
 
-	err = session->auxtrace->process_auxtrace_event(session, event, tool);
+	err = session->auxtrace->process_auxtrace_event(session, event, session->tool);
 	if (err < 0)
 		return err;
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 97776470a52e..6be89776358c 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -519,9 +519,8 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
 					 perf_event__handler_t process);
 int perf_event__process_auxtrace_info(struct perf_session *session,
 				      union perf_event *event);
-s64 perf_event__process_auxtrace(struct perf_tool *tool,
-				 union perf_event *event,
-				 struct perf_session *session);
+s64 perf_event__process_auxtrace(struct perf_session *session,
+				 union perf_event *event);
 int perf_event__process_auxtrace_error(struct perf_session *session,
 				       union perf_event *event);
 int itrace_parse_synth_opts(const struct option *opt, const char *str,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e781cdba845c..7d2c8ce6cfad 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -275,10 +275,8 @@ static int skipn(int fd, off_t n)
 	return 0;
 }
 
-static s64 process_event_auxtrace_stub(struct perf_tool *tool __maybe_unused,
-				       union perf_event *event,
-				       struct perf_session *session
-				       __maybe_unused)
+static s64 process_event_auxtrace_stub(struct perf_session *session __maybe_unused,
+				       union perf_event *event)
 {
 	dump_printf(": unhandled!\n");
 	if (perf_data__is_pipe(session->data))
@@ -1376,7 +1374,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_AUXTRACE:
 		/* setup for reading amidst mmap */
 		lseek(fd, file_offset + event->header.size, SEEK_SET);
-		return tool->auxtrace(tool, event, session);
+		return tool->auxtrace(session, event);
 	case PERF_RECORD_AUXTRACE_ERROR:
 		perf_session__auxtrace_error_inc(session, event);
 		return tool->auxtrace_error(session, event);
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 9c7f78d76275..56e4ca54020a 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -27,13 +27,11 @@ typedef int (*event_attr_op)(struct perf_tool *tool,
 			     struct perf_evlist **pevlist);
 
 typedef int (*event_op2)(struct perf_session *session, union perf_event *event);
+typedef s64 (*event_op3)(struct perf_session *session, union perf_event *event);
 
 typedef int (*event_oe)(struct perf_tool *tool, union perf_event *event,
 			struct ordered_events *oe);
 
-typedef s64 (*event_op3)(struct perf_tool *tool, union perf_event *event,
-			 struct perf_session *session);
-
 enum show_feature_header {
 	SHOW_FEAT_NO_HEADER = 0,
 	SHOW_FEAT_HEADER,
-- 
2.17.1

