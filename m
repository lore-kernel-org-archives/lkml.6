Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162733AbeE1OFk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:05:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162253AbeE1Kiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:38:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yisheng Xie <xieyisheng1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 279/329] perf top: Fix top.call-graph config option reading
Date: Mon, 28 May 2018 12:03:28 +0200
Message-Id: <20180528100305.054283151@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yisheng Xie <xieyisheng1@huawei.com>

[ Upstream commit a3a4a3b37c9b911af4c375b2475cea0fd2b84d38 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-top.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1061,8 +1061,10 @@ parse_callchain_opt(const struct option
 
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
