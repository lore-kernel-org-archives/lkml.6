Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeDRS4x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:56:53 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46730 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750872AbeDRS4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:56:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0T.Qn96V_1524077800;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: mhocko@kernel.org, gorcunov@gmail.com, akpm@linux-foundation.org
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -mmotm] prctl: add comment about mmap_sem and arg_lock
Date: Thu, 19 Apr 2018 02:56:39 +0800
Message-Id: <1524077799-80690-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comment to elaborate why mmap_sem for is used by prctl.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
akpm: this patch can be foled into:
mm-introduce-arg_lock-to-protect-arg_startend-and-env_startend-in-mm_struct.patch

 kernel/sys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index 0cc5a1c..943fdc5 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2011,6 +2011,10 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 			return error;
 	}
 
+	/*
+	 * arg_lock protects concurent updates but we still need mmap_sem for
+	 * read to exclude races with sys_brk.
+	 */
 	down_read(&mm->mmap_sem);
 
 	/*
-- 
1.8.3.1
