Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755170AbeEaLZ1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:25:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8227 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754683AbeEaLWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:43 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 14/21] sched/debug: use match_string() helper
Date: Thu, 31 May 2018 19:11:19 +0800
Message-ID: <1527765086-19873-15-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - rename i to ret to show the change in returned value meaning - per Andy

 kernel/sched/debug.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 15b10e2..5591147 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -111,20 +111,19 @@ static int sched_feat_set(char *cmp)
 		cmp += 3;
 	}
 
-	for (i = 0; i < __SCHED_FEAT_NR; i++) {
-		if (strcmp(cmp, sched_feat_names[i]) == 0) {
-			if (neg) {
-				sysctl_sched_features &= ~(1UL << i);
-				sched_feat_disable(i);
-			} else {
-				sysctl_sched_features |= (1UL << i);
-				sched_feat_enable(i);
-			}
-			break;
-		}
+	i = match_string(sched_feat_names, __SCHED_FEAT_NR, cmp);
+	if (i < 0)
+		return i;
+
+	if (neg) {
+		sysctl_sched_features &= ~(1UL << i);
+		sched_feat_disable(i);
+	} else {
+		sysctl_sched_features |= (1UL << i);
+		sched_feat_enable(i);
 	}
 
-	return i;
+	return 0;
 }
 
 static ssize_t
@@ -133,7 +132,7 @@ static int sched_feat_set(char *cmp)
 {
 	char buf[64];
 	char *cmp;
-	int i;
+	int ret;
 	struct inode *inode;
 
 	if (cnt > 63)
@@ -148,10 +147,10 @@ static int sched_feat_set(char *cmp)
 	/* Ensure the static_key remains in a consistent state */
 	inode = file_inode(filp);
 	inode_lock(inode);
-	i = sched_feat_set(cmp);
+	ret = sched_feat_set(cmp);
 	inode_unlock(inode);
-	if (i == __SCHED_FEAT_NR)
-		return -EINVAL;
+	if (ret < 0)
+		return ret;
 
 	*ppos += cnt;
 
-- 
1.7.12.4
