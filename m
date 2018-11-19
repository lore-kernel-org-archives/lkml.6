Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EEBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09DB20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09DB20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbeKSWnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:43:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728785AbeKSWnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:43:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F8CA30841DE;
        Mon, 19 Nov 2018 12:20:23 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4D6C5C57B;
        Mon, 19 Nov 2018 12:20:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 01/12] perf tools: Fix build on sparc
Date:   Mon, 19 Nov 2018 13:20:05 +0100
Message-Id: <20181119122016.22423-2-jolsa@kernel.org>
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
References: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 19 Nov 2018 12:20:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>

A lot of warnings on sparc, this is the patch I'm using.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Link: http://lkml.kernel.org/n/tip-xfdgbruww1yfr42eygcm186b@git.kernel.org
Signed-off-by: David Miller <davem@davemloft.net>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/bench/epoll-ctl.c  | 7 ++++---
 tools/perf/bench/epoll-wait.c | 6 ++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index b6f6fc4a7129..5b6ecfcc8c3a 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -19,6 +19,7 @@
 #include <sys/resource.h>
 #include <sys/epoll.h>
 #include <sys/eventfd.h>
+#include <inttypes.h>
 
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
@@ -201,7 +202,7 @@ static void *workerfn(void *arg)
 
 static void init_fdmaps(struct worker *w, int pct)
 {
-	ssize_t i;
+	unsigned int i;
 	int inc;
 	struct epoll_event ev;
 
@@ -302,7 +303,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 	struct worker *worker = NULL;
 	struct cpu_map *cpu;
 	struct rlimit rl, prevrl;
-	ssize_t i;
+	unsigned int i;
 
 	argc = parse_options(argc, argv, options, bench_epoll_ctl_usage, 0);
 	if (argc) {
@@ -340,7 +341,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 	if (getrlimit(RLIMIT_NOFILE, &prevrl))
 	    err(EXIT_FAILURE, "getrlimit");
 	rl.rlim_cur = rl.rlim_max = nfds * nthreads * 2 + 50;
-	printinfo("Setting RLIMIT_NOFILE rlimit from %lu to: %lu\n",
+	printinfo("Setting RLIMIT_NOFILE rlimit from %" PRIu64 " to: %" PRIu64 "\n",
 		  prevrl.rlim_max, rl.rlim_max);
 	if (setrlimit(RLIMIT_NOFILE, &rl) < 0)
 		err(EXIT_FAILURE, "setrlimit");
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 4e4efc5cfe22..595e9833201b 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -73,6 +73,7 @@
 #include <sys/epoll.h>
 #include <sys/eventfd.h>
 #include <sys/types.h>
+#include <inttypes.h>
 
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
@@ -395,7 +396,7 @@ static void *writerfn(void *p)
 		nanosleep(&ts, NULL);
 	}
 
-	printinfo("exiting writer-thread (total full-loops: %ld)\n", iter);
+	printinfo("exiting writer-thread (total full-loops: %ld)\n", (long int) iter);
 	return NULL;
 }
 
@@ -459,7 +460,8 @@ int bench_epoll_wait(int argc, const char **argv)
 	if (getrlimit(RLIMIT_NOFILE, &prevrl))
 		err(EXIT_FAILURE, "getrlimit");
 	rl.rlim_cur = rl.rlim_max = nfds * nthreads * 2 + 50;
-	printinfo("Setting RLIMIT_NOFILE rlimit from %lu to: %lu\n", prevrl.rlim_max, rl.rlim_max);
+	printinfo("Setting RLIMIT_NOFILE rlimit from %" PRIu64 " to: %" PRIu64" \n",
+		  prevrl.rlim_max, rl.rlim_max);
 	if (setrlimit(RLIMIT_NOFILE, &rl) < 0)
 		err(EXIT_FAILURE, "setrlimit");
 
-- 
2.17.2

