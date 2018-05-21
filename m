Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeEUMNQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:13:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752969AbeEUMJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:19 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 27/33] sched/debug: use match_string() helper
Date: Mon, 21 May 2018 19:58:04 +0800
Message-ID: <1526903890-35761-28-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 kernel/sched/debug.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 15b10e2..9e34499 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -111,16 +111,14 @@ static int sched_feat_set(char *cmp)
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
+	i = match_string(sched_feat_names, __SCHED_FEAT_NR, cmp);
+	if (i >= 0) {
+		if (neg) {
+			sysctl_sched_features &= ~(1UL << i);
+			sched_feat_disable(i);
+		} else {
+			sysctl_sched_features |= (1UL << i);
+			sched_feat_enable(i);
 		}
 	}
 
@@ -150,7 +148,7 @@ static int sched_feat_set(char *cmp)
 	inode_lock(inode);
 	i = sched_feat_set(cmp);
 	inode_unlock(inode);
-	if (i == __SCHED_FEAT_NR)
+	if (i < 0)
 		return -EINVAL;
 
 	*ppos += cnt;
-- 
1.7.12.4
