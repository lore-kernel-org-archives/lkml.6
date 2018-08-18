Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D54CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9C5219C5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9C5219C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeHRO3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:29:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:29:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBLwVX1283758
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:21:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBLwLV1283755;
        Sat, 18 Aug 2018 04:21:58 -0700
Date:   Sat, 18 Aug 2018 04:21:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-y59may7zx1eccnp4m3qm4u0b@git.kernel.org>
Cc:     namhyung@kernel.org, dsahern@gmail.com, tglx@linutronix.de,
        hpa@zytor.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, adrian.hunter@intel.com, mingo@kernel.org,
        wangnan0@huawei.com
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          hpa@zytor.com, dsahern@gmail.com, tglx@linutronix.de,
          namhyung@kernel.org, wangnan0@huawei.com, mingo@kernel.org,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Use perf_evsel__sc_tp_{uint,ptr} for
 "id"/"args" handling syscalls:* events
Git-Commit-ID: f3acd8869b9badcfd91cf50a2b6242be7b9368e2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f3acd8869b9badcfd91cf50a2b6242be7b9368e2
Gitweb:     https://git.kernel.org/tip/f3acd8869b9badcfd91cf50a2b6242be7b9368e2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 2 Aug 2018 15:11:58 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 Aug 2018 15:39:00 -0300

perf trace: Use perf_evsel__sc_tp_{uint,ptr} for "id"/"args" handling syscalls:* events

Now it looks just about the same as for the trace__sys_{enter,exit}.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-y59may7zx1eccnp4m3qm4u0b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 41799596c045..7232a7302580 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1693,20 +1693,13 @@ out_put:
 static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evsel,
 				    struct perf_sample *sample)
 {
-	struct format_field *field = perf_evsel__field(evsel, "__syscall_nr");
 	struct thread_trace *ttrace;
 	struct thread *thread;
-	struct syscall *sc;
+	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	struct syscall *sc = trace__syscall_info(trace, evsel, id);
 	char msg[1024];
-	int id, err = -1;
 	void *args;
 
-	if (field == NULL)
-		return -1;
-
-	id = format_field__intval(field, sample, evsel->needs_swap);
-	sc = trace__syscall_info(trace, evsel, id);
-
 	if (sc == NULL)
 		return -1;
 
@@ -1719,7 +1712,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 	if (ttrace == NULL)
 		goto out_put;
 
-	args = sample->raw_data + field->offset + sizeof(u64); /* skip __syscall_nr, there is where args are */
+	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
 	syscall__scnprintf_args(sc, msg, sizeof(msg), args, trace, thread);
 	fprintf(trace->output, "%s", msg);
 	err = 0;
