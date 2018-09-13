Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E64C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F06C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F06C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeIMSFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMSFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72D7886668;
        Thu, 13 Sep 2018 12:56:19 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 983DA600C6;
        Thu, 13 Sep 2018 12:56:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 38/48] perf record: Read record thread's mmaps
Date:   Thu, 13 Sep 2018 14:54:40 +0200
Message-Id: <20180913125450.21342-39-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 13 Sep 2018 12:56:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the maps source from evlist into thread data.

Link: http://lkml.kernel.org/n/tip-2r6hn6shl185j66b4vl1k4pr@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5c6b56f164a9..d6fef646b67f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -96,6 +96,8 @@ struct record {
 	int			threads_cnt;
 };
 
+static __thread struct record_thread *thread;
+
 static volatile int auxtrace_record__snapshot_started;
 static DEFINE_TRIGGER(auxtrace_snapshot_trigger);
 static DEFINE_TRIGGER(switch_output_trigger);
@@ -561,24 +563,24 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 				    bool overwrite)
 {
 	u64 bytes_written = rec->bytes_written;
-	int i;
+	int i, nr;
 	int rc = 0;
-	struct perf_mmap *maps;
+	struct perf_mmap **maps;
 
 	if (!evlist)
 		return 0;
 
-	maps = overwrite ? evlist->overwrite_mmap : evlist->mmap;
+	maps = overwrite ? thread->ovw_mmap : thread->mmap;
 	if (!maps)
 		return 0;
 
 	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
 		return 0;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
-		struct perf_mmap *map = &maps[i];
-		struct perf_mmap *track_map =  evlist->track_mmap ?
-					      &evlist->track_mmap[i] : NULL;
+	nr = overwrite ? thread->ovw_mmap_nr : thread->mmap_nr;
+
+	for (i = 0; i < nr; i++) {
+		struct perf_mmap *map = maps[i];
 
 		if (map->base) {
 			if (perf_mmap__push(map, rec, record__pushfn) != 0) {
@@ -592,21 +594,20 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 			rc = -1;
 			goto out;
 		}
-
-		if (track_map && track_map->base) {
-			if (perf_mmap__push(track_map, rec, record__pushfn) != 0) {
-				rc = -1;
-				goto out;
-			}
-		}
 	}
 
 	/*
 	 * Mark the round finished in case we wrote
 	 * at least one event.
 	 */
-	if (bytes_written != rec->bytes_written)
-		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
+	if (bytes_written != rec->bytes_written) {
+		/*
+		 * All maps of the threads point to a single file,
+		 * so we can just pick first one.
+		 */
+		rc = record__write(rec, thread->mmap[0], &finished_round_event,
+				   sizeof(finished_round_event));
+	}
 
 	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
@@ -1222,6 +1223,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			goto out_child;
 	}
 
+	thread = &rec->threads[0];
+
 	err = bpf__apply_obj_config();
 	if (err) {
 		char errbuf[BUFSIZ];
@@ -1415,7 +1418,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (hits == rec->samples) {
 			if (done || draining)
 				break;
-			err = perf_evlist__poll(rec->evlist, -1);
+			err = fdarray__poll(&thread->pollfd, -1);
 			/*
 			 * Propagate error, only if there's any. Ignore positive
 			 * number of returned events and interrupt error.
-- 
2.17.1

