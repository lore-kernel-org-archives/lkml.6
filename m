Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAAEC38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07B120C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zpOP8BLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07B120C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbeGKUvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389371AbeGKUvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:51:24 -0400
Received: from jouet.localdomain (unknown [71.46.56.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E775520C0E;
        Wed, 11 Jul 2018 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531341918;
        bh=grSi9/ZZM+YGYCAxYkvsc5DAoZ+mfZO5hQvDo7igZ7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zpOP8BLIuL0ktJgjTOa73NPc8a1jWYRxVrTh7YMb7RsU1GHj3RwUaquczXgqQtJPE
         sEl+XIr9KSG+G1L4eljZMMmjzk2l/gjfWt3l9QTlnvM+Djnlbqz18w1eXFPPwTbUHb
         HAjyOkHDFhOpyLj1auQ02bHjQz55YMIwai9+zrpI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/14] perf stat: Fix --interval_clear option
Date:   Wed, 11 Jul 2018 16:43:03 -0400
Message-Id: <20180711204305.12924-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.4

