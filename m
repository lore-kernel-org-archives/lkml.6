Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeCFGoR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:44:17 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35463 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeCFGoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:44:15 -0500
X-Google-Smtp-Source: AG47ELuuzsw4ea2l34gLx05B4WqCzpSplGR37ZOgCDMQ+KuiKF2d+4Ps6+ixP+9Z4QPvcR1bL80aUg==
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Ilya Pronin <ipronin@twitter.com>
Subject: [PATCH] perf stat: fix cvs output format
Date: Mon,  5 Mar 2018 22:43:53 -0800
Message-Id: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.9.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Pronin <ipronin@twitter.com>

When printing stats in CSV mode, perf stat appends extra CSV
separators when counter is not supported:

<not supported>,,L1-dcache-store-misses,mesos/bd442f34-2b4a-47df-b966-9b281f9f56fc,0,100.00,,,,

which causes a failure of parsing fields. The numbers of separators
is fixed for each line, no matter supported or not supported.

Fixes: 92a61f6412d3 ("perf stat: Implement CSV metrics output")
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Ilya Pronin <ipronin@twitter.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 98bf9d32f222..54a4c152edb3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -917,7 +917,7 @@ static void print_metric_csv(void *ctx,
 	char buf[64], *vals, *ends;
 
 	if (unit == NULL || fmt == NULL) {
-		fprintf(out, "%s%s%s%s", csv_sep, csv_sep, csv_sep, csv_sep);
+		fprintf(out, "%s%s", csv_sep, csv_sep);
 		return;
 	}
 	snprintf(buf, sizeof(buf), fmt, val);
-- 
2.13.0
