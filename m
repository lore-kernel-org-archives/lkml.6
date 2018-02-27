Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbeB0A0M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 19:26:12 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:33333 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751351AbeB0A0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 19:26:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0SyYb1iR_1519691153;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: akpm@linux-foundation.org, mingo@kernel.org, adobriyan@gmail.com
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4 v2] mm: use access_remote_vm() in get_cmdline()
Date: Tue, 27 Feb 2018 08:25:51 +0800
Message-Id: <1519691151-101999-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_cmdline() is using access_process_vm() which increases mm reference
count, but the mm reference count has been increased before calling
access_process_vm() and it is kept across get_cmdline(). It sounds
unnecessary to get mm reference count increased twice, so replace
access_process_vm() to access_remote_vm() which requires caller increase
mm reference count.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index c125050..9b40637 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -732,7 +732,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	if (len > buflen)
 		len = buflen;
 
-	res = access_process_vm(task, arg_start, buffer, len, FOLL_FORCE);
+	res = access_remote_vm(mm, arg_start, buffer, len, FOLL_FORCE);
 
 	/*
 	 * If the nul at the end of args has been overwritten, then
@@ -746,7 +746,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 			len = env_end - env_start;
 			if (len > buflen - res)
 				len = buflen - res;
-			res += access_process_vm(task, env_start,
+			res += access_remote_vm(mm, env_start,
 						 buffer+res, len,
 						 FOLL_FORCE);
 			res = strnlen(buffer, res);
-- 
1.8.3.1
