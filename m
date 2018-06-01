Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbeFAOqE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:46:04 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43968 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeFAOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:43:59 -0400
X-Google-Smtp-Source: ADUXVKIJ5usG/nw0b85lPMWW9QikeFo2wDoGbnbjQksQqAznG1viYCqyRXPnrtHsiGuLZedrlG0F5A==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 04/10] lightnvm: proper error handling for pblk_bio_add_pages
Date: Fri,  1 Jun 2018 16:41:08 +0200
Message-Id: <20180601144114.17490-5-mb@lightnvm.io>
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

Currently in case of error caused by bio_pc_add_page in
pblk_bio_add_pages two issues occur when calling from
pblk_rb_read_to_bio(). First one is in pblk_bio_free_pages, since we
are trying to free pages not allocated from our mempool. Second one
is the warn from dma_pool_free, that we are trying to free NULL
pointer dma.

This commit fix both issues.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 549341b24e3c..99036befb571 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -278,7 +278,9 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 		return;
 	}
 
-	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
+	if (rqd->meta_list)
+		nvm_dev_dma_free(dev->parent, rqd->meta_list,
+				rqd->dma_meta_list);
 	mempool_free(rqd, pool);
 }
 
@@ -316,7 +318,7 @@ int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 
 	return 0;
 err:
-	pblk_bio_free_pages(pblk, bio, 0, i - 1);
+	pblk_bio_free_pages(pblk, bio, (bio->bi_vcnt - i), i);
 	return -1;
 }
 
-- 
2.11.0
