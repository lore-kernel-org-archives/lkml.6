Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeFAOqA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:46:00 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:45592 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeFAOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:44:00 -0400
X-Google-Smtp-Source: ADUXVKLINzm/rPr4yfozGpH+ggCjZFMrUEWx0Vqt1RRKrBKNY8G2TLK8LzbHh8uTWm2zP0W3Zcx3Eg==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 05/10] lightnvm: fix partial read error path
Date: Fri,  1 Jun 2018 16:41:09 +0200
Message-Id: <20180601144114.17490-6-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601144114.17490-1-mb@lightnvm.io>
References: <20180601144114.17490-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

When error occurs during bio_add_page on partial read path, pblk
tries to free pages twice.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 38f89a84ce5e..f770fd113ffe 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -256,7 +256,7 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
 
 	if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
-		goto err;
+		goto err_add_pages;
 
 	if (nr_holes != new_bio->bi_vcnt) {
 		pr_err("pblk: malformed bio\n");
@@ -347,10 +347,10 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	return NVM_IO_OK;
 
 err:
-	pr_err("pblk: failed to perform partial read\n");
-
 	/* Free allocated pages in new bio */
-	pblk_bio_free_pages(pblk, bio, 0, new_bio->bi_vcnt);
+	pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
+err_add_pages:
+	pr_err("pblk: failed to perform partial read\n");
 	__pblk_end_io_read(pblk, rqd, false);
 	return NVM_IO_ERR;
 }
-- 
2.11.0
