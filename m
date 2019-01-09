Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D43EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210E220821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfAIHKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:10:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59721 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfAIHKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:10:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097AeOf3855524
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:10:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097Ae0V3855521;
        Tue, 8 Jan 2019 23:10:40 -0800
Date:   Tue, 8 Jan 2019 23:10:40 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-qt20y0acmf8k0bzisce8kw95@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        lclaudio@redhat.com, jolsa@kernel.org, mingo@kernel.org,
        acme@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, hpa@zytor.com
Reply-To: jolsa@kernel.org, mingo@kernel.org, lclaudio@redhat.com,
          wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com,
          acme@redhat.com, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Fix alignment for [continued] lines
Git-Commit-ID: ac6e022cbfdce215ad545e91d9827060855da3d7
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

Commit-ID:  ac6e022cbfdce215ad545e91d9827060855da3d7
Gitweb:     https://git.kernel.org/tip/ac6e022cbfdce215ad545e91d9827060855da3d7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 7 Jan 2019 16:54:38 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 13:28:12 -0300

perf trace: Fix alignment for [continued] lines

We were not taking into account the "... [continued]" printed
characters, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qt20y0acmf8k0bzisce8kw95@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b8bf5d025563..ed4583128b9c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2032,9 +2032,10 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 	if (ttrace->entry_pending) {
 		printed = fprintf(trace->output, "%s", ttrace->entry_str);
 	} else {
-		fprintf(trace->output, " ... [");
+		printed += fprintf(trace->output, " ... [");
 		color_fprintf(trace->output, PERF_COLOR_YELLOW, "continued");
-		fprintf(trace->output, "]: %s()", sc->name);
+		printed += 9;
+		printed += fprintf(trace->output, "]: %s()", sc->name);
 	}
 
 	printed++; /* the closing ')' */
