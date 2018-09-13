Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C440C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CC720882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CC720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeIMSE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbeIMSE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62F40310E9BE;
        Thu, 13 Sep 2018 12:55:07 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52F1A600C6;
        Thu, 13 Sep 2018 12:55:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 06/48] perf tools: Create separate mmap for dummy tracking event
Date:   Thu, 13 Sep 2018 14:54:08 +0200
Message-Id: <20180913125450.21342-7-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 13 Sep 2018 12:55:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When indexed data file support is enabled, a dummy tracking event will
be used to track metadata (like task, comm and mmap events) for a
session and actual samples will be recorded in separate (intermediate)
files and then merged (with index table).

Provide separate mmap to the dummy tracking event.  The size is fixed
to 128KiB (+ 1 page) as the event rate will be lower than samples.  I
originally wanted to use a single mmap for this but cross-cpu sharing
is prohibited so it's per-cpu (or per-task) like normal mmaps.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/n/tip-8vw9ocqkwqa7rsoolc25ezdt@git.kernel.org
Original-patch-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c |  9 ++++++
 tools/perf/util/evlist.c    | 55 ++++++++++++++++++++++++++++++-------
 tools/perf/util/evlist.h    |  3 ++
 tools/perf/util/mmap.h      |  1 +
 4 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0980dfe3396b..cb5a605679a1 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -533,6 +533,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct perf_mmap *map = &maps[i];
+		struct perf_mmap *track_map =  evlist->track_mmap ?
+					      &evlist->track_mmap[i] : NULL;
 
 		if (map->base) {
 			if (perf_mmap__push(map, rec, record__pushfn) != 0) {
@@ -546,6 +548,13 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 			rc = -1;
 			goto out;
 		}
+
+		if (track_map && track_map->base) {
+			if (perf_mmap__push(track_map, rec, record__pushfn) != 0) {
+				rc = -1;
+				goto out;
+			}
+		}
 	}
 
 	/*
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7428d65650c9..6cbfc5ceab75 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -736,9 +736,15 @@ static void perf_evlist__munmap_nofree(struct perf_evlist *evlist)
 {
 	int i;
 
-	if (evlist->mmap)
+	if (evlist->mmap) {
 		for (i = 0; i < evlist->nr_mmaps; i++)
 			perf_mmap__munmap(&evlist->mmap[i]);
+	}
+
+	if (evlist->track_mmap) {
+		for (i = 0; i < evlist->nr_mmaps; i++)
+			perf_mmap__munmap(&evlist->track_mmap[i]);
+	}
 
 	if (evlist->overwrite_mmap)
 		for (i = 0; i < evlist->nr_mmaps; i++)
@@ -792,14 +798,20 @@ perf_evlist__should_poll(struct perf_evlist *evlist __maybe_unused,
 }
 
 static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
-				       struct mmap_params *mp, int cpu_idx,
-				       int thread, int *_output, int *_output_overwrite)
+				       struct mmap_params *_mp, int cpu_idx,
+				       int thread, int *_output, int *_output_overwrite,
+				       int *_output_track)
 {
+	struct mmap_params mp_track = {
+		.prot = PROT_READ | PROT_WRITE,
+		.mask = TRACK_MMAP_SIZE - page_size - 1,
+	};
 	struct perf_evsel *evsel;
 	int revent;
 	int evlist_cpu = cpu_map__cpu(evlist->cpus, cpu_idx);
 
 	evlist__for_each_entry(evlist, evsel) {
+		struct mmap_params *mp = _mp;
 		struct perf_mmap *maps = evlist->mmap;
 		int *output = _output;
 		int fd;
@@ -821,6 +833,12 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 			mp->prot &= ~PROT_WRITE;
 		}
 
+		if (mp->track_mmap && perf_evsel__is_dummy_tracking(evsel)) {
+			output = _output_track;
+			maps   = evlist->track_mmap;
+			mp     = &mp_track;
+		}
+
 		if (evsel->system_wide && thread)
 			continue;
 
@@ -880,13 +898,15 @@ static int perf_evlist__mmap_per_cpu(struct perf_evlist *evlist,
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		int output = -1;
 		int output_overwrite = -1;
+		int output_track = -1;
 
 		auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, cpu,
 					      true);
 
 		for (thread = 0; thread < nr_threads; thread++) {
 			if (perf_evlist__mmap_per_evsel(evlist, cpu, mp, cpu,
-							thread, &output, &output_overwrite))
+							thread, &output, &output_overwrite,
+							&output_track))
 				goto out_unmap;
 		}
 	}
@@ -908,12 +928,13 @@ static int perf_evlist__mmap_per_thread(struct perf_evlist *evlist,
 	for (thread = 0; thread < nr_threads; thread++) {
 		int output = -1;
 		int output_overwrite = -1;
+		int output_track = -1;
 
 		auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, thread,
 					      false);
 
 		if (perf_evlist__mmap_per_evsel(evlist, thread, mp, 0, thread,
-						&output, &output_overwrite))
+						&output, &output_overwrite, &output_track))
 			goto out_unmap;
 	}
 
@@ -1058,12 +1079,26 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp;
+	struct mmap_params mp = {
+		.track_mmap = false,
+	};
 
-	if (!evlist->mmap)
-		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
-	if (!evlist->mmap)
-		return -ENOMEM;
+	if (!evlist->mmap) {
+		struct perf_mmap *map;
+
+		map = perf_evlist__alloc_mmap(evlist, false);
+		if (!map)
+			return -ENOMEM;
+
+		evlist->mmap = map;
+		if (mp.track_mmap) {
+			map = perf_evlist__alloc_mmap(evlist, false);
+			if (!map)
+				return -ENOMEM;
+
+			evlist->track_mmap = map;
+		}
+	}
 
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index c11cb80e7847..4ef1d355e811 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -24,6 +24,8 @@ struct record_opts;
 #define PERF_EVLIST__HLIST_BITS 8
 #define PERF_EVLIST__HLIST_SIZE (1 << PERF_EVLIST__HLIST_BITS)
 
+#define TRACK_MMAP_SIZE  (((128 * 1024 / page_size) + 1) * page_size)
+
 struct perf_evlist {
 	struct list_head entries;
 	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
@@ -44,6 +46,7 @@ struct perf_evlist {
 	struct fdarray	 pollfd;
 	struct perf_mmap *mmap;
 	struct perf_mmap *overwrite_mmap;
+	struct perf_mmap *track_mmap;
 	struct thread_map *threads;
 	struct cpu_map	  *cpus;
 	struct perf_evsel *selected;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e603314dc792..9d2672d8f131 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -59,6 +59,7 @@ enum bkw_mmap_state {
 struct mmap_params {
 	int			    prot, mask;
 	struct auxtrace_mmap_params auxtrace_mp;
+	bool track_mmap;
 };
 
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu);
-- 
2.17.1

