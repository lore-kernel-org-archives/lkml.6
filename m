Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657F7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2275C2534E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2275C2534E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeGBNmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:42:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752211AbeGBNmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:42:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73F5E808255B;
        Mon,  2 Jul 2018 13:42:06 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B18D178B6;
        Mon,  2 Jul 2018 13:42:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 2/2] perf stat: Fix --interval_clear option
Date:   Mon,  2 Jul 2018 15:42:02 +0200
Message-Id: <20180702134202.17745-2-jolsa@kernel.org>
In-Reply-To: <20180702134202.17745-1-jolsa@kernel.org>
References: <20180702134202.17745-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 13:42:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 13:42:06 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 9660e08ee8cb ("perf stat: Add --interval-clear option")
Link: http://lkml.kernel.org/n/tip-cws96nsw02q7vmxqwgofc5ou@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.17.1

