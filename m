Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7B72084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfBUQHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:07:23 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:46468 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728491AbfBUQHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:07:21 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 444zrQ2sZDz1yTx;
        Thu, 21 Feb 2019 17:07:18 +0100 (CET)
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.21.5.153
Received: from fau.de (faustud-010-021-005-153.pool.uni-erlangen.de [10.21.5.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18UGQTr9Q2Aj6fujvYOCb5QzhzPOXQnC70=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 444zrM26NBz20V6;
        Thu, 21 Feb 2019 17:07:15 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Gardner <rob.gardner@oracle.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 3/3] perf machine: add inline symbols to callchains
Date:   Thu, 21 Feb 2019 17:06:52 +0100
Message-Id: <20190221160652.1788-4-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
References: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use map__inlines to resolve inlined functions for every entry with
an symbol that should be added to a callchain.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 tools/perf/util/machine.c | 115 ++++++++++++++++++++++++++++----------
 1 file changed, 87 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index dce29c21e4ea..070d074482b4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1908,6 +1908,91 @@ struct iterations {
 	u64 cycles;
 };
 
+static int __add_callchain_location(struct callchain_cursor *cursor,
+				    struct symbol **parent,
+				    struct addr_location *root_al,
+				    u64 addr, struct addr_location *al,
+				    bool branch, struct branch_flags *flags,
+				    u64 branch_from, struct iterations *iter)
+{
+	int nr_loop_iter = 0;
+	u64 iter_cycles = 0;
+
+	if (symbol_conf.hide_unresolved && al->sym == NULL)
+		return 0;
+
+	if (al->sym) {
+		if (perf_hpp_list.parent && !*parent &&
+		  symbol__match_regex(al->sym, &parent_regex))
+			*parent = al->sym;
+		else if (have_ignore_callees && root_al &&
+		  symbol__match_regex(al->sym, &ignore_callees_regex)) {
+			/* Treat this symbol as the root,
+			   forgetting its callees. */
+			*root_al = *al;
+			callchain_cursor_reset(cursor);
+		}
+	}
+
+	if (iter) {
+		nr_loop_iter = iter->nr_loop_iter;
+		iter_cycles = iter->cycles;
+	}
+	return callchain_cursor_append(cursor, addr, al->map, al->sym, branch,
+				       flags, nr_loop_iter, iter_cycles,
+				       branch_from, al->srcline);
+}
+
+static int __add_callchain_ip(struct callchain_cursor *cursor, u64 ip,
+			      struct addr_location *al, bool branch,
+			      struct branch_flags *flags, u64 branch_from,
+			      struct iterations *iter, struct symbol **parent,
+			      struct addr_location *root_al)
+{
+	struct inline_node *inline_node;
+	struct inline_list *inline_list;
+	const char *srcline;
+	struct symbol *symbol;
+	int err = 0;
+
+	al->srcline = callchain_srcline(al->map, al->sym, al->addr);
+	if (callchain_param.order == ORDER_CALLER)
+		err = __add_callchain_location(cursor, parent, root_al, ip, al,
+					       branch, flags, branch_from, iter);
+	if (err || !al->map || !al->sym)
+		goto no_inline;
+
+	inline_node = map__inlines(al->map, ip, al->sym);
+	if (!inline_node || list_empty(&inline_node->val))
+		goto no_inline;
+
+	symbol = al->sym;
+	srcline = al->srcline;
+	list_for_each_entry(inline_list, &inline_node->val, list) {
+		if (inline_list->symbol == symbol)
+			continue;
+		al->sym = inline_list->symbol;
+		al->srcline = inline_list->srcline;
+		err = __add_callchain_location(cursor, parent, root_al, ip,
+					       al, branch, flags,
+					       branch_from, iter);
+		if (err)
+			break;
+	}
+
+	if (callchain_param.order == ORDER_CALLEE) {
+		al->srcline = srcline;
+		al->sym = symbol;
+	}
+
+no_inline:
+	if (!err && callchain_param.order == ORDER_CALLEE)
+		err = __add_callchain_location(cursor, parent, root_al, ip, al,
+					       branch, flags, branch_from, iter);
+	return err;
+}
+
+
 static int add_callchain_ip(struct thread *thread,
 			    struct callchain_cursor *cursor,
 			    struct symbol **parent,
@@ -1920,9 +2005,6 @@ static int add_callchain_ip(struct thread *thread,
 			    u64 branch_from)
 {
 	struct addr_location al;
-	int nr_loop_iter = 0;
-	u64 iter_cycles = 0;
-	const char *srcline = NULL;
 
 	al.filtered = 0;
 	al.sym = NULL;
@@ -1955,31 +2037,8 @@ static int add_callchain_ip(struct thread *thread,
 		thread__find_symbol(thread, *cpumode, ip, &al);
 	}
 
-	if (al.sym != NULL) {
-		if (perf_hpp_list.parent && !*parent &&
-		    symbol__match_regex(al.sym, &parent_regex))
-			*parent = al.sym;
-		else if (have_ignore_callees && root_al &&
-		  symbol__match_regex(al.sym, &ignore_callees_regex)) {
-			/* Treat this symbol as the root,
-			   forgetting its callees. */
-			*root_al = al;
-			callchain_cursor_reset(cursor);
-		}
-	}
-
-	if (symbol_conf.hide_unresolved && al.sym == NULL)
-		return 0;
-
-	if (iter) {
-		nr_loop_iter = iter->nr_loop_iter;
-		iter_cycles = iter->cycles;
-	}
-
-	srcline = callchain_srcline(al.map, al.sym, al.addr);
-	return callchain_cursor_append(cursor, ip, al.map, al.sym,
-				       branch, flags, nr_loop_iter,
-				       iter_cycles, branch_from, srcline);
+	return __add_callchain_ip(cursor, ip, &al, branch, flags, branch_from,
+				  iter, parent, root_al);
 }
 
 struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
-- 
2.19.2

