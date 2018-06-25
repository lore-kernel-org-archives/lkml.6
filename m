Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E50C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AC925F92
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrsviBJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AC925F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965074AbeFYRmB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965030AbeFYRl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:57 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5CD25F77;
        Mon, 25 Jun 2018 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948516;
        bh=ZltD77OkN+1yvkr+MqP4TKSIpwhHXU/n3mHBuVQ5Mp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrsviBJ8Yzeg+26O6BPpQgYaGv4XHXqgnsWGvpyvYTmqtTlDKKFuQfDp7pHsPdzcb
         yPgfoizuGSuftT01Cf4H82I1dHHpXQtG/3d52mmo2gg0UX2Onu4jhffbzpT9zP6CCM
         ovm31oZ8KhhSHCdafaZdrCha2eamZa68ox2wAgns=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/19] perf bench: Fix numa report output code
Date:   Mon, 25 Jun 2018 14:40:42 -0300
Message-Id: <20180625174045.25765-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
2.14.3

