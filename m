Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754472AbeE1JFZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:05:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54160 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754186AbeE1I67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:58:59 -0400
X-Google-Smtp-Source: AB8JxZrgSJFVbG1rZpMvhNqUvT45C7NnVlo9xCdmfNxCAnOObuDPrGRGZW1hcDU2CpxXWetv2nhT4g==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 07/20] lightnvm: pblk: remove unnecessary indirection
Date: Mon, 28 May 2018 10:58:28 +0200
Message-Id: <20180528085841.26684-8-mb@lightnvm.io>
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

Call nvm_submit_io directly and remove an unnecessary indirection on the
read path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index b201fc486adb..a2e678de428f 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -102,16 +102,6 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 #endif
 }
 
-static int pblk_submit_read_io(struct pblk *pblk, struct nvm_rq *rqd)
-{
-	int err;
-
-	err = pblk_submit_io(pblk, rqd);
-	if (err)
-		return NVM_IO_ERR;
-
-	return NVM_IO_OK;
-}
 
 static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 				sector_t blba)
@@ -485,9 +475,9 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		rqd->bio = int_bio;
 		r_ctx->private = bio;
 
-		ret = pblk_submit_read_io(pblk, rqd);
-		if (ret) {
+		if (pblk_submit_io(pblk, rqd)) {
 			pr_err("pblk: read IO submission failed\n");
+			ret = NVM_IO_ERR;
 			if (int_bio)
 				bio_put(int_bio);
 			goto fail_end_io;
-- 
2.11.0
