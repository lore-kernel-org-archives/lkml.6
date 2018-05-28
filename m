Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933345AbeE1JFj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:05:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53087 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754173AbeE1I66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:58:58 -0400
X-Google-Smtp-Source: ADUXVKIf4azHoQMC48wKH6XjZK9JAdgFhRmCDSFNqxX552jbV5JJZ3i1tUVQWeyYoNgrnMnPfQuh9w==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 06/20] lightnvm: pblk: return NVM_ error on failed submission
Date: Mon, 28 May 2018 10:58:27 +0200
Message-Id: <20180528085841.26684-7-mb@lightnvm.io>
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

Return a meaningful error when the sanity vector I/O check fails.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 2cad918434a7..0d4078805ecc 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -467,16 +467,13 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 
+	atomic_inc(&pblk->inflight_io);
+
 #ifdef CONFIG_NVM_DEBUG
-	int ret;
-
-	ret = pblk_check_io(pblk, rqd);
-	if (ret)
-		return ret;
+	if (pblk_check_io(pblk, rqd))
+		return NVM_IO_ERR;
 #endif
 
-	atomic_inc(&pblk->inflight_io);
-
 	return nvm_submit_io(dev, rqd);
 }
 
@@ -484,16 +481,13 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 
+	atomic_inc(&pblk->inflight_io);
+
 #ifdef CONFIG_NVM_DEBUG
-	int ret;
-
-	ret = pblk_check_io(pblk, rqd);
-	if (ret)
-		return ret;
+	if (pblk_check_io(pblk, rqd))
+		return NVM_IO_ERR;
 #endif
 
-	atomic_inc(&pblk->inflight_io);
-
 	return nvm_submit_io_sync(dev, rqd);
 }
 
-- 
2.11.0
