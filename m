Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeCLLfx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:35:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751377AbeCLLfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:35:51 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <acme@kernel.org>
CC: <jolsa@redhat.com>, <namhyung@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 1/2] perf top: Fix top.call-graph works abnormal
Date: Mon, 12 Mar 2018 19:25:56 +0800
Message-ID: <1520853957-36106-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When try to add call-graph for top into .perfconfig file, like:

      [top]
            call-graph = fp

find it cannot work for perf_top_config() do not parse this option.

Fix it by call perf_default_config() when config top.call-graph.

Fixes: b8cbb349061e (perf config: Bring perf_default_config to the very beginning at main())
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 tools/perf/builtin-top.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 35ac016..fd6e238 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1224,8 +1224,10 @@ static int __cmd_top(struct perf_top *top)
 
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
-- 
1.7.12.4
