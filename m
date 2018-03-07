Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeCGI1n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:27:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49585 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeCGI1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:27:40 -0500
Date: Wed, 7 Mar 2018 00:27:33 -0800
From: tip-bot for Ilya Pronin <tipbot@zytor.com>
Message-ID: <tip-40c21898ba5372c14ef71717040529794a91ccc2@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        ak@linux.intel.com, mingo@kernel.org, ipronin@twitter.com,
        tglx@linutronix.de, xiyou.wangcong@gmail.com, jolsa@redhat.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, ipronin@twitter.com,
        mingo@kernel.org, ak@linux.intel.com, acme@redhat.com,
        xiyou.wangcong@gmail.com, tglx@linutronix.de, jolsa@redhat.com
In-Reply-To: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Fix CVS output format for
 non-supported counters
Git-Commit-ID: 40c21898ba5372c14ef71717040529794a91ccc2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  40c21898ba5372c14ef71717040529794a91ccc2
Gitweb:     https://git.kernel.org/tip/40c21898ba5372c14ef71717040529794a91ccc2
Author:     Ilya Pronin <ipronin@twitter.com>
AuthorDate: Mon, 5 Mar 2018 22:43:53 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Mar 2018 10:53:52 -0300

perf stat: Fix CVS output format for non-supported counters

When printing stats in CSV mode, 'perf stat' appends extra separators
when a counter is not supported:

<not supported>,,L1-dcache-store-misses,mesos/bd442f34-2b4a-47df-b966-9b281f9f56fc,0,100.00,,,,

Which causes a failure when parsing fields. The numbers of separators
should be the same for each line, no matter if the counter is or not
supported.

Signed-off-by: Ilya Pronin <ipronin@twitter.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/r/20180306064353.31930-1-xiyou.wangcong@gmail.com
Fixes: 92a61f6412d3 ("perf stat: Implement CSV metrics output")
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
