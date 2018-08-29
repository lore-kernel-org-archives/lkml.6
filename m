Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FDDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F862083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="CZJdMNBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F862083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeH2SFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:05:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39549 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbeH2SFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:05:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id g20-v6so2379926pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oc0m08zEe/xHCcsliqxWcsBaRI9TQiNjC1hXlKLH8mk=;
        b=CZJdMNBrpskOJ/JAR4sIMlSMzlLsthpdJ2goBQtfT9ylx6luhMqxlPsfTULICWJxpy
         XePQu64eGWUTZMUVRdOYMmT/KPtHEMBz9xSsP+JMYuST7CXPViawxlO2vF1v87H0nohz
         27B/RGRHbrJL5qiDNBGDaRUbv53DQIqBMTCC9Fj32REAfpG/+nuSW9AkYgLk+8TeZ4H9
         Ghm+GYRNr/DYwhJPY3QwoPTxMO6kVAHp+XnjdtJb54pkHpw0QHhWbZbKPW3b/UOMK3Es
         GQ2USn67lhtuS90UxVs8Rmu6DCVlNAj7J2WsT3dYQvY6pL5fL7BNIa6kpFynzUzK+9MT
         HoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oc0m08zEe/xHCcsliqxWcsBaRI9TQiNjC1hXlKLH8mk=;
        b=CgtlgRp/svrOqQrVi6V/8z3WS6JQvDirE78edQyx3VxJ9AT6USDNgE5SNwcZdZ5oDn
         H6zB0/uSPr+7Viid6Ov1s+RRRth/iFo1dMGWX0W7RbKXnxHFplLq9vKgfXHnGk5touBQ
         BChW0DjEiiIhY1lO4jfiNtgkiAnmHN2bVdxJwV7FtwOjlS6RwRefTeHkpM6nD44jL5Zm
         l2qM3HpO9v7gW26BCFru83DrZkJ2Ql+Y2WKvKvoIbU9lTrjfJNWwLurB5kowrqSrBvDs
         AGjLx8s8hXN9DAyN8pxrW61JikVmEzrcDAMDjCJveZLXcIoP918YR05nmP9Haax2FBs0
         mDdA==
X-Gm-Message-State: APzg51BtraaOF4EY0MqyknLk4VY6InTtz8Pc/FYgl3BbH0hIJ/P1fR24
        Fe5jJyoWPpgy4mgQZO124By3Dg==
X-Google-Smtp-Source: ANB0VdYUbFg9VfrVM/QfR6ZfdK7Xxc4r3JzjQisJM03S2KWkRUn5JRGStQ1xm3+ioF72xnZwI6JTLw==
X-Received: by 2002:a63:6243:: with SMTP id w64-v6mr5991471pgb.145.1535551724304;
        Wed, 29 Aug 2018 07:08:44 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id j27-v6sm6914478pfj.91.2018.08.29.07.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 07:08:42 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: remove debug from pblk_[down/up]_page
Date:   Wed, 29 Aug 2018 16:08:32 +0200
Message-Id: <20180829140832.29341-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the debug only iteration within __pblk_down_page, which
then allows us to reduce the number of arguments down to pblk and
the parallel unit from the functions that calls it. Simplifying the
callers logic considerably.

Also, rename the functions pblk_[down/up]_page to pblk_[down/up]_pu,
to communicate that it takes a lock on the parallel unit.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c     | 34 +++++++++-------------------------
 drivers/lightnvm/pblk-map.c      |  2 +-
 drivers/lightnvm/pblk-recovery.c |  6 +++---
 drivers/lightnvm/pblk-write.c    |  6 +++---
 drivers/lightnvm/pblk.h          |  6 +++---
 5 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index bb1a7cc24cbb..08df6bcd2f81 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1861,8 +1861,7 @@ void pblk_gen_run_ws(struct pblk *pblk, struct pblk_line *line, void *priv,
 	queue_work(wq, &line_ws->ws);
 }
 
