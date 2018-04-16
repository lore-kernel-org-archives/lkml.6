Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754360AbeDPKZx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:25:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44853 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeDPKZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:25:48 -0400
X-Google-Smtp-Source: AIpwx4/PEufFE0UqaQ1Uz3NtXAsvbVRavvtSoMnJ8JLQlLMJdsH/p3YK7oA7yAqO4Ru9538x4oymdg==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 07/11] lightnvm: pblk: remove unnecessary indirection
Date: Mon, 16 Apr 2018 12:25:28 +0200
Message-Id: <1523874332-6272-8-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary indirection on the read path.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 89aed634333a..2f8224354c62 100644
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
@@ -485,7 +475,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		rqd->bio = int_bio;
 		r_ctx->private = bio;
 
-		ret = pblk_submit_read_io(pblk, rqd);
+		ret = pblk_submit_io(pblk, rqd);
 		if (ret) {
 			pr_err("pblk: read IO submission failed\n");
 			if (int_bio)
-- 
2.7.4
