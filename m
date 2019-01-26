Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92099C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A94A214C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfAZJzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:55:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAZJzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:55:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0Q9taEa509968
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 01:55:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0Q9taNx509965;
        Sat, 26 Jan 2019 01:55:36 -0800
Date:   Sat, 26 Jan 2019 01:55:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-rvo9dzflkneqmprb0dgbfybx@git.kernel.org>
Cc:     jolsa@kernel.org, adrian.hunter@intel.com, mingo@kernel.org,
        hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, namhyung@kernel.org
Reply-To: namhyung@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Move symbol_conf to separate file
Git-Commit-ID: 19ea1b6f63dda171eb5f2a41a9d7badc722221cd
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

Commit-ID:  19ea1b6f63dda171eb5f2a41a9d7badc722221cd
Gitweb:     https://git.kernel.org/tip/19ea1b6f63dda171eb5f2a41a9d7badc722221cd
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 22 Jan 2019 10:32:27 -0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:08 +0100

perf symbols: Move symbol_conf to separate file

So that we don't drag all the headers included in symbol.h when needing
to access symbol_conf in another header, such as annotate.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-rvo9dzflkneqmprb0dgbfybx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.h      | 64 +------------------------------------
 tools/perf/util/symbol_conf.h | 73 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 63 deletions(-)

diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 14d9d438e7e2..277841e3dbd1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -15,6 +15,7 @@
 #include "build-id.h"
 #include "event.h"
 #include "path.h"
+#include "symbol_conf.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 #include <libelf.h>
@@ -89,69 +90,6 @@ static inline size_t symbol__size(const struct symbol *sym)
 struct strlist;
 struct intlist;
 
-struct symbol_conf {
-	unsigned short	priv_size;
-	bool		try_vmlinux_path,
-			init_annotation,
-			force,
-			ignore_vmlinux,
-			ignore_vmlinux_buildid,
-			show_kernel_path,
-			use_modules,
-			allow_aliases,
-			sort_by_name,
-			show_nr_samples,
-			show_total_period,
-			use_callchain,
-			cumulate_callchain,
-			show_branchflag_count,
-			exclude_other,
-			show_cpu_utilization,
-			initialized,
-			kptr_restrict,
-			event_group,
-			demangle,
-			demangle_kernel,
-			filter_relative,
-			show_hist_headers,
-			branch_callstack,
-			has_filter,
-			show_ref_callgraph,
-			hide_unresolved,
-			raw_trace,
-			report_hierarchy,
-			inline_name;
-	const char	*vmlinux_name,
-			*kallsyms_name,
-			*source_prefix,
-			*field_sep,
-			*graph_function;
-	const char	*default_guest_vmlinux_name,
-			*default_guest_kallsyms,
-			*default_guest_modules;
-	const char	*guestmount;
-	const char	*dso_list_str,
-			*comm_list_str,
-			*pid_list_str,
-			*tid_list_str,
-			*sym_list_str,
-			*col_width_list_str,
-			*bt_stop_list_str;
-       struct strlist	*dso_list,
-			*comm_list,
-			*sym_list,
-			*dso_from_list,
-			*dso_to_list,
-			*sym_from_list,
-			*sym_to_list,
-			*bt_stop_list;
-	struct intlist	*pid_list,
-			*tid_list;
-	const char	*symfs;
-};
-
-extern struct symbol_conf symbol_conf;
-
 struct symbol_name_rb_node {
 	struct rb_node	rb_node;
 	struct symbol	sym;
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
new file mode 100644
index 000000000000..fffea68c1203
--- /dev/null
+++ b/tools/perf/util/symbol_conf.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_SYMBOL_CONF
+#define __PERF_SYMBOL_CONF 1
+
+#include <stdbool.h>
+
+struct strlist;
+struct intlist;
+
+struct symbol_conf {
+	unsigned short	priv_size;
+	bool		try_vmlinux_path,
+			init_annotation,
+			force,
+			ignore_vmlinux,
+			ignore_vmlinux_buildid,
+			show_kernel_path,
+			use_modules,
+			allow_aliases,
+			sort_by_name,
+			show_nr_samples,
+			show_total_period,
+			use_callchain,
+			cumulate_callchain,
+			show_branchflag_count,
+			exclude_other,
+			show_cpu_utilization,
+			initialized,
+			kptr_restrict,
+			event_group,
+			demangle,
+			demangle_kernel,
+			filter_relative,
+			show_hist_headers,
+			branch_callstack,
+			has_filter,
+			show_ref_callgraph,
+			hide_unresolved,
+			raw_trace,
+			report_hierarchy,
+			inline_name;
+	const char	*vmlinux_name,
+			*kallsyms_name,
+			*source_prefix,
+			*field_sep,
+			*graph_function;
+	const char	*default_guest_vmlinux_name,
+			*default_guest_kallsyms,
+			*default_guest_modules;
+	const char	*guestmount;
+	const char	*dso_list_str,
+			*comm_list_str,
+			*pid_list_str,
+			*tid_list_str,
+			*sym_list_str,
+			*col_width_list_str,
+			*bt_stop_list_str;
+       struct strlist	*dso_list,
+			*comm_list,
+			*sym_list,
+			*dso_from_list,
+			*dso_to_list,
+			*sym_from_list,
+			*sym_to_list,
+			*bt_stop_list;
+	struct intlist	*pid_list,
+			*tid_list;
+	const char	*symfs;
+};
+
+extern struct symbol_conf symbol_conf;
+
+#endif // __PERF_SYMBOL_CONF