-static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
-			     int nr_ppas, int pos)
+static void __pblk_down_pu(struct pblk *pblk, int pos)
 {
 	struct pblk_lun *rlun = &pblk->luns[pos];
 	int ret;
@@ -1871,13 +1870,6 @@ static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
 	 * Only send one inflight I/O per LUN. Since we map at a page
 	 * granurality, all ppas in the I/O will map to the same LUN
 	 */
-#ifdef CONFIG_NVM_PBLK_DEBUG
-	int i;
-
-	for (i = 1; i < nr_ppas; i++)
-		WARN_ON(ppa_list[0].a.lun != ppa_list[i].a.lun ||
-				ppa_list[0].a.ch != ppa_list[i].a.ch);
-#endif
 
 	ret = down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
 	if (ret == -ETIME || ret == -EINTR)
@@ -1885,21 +1877,21 @@ static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
 				-ret);
 }
 
-void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
+void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	int pos = pblk_ppa_to_pos(geo, ppa_list[0]);
+	int pos = pblk_ppa_to_pos(geo, ppa);
 
-	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
+	__pblk_down_pu(pblk, pos);
 }
 
-void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
+void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
 		  unsigned long *lun_bitmap)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	int pos = pblk_ppa_to_pos(geo, ppa_list[0]);
+	int pos = pblk_ppa_to_pos(geo, ppa);
 
 	/* If the LUN has been locked for this same request, do no attempt to
 	 * lock it again
@@ -1907,23 +1899,15 @@ void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
 	if (test_and_set_bit(pos, lun_bitmap))
 		return;
 
-	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
+	__pblk_down_pu(pblk, pos);
 }
 
-void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
+void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_lun *rlun;
-	int pos = pblk_ppa_to_pos(geo, ppa_list[0]);
-
-#ifdef CONFIG_NVM_PBLK_DEBUG
-	int i;
-
-	for (i = 1; i < nr_ppas; i++)
-		WARN_ON(ppa_list[0].a.lun != ppa_list[i].a.lun ||
-				ppa_list[0].a.ch != ppa_list[i].a.ch);
-#endif
+	int pos = pblk_ppa_to_pos(geo, ppa);
 
 	rlun = &pblk->luns[pos];
 	up(&rlun->wr_sem);
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index dc0efb852475..ff677ca6e4e1 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -79,7 +79,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 		}
 	}
 
-	pblk_down_rq(pblk, ppa_list, nr_secs, lun_bitmap);
+	pblk_down_rq(pblk, ppa_list[0], lun_bitmap);
 	return 0;
 }
 
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index eea901d7cebc..df624d504d24 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -227,7 +227,7 @@ static void pblk_end_io_recov(struct nvm_rq *rqd)
 	struct pblk_pad_rq *pad_rq = rqd->private;
 	struct pblk *pblk = pad_rq->pblk;
 
-	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
+	pblk_up_pu(pblk, ppa_list[0]);
 
 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
 
@@ -339,12 +339,12 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	}
 
 	kref_get(&pad_rq->ref);
-	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_down_pu(pblk, rqd->ppa_list[0]);
 
 	ret = pblk_submit_io(pblk, rqd);
 	if (ret) {
 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
-		pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+		pblk_up_pu(pblk, rqd->ppa_list[0]);
 		goto fail_free_bio;
 	}
 
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index cd579b440b56..55d198edd70a 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -270,7 +270,7 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	int sync;
 
-	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
+	pblk_up_pu(pblk, ppa_list[0]);
 
 	if (rqd->error) {
 		pblk_log_write_err(pblk, rqd);
@@ -420,7 +420,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 		list_del(&meta_line->list);
 	spin_unlock(&l_mg->close_lock);
 
-	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
+	pblk_down_pu(pblk, ppa_list[0]);
 
 	ret = pblk_submit_io(pblk, rqd);
 	if (ret) {
@@ -431,7 +431,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	return NVM_IO_OK;
 
 fail_rollback:
-	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
+	pblk_up_pu(pblk, ppa_list[0]);
 	spin_lock(&l_mg->close_lock);
 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
 	list_add(&meta_line->list, &meta_line->list);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 2f61f4428fcb..390855375b1e 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -823,10 +823,10 @@ u64 pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
 u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
 int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
 		   unsigned long secs_to_flush);
-void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
-void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
+void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa);
+void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
 		  unsigned long *lun_bitmap);
-void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
+void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa);
 void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap);
 int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 		       int nr_pages);
-- 
2.11.0

