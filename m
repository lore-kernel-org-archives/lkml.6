Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbeE1JEz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:04:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32989 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeE1I7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:59:01 -0400
X-Google-Smtp-Source: ADUXVKIwgmyhYvN+6JxWaxilBxofeUzVpOSzHojl1/EbhYIZJ78bV5r48HVJdCbMt+QT6OrHXF6kNA==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 08/20] lightnvm: pblk: remove unnecessary argument
Date: Mon, 28 May 2018 10:58:29 +0200
Message-Id: <20180528085841.26684-9-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180528085841.26684-1-mb@lightnvm.io>
References: <20180528085841.26684-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

Remove unnecessary argument on pblk_line_free()

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 6 +++---
 drivers/lightnvm/pblk-init.c | 2 +-
 drivers/lightnvm/pblk.h      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 0d4078805ecc..4b10122aec89 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1337,7 +1337,7 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
 	retry_line->emeta = line->emeta;
 	retry_line->meta_line = line->meta_line;
 
-	pblk_line_free(pblk, line);
+	pblk_line_free(line);
 	l_mg->data_line = retry_line;
 	spin_unlock(&l_mg->free_lock);
 
@@ -1562,7 +1562,7 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 	return new;
 }
 
-void pblk_line_free(struct pblk *pblk, struct pblk_line *line)
+void pblk_line_free(struct pblk_line *line)
 {
 	kfree(line->map_bitmap);
 	kfree(line->invalid_bitmap);
@@ -1584,7 +1584,7 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
 	line->state = PBLK_LINESTATE_FREE;
 	line->gc_group = PBLK_LINEGC_NONE;
-	pblk_line_free(pblk, line);
+	pblk_line_free(line);
 	spin_unlock(&line->lock);
 
 	atomic_dec(&gc->pipeline_gc);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8f8c9abd14fc..b52855f9336b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -509,7 +509,7 @@ static void pblk_lines_free(struct pblk *pblk)
 	for (i = 0; i < l_mg->nr_lines; i++) {
 		line = &pblk->lines[i];
 
-		pblk_line_free(pblk, line);
+		pblk_line_free(line);
 		pblk_line_meta_free(line);
 	}
 	spin_unlock(&l_mg->free_lock);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 9c682acfc5d1..dfbfe9e9a385 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -766,7 +766,7 @@ struct pblk_line *pblk_line_get_data(struct pblk *pblk);
 struct pblk_line *pblk_line_get_erase(struct pblk *pblk);
 int pblk_line_erase(struct pblk *pblk, struct pblk_line *line);
 int pblk_line_is_full(struct pblk_line *line);
-void pblk_line_free(struct pblk *pblk, struct pblk_line *line);
+void pblk_line_free(struct pblk_line *line);
 void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_close(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_close_ws(struct work_struct *work);
-- 
2.11.0
