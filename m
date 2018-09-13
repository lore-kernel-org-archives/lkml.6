Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99187C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C50F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C50F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeIMSFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMSFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 028C181DE9;
        Thu, 13 Sep 2018 12:56:26 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24287600C8;
        Thu, 13 Sep 2018 12:56:23 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 41/48] perf record: Move bytes_written into struct record_thread
Date:   Thu, 13 Sep 2018 14:54:43 +0200
Message-Id: <20180913125450.21342-42-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 13 Sep 2018 12:56:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving bytes_written into struct record_thread.

Link: http://lkml.kernel.org/n/tip-q1xlsqksw6i8my0wbunv066d@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b17445f332a8..253bafd4dbe7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -73,12 +73,12 @@ struct record_thread {
 	struct fdarray		  pollfd;
 	struct record		 *rec;
 	unsigned long long	  samples;
+	u64			  bytes_written;
 };
 
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
-	u64			bytes_written;
 	struct perf_data	data;
 	struct auxtrace_record	*itr;
 	struct perf_evlist	*evlist;
@@ -114,7 +114,7 @@ static bool switch_output_size(struct record *rec)
 {
 	return rec->switch_output.size &&
 	       trigger_is_ready(&switch_output_trigger) &&
-	       (rec->bytes_written >= rec->switch_output.size);
+	       (thread->bytes_written >= rec->switch_output.size);
 }
 
 static bool switch_output_time(struct record *rec)
@@ -138,7 +138,7 @@ static int record__write(struct record *rec, struct perf_mmap *map,
 		return -1;
 	}
 
-	rec->bytes_written += size;
+	thread->bytes_written += size;
 
 	if (switch_output_size(rec))
 		trigger_hit(&switch_output_trigger);
@@ -564,7 +564,7 @@ static struct perf_event_header finished_round_event = {
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
 				    bool overwrite)
 {
-	u64 bytes_written = rec->bytes_written;
+	u64 bytes_written = thread->bytes_written;
 	int i, nr;
 	int rc = 0;
 	struct perf_mmap **maps;
@@ -602,7 +602,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	 * Mark the round finished in case we wrote
 	 * at least one event.
 	 */
-	if (bytes_written != rec->bytes_written) {
+	if (bytes_written != thread->bytes_written) {
 		/*
 		 * All maps of the threads point to a single file,
 		 * so we can just pick first one.
@@ -701,8 +701,12 @@ static int record__merge_index(struct record *rec)
 			goto out_close;
 
 		pr_debug(" ok\n");
+		rec->session->header.data_size += idx[i].size;
 	}
 
+	offset = lseek(output_fd, 0, SEEK_END);
+	rec->session->header.data_size = offset - session->header.data_offset;
+
 	session->header.index = idx;
 	session->header.nr_index = nr_index;
 
@@ -727,10 +731,11 @@ record__finish_output(struct record *rec)
 	if (data->is_pipe)
 		return;
 
-	rec->session->header.data_size += rec->bytes_written;
-
 	if (rec->opts.index)
 		record__merge_index(rec);
+	else
+		rec->session->header.data_size += thread->bytes_written;
+
 
 	data->size = lseek(perf_data__fd(data), 0, SEEK_END);
 
@@ -793,7 +798,7 @@ record__switch_output(struct record *rec, bool at_exit)
 				    rec->session->header.data_offset,
 				    at_exit);
 	if (fd >= 0 && !at_exit) {
-		rec->bytes_written = 0;
+		thread->bytes_written = 0;
 		rec->session->header.data_size = 0;
 	}
 
@@ -917,7 +922,6 @@ static int record__synthesize(struct record *rec, bool tail)
 				pr_err("Couldn't record tracing data.\n");
 				goto out;
 			}
-			rec->bytes_written += err;
 		}
 	}
 
-- 
2.17.1

