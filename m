Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeCLLfy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:35:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6191 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751247AbeCLLfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:35:51 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <acme@kernel.org>
CC: <jolsa@redhat.com>, <namhyung@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 2/2] perf record: Avoid duplicate call of perf_default_config()
Date: Mon, 12 Mar 2018 19:25:57 +0800
Message-ID: <1520853957-36106-2-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1520853957-36106-1-git-send-email-xieyisheng1@huawei.com>
References: <1520853957-36106-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have brought perf_default_config to the very beginning at main(), so
it no need to call perf_default_config() once more for most of config in
perf-record but only for record.call-graph.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 tools/perf/builtin-record.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a217623..811cfc1 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1260,10 +1260,12 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 			return -1;
 		return 0;
 	}
-	if (!strcmp(var, "record.call-graph"))
-		var = "call-graph.record-mode"; /* fall-through */
+	if (!strcmp(var, "record.call-graph")) {
+		var = "call-graph.record-mode";
+		return perf_default_config(var, value, cb);
+	}
 
-	return perf_default_config(var, value, cb);
+	return 0;
 }
 
 struct clockid_map {
-- 
1.7.12.4
