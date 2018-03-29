Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeC2WIX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:08:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39046 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbeC2WHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:40 -0400
X-Google-Smtp-Source: AIpwx4+kPv8zaP/PuaKPqg+xkqmPkZUFMQi4dkRyvj0DKbeZafH7/k+Rfu7h+M8XCSUl5NQPHfloCA==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 36/37] lightnvm: pblk: remove some unnecessary NULL checks
Date: Fri, 30 Mar 2018 00:05:23 +0200
Message-Id: <20180329220524.30363-37-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

Smatch complains that flush_workqueue() dereferences the work queue
pointer but then we check if it's NULL on the next line when it's too
late.  These NULL checks can be removed because the module won't load if
we can't allocate the work queues.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-gc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 7143b0f740fb..6851a5c67189 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -664,12 +664,10 @@ void pblk_gc_exit(struct pblk *pblk)
 		kthread_stop(gc->gc_reader_ts);
 
 	flush_workqueue(gc->gc_reader_wq);
-	if (gc->gc_reader_wq)
-		destroy_workqueue(gc->gc_reader_wq);
+	destroy_workqueue(gc->gc_reader_wq);
 
 	flush_workqueue(gc->gc_line_reader_wq);
-	if (gc->gc_line_reader_wq)
-		destroy_workqueue(gc->gc_line_reader_wq);
+	destroy_workqueue(gc->gc_line_reader_wq);
 
 	if (gc->gc_writer_ts)
 		kthread_stop(gc->gc_writer_ts);
-- 
2.11.0
