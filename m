Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeEQIql (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:46:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57718 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750891AbeEQIqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:46:39 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <rostedt@goodmis.org>, <mingo@redhat.com>
CC: <linux-kernel@vger.kernel.org>, Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH] tracing: use match_string() to simplify the code
Date: Thu, 17 May 2018 16:36:03 +0800
Message-ID: <1526546163-4609-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used to simplify the code.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 kernel/trace/trace.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 414d721..4bd653a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4395,8 +4395,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
 {
 	char *cmp;
 	int neg = 0;
-	int ret = -ENODEV;
-	int i;
+	int ret;
 	size_t orig_len = strlen(option);
 
 	cmp = strstrip(option);
@@ -4408,16 +4407,12 @@ static int trace_set_options(struct trace_array *tr, char *option)
 
 	mutex_lock(&trace_types_lock);
 
-	for (i = 0; trace_options[i]; i++) {
-		if (strcmp(cmp, trace_options[i]) == 0) {
-			ret = set_tracer_flag(tr, 1 << i, !neg);
-			break;
-		}
-	}
-
+	ret = match_string(trace_options, -1, cmp);
 	/* If no option could be set, test the specific tracer options */
-	if (!trace_options[i])
+	if (ret < 0)
 		ret = set_tracer_option(tr, cmp, neg);
+	else
+		ret = set_tracer_flag(tr, 1 << ret, !neg);
 
 	mutex_unlock(&trace_types_lock);
 
-- 
1.7.12.4
