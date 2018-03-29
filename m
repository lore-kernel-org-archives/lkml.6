Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeC2WOc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:14:32 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38998 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeC2WHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:08 -0400
X-Google-Smtp-Source: AIpwx4/I6ZVL3+OboOdnBvwCET99c5n6oyik+f1epyqu9jvC0e3ntd904v9+yvLa24ZbH465Qd2WNw==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 10/37] lightnvm: pblk: allow allocation of new lines during shutdown
Date: Fri, 30 Mar 2018 00:04:57 +0200
Message-Id: <20180329220524.30363-11-mb@lightnvm.io>
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

When shutting down pblk the write buffer is flushed and if the
current line can't fit the data in the write buffer we need
to allocate a new line, so remove the check that prevents this.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 22e61cd4f801..8848443a0721 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1407,13 +1407,6 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 	l_mg->data_line = new;
 
 	spin_lock(&l_mg->free_lock);
-	if (pblk->state != PBLK_STATE_RUNNING) {
-		l_mg->data_line = NULL;
-		l_mg->data_next = NULL;
-		spin_unlock(&l_mg->free_lock);
-		goto out;
-	}
-
 	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
 	spin_unlock(&l_mg->free_lock);
 
-- 
2.11.0
