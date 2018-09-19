Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB77ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9098E21526
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUz2qBry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9098E21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbeISUE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731308AbeISUEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:04:25 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C6E2086E;
        Wed, 19 Sep 2018 14:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537367174;
        bh=NFzy8uQcmsaVqe9Jm7LI8Mq3nYvzu49ZH4NGmX3ILn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUz2qBrysQQwWsQP/eXeWgRrkasvvI88zzCZ1EZ/8xG8/zj/mSIjtou3y50bWs98z
         6hgdg/QT4WcoAT3IBmIxGso/K08VnN06K36mw+Esq57FIP++D1tWc0YcitgU5thHBq
         ldCLdtQyON80XQFRiUidbjj8lSNVTxDriG9cj/4g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/13] perf tools: Remove perf_tool from event_op3
Date:   Wed, 19 Sep 2018 11:25:32 -0300
Message-Id: <20180919142537.29985-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Now that we keep a perf_tool pointer inside perf_session, there's no need
to have a perf_tool argument in the event_op3 callback. Remove it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180913125450.21342-3-jolsa@kernel.org
[ Fix the builtin-inject.c build for !HAVE_AUXTRACE_SUPPORT ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 11 +++++------
 tools/perf/util/auxtrace.c  |  7 +++----
 tools/perf/util/auxtrace.h  |  5 ++---
 tools/perf/util/session.c   |  8 +++-----
 tools/perf/util/tool.h      |  4 +---
 5 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d77ed2aea95a..b4a29f435b06 100644
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
@@ -172,9 +172,8 @@ static s64 perf_event__repipe_auxtrace(struct perf_tool *tool,
 #else
 
 static s64
-perf_event__repipe_auxtrace(struct perf_tool *tool __maybe_unused,
-			    union perf_event *event __maybe_unused,
-			    struct perf_session *session __maybe_unused)
+perf_event__repipe_auxtrace(struct perf_session *session __maybe_unused,
+			    union perf_event *event __maybe_unused)
 {
 	pr_err("AUX area tracing not supported\n");
 	return -EINVAL;
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
2.14.4

