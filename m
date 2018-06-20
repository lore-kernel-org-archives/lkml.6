Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A208C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BB320693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BB320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755039AbeFTJkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:40:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754354AbeFTJkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:40:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3437E401EF00;
        Wed, 20 Jun 2018 09:40:39 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 992532156880;
        Wed, 20 Jun 2018 09:40:37 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf bench: Fix numa report output code
Date:   Wed, 20 Jun 2018 11:40:36 +0200
Message-Id: <20180620094036.17278-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 20 Jun 2018 09:40:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 20 Jun 2018 09:40:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we can hit following assert when running numa bench:

  $ perf bench numa mem -p 3 -t 1 -P 512 -s 100 -zZ0cm --thp 1
  perf: bench/numa.c:1577: __bench_numa: Assertion `!(!(((wait_stat) & 0x7f) == 0))' failed.

The assertion is correct, because we hit the SIGFPE in following line:

  Thread 2.2 "thread 0/0" received signal SIGFPE, Arithmetic exception.
  [Switching to Thread 0x7fffd28c6700 (LWP 11750)]
  0x000.. in worker_thread (__tdata=0x7.. ) at bench/numa.c:1257
  1257 td->speed_gbs = bytes_done / (td->runtime_ns / NSEC_PER_SEC) / 1e9;

We don't check if the runtime is actually bigger than 1 second,
and thus this might end up with zero division within FPU.

Adding the check to prevent this.

Link: http://lkml.kernel.org/n/tip-9y8n4x48mjbbcay73sq6nche@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/bench/numa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 63eb49082774..44195514b19e 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -1098,7 +1098,7 @@ static void *worker_thread(void *__tdata)
 	u8 *global_data;
 	u8 *process_data;
 	u8 *thread_data;
-	u64 bytes_done;
+	u64 bytes_done, secs;
 	long work_done;
 	u32 l;
 	struct rusage rusage;
@@ -1254,7 +1254,8 @@ static void *worker_thread(void *__tdata)
 	timersub(&stop, &start0, &diff);
 	td->runtime_ns = diff.tv_sec * NSEC_PER_SEC;
 	td->runtime_ns += diff.tv_usec * NSEC_PER_USEC;
-	td->speed_gbs = bytes_done / (td->runtime_ns / NSEC_PER_SEC) / 1e9;
+	secs = td->runtime_ns / NSEC_PER_SEC;
+	td->speed_gbs = secs ? bytes_done / secs / 1e9 : 0;
 
 	getrusage(RUSAGE_THREAD, &rusage);
 	td->system_time_ns = rusage.ru_stime.tv_sec * NSEC_PER_SEC;
-- 
2.13.6

