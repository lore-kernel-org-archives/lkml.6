Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F01EC61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5465F2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5465F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeIMSFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbeIMSFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F38943082B70;
        Thu, 13 Sep 2018 12:55:59 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDEE7600C8;
        Thu, 13 Sep 2018 12:55:57 +0000 (UTC)
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
Subject: [PATCH 29/48] perf callchain: Maintain libunwind's address space in map_groups
Date:   Thu, 13 Sep 2018 14:54:31 +0200
Message-Id: <20180913125450.21342-30-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 13 Sep 2018 12:56:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the address_space was kept in thread struct but it's more
appropriate to keep it in map_groups as it's maintained throughout
exec's with timestamps.  Also we should not flush the address space
after exec since it still can be accessed when used with an indexed
data file.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/n/tip-hjryh6x2yfnrz8g0djhez24z@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/map.h                    |  5 ++++-
 tools/perf/util/thread.h                 |  1 -
 tools/perf/util/unwind-libunwind-local.c | 28 ++++++++++++++----------
 tools/perf/util/unwind-libunwind.c       |  9 ++++----
 tools/perf/util/unwind.h                 |  7 +++---
 5 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 02c6f6962eb1..b1efe57b8563 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -65,10 +65,13 @@ struct maps {
 
 struct map_groups {
 	struct maps	 maps;
-	struct machine	 *machine;
+	struct machine	*machine;
 	refcount_t	 refcnt;
 	u64		 timestamp;
 	struct list_head list;
+#ifdef HAVE_LIBUNWIND_SUPPORT
+	void		*addr_space;
+#endif
 };
 
 struct map_groups *map_groups__new(struct machine *machine);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 86186a0773a0..637775f622b3 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -40,7 +40,6 @@ struct thread {
 	struct thread_stack	*ts;
 	struct nsinfo		*nsinfo;
 #ifdef HAVE_LIBUNWIND_SUPPORT
-	void				*addr_space;
 	struct unwind_libunwind_ops	*unwind_libunwind_ops;
 #endif
 };
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index da6f39315b47..f7c921f87bcf 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -617,32 +617,35 @@ static unw_accessors_t accessors = {
 	.get_proc_name		= get_proc_name,
 };
 
-static int _unwind__prepare_access(struct thread *thread)
+static int _unwind__prepare_access(struct map_groups *mg)
 {
 	if (!dwarf_callchain_users)
 		return 0;
-	thread->addr_space = unw_create_addr_space(&accessors, 0);
-	if (!thread->addr_space) {
+
+	mg->addr_space = unw_create_addr_space(&accessors, 0);
+	if (!mg->addr_space) {
 		pr_err("unwind: Can't create unwind address space.\n");
 		return -ENOMEM;
 	}
 
-	unw_set_caching_policy(thread->addr_space, UNW_CACHE_GLOBAL);
+	unw_set_caching_policy(mg->addr_space, UNW_CACHE_GLOBAL);
 	return 0;
 }
 
-static void _unwind__flush_access(struct thread *thread)
+static void _unwind__flush_access(struct map_groups *mg)
 {
 	if (!dwarf_callchain_users)
 		return;
-	unw_flush_cache(thread->addr_space, 0, 0);
+
+	unw_flush_cache(mg->addr_space, 0, 0);
 }
 
-static void _unwind__finish_access(struct thread *thread)
+static void _unwind__finish_access(struct map_groups *mg)
 {
 	if (!dwarf_callchain_users)
 		return;
-	unw_destroy_addr_space(thread->addr_space);
+
+	unw_destroy_addr_space(mg->addr_space);
 }
 
 static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
@@ -650,7 +653,6 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 {
 	u64 val;
 	unw_word_t ips[max_stack];
-	unw_addr_space_t addr_space;
 	unw_cursor_t c;
 	int ret, i = 0;
 
@@ -666,13 +668,15 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 	 * unwind itself.
 	 */
 	if (max_stack - 1 > 0) {
+		struct map_groups *mg;
+
 		WARN_ONCE(!ui->thread, "WARNING: ui->thread is NULL");
-		addr_space = ui->thread->addr_space;
 
-		if (addr_space == NULL)
+		mg = thread__get_map_groups(ui->thread, ui->sample->time);
+		if (mg == NULL || mg->addr_space == NULL)
 			return -1;
 
-		ret = unw_init_remote(&c, addr_space, ui);
+		ret = unw_init_remote(&c, mg->addr_space, ui);
 		if (ret)
 			display_error(ret);
 
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index b029a5e9ae49..ce8408e460f2 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -18,12 +18,13 @@ static void unwind__register_ops(struct thread *thread,
 int unwind__prepare_access(struct thread *thread, struct map *map,
 			   bool *initialized)
 {
+	struct map_groups *mg = thread->mg;
 	const char *arch;
 	enum dso_type dso_type;
 	struct unwind_libunwind_ops *ops = local_unwind_libunwind_ops;
 	int err;
 
-	if (thread->addr_space) {
+	if (mg->addr_space) {
 		pr_debug("unwind: thread map already set, dso=%s\n",
 			 map->dso->name);
 		if (initialized)
@@ -56,7 +57,7 @@ int unwind__prepare_access(struct thread *thread, struct map *map,
 out_register:
 	unwind__register_ops(thread, ops);
 
-	err = thread->unwind_libunwind_ops->prepare_access(thread);
+	err = thread->unwind_libunwind_ops->prepare_access(thread->mg);
 	if (initialized)
 		*initialized = err ? false : true;
 	return err;
@@ -65,13 +66,13 @@ int unwind__prepare_access(struct thread *thread, struct map *map,
 void unwind__flush_access(struct thread *thread)
 {
 	if (thread->unwind_libunwind_ops)
-		thread->unwind_libunwind_ops->flush_access(thread);
+		thread->unwind_libunwind_ops->flush_access(thread->mg);
 }
 
 void unwind__finish_access(struct thread *thread)
 {
 	if (thread->unwind_libunwind_ops)
-		thread->unwind_libunwind_ops->finish_access(thread);
+		thread->unwind_libunwind_ops->finish_access(thread->mg);
 }
 
 int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
index 8a44a1569a21..0f18a0858904 100644
--- a/tools/perf/util/unwind.h
+++ b/tools/perf/util/unwind.h
@@ -9,6 +9,7 @@ struct map;
 struct perf_sample;
 struct symbol;
 struct thread;
+struct map_groups;
 
 struct unwind_entry {
 	struct map	*map;
@@ -19,9 +20,9 @@ struct unwind_entry {
 typedef int (*unwind_entry_cb_t)(struct unwind_entry *entry, void *arg);
 
 struct unwind_libunwind_ops {
-	int (*prepare_access)(struct thread *thread);
-	void (*flush_access)(struct thread *thread);
-	void (*finish_access)(struct thread *thread);
+	int (*prepare_access)(struct map_groups *mg);
+	void (*flush_access)(struct map_groups *mg);
+	void (*finish_access)(struct map_groups *mg);
 	int (*get_entries)(unwind_entry_cb_t cb, void *arg,
 			   struct thread *thread,
 			   struct perf_sample *data, int max_stack);
-- 
2.17.1

