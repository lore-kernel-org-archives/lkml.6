Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932913AbeB1RJp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:09:45 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50479 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933628AbeB1PuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:50:02 -0500
X-Google-Smtp-Source: AH8x227L0z7akIkiPfttFpP3MaNZt4BpeMhhKOca0/oYzWO3ywKL1YRlY/5P3H1mrslqwLpSFjFnjg==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 12/15] lightnvn: pblk: use generic address format
Date: Wed, 28 Feb 2018 16:49:32 +0100
Message-Id: <1519832975-25432-13-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic address format on common address manipulations.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 10 +++++-----
 drivers/lightnvm/pblk-map.c   |  4 ++--
 drivers/lightnvm/pblk-sysfs.c |  4 ++--
 drivers/lightnvm/pblk.h       |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 7d0bd33f11d9..2e10b18b61e3 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -885,7 +885,7 @@ int pblk_line_erase(struct pblk *pblk, struct pblk_line *line)
 		}
 
 		ppa = pblk->luns[bit].bppa; /* set ch and lun */
-		ppa.g.blk = line->id;
+		ppa.a.blk = line->id;
 
 		atomic_dec(&line->left_eblks);
 		WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
@@ -1686,8 +1686,8 @@ static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
 	int i;
 
 	for (i = 1; i < nr_ppas; i++)
-		WARN_ON(ppa_list[0].g.lun != ppa_list[i].g.lun ||
-				ppa_list[0].g.ch != ppa_list[i].g.ch);
+		WARN_ON(ppa_list[0].a.lun != ppa_list[i].a.lun ||
+				ppa_list[0].a.ch != ppa_list[i].a.ch);
 #endif
 
 	ret = down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
@@ -1731,8 +1731,8 @@ void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
 	int i;
 
 	for (i = 1; i < nr_ppas; i++)
-		WARN_ON(ppa_list[0].g.lun != ppa_list[i].g.lun ||
-				ppa_list[0].g.ch != ppa_list[i].g.ch);
+		WARN_ON(ppa_list[0].a.lun != ppa_list[i].a.lun ||
+				ppa_list[0].a.ch != ppa_list[i].a.ch);
 #endif
 
 	rlun = &pblk->luns[pos];
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 04e08d76ea5f..20dbaa89c9df 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -127,7 +127,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			atomic_dec(&e_line->left_eblks);
 
 			*erase_ppa = rqd->ppa_list[i];
-			erase_ppa->g.blk = e_line->id;
+			erase_ppa->a.blk = e_line->id;
 
 			spin_unlock(&e_line->lock);
 
@@ -168,6 +168,6 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		set_bit(bit, e_line->erase_bitmap);
 		atomic_dec(&e_line->left_eblks);
 		*erase_ppa = pblk->luns[bit].bppa; /* set ch and lun */
-		erase_ppa->g.blk = e_line->id;
+		erase_ppa->a.blk = e_line->id;
 	}
 }
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index cbb5b6edb7bf..a643dc623731 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -39,8 +39,8 @@ static ssize_t pblk_sysfs_luns_show(struct pblk *pblk, char *page)
 		sz += snprintf(page + sz, PAGE_SIZE - sz,
 				"pblk: pos:%d, ch:%d, lun:%d - %d\n",
 					i,
-					rlun->bppa.g.ch,
-					rlun->bppa.g.lun,
+					rlun->bppa.a.ch,
+					rlun->bppa.a.lun,
 					active);
 	}
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index dd0089fe62b9..6ac64d9eb57e 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -936,12 +936,12 @@ static inline int pblk_pad_distance(struct pblk *pblk)
 
 static inline int pblk_ppa_to_line(struct ppa_addr p)
 {
-	return p.g.blk;
+	return p.a.blk;
 }
 
 static inline int pblk_ppa_to_pos(struct nvm_geo *geo, struct ppa_addr p)
 {
-	return p.g.lun * geo->num_ch + p.g.ch;
+	return p.a.lun * geo->num_ch + p.a.ch;
 }
 
 static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
-- 
2.7.4
