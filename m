Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B61C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FA420854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FA420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeIMSFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIMSFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52A12811C0;
        Thu, 13 Sep 2018 12:55:55 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5052C600C9;
        Thu, 13 Sep 2018 12:55:53 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 27/48] perf tools: Use map_groups__find_addr_by_time()
Date:   Thu, 13 Sep 2018 14:54:29 +0200
Message-Id: <20180913125450.21342-28-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 13 Sep 2018 12:55:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Use timestamp to find a corresponding map so that it can find a match
symbol eventually.

Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-v4i4q9u41ab4hcjispe9qjzk@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/event.c  | 83 +++++++++++++++++++++++++++++++++++-----
 tools/perf/util/thread.c |  8 +++-
 2 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 74d20056b860..64ba909aeecb 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1516,12 +1516,11 @@ int perf_event__process(struct perf_tool *tool __maybe_unused,
 	return machine__process_event(machine, event, sample);
 }
 
-static
-struct map *map_groups__find_map(struct map_groups *mg, u8 cpumode,
-				 u64 addr, struct addr_location *al)
+static bool map_groups__set_addr_location(struct map_groups *mg,
+					  struct addr_location *al,
+					  u8 cpumode, u64 addr)
 {
 	struct machine *machine = mg->machine;
-	bool load_map = false;
 
 	al->machine = machine;
 	al->addr = addr;
@@ -1530,21 +1529,17 @@ struct map *map_groups__find_map(struct map_groups *mg, u8 cpumode,
 
 	if (machine == NULL) {
 		al->map = NULL;
-		return NULL;
+		return true;
 	}
 
 	BUG_ON(mg == NULL);
 
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
-		mg = &machine->kmaps;
-		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
 		al->level = '.';
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
 		al->level = 'g';
-		mg = &machine->kmaps;
-		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
 		al->level = 'u';
 	} else {
@@ -1560,8 +1555,27 @@ struct map *map_groups__find_map(struct map_groups *mg, u8 cpumode,
 			!perf_host)
 			al->filtered |= (1 << HIST_FILTER__HOST);
 
+		return true;
+	}
+	return false;
+}
+
+static
+struct map *map_groups__find_map(struct map_groups *mg, u8 cpumode,
+				 u64 addr, struct addr_location *al)
+{
+	struct machine *machine = mg->machine;
+	bool load_map = false;
+
+	if (map_groups__set_addr_location(mg, al, cpumode, addr))
 		return NULL;
+
+	if ((cpumode == PERF_RECORD_MISC_KERNEL && perf_host) ||
+	    (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest)) {
+		mg = &machine->kmaps;
+		load_map = true;
 	}
+
 try_again:
 	al->map = map_groups__find(mg, al->addr);
 	if (al->map == NULL) {
@@ -1594,6 +1608,55 @@ struct map *map_groups__find_map(struct map_groups *mg, u8 cpumode,
 	return al->map;
 }
 
+static
+struct map *map_groups__find_map_by_time(struct map_groups *mg, u8 cpumode,
+					 u64 addr, struct addr_location *al,
+					 u64 timestamp)
+{
+	struct machine *machine = mg->machine;
+	bool load_map = false;
+
+	if (map_groups__set_addr_location(mg, al, cpumode, addr))
+		return NULL;
+
+	if ((cpumode == PERF_RECORD_MISC_KERNEL && perf_host) ||
+	    (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest)) {
+		mg = &machine->kmaps;
+		load_map = true;
+	}
+
+try_again:
+	al->map = map_groups__find_by_time(mg, al->addr, timestamp);
+	if (al->map == NULL) {
+		/*
+		 * If this is outside of all known maps, and is a negative
+		 * address, try to look it up in the kernel dso, as it might be
+		 * a vsyscall or vdso (which executes in user-mode).
+		 *
+		 * XXX This is nasty, we should have a symbol list in the
+		 * "[vdso]" dso, but for now lets use the old trick of looking
+		 * in the whole kernel symbol list.
+		 */
+		if (cpumode == PERF_RECORD_MISC_USER && machine &&
+		    mg != &machine->kmaps &&
+		    machine__kernel_ip(machine, al->addr)) {
+			mg = &machine->kmaps;
+			load_map = true;
+			goto try_again;
+		}
+	} else {
+		/*
+		 * Kernel maps might be changed when loading symbols so loading
+		 * must be done prior to using kernel maps.
+		 */
+		if (load_map)
+			map__load(al->map);
+		al->addr = al->map->map_ip(al->map, al->addr);
+	}
+
+	return al->map;
+}
+
 struct map *thread__find_map(struct thread *thread, u8 cpumode,
 			     u64 addr, struct addr_location *al)
 {
@@ -1613,7 +1676,7 @@ struct map *thread__find_map_by_time(struct thread *thread, u8 cpumode,
 		mg = thread->mg;
 
 	al->thread = thread;
-	return map_groups__find_map(mg, cpumode, addr, al);
+	return map_groups__find_map_by_time(mg, cpumode, addr, al, timestamp);
 }
 
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 8a0b27202ab7..491761752ac6 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -449,8 +449,12 @@ int thread__insert_map(struct thread *thread, struct map *map)
 	if (ret)
 		return ret;
 
-	map_groups__fixup_overlappings(thread->mg, map, stderr);
-	map_groups__insert(thread->mg, map);
+	if (perf_has_index) {
+		map_groups__insert_by_time(thread->mg, map);
+	} else {
+		map_groups__fixup_overlappings(thread->mg, map, stderr);
+		map_groups__insert(thread->mg, map);
+	}
 
 	return 0;
 }
-- 
2.17.1

