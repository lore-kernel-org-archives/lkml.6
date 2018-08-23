Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F354D208DC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F354D208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeHWLvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:51:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbeHWLvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:51:42 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C3973C93;
        Thu, 23 Aug 2018 08:23:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 095/217] perf bench: Fix numa report output code
Date:   Thu, 23 Aug 2018 09:53:28 +0200
Message-Id: <20180823075509.793123873@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 983107072be1a39cbde67d45cb0059138190e015 ]

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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180620094036.17278-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/bench/numa.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -1098,7 +1098,7 @@ static void *worker_thread(void *__tdata
 	u8 *global_data;
 	u8 *process_data;
 	u8 *thread_data;
-	u64 bytes_done;
+	u64 bytes_done, secs;
 	long work_done;
 	u32 l;
 	struct rusage rusage;
@@ -1254,7 +1254,8 @@ static void *worker_thread(void *__tdata
 	timersub(&stop, &start0, &diff);
 	td->runtime_ns = diff.tv_sec * NSEC_PER_SEC;
 	td->runtime_ns += diff.tv_usec * NSEC_PER_USEC;
-	td->speed_gbs = bytes_done / (td->runtime_ns / NSEC_PER_SEC) / 1e9;
+	secs = td->runtime_ns / NSEC_PER_SEC;
+	td->speed_gbs = secs ? bytes_done / secs / 1e9 : 0;
 
 	getrusage(RUSAGE_THREAD, &rusage);
 	td->system_time_ns = rusage.ru_stime.tv_sec * NSEC_PER_SEC;


