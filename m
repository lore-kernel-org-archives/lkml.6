Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeDAI47 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 04:56:59 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:43874 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753247AbeDAI4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 04:56:40 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, pantelis.antoniou@konsulko.com,
        mark.rutland@arm.com, pmladek@suse.com,
        andriy.shevchenko@linux.intel.com, joe@perches.com, corbet@lwn.net,
        me@tobin.cc, sergey.senozhatsky@gmail.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] printk: Use %pCOW for kmsg
Date: Sun,  1 Apr 2018 10:56:22 +0200
Message-Id: <20180401085622.7754-3-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180401085622.7754-1-richard@nod.at>
References: <20180401085622.7754-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...userspace likes eye candy.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/printk/printk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f274fbef821d..42ea0a18081d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -815,7 +815,10 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 		}
 	}
 
-	printk_emit(facility, level, NULL, 0, "%s", line);
+	if (line[len - 1] == '\n')
+		line[len - 1] = '\0';
+
+	printk_emit(facility, level, NULL, 0, "%pCOW", line);
 	kfree(buf);
 	return ret;
 }
-- 
2.13.6
