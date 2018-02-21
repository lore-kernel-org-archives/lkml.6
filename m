Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeBUIGY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:06:24 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39099 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBUIDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:03:55 -0500
X-Google-Smtp-Source: AH8x226HVvYEYyB+fVt9ifPZQG4c0sPmNS/Yz3i/aC6i9BDEyHwzEHdS81ujaHHaGiNQh3Udk5Hj2Q==
From: hans.ml.holmberg@owltronix.com
To: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 2/3] lightnvm: pblk: allow allocation of new lines during shutdown
Date: Wed, 21 Feb 2018 09:03:00 +0100
Message-Id: <1519200181-10886-3-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When shutting down pblk the write buffer is flushed and if the
current line can't fit the data in the write buffer we need
to allocate a new line, so remove the check that prevents this.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 22e61cd..8848443 100644
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
2.7.4
