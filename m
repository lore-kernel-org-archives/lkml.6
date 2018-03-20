Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeCTG3Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:29:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59265 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTG3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:29:22 -0400
Date: Mon, 19 Mar 2018 23:28:59 -0700
From: tip-bot for Yisheng Xie <tipbot@zytor.com>
Message-ID: <tip-a3a4a3b37c9b911af4c375b2475cea0fd2b84d38@git.kernel.org>
Cc: peterz@infradead.org, hpa@zytor.com, wangnan0@huawei.com,
        xieyisheng1@huawei.com, acme@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Reply-To: mingo@kernel.org, jolsa@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, xieyisheng1@huawei.com,
        acme@redhat.com, peterz@infradead.org, hpa@zytor.com,
        wangnan0@huawei.com
In-Reply-To: <1520853957-36106-1-git-send-email-xieyisheng1@huawei.com>
References: <1520853957-36106-1-git-send-email-xieyisheng1@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Fix top.call-graph config option reading
Git-Commit-ID: a3a4a3b37c9b911af4c375b2475cea0fd2b84d38
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

Commit-ID:  a3a4a3b37c9b911af4c375b2475cea0fd2b84d38
Gitweb:     https://git.kernel.org/tip/a3a4a3b37c9b911af4c375b2475cea0fd2b84d38
Author:     Yisheng Xie <xieyisheng1@huawei.com>
AuthorDate: Mon, 12 Mar 2018 19:25:56 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:56:04 -0300

perf top: Fix top.call-graph config option reading

When trying to add the "call-graph" variable for top into the
.perfconfig file, like:

      [top]
            call-graph = fp

I that perf_top_config() do not parse this variable.

Fix it by calling perf_default_config() when the top.call-graph variable
is set.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: b8cbb349061e ("perf config: Bring perf_default_config to the very beginning at main()")
Link: http://lkml.kernel.org/r/1520853957-36106-1-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0a26b56afcc5..113c298ed38b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1223,8 +1223,10 @@ parse_callchain_opt(const struct option *opt, const char *arg, int unset)
 
 static int perf_top_config(const char *var, const char *value, void *cb __maybe_unused)
 {
-	if (!strcmp(var, "top.call-graph"))
-		var = "call-graph.record-mode"; /* fall-through */
+	if (!strcmp(var, "top.call-graph")) {
+		var = "call-graph.record-mode";
+		return perf_default_config(var, value, cb);
+	}
 	if (!strcmp(var, "top.children")) {
 		symbol_conf.cumulate_callchain = perf_config_bool(var, value);
 		return 0;
