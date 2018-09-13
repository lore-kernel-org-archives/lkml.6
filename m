Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B95C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDE920854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDE920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeIMSFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMSFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B4A0308421A;
        Thu, 13 Sep 2018 12:56:32 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0321600C8;
        Thu, 13 Sep 2018 12:56:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 44/48] perf record: Add --threads option
Date:   Thu, 13 Sep 2018 14:54:46 +0200
Message-Id: <20180913125450.21342-45-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 13 Sep 2018 12:56:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows to assign number to record::threads_cnt and thus
to create multiple threads. At this point we don't allow
to specify number of threads, instead we assign it number
of evlist's mmaps to have a single thread for each.

Link: http://lkml.kernel.org/n/tip-ijl786fsk46q6g01is378a5t@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fbca1d15b90d..ada6f795d492 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -102,6 +102,7 @@ struct record {
 	unsigned long long	samples;
 	struct record_thread	*threads;
 	int			threads_cnt;
+	bool			threads_set;
 	int			threads_signal_cnt;
 	pthread_mutex_t		threads_signal_mutex;
 	pthread_cond_t		threads_signal_cond;
@@ -1133,11 +1134,38 @@ record__threads_create(struct record *rec)
 	return threads ? 0 : -ENOMEM;
 }
 
+static int record__threads_cnt(struct record *rec)
+{
+	struct perf_evlist *evlist = rec->evlist;
+	int cnt;
+
+	if (rec->threads_set) {
+		if (rec->threads_cnt) {
+			pr_err("failed: Can't specify number of threads yet.\n");
+			return -EINVAL;
+		}
+		if (evlist->overwrite_mmap) {
+			pr_err("failed: Can't use multiple threads with overwrite mmaps yet.\n");
+			return -EINVAL;
+		}
+		cnt = evlist->nr_mmaps;
+	} else {
+		cnt = 1;
+	}
+
+	rec->threads_cnt = cnt;
+	return 0;
+}
+
 static int
 record__threads_config(struct record *rec)
 {
 	int ret;
 
+	ret = record__threads_cnt(rec);
+	if (ret)
+		goto out;
+
 	ret = record__threads_create(rec);
 	if (ret)
 		goto out;
@@ -2119,6 +2147,8 @@ static struct option __record_options[] = {
 		    "Parse options then exit"),
 	OPT_BOOLEAN(0, "index", &record.opts.index,
 		    "make index for sample data to speed-up processing"),
+	OPT_INTEGER_OPTARG_SET(0, "threads", &record.threads_cnt, &record.threads_set,
+			       "count", "Enabled threads (count)", 0),
 	OPT_END()
 };
 
@@ -2267,6 +2297,12 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	/*
+	 * Threads need index data file.
+	 */
+	if (record.threads_set)
+		record.opts.index = true;
+
 	if (rec->opts.index) {
 		if (!rec->opts.sample_time) {
 			pr_err("Sample timestamp is required for indexing\n");
-- 
2.17.1

