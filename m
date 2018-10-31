Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026CFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AA52080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AA52080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeKAHLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:11:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeKAHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:11:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VMBdDC2561490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:11:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VMBdLn2561487;
        Wed, 31 Oct 2018 15:11:39 -0700
Date:   Wed, 31 Oct 2018 15:11:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for David Miller <tipbot@zytor.com>
Message-ID: <tip-ff27a06af6ffd3f49b9e193eb68f487ad76651e1@git.kernel.org>
Cc:     davem@davemloft.net, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, acme@redhat.com, hpa@zytor.com,
        kan.liang@linux.intel.com, jolsa@kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, davem@davemloft.net, jolsa@kernel.org,
          kan.liang@linux.intel.com, hpa@zytor.com, namhyung@kernel.org,
          acme@redhat.com
In-Reply-To: <20181030.223003.2242527041807905962.davem@davemloft.net>
References: <20181030.223003.2242527041807905962.davem@davemloft.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Start display thread earlier
Git-Commit-ID: ff27a06af6ffd3f49b9e193eb68f487ad76651e1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ff27a06af6ffd3f49b9e193eb68f487ad76651e1
Gitweb:     https://git.kernel.org/tip/ff27a06af6ffd3f49b9e193eb68f487ad76651e1
Author:     David Miller <davem@davemloft.net>
AuthorDate: Tue, 30 Oct 2018 22:30:03 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 10:10:11 -0300

perf top: Start display thread earlier

If events are coming in at a rate such that the event processing thread
can barely keep up, our initial run of the event ring will almost never
terminate and this delays the starting of the display thread.

The screen basically stays black until the event thread can get out of
it's endless loop.

Therefore, start the display thread before we start processing the ring
buffer.

This also make sure that we always have the user requested real time
setting engaged when processing the ring.

Signed-off-by: David S. Miller <davem@davemloft.net>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181030.223003.2242527041807905962.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 8e29e0cc8626..b2838de13de0 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1134,11 +1134,6 @@ static int __cmd_top(struct perf_top *top)
         if (!target__none(&opts->target))
                 perf_evlist__enable(top->evlist);
 
-	/* Wait for a minimal set of events before starting the snapshot */
-	perf_evlist__poll(top->evlist, 100);
-
-	perf_top__mmap_read(top);
-
 	ret = -1;
 	if (pthread_create(&thread, NULL, (use_browser > 0 ? display_thread_tui :
 							    display_thread), top)) {
@@ -1156,6 +1151,11 @@ static int __cmd_top(struct perf_top *top)
 		}
 	}
 
+	/* Wait for a minimal set of events before starting the snapshot */
+	perf_evlist__poll(top->evlist, 100);
+
+	perf_top__mmap_read(top);
+
 	while (!done) {
 		u64 hits = top->samples;
 
