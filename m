Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC1B21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfBSSig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:38:36 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:48103 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbfBSSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:38:36 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 443qHt0XLJz1ybp;
        Tue, 19 Feb 2019 19:38:34 +0100 (CET)
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.21.0.253
Received: from fau.de (faustud-010-021-000-253.pool.uni-erlangen.de [10.21.0.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19K/0naz89DBfZaMD9iGb61ooggEpSxoGs=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 443qHq6LMxz1yW0;
        Tue, 19 Feb 2019 19:38:31 +0100 (CET)
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
Subject: [PATCH 1/2] perf evsel: split sample__fprintf_callchain in output and iteration
Date:   Tue, 19 Feb 2019 19:38:09 +0100
Message-Id: <4f1e7f5086ce20e041c597577aa6da23a14cfa8c.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the iteration over the callchain and the actual output of an
link in the callchain into separate functions. This allows to reuse
the output function in a follow up patch to add inline symbols to
the output.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 tools/perf/util/evsel_fprintf.c | 111 ++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 95ea147f9e18..c710f687ddf4 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -99,12 +99,12 @@ int perf_evsel__fprintf(struct perf_evsel *evsel,
 	return ++printed;
 }
 
-int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
-			      unsigned int print_opts, struct callchain_cursor *cursor,
-			      FILE *fp)
+static int __fprintf_callchain_link(u64 ip, struct map *map, struct symbol *symbol,
+				    const char *srcline, bool first, int left_alignment,
+				    unsigned int print_opts, FILE *fp)
 {
+	u64 addr = 0;
 	int printed = 0;
-	struct callchain_cursor_node *node;
 	int print_ip = print_opts & EVSEL__PRINT_IP;
 	int print_sym = print_opts & EVSEL__PRINT_SYM;
 	int print_dso = print_opts & EVSEL__PRINT_DSO;
@@ -115,63 +115,80 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 	int print_arrow = print_opts & EVSEL__PRINT_CALLCHAIN_ARROW;
 	int print_skip_ignored = print_opts & EVSEL__PRINT_SKIP_IGNORED;
 	char s = print_oneline ? ' ' : '\t';
-	bool first = true;
+	struct addr_location node_al;
 
-	if (sample->callchain) {
-		struct addr_location node_al;
 
-		callchain_cursor_commit(cursor);
+	if (symbol && symbol->ignore && print_skip_ignored)
+		return 0;
 
-		while (1) {
-			u64 addr = 0;
+	printed += fprintf(fp, "%-*.*s", left_alignment, left_alignment, " ");
 
-			node = callchain_cursor_current(cursor);
-			if (!node)
-				break;
+	if (print_arrow && !first)
+		printed += fprintf(fp, " <-");
 
-			if (node->sym && node->sym->ignore && print_skip_ignored)
-				goto next;
+	if (print_ip)
+		printed += fprintf(fp, "%c%16" PRIx64, s, ip);
 
-			printed += fprintf(fp, "%-*.*s", left_alignment, left_alignment, " ");
+	if (map)
+		addr = map->map_ip(map, ip);
 
-			if (print_arrow && !first)
-				printed += fprintf(fp, " <-");
+	if (print_sym) {
+		printed += fprintf(fp, " ");
+		node_al.addr = addr;
+		node_al.map  = map;
 
-			if (print_ip)
-				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
+		if (print_symoffset) {
+			printed += __symbol__fprintf_symname_offs(symbol, &node_al,
+								  print_unknown_as_addr,
+								  true, fp);
+		} else {
+			printed += __symbol__fprintf_symname(symbol, &node_al,
+							     print_unknown_as_addr,
+							     fp);
+		}
+	}
 
-			if (node->map)
-				addr = node->map->map_ip(node->map, node->ip);
+	if (print_dso && (!symbol || !symbol->inlined)) {
+		printed += fprintf(fp, " (");
+		printed += map__fprintf_dsoname(map, fp);
+		printed += fprintf(fp, ")");
+	}
 
-			if (print_sym) {
-				printed += fprintf(fp, " ");
-				node_al.addr = addr;
-				node_al.map  = node->map;
+	if (print_srcline && srcline)
+		printed += fprintf(fp, "\n  %s", srcline);
+	else if (print_srcline)
+		printed += map__fprintf_srcline(map, addr, "\n  ", fp);
 
-				if (print_symoffset) {
-					printed += __symbol__fprintf_symname_offs(node->sym, &node_al,
-										  print_unknown_as_addr,
-										  true, fp);
-				} else {
-					printed += __symbol__fprintf_symname(node->sym, &node_al,
-									     print_unknown_as_addr, fp);
-				}
-			}
+	if (symbol && symbol->inlined)
+		printed += fprintf(fp, " (inlined)");
 
-			if (print_dso && (!node->sym || !node->sym->inlined)) {
-				printed += fprintf(fp, " (");
-				printed += map__fprintf_dsoname(node->map, fp);
-				printed += fprintf(fp, ")");
-			}
+	if (!print_oneline)
+		printed += fprintf(fp, "\n");
 
-			if (print_srcline)
-				printed += map__fprintf_srcline(node->map, addr, "\n  ", fp);
+	return printed;
+}
+
+int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
+			      unsigned int print_opts, struct callchain_cursor *cursor,
+			      FILE *fp)
+{
+	int printed = 0;
+	struct callchain_cursor_node *node;
+
+	if (sample->callchain) {
+		callchain_cursor_commit(cursor);
+
+		while (1) {
+			node = callchain_cursor_current(cursor);
+			if (!node)
+				break;
 
-			if (node->sym && node->sym->inlined)
-				printed += fprintf(fp, " (inlined)");
 
-			if (!print_oneline)
-				printed += fprintf(fp, "\n");
+			printed += __fprintf_callchain_link(node->ip, node->map,
+							    node->sym, NULL,
+							    (printed == 0),
+							    left_alignment,
+							    print_opts, fp);
 
 			/* Add srccode here too? */
 			if (symbol_conf.bt_stop_list &&
@@ -181,8 +198,6 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 				break;
 			}
 
-			first = false;
-next:
 			callchain_cursor_advance(cursor);
 		}
 	}
-- 
2.19.2

