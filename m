Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7ECC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A7A2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbeLNUdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:33:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51017 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNUdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:33:53 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKWVvs1454372
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:32:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKWVcw1454368;
        Fri, 14 Dec 2018 12:32:31 -0800
Date:   Fri, 14 Dec 2018 12:32:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-41405354bd534857a02448c14df4454bf8abe432@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        peterz@infradead.org, kan.liang@linux.intel.com, ak@linux.intel.com
Reply-To: peterz@infradead.org, kan.liang@linux.intel.com,
          ak@linux.intel.com, linux-kernel@vger.kernel.org,
          yao.jin@linux.intel.com, mingo@kernel.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <1543586097-27632-3-git-send-email-yao.jin@linux.intel.com>
References: <1543586097-27632-3-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Create a annotate2 flag in struct
 symbol
Git-Commit-ID: 41405354bd534857a02448c14df4454bf8abe432
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

Commit-ID:  41405354bd534857a02448c14df4454bf8abe432
Gitweb:     https://git.kernel.org/tip/41405354bd534857a02448c14df4454bf8abe432
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 30 Nov 2018 21:54:55 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 30 Nov 2018 17:14:52 -0300

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
 
