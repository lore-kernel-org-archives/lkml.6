Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6478C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C7021479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfBSSik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:38:40 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:40947 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbfBSSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:38:39 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 443qHw6Kjqz20VF;
        Tue, 19 Feb 2019 19:38:36 +0100 (CET)
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.21.0.253
Received: from fau.de (faustud-010-021-000-253.pool.uni-erlangen.de [10.21.0.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+RS4bPv27qHATeRGGC//69+XJ3CbAfkHg=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 443qHt5pkwz204J;
        Tue, 19 Feb 2019 19:38:34 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf evsel: add inline functions to sample callchain output
Date:   Tue, 19 Feb 2019 19:38:10 +0100
Message-Id: <6aab7b5b0816426fed3cb2f2a2ba08e73e4c51e2.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
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
 tools/perf/util/evsel_fprintf.c | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index c710f687ddf4..9f9ece453dc4 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -168,6 +168,49 @@ static int __fprintf_callchain_link(u64 ip, struct map *map, struct symbol *symb
 	return printed;
 }
 
+static int __fprintf_callchain_inlines(struct callchain_cursor_node *node,
+				       bool first, int left_alignment,
+				       unsigned int print_opts, FILE *fp)
+{
+	int printed = 0;
+	struct inline_node *inline_node;
+	struct inline_list *ilist;
+	u64 addr;
+
+	if (!symbol_conf.inline_name)
+		return 0;
+
+	if (!node->map || !node->map->dso)
+		return 0;
+
+	addr = node->map->map_ip(node->map, node->ip);
+
+	inline_node = inlines__tree_find(&node->map->dso->inlined_nodes,
+					 addr);
+	if (!inline_node) {
+		inline_node = dso__parse_addr_inlines(node->map->dso,
+						      addr, node->sym);
+		if (!inline_node)
+			return 0;
+		inlines__tree_insert(&node->map->dso->inlined_nodes,
+				     inline_node);
+	}
+
+	list_for_each_entry(ilist, &inline_node->val, list) {
+		if (ilist->symbol == node->sym)
+			break;
+
+		printed += __fprintf_callchain_link(node->ip, node->map,
+						    ilist->symbol,
+						    ilist->srcline,
+						    first, left_alignment,
+						    print_opts, fp);
+		first = (first && printed == 0);
+	}
+
+	return printed;
+}
+
 int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			      unsigned int print_opts, struct callchain_cursor *cursor,
 			      FILE *fp)
@@ -183,6 +226,9 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (!node)
 				break;
 
+			printed += __fprintf_callchain_inlines(node, (printed ==  0),
+							       left_alignment,
+							       print_opts, fp);
 
 			printed += __fprintf_callchain_link(node->ip, node->map,
 							    node->sym, NULL,
-- 
2.19.2

