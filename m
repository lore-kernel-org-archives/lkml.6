Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D708C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD94720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD94720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeIMSFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMSFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D51213AB3;
        Thu, 13 Sep 2018 12:56:28 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EFC6600C8;
        Thu, 13 Sep 2018 12:56:26 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 42/48] perf record: Add record_thread start/stop/process functions
Date:   Thu, 13 Sep 2018 14:54:44 +0200
Message-Id: <20180913125450.21342-43-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Sep 2018 12:56:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding thread process and API to start/stop it.

Link: http://lkml.kernel.org/n/tip-bwa3w7lt63ffe78w4ggjc9dw@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 92 +++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 253bafd4dbe7..6ad57ba6657e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -65,6 +65,11 @@ struct switch_output {
 	bool		 set;
 };
 
+enum {
+	RECORD_THREAD__RUNNING	= 0,
+	RECORD_THREAD__STOP	= 1,
+};
+
 struct record_thread {
 	struct perf_mmap	**mmap;
 	int			  mmap_nr;
@@ -74,6 +79,8 @@ struct record_thread {
 	struct record		 *rec;
 	unsigned long long	  samples;
 	u64			  bytes_written;
+	pthread_t		  pt;
+	int			  state;
 };
 
 struct record {
@@ -1145,6 +1152,80 @@ record__threads_config(struct record *rec)
 	return ret;
 }
 
+static void*
+record_thread__process(struct record *rec)
+{
+	while (thread->state != RECORD_THREAD__STOP) {
+		unsigned long long hits = thread->samples;
+		int err;
+
+		if (record__mmap_read_all(thread->rec) < 0)
+			break;
+
+		if (hits == thread->samples) {
+			err = fdarray__poll(&thread->pollfd, 500);
+			/*
+			 * Propagate error, only if there's any. Ignore positive
+			 * number of returned events and interrupt error.
+			 */
+			if (err > 0 || (err < 0 && errno == EINTR))
+				err = 0;
+			rec->waking++;
+
+			if (fdarray__filter(&thread->pollfd, POLLERR|POLLHUP,
+					    perf_mmap__put_filtered, NULL) == 0)
+				break;
+		}
+	}
+
+	return NULL;
+}
+
+static void *worker(void *arg)
+{
+	struct record_thread *th = arg;
+	struct record *rec = th->rec;
+
+	thread        = th;
+	thread->state = RECORD_THREAD__RUNNING;
+
+	return record_thread__process(rec);
+}
+
+static int record__threads_start(struct record *rec)
+{
+	struct record_thread *threads = rec->threads;
+	int i, err = 0;
+
+	for (i = 1; !err && i < rec->threads_cnt; i++) {
+		struct record_thread *th = threads + i;
+
+		err = pthread_create(&th->pt, NULL, worker, th);
+	}
+
+	return err;
+}
+
+static int record__threads_stop(struct record *rec)
+{
+	struct record_thread *threads = rec->threads;
+	int i, err = 0;
+
+	for (i = 1; i < rec->threads_cnt; i++) {
+		struct record_thread *th = threads + i;
+
+		th->state = RECORD_THREAD__STOP;
+	}
+
+	for (i = 1; !err && i < rec->threads_cnt; i++) {
+		struct record_thread *th = threads + i;
+
+		err = pthread_join(th->pt, NULL);
+	}
+
+	return err;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1270,6 +1351,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	/*
+	 * We need to call this before record__synthesize, so in case we
+	 * sample system wide perf threads get synthesized as well.
+	 */
+	err = record__threads_start(rec);
+	if (err < 0)
+		goto out_child;
+
 	err = record__synthesize(rec, false);
 	if (err < 0)
 		goto out_child;
@@ -1450,6 +1539,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
+	if (record__threads_stop(rec))
+		pr_err("failed to stop threads\n");
+
 	if (forks && workload_exec_errno) {
 		char msg[STRERR_BUFSIZE];
 		const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
-- 
2.17.1

