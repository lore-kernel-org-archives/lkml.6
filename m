Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A761C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B5420854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B5420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeIMSFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30617 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMSFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BCCEC0587FE;
        Thu, 13 Sep 2018 12:56:17 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 707E8600C6;
        Thu, 13 Sep 2018 12:56:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 37/48] perf record: Introduce struct record_thread
Date:   Thu, 13 Sep 2018 14:54:39 +0200
Message-Id: <20180913125450.21342-38-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 13 Sep 2018 12:56:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding struct record_thread to carry the single thread's maps.

Link: http://lkml.kernel.org/n/tip-dsyi97xdc7ullvsisqmha0ca@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 179 ++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1b01cb4d06b8..5c6b56f164a9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -65,6 +65,15 @@ struct switch_output {
 	bool		 set;
 };
 
+struct record_thread {
+	struct perf_mmap	**mmap;
+	int			  mmap_nr;
+	struct perf_mmap	**ovw_mmap;
+	int			  ovw_mmap_nr;
+	struct fdarray		  pollfd;
+	struct record		 *rec;
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -83,6 +92,8 @@ struct record {
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
+	struct record_thread	*threads;
+	int			threads_cnt;
 };
 
 static volatile int auxtrace_record__snapshot_started;
@@ -967,6 +978,166 @@ static int record__synthesize(struct record *rec, bool tail)
 	return err;
 }
 
+static void
+record_thread__clean(struct record_thread *th)
+{
+	free(th->mmap);
+	free(th->ovw_mmap);
+}
+
+static void
+record__threads_clean(struct record *rec)
+{
+	struct record_thread *threads = rec->threads;
+	int i;
+
+	if (threads) {
+		for (i = 0; i < rec->threads_cnt; i++)
+			record_thread__clean(threads + i);
+	}
+}
+
+static void record_thread__init(struct record_thread *th, struct record *rec)
+{
+	memset(th, 0, sizeof(*th));
+	fdarray__init(&th->pollfd, 64);
+	th->rec = rec;
+}
+
+static int
+record_thread__mmap(struct record_thread *th, int nr, int nr_ovw)
+{
+	struct perf_mmap **mmap;
+
+	mmap = zalloc(sizeof(*mmap) * nr);
+	if (!mmap)
+		return -ENOMEM;
+
+	th->mmap    = mmap;
+	th->mmap_nr = nr;
+
+	if (nr_ovw) {
+		mmap = zalloc(sizeof(*mmap) * nr_ovw);
+		if (!mmap)
+			return -ENOMEM;
+
+		th->ovw_mmap    = mmap;
+		th->ovw_mmap_nr = nr;
+	}
+
+	return 0;
+}
+
+static int
+record__threads_assign(struct record *rec)
+{
+	struct record_thread *threads = rec->threads;
+	struct record_thread *thread0 = threads;
+	struct perf_evlist *evlist = rec->evlist;
+	int i, j, nr, nr0, nr_ovw, nr_trk;
+	int ret = -ENOMEM;
+
+	nr     = evlist->mmap           ? evlist->nr_mmaps : 0;
+	nr_trk = evlist->track_mmap     ? evlist->nr_mmaps : 0;
+	nr_ovw = evlist->overwrite_mmap ? evlist->nr_mmaps : 0;
+
+	nr0  = nr_trk;
+	nr0 += nr;
+
+	if (record_thread__mmap(thread0, nr0, nr_ovw))
+		goto out_error;
+
+	for (i = 0; i < nr_ovw; i++)
+		thread0->ovw_mmap[i] = &evlist->overwrite_mmap[i];
+
+	for (i = 0; i < nr_trk; i++)
+		thread0->mmap[i] = &evlist->track_mmap[i];
+
+	for (j = 0; i < nr0 && j < nr; i++, j++)
+		thread0->mmap[i] = &evlist->mmap[j];
+
+	ret = 0;
+
+out_error:
+	return ret;
+}
+
+static int
+record_thread__create_poll(struct record_thread *th,
+			   struct perf_evlist *evlist)
+{
+	struct fdarray *fda = &evlist->pollfd;
+	struct perf_mmap *mmap;
+	int i, j;
+
+	for (i = 0; i < th->mmap_nr; i++) {
+		mmap = th->mmap[i];
+
+		for (j = 0; j < fda->nr; j++) {
+			if (mmap != fda->priv[j].ptr)
+				continue;
+
+			if (fdarray__add_clone(&th->pollfd, j, fda) < 0)
+				return -ENOMEM;
+
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int
+record__threads_create_poll(struct record *rec)
+{
+	struct record_thread *threads = rec->threads;
+	int ret = 0, i;
+
+	for (i = 0; !ret && (i < rec->threads_cnt); i++)
+		ret = record_thread__create_poll(threads + i, rec->evlist);
+
+	return ret;
+}
+
+static int
+record__threads_create(struct record *rec)
+{
+	struct record_thread *threads;
+	int i, cnt = rec->threads_cnt;
+
+	threads = zalloc(sizeof(*threads) * cnt);
+	if (threads) {
+		for (i = 0; i < cnt; i++)
+			record_thread__init(threads + i, rec);
+
+		rec->threads = threads;
+	}
+
+	return threads ? 0 : -ENOMEM;
+}
+
+static int
+record__threads_config(struct record *rec)
+{
+	int ret;
+
+	ret = record__threads_create(rec);
+	if (ret)
+		goto out;
+
+	ret = record__threads_assign(rec);
+	if (ret)
+		goto out;
+
+	ret = record__threads_create_poll(rec);
+
+out:
+	if (ret)
+		record__threads_clean(rec);
+
+	return ret;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1040,6 +1211,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	if (record__threads_config(rec)) {
+		err = -1;
+		goto out_child;
+	}
+
 	if (opts->index) {
 		err = record__mmap_index(rec);
 		if (err)
@@ -1316,6 +1492,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	perf_hooks__invoke_record_end();
 
+	record__threads_clean(rec);
+
 	if (!err && !quiet) {
 		char samples[128];
 		const char *postfix = rec->timestamp_filename ?
@@ -1657,6 +1835,7 @@ static struct record record = {
 		.mmap2		= perf_event__process_mmap2,
 		.ordered_events	= true,
 	},
+	.threads_cnt = 1,
 };
 
 const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
-- 
2.17.1

