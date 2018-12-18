Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B446EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE4820873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeLROAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:00:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44111 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeLROAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:00:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDxSuO2852023
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:59:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDxSg82852020;
        Tue, 18 Dec 2018 05:59:28 -0800
Date:   Tue, 18 Dec 2018 05:59:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-246fda09c127e689780d32ef72f2e870615ece3f@git.kernel.org>
Cc:     ak@linux.intel.com, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kan.liang@linux.intel.com, yao.jin@linux.intel.com, acme@redhat.com
Reply-To: kan.liang@linux.intel.com, tglx@linutronix.de, acme@redhat.com,
          yao.jin@linux.intel.com, jolsa@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          ak@linux.intel.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <1543586097-27632-3-git-send-email-yao.jin@linux.intel.com>
References: <1543586097-27632-3-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Create a annotate2 flag in struct
 symbol
Git-Commit-ID: 246fda09c127e689780d32ef72f2e870615ece3f
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

Commit-ID:  246fda09c127e689780d32ef72f2e870615ece3f
Gitweb:     https://git.kernel.org/tip/246fda09c127e689780d32ef72f2e870615ece3f
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 30 Nov 2018 21:54:55 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:55:40 -0300

perf annotate: Create a annotate2 flag in struct symbol

We often use the symbol__annotate2() to annotate a specified symbol.
While annotating may take some time, so in order to avoid annotating the
same symbol repeatedly, the patch creates a new flag to indicate the
symbol has been annotated.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1543586097-27632-3-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 1 +
 tools/perf/util/symbol.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4b2b1b09b8f1..f69d8e177fa3 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2798,6 +2798,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 	notes->nr_events = nr_pcnt;
 
 	annotation__update_column_widths(notes);
+	sym->annotate2 = true;
 
 	return 0;
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d026d215bdc6..14d9d438e7e2 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -63,6 +63,7 @@ struct symbol {
 	u8		ignore:1;
 	u8		inlined:1;
 	u8		arch_sym;
+	bool		annotate2;
 	char		name[0];
 };
 
