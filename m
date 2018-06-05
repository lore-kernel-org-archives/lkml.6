Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbeFER7Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752732AbeFERwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:08 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 29/46] perf script: Check if evsel has callchains before trying to use it
Date: Tue,  5 Jun 2018 14:50:13 -0300
Message-Id: <20180605175030.32549-30-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were checking just if callchain processing was asked for by the
user, not if the evsel itself has callchains, and since we can have
some evsels with callchains and others without, check that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-inxl7k49q9f9w1se039fbxuw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 48e940efb3cb..b3bf35512d21 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -606,7 +606,7 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 	if (PRINT_FIELD(COMM)) {
 		if (latency_format)
 			printed += fprintf(fp, "%8.8s ", thread__comm_str(thread));
-		else if (PRINT_FIELD(IP) && symbol_conf.use_callchain)
+		else if (PRINT_FIELD(IP) && evsel__has_callchain(evsel) && symbol_conf.use_callchain)
 			printed += fprintf(fp, "%s ", thread__comm_str(thread));
 		else
 			printed += fprintf(fp, "%16s ", thread__comm_str(thread));
-- 
2.14.3
