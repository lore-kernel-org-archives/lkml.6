Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B90C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB0120854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB0120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeIMSFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIMSFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79F062C971E;
        Thu, 13 Sep 2018 12:55:43 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71273600C8;
        Thu, 13 Sep 2018 12:55:41 +0000 (UTC)
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
Subject: [PATCH 22/48] perf tools: Introduce thread__find_symbol_by_time() and friends
Date:   Thu, 13 Sep 2018 14:54:24 +0200
Message-Id: <20180913125450.21342-23-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Sep 2018 12:55:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

These new functions are for find appropriate map (and symbol) at the
given time when used with an indexed data file.  This is based on the
fact that map_groups list is sorted by time in the previous patch.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/n/tip-dg807z4umbjfq0yk2e3vixaj@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/event.c   | 52 ++++++++++++++++++++++++++++++++++-----
 tools/perf/util/machine.c | 20 +++++++++------
 tools/perf/util/thread.c  | 25 +++++++++++++++++++
 tools/perf/util/thread.h  |  9 +++++++
 4 files changed, 92 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 29438cda8aa2..74d20056b860 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1516,15 +1516,14 @@ int perf_event__process(struct perf_tool *tool __maybe_unused,
 	return machine__process_event(machine, event, sample);
 }
 
-struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
-			     struct addr_location *al)
+static
+struct map *map_groups__find_map(struct map_groups *mg, u8 cpumode,
+				 u64 addr, struct addr_location *al)
 {
-	struct map_groups *mg = thread->mg;
 	struct machine *machine = mg->machine;
 	bool load_map = false;
 
 	al->machine = machine;
-	al->thread = thread;
 	al->addr = addr;
 	al->cpumode = cpumode;
 	al->filtered = 0;
@@ -1595,6 +1594,28 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	return al->map;
 }
 
+struct map *thread__find_map(struct thread *thread, u8 cpumode,
+			     u64 addr, struct addr_location *al)
+{
+	al->thread = thread;
+	return map_groups__find_map(thread->mg, cpumode, addr, al);
+}
+
+struct map *thread__find_map_by_time(struct thread *thread, u8 cpumode,
+				     u64 addr, struct addr_location *al,
+				     u64 timestamp)
+{
+	struct map_groups *mg;
+
+	if (perf_has_index)
+		mg = thread__get_map_groups(thread, timestamp);
+	else
+		mg = thread->mg;
+
+	al->thread = thread;
+	return map_groups__find_map(mg, cpumode, addr, al);
+}
+
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al)
 {
@@ -1604,6 +1625,22 @@ struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 	return al->sym;
 }
 
+struct symbol *thread__find_symbol_by_time(struct thread *thread, u8 cpumode,
+					   u64 addr, struct addr_location *al,
+					   u64 timestamp)
+{
+	if (perf_has_index)
+		thread__find_map_by_time(thread, cpumode, addr, al, timestamp);
+	else
+		thread__find_map(thread, cpumode, addr, al);
+
+	if (al->map != NULL)
+		al->sym = map__find_symbol(al->map, al->addr);
+	else
+		al->sym = NULL;
+	return al->sym;
+}
+
 /*
  * Callers need to drop the reference to al->thread, obtained in
  * machine__findnew_thread()
@@ -1619,7 +1656,9 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 		return -1;
 
 	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread->tid);
-	thread__find_map(thread, sample->cpumode, sample->ip, al);
+	thread__find_map_by_time(thread, sample->cpumode,
+				 sample->ip, al, sample->time);
+
 	dump_printf(" ...... dso: %s\n",
 		    al->map ? al->map->dso->long_name :
 			al->level == 'H' ? "[hypervisor]" : "<not found>");
@@ -1698,7 +1737,8 @@ bool sample_addr_correlates_sym(struct perf_event_attr *attr)
 void thread__resolve(struct thread *thread, struct addr_location *al,
 		     struct perf_sample *sample)
 {
-	thread__find_map(thread, sample->cpumode, sample->addr, al);
+	thread__find_map_by_time(thread, sample->cpumode, sample->addr,
+				 al, sample->time);
 
 	al->cpu = sample->cpu;
 	al->sym = NULL;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e2ebe471cdbc..0c576a01697e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2011,7 +2011,7 @@ static bool symbol__match_regex(struct symbol *sym, regex_t *regex)
 
 static void ip__resolve_ams(struct thread *thread,
 			    struct addr_map_symbol *ams,
-			    u64 ip)
+			    u64 ip, u64 timestamp)
 {
 	struct addr_location al;
 
@@ -2023,7 +2023,8 @@ static void ip__resolve_ams(struct thread *thread,
 	 * Thus, we have to try consecutively until we find a match
 	 * or else, the symbol is unknown
 	 */
