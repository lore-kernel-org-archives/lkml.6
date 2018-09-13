Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909ADC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6762133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6762133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeIMSFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMSFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5533E3680A;
        Thu, 13 Sep 2018 12:56:30 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79683600D4;
        Thu, 13 Sep 2018 12:56:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 43/48] perf record: Wait for all threads being started
Date:   Thu, 13 Sep 2018 14:54:45 +0200
Message-Id: <20180913125450.21342-44-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 13 Sep 2018 12:56:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure all threads are started and ready before
we enable events. Using pthread_cond_t signaling
logic for that.

Link: http://lkml.kernel.org/n/tip-z4x5ikp8v7e3flpxoo4bv1un@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6ad57ba6657e..fbca1d15b90d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -102,6 +102,9 @@ struct record {
 	unsigned long long	samples;
 	struct record_thread	*threads;
 	int			threads_cnt;
+	int			threads_signal_cnt;
+	pthread_mutex_t		threads_signal_mutex;
+	pthread_cond_t		threads_signal_cond;
 	unsigned long		waking;
 };
 
@@ -1145,6 +1148,9 @@ record__threads_config(struct record *rec)
 
 	ret = record__threads_create_poll(rec);
 
+	pthread_mutex_init(&rec->threads_signal_mutex, NULL);
+	pthread_cond_init(&rec->threads_signal_cond, NULL);
+
 out:
 	if (ret)
 		record__threads_clean(rec);
@@ -1181,6 +1187,26 @@ record_thread__process(struct record *rec)
 	return NULL;
 }
 
+static void signal_main(struct record *rec)
+{
+	pthread_mutex_lock(&rec->threads_signal_mutex);
+	rec->threads_signal_cnt++;
+	pthread_cond_signal(&rec->threads_signal_cond);
+	pthread_mutex_unlock(&rec->threads_signal_mutex);
+}
+
+static void wait_for_signal(struct record *rec)
+{
+	pthread_mutex_lock(&rec->threads_signal_mutex);
+
+	while (rec->threads_signal_cnt < rec->threads_cnt) {
+		pthread_cond_wait(&rec->threads_signal_cond,
+				  &rec->threads_signal_mutex);
+	}
+
+	pthread_mutex_unlock(&rec->threads_signal_mutex);
+}
+
 static void *worker(void *arg)
 {
 	struct record_thread *th = arg;
@@ -1189,6 +1215,8 @@ static void *worker(void *arg)
 	thread        = th;
 	thread->state = RECORD_THREAD__RUNNING;
 
+	signal_main(rec);
+
 	return record_thread__process(rec);
 }
 
@@ -1197,12 +1225,17 @@ static int record__threads_start(struct record *rec)
 	struct record_thread *threads = rec->threads;
 	int i, err = 0;
 
+	rec->threads_signal_cnt = 1;
+
 	for (i = 1; !err && i < rec->threads_cnt; i++) {
 		struct record_thread *th = threads + i;
 
 		err = pthread_create(&th->pt, NULL, worker, th);
 	}
 
+	if (rec->threads_cnt > 1)
+		wait_for_signal(rec);
+
 	return err;
 }
 
-- 
2.17.1

