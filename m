Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E914DC61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD5F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD5F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeIMSFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10123 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMSFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A30D43DE;
        Thu, 13 Sep 2018 12:56:21 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCCF9600C9;
        Thu, 13 Sep 2018 12:56:19 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 39/48] perf record: Move waking into struct record
Date:   Thu, 13 Sep 2018 14:54:41 +0200
Message-Id: <20180913125450.21342-40-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Sep 2018 12:56:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to keep global number of 'waking' now.

TODO: make this multiple threads safe.

Link: http://lkml.kernel.org/n/tip-veetgk62aisdt1cxaa6fbgox@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d6fef646b67f..62ff4411ce39 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -94,6 +94,7 @@ struct record {
 	unsigned long long	samples;
 	struct record_thread	*threads;
 	int			threads_cnt;
+	unsigned long		waking;
 };
 
 static __thread struct record_thread *thread;
@@ -1143,7 +1144,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
 	int status = 0;
-	unsigned long waking = 0;
 	const bool forks = argc > 0;
 	struct perf_tool *tool = &rec->tool;
 	struct record_opts *opts = &rec->opts;
@@ -1400,8 +1400,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 			if (!quiet)
 				fprintf(stderr, "[ perf record: dump data: Woken up %ld times ]\n",
-					waking);
-			waking = 0;
+					rec->waking);
+			rec->waking = 0;
 			fd = record__switch_output(rec, false);
 			if (fd < 0) {
 				pr_err("Failed to switch to new file\n");
@@ -1425,7 +1425,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			 */
 			if (err > 0 || (err < 0 && errno == EINTR))
 				err = 0;
-			waking++;
+			rec->waking++;
 
 			if (perf_evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
 				draining = true;
@@ -1454,7 +1454,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 	if (!quiet)
-		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
+		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", rec->waking);
 
 	if (target__none(&rec->opts.target))
 		record__synthesize_workload(rec, true);
-- 
2.17.1