-	thread__find_cpumode_addr_location(thread, ip, &al);
+	thread__find_cpumode_addr_location_by_time(thread, ip,
+						   &al, timestamp);
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
@@ -2034,13 +2035,14 @@ static void ip__resolve_ams(struct thread *thread,
 
 static void ip__resolve_data(struct thread *thread,
 			     u8 m, struct addr_map_symbol *ams,
-			     u64 addr, u64 phys_addr)
+			     u64 addr, u64 phys_addr, u64 timestamp)
 {
 	struct addr_location al;
 
 	memset(&al, 0, sizeof(al));
 
-	thread__find_symbol(thread, m, addr, &al);
+	thread__find_symbol_by_time(thread, m, addr,
+				    &al, timestamp);
 
 	ams->addr = addr;
 	ams->al_addr = al.addr;
@@ -2057,9 +2059,9 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 	if (!mi)
 		return NULL;
 
-	ip__resolve_ams(al->thread, &mi->iaddr, sample->ip);
+	ip__resolve_ams(al->thread, &mi->iaddr, sample->ip, sample->time);
 	ip__resolve_data(al->thread, al->cpumode, &mi->daddr,
-			 sample->addr, sample->phys_addr);
+			 sample->addr, sample->phys_addr, sample->time);
 	mi->data_src.val = sample->data_src;
 
 	return mi;
@@ -2175,8 +2177,10 @@ struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
 		return NULL;
 
 	for (i = 0; i < bs->nr; i++) {
-		ip__resolve_ams(al->thread, &bi[i].to, bs->entries[i].to);
-		ip__resolve_ams(al->thread, &bi[i].from, bs->entries[i].from);
+		ip__resolve_ams(al->thread, &bi[i].to,
+				bs->entries[i].to, sample->time);
+		ip__resolve_ams(al->thread, &bi[i].from,
+				bs->entries[i].from, sample->time);
 		bi[i].flags = bs->entries[i].flags;
 	}
 	return bi;
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index fbda4b6d2ec5..8a0b27202ab7 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -550,3 +550,28 @@ struct thread *thread__main_thread(struct machine *machine, struct thread *threa
 
 	return machine__find_thread(machine, thread->pid_, thread->pid_);
 }
+
+void thread__find_cpumode_addr_location_by_time(struct thread *thread,
+						u64 addr, struct addr_location *al,
+						u64 timestamp)
+{
+	size_t i;
+	const u8 cpumodes[] = {
+		PERF_RECORD_MISC_USER,
+		PERF_RECORD_MISC_KERNEL,
+		PERF_RECORD_MISC_GUEST_USER,
+		PERF_RECORD_MISC_GUEST_KERNEL
+	};
+
+	if (!perf_has_index) {
+		thread__find_cpumode_addr_location(thread, addr, al);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cpumodes); i++) {
+		thread__find_symbol_by_time(thread, cpumodes[i],
+					    addr, al, timestamp);
+		if (al->map)
+			break;
+	}
+}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index e7eaf32a0cf1..86186a0773a0 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -99,12 +99,21 @@ struct thread *thread__main_thread(struct machine *machine, struct thread *threa
 
 struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al);
+struct map *thread__find_map_by_time(struct thread *thread, u8 cpumode,
+				     u64 addr, struct addr_location *al,
+				     u64 timestamp);
 
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al);
+struct symbol *thread__find_symbol_by_time(struct thread *thread, u8 cpumode,
+					   u64 addr, struct addr_location *al,
+					   u64 timestamp);
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 					struct addr_location *al);
+void thread__find_cpumode_addr_location_by_time(struct thread *thread,
+						u64 addr, struct addr_location *al,
+						u64 timestamp);
 
 static inline void *thread__priv(struct thread *thread)
 {
-- 
2.17.1

