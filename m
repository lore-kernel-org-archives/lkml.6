Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeC2WOs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:14:48 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43900 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbeC2WHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:06 -0400
X-Google-Smtp-Source: AIpwx4+r8oXg9s+sJrQZjXzlJZtHzTWhQYrKZotIxKXHdG81/RrEKxMCfjBtg4Ae64mXEF15OcacMw==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 09/37] lightnvm: pblk: delete writer kick timer before stopping thread
Date: Fri, 30 Mar 2018 00:04:56 +0200
Message-Id: <20180329220524.30363-10-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Unless we delete the timer that wakes up the write thread
before we stop the thread we risk re-starting the thread, so
delete the timer first.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8416910ee8bf..49c65f1dd48b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -912,9 +912,9 @@ static void pblk_writer_stop(struct pblk *pblk)
 	WARN(pblk_rb_sync_count(&pblk->rwb),
 			"Stopping not fully synced write buffer\n");
 
+	del_timer_sync(&pblk->wtimer);
 	if (pblk->writer_ts)
 		kthread_stop(pblk->writer_ts);
-	del_timer(&pblk->wtimer);
 }
 
 static void pblk_free(struct pblk *pblk)
-- 
2.11.0
