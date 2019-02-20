Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CE1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F4E20685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfBTK7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:59:42 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:42164 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfBTK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:59:42 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 444F3v20Zpz1yR3;
        Wed, 20 Feb 2019 11:59:39 +0100 (CET)
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.21.3.88
Received: from fau.de (faustud-010-021-003-088.pool.uni-erlangen.de [10.21.3.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/8CY91/8H/yA5l8VtHDkBsyYQxTy09J+I=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 444F3s079zz1yFZ;
        Wed, 20 Feb 2019 11:59:37 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCHv2 2/2] perf evsel: add inline functions to sample callchain output
Date:   Wed, 20 Feb 2019 11:59:13 +0100
Message-Id: <20190220105913.1321-1-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190220001116.3b3yyndjjmqs3hmm@studium.uni-erlangen.de>
References: <20190220001116.3b3yyndjjmqs3hmm@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever a callchain shall be printed search for each address whether
inline information is available and add those symbols to the output
if symbol_conf.inline_name is enabled.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
v2:
 - fix handling of static binaries

 tools/perf/util/evsel_fprintf.c | 55 +++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index c710f687ddf4..a8d6465af1aa 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -168,6 +168,52 @@ static int __fprintf_callchain_link(u64 ip, struct map *map, struct symbol *symb
 	return printed;
 }
 
+static int __fprintf_callchain(struct callchain_cursor_node *node, bool first,
+			       int left_alignment, unsigned int print_opts,
+			       FILE *fp)
+{
+	int printed = 0;
+	struct inline_node *inline_node;
+	struct inline_list *ilist;
+	u64 addr;
+
+	if (!symbol_conf.inline_name)
+		goto no_inline;
+
+	if (!node->map || !node->map->dso)
+		goto no_inline;
+
+	addr = node->map->map_ip(node->map, node->ip);
+	addr = map__rip_2objdump(node->map, addr);
+
+	inline_node = inlines__tree_find(&node->map->dso->inlined_nodes,
+					 addr);
+	if (!inline_node) {
+		inline_node = dso__parse_addr_inlines(node->map->dso,
+						      addr, node->sym);
+		if (!inline_node)
+			goto no_inline;
+		inlines__tree_insert(&node->map->dso->inlined_nodes,
+				     inline_node);
+	}
+
+	list_for_each_entry(ilist, &inline_node->val, list) {
+		printed += __fprintf_callchain_link(node->ip, node->map,
+						    ilist->symbol,
+						    ilist->srcline,
+						    first, left_alignment,
+						    print_opts, fp);
+		first = (first && printed == 0);
+	}
+
+	return printed;
+
+no_inline:
+	return __fprintf_callchain_link(node->ip, node->map, node->sym,
+					NULL, first, left_alignment,
+					print_opts, fp);
+}
+
 int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			      unsigned int print_opts, struct callchain_cursor *cursor,
 			      FILE *fp)
@@ -183,12 +229,9 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (!node)
 				break;
 
-
-			printed += __fprintf_callchain_link(node->ip, node->map,
-							    node->sym, NULL,
-							    (printed == 0),
-							    left_alignment,
-							    print_opts, fp);
+			printed += __fprintf_callchain(node, (printed == 0),
+						       left_alignment,
+						       print_opts, fp);
 
 			/* Add srccode here too? */
 			if (symbol_conf.bt_stop_list &&
-- 
2.19.2

