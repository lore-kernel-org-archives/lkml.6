Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8CBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75202208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbeLNUv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:51:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39905 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbeLNUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:51:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKoeES1458182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:50:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKoedG1458179;
        Fri, 14 Dec 2018 12:50:40 -0800
Date:   Fri, 14 Dec 2018 12:50:40 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-bnev2mloavyurmgchcr3o24o@git.kernel.org>
Cc:     davem@davemloft.net, tglx@linutronix.de, jolsa@kernel.org,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com
Reply-To: jolsa@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          davem@davemloft.net, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Display slow reader warning when droping
 samples
Git-Commit-ID: ffec48b734491d7c687c5cb430bffdbb9c56824e
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

Commit-ID:  ffec48b734491d7c687c5cb430bffdbb9c56824e
Gitweb:     https://git.kernel.org/tip/ffec48b734491d7c687c5cb430bffdbb9c56824e
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 19 Nov 2018 11:12:01 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:34 -0300

perf top: Display slow reader warning when droping samples

Currently we display the "Too slow to read ring buffer.." helpline only
in the slow reader thread. This patch triggers it also when the
processing thread drops samples, because it has the same reason, which
is too many data on input.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-bnev2mloavyurmgchcr3o24o@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 9166f6087e3f..f22c531be366 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -571,7 +571,7 @@ static void perf_top__sort_new_samples(void *arg)
 	hists__collapse_resort(hists, NULL);
 	perf_evsel__output_resort(evsel, NULL);
 
-	if (t->lost)
+	if (t->lost || t->drop)
 		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
 
 	perf_top__reset_sample_counters(t);
