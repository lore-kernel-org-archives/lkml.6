Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB26FC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7405D20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7405D20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbeIMSFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIMSFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C718A3086257;
        Thu, 13 Sep 2018 12:55:45 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C365B600D1;
        Thu, 13 Sep 2018 12:55:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 23/48] perf callchain: Use thread__find_addr_location_by_time() and friends
Date:   Thu, 13 Sep 2018 14:54:25 +0200
Message-Id: <20180913125450.21342-24-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 13 Sep 2018 12:55:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Find correct thread/map/symbol using proper functions.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/n/tip-k02mlrexo1h3bsezgrr7ydn8@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c                | 18 +++++++++++-------
 tools/perf/util/unwind-libdw.c           |  6 ++++--
 tools/perf/util/unwind-libunwind-local.c | 11 +++++++----
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0c576a01697e..dc46a7967e10 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2101,7 +2101,8 @@ static int add_callchain_ip(struct thread *thread,
 			    bool branch,
 			    struct branch_flags *flags,
 			    struct iterations *iter,
-			    u64 branch_from)
+			    u64 branch_from,
+			    u64 timestamp)
 {
 	struct addr_location al;
 	int nr_loop_iter = 0;
@@ -2111,7 +2112,8 @@ static int add_callchain_ip(struct thread *thread,
 	al.filtered = 0;
 	al.sym = NULL;
 	if (!cpumode) {
-		thread__find_cpumode_addr_location(thread, ip, &al);
+		thread__find_cpumode_addr_location_by_time(thread, ip,
+							   &al, timestamp);
 	} else {
 		if (ip >= PERF_CONTEXT_MAX) {
 			switch (ip) {
@@ -2136,7 +2138,8 @@ static int add_callchain_ip(struct thread *thread,
 			}
 			return 0;
 		}
-		thread__find_symbol(thread, *cpumode, ip, &al);
+		thread__find_symbol_by_time(thread, *cpumode, ip, &al,
+					    timestamp);
 	}
 
 	if (al.sym != NULL) {
@@ -2333,7 +2336,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, ip,
 					       branch, flags, NULL,
-					       branch_from);
+					       branch_from, sample->time);
 			if (err)
 				return (err < 0) ? err : 0;
 		}
@@ -2356,6 +2359,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	int chain_nr = 0;
 	u8 cpumode = PERF_RECORD_MISC_USER;
 	int i, j, err, nr_entries;
+	u64 timestamp = sample->time;
 	int skip_idx = -1;
 	int first_call = 0;
 
@@ -2429,13 +2433,13 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 					       root_al,
 					       NULL, be[i].to,
 					       true, &be[i].flags,
-					       NULL, be[i].from);
+					       NULL, be[i].from, timestamp);
 
 			if (!err)
 				err = add_callchain_ip(thread, cursor, parent, root_al,
 						       NULL, be[i].from,
 						       true, &be[i].flags,
-						       &iter[i], 0);
+						       &iter[i], 0, timestamp);
 			if (err == -EINVAL)
 				break;
 			if (err)
@@ -2469,7 +2473,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
-				       false, NULL, NULL, 0);
+				       false, NULL, NULL, 0, timestamp);
 
 		if (err)
 			return (err < 0) ? err : 0;
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 6f318b15950e..c22c1030a8ad 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -32,7 +32,8 @@ static int __report_module(struct addr_location *al, u64 ip,
 	 * Some callers will use al->sym, so we can't just use the
 	 * cheaper thread__find_map() here.
 	 */
-	thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
+	thread__find_symbol_by_time(ui->thread, PERF_RECORD_MISC_USER, ip,
+				    al, ui->sample->time);
 
 	if (al->map)
 		dso = al->map->dso;
@@ -104,7 +105,8 @@ static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 	struct addr_location al;
 	ssize_t size;
 
-	if (!thread__find_map(ui->thread, PERF_RECORD_MISC_USER, addr, &al)) {
+	if (!thread__find_map_by_time(ui->thread, PERF_RECORD_MISC_USER,
+				      addr, &al, ui->sample->time)) {
 		pr_debug("unwind: no map for %lx\n", (unsigned long)addr);
 		return -1;
 	}
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 79f521a552cf..da6f39315b47 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -366,7 +366,9 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 static struct map *find_map(unw_word_t ip, struct unwind_info *ui)
 {
 	struct addr_location al;
-	return thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
+
+	return thread__find_map_by_time(ui->thread, PERF_RECORD_MISC_USER, ip,
+					&al, ui->sample->time);
 }
 
 static int
@@ -568,13 +570,14 @@ static void put_unwind_info(unw_addr_space_t __maybe_unused as,
 	pr_debug("unwind: put_unwind_info called\n");
 }
 
-static int entry(u64 ip, struct thread *thread,
+static int entry(u64 ip, struct thread *thread, u64 timestamp,
 		 unwind_entry_cb_t cb, void *arg)
 {
 	struct unwind_entry e;
 	struct addr_location al;
 
-	e.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
+	e.sym = thread__find_symbol_by_time(thread, PERF_RECORD_MISC_USER, ip,
+					    &al, timestamp);
 	e.ip  = ip;
 	e.map = al.map;
 
@@ -700,7 +703,7 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 
 		if (callchain_param.order == ORDER_CALLER)
 			j = max_stack - i - 1;
-		ret = ips[j] ? entry(ips[j], ui->thread, cb, arg) : 0;
+		ret = ips[j] ? entry(ips[j], ui->thread, ui->sample->time, cb, arg) : 0;
 	}
 
 	return ret;
-- 
2.17.1

