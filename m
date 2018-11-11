Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95129C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638FC20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638FC20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbeKLIsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:48:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41690 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbeKLIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:48:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D6A3514A63E75;
        Sun, 11 Nov 2018 14:58:18 -0800 (PST)
Date:   Sun, 11 Nov 2018 14:58:16 -0800 (PST)
Message-Id: <20181111.145816.1004931661988682087.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181111224336.GA30042@krava>
References: <20181111194132.GA3769@krava>
        <20181111.143208.353362314504370863.davem@davemloft.net>
        <20181111224336.GA30042@krava>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 11 Nov 2018 14:58:19 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>
Date: Sun, 11 Nov 2018 23:43:36 +0100

> On Sun, Nov 11, 2018 at 02:32:08PM -0800, David Miller wrote:
>> From: Jiri Olsa <jolsa@redhat.com>
>> Date: Sun, 11 Nov 2018 20:41:32 +0100
>> 
>> > I added the dropping logic, it's simple so far..
>> 
>> How do you maintain your perf/fixes branch?  Do you rebase? :-/
>> 
>> I just pulled after a previous pull and got nothing but conflicts on
>> every single file.
> 
> yep, I rebase.. it's my devel branch, I dont keep it sane, sry ;-)

Ok, a lot of warnings on sparc, this is the patch I'm using.

The iterator variable type changes are because of comparisons between
signed and unsigned.

The rlimit members are long long unsigned int.

Etc.

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index b6f6fc4..0128ed8 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -201,7 +201,7 @@ static void *workerfn(void *arg)
 
 static void init_fdmaps(struct worker *w, int pct)
 {
-	ssize_t i;
+	unsigned int i;
 	int inc;
 	struct epoll_event ev;
 
@@ -302,7 +302,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 	struct worker *worker = NULL;
 	struct cpu_map *cpu;
 	struct rlimit rl, prevrl;
-	ssize_t i;
+	unsigned int i;
 
 	argc = parse_options(argc, argv, options, bench_epoll_ctl_usage, 0);
 	if (argc) {
@@ -340,7 +340,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 	if (getrlimit(RLIMIT_NOFILE, &prevrl))
 	    err(EXIT_FAILURE, "getrlimit");
 	rl.rlim_cur = rl.rlim_max = nfds * nthreads * 2 + 50;
-	printinfo("Setting RLIMIT_NOFILE rlimit from %lu to: %lu\n",
+	printinfo("Setting RLIMIT_NOFILE rlimit from %llu to: %llu\n",
 		  prevrl.rlim_max, rl.rlim_max);
 	if (setrlimit(RLIMIT_NOFILE, &rl) < 0)
 		err(EXIT_FAILURE, "setrlimit");
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 4e4efc5..d5d17e2 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -395,7 +395,7 @@ static void *writerfn(void *p)
 		nanosleep(&ts, NULL);
 	}
 
-	printinfo("exiting writer-thread (total full-loops: %ld)\n", iter);
+	printinfo("exiting writer-thread (total full-loops: %ld)\n", (long int) iter);
 	return NULL;
 }
 
@@ -459,7 +459,7 @@ int bench_epoll_wait(int argc, const char **argv)
 	if (getrlimit(RLIMIT_NOFILE, &prevrl))
 		err(EXIT_FAILURE, "getrlimit");
 	rl.rlim_cur = rl.rlim_max = nfds * nthreads * 2 + 50;
-	printinfo("Setting RLIMIT_NOFILE rlimit from %lu to: %lu\n", prevrl.rlim_max, rl.rlim_max);
+	printinfo("Setting RLIMIT_NOFILE rlimit from %llu to: %llu\n", prevrl.rlim_max, rl.rlim_max);
 	if (setrlimit(RLIMIT_NOFILE, &rl) < 0)
 		err(EXIT_FAILURE, "setrlimit");
 
