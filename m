Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbeBTWyt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:54:49 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41939 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeBTWys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:54:48 -0500
X-Google-Smtp-Source: AH8x2257rqhZNLExXaPID4QrFi8xD/ukajNWPFB10XMSlgUwI3YZQhnt+iAy0aYRwH7fTtmsOYDQnA==
From: Brian Belleville <bbellevi@uci.edu>
To: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Cc: Brian Belleville <bbellevi@uci.edu>
Subject: [PATCH] floppy: Don't print kernel addresses to log in show_floppy
Date: Tue, 20 Feb 2018 14:54:25 -0800
Message-Id: <20180220225425.40682-1-bbellevi@uci.edu>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Outputting kernel addresses will reveal the locations of kernel code
and data. Change the cases in show_floppy that print
fd_timer.work.func and fd_timeout.work.func to use the %pf format
specifier, which will print the symbol name, like what is done for the
other function pointers printed by show_floppy. No longer output the
value of cont. The variable cont is a pointer that can hold the
address of kernel global variables.

Signed-off-by: Brian Belleville <bbellevi@uci.edu>
---
 drivers/block/floppy.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index eae484a..e29d417 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1819,15 +1819,14 @@ static void show_floppy(void)
 	if (work_pending(&floppy_work))
 		pr_info("floppy_work.func=%pf\n", floppy_work.func);
 	if (delayed_work_pending(&fd_timer))
-		pr_info("delayed work.function=%p expires=%ld\n",
+		pr_info("delayed work.function=%pf expires=%ld\n",
 		       fd_timer.work.func,
 		       fd_timer.timer.expires - jiffies);
 	if (delayed_work_pending(&fd_timeout))
-		pr_info("timer_function=%p expires=%ld\n",
+		pr_info("timer_function=%pf expires=%ld\n",
 		       fd_timeout.work.func,
 		       fd_timeout.timer.expires - jiffies);
 
-	pr_info("cont=%p\n", cont);
 	pr_info("current_req=%p\n", current_req);
 	pr_info("command_status=%d\n", command_status);
 	pr_info("\n");
-- 
2.7.4
