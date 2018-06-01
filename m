Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeFANFP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:05:15 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35034 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeFANFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:05:02 -0400
X-Google-Smtp-Source: ADUXVKIgZfuQVy+INo4B/tWqtMS+ukWxBkI6rmP2ewUV8eReW602sehtA1ZGf96kZsEOKlUNUSMr8w==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 07/18] lightnvm: pblk: remove unnecessary indirection
Date: Fri,  1 Jun 2018 15:04:21 +0200
Message-Id: <20180601130432.30866-8-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601130432.30866-1-mb@lightnvm.io>
References: <20180601130432.30866-1-mb@lightnvm.io>
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
