Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86802C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5913A20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5913A20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeKSWoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:44:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbeKSWoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:44:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C1E730917A1;
        Mon, 19 Nov 2018 12:20:41 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E98B15C8A1;
        Mon, 19 Nov 2018 12:20:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 08/12] perf top: Set session_done when exiting
Date:   Mon, 19 Nov 2018 13:20:12 +0100
Message-Id: <20181119122016.22423-9-jolsa@kernel.org>
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
References: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 19 Nov 2018 12:20:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we can get out of hist processing ASAP on user request.

Link: http://lkml.kernel.org/n/tip-mi1dfa14swg9tarrp6jcgv41@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ca2a1557ac07..ce542cc1e84f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -577,6 +577,12 @@ static void perf_top__sort_new_samples(void *arg)
 	perf_top__reset_sample_counters(t);
 }
 
+static void stop_top(void)
+{
+	session_done = 1;
+	done = 1;
+}
+
 static void *display_thread_tui(void *arg)
 {
 	struct perf_evsel *pos;
@@ -613,13 +619,13 @@ static void *display_thread_tui(void *arg)
 				      !top->record_opts.overwrite,
 				      &top->annotation_opts);
 
-	done = 1;
+	stop_top();
 	return NULL;
 }
 
 static void display_sig(int sig __maybe_unused)
 {
-	done = 1;
+	stop_top();
 }
 
 static void display_setup_sig(void)
@@ -672,7 +678,7 @@ static void *display_thread(void *arg)
 
 			if (perf_top__handle_keypress(top, c))
 				goto repeat;
-			done = 1;
+			stop_top();
 		}
 	}
 
-- 
2.17.2

