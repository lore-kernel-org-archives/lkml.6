Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4C0C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30013208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30013208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbeGLONk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:13:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41463 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeGLONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:13:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CE3W3s3935119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 07:03:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CE3WMs3935116;
        Thu, 12 Jul 2018 07:03:32 -0700
Date:   Thu, 12 Jul 2018 07:03:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c818cc063089e78bc31845d1eb6a1f0bedee1eae@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org
Reply-To: mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
          dsahern@gmail.com, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com
In-Reply-To: <20180702134202.17745-2-jolsa@kernel.org>
References: <20180702134202.17745-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Fix --interval_clear option
Git-Commit-ID: c818cc063089e78bc31845d1eb6a1f0bedee1eae
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

Commit-ID:  c818cc063089e78bc31845d1eb6a1f0bedee1eae
Gitweb:     https://git.kernel.org/tip/c818cc063089e78bc31845d1eb6a1f0bedee1eae
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 2 Jul 2018 15:42:02 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 09:43:03 -0400

perf stat: Fix --interval_clear option

Currently we display extra header line, like:

  # perf stat -I 1000 -a --interval-clear
  #           time             counts unit events
         insn per cycle branch-misses of all branches
       2.964917103        3855.349912      cpu-clock (msec)          #    3.855 CPUs utilized
       2.964917103             23,993      context-switches          #    0.006 M/sec
       2.964917103              1,301      cpu-migrations            #    0.329 K/sec
       ...

Fixing the condition and getting proper:

  # perf stat -I 1000 -a --interval-clear
  #           time             counts unit events
       2.359048938        1432.492228      cpu-clock (msec)          #    1.432 CPUs utilized
       2.359048938              7,613      context-switches          #    0.002 M/sec
       2.359048938                419      cpu-migrations            #    0.133 K/sec
       ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 9660e08ee8cb ("perf stat: Add --interval-clear option")
Link: http://lkml.kernel.org/r/20180702134202.17745-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 22547a490e1f..05be023c3f0e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1742,7 +1742,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 		}
 	}
 
-	if ((num_print_interval == 0 && metric_only) || interval_clear)
+	if ((num_print_interval == 0 || interval_clear) && metric_only)
 		print_metric_headers(" ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
