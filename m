Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45211C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93FE214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="SANQqi6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93FE214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeJISaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:52 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:44425 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeJISav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:51 -0400
Received: by mail-pg1-f178.google.com with SMTP id g2-v6so640190pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Exb272KJql0vCNZeHNmY0TUnaGDiFjdCHNepL2+FZxg=;
        b=SANQqi6HuXIwgIjeDC2bdiahBv6JIR+zdOZn0PK0IpE0zCvEmf9uDqLOmrGe9e6DVE
         qFeHg9dFYdqq0fUVwBC53ambrKke/xiWFahPitIlBUUt4ZlYI/gxn9hnP36mm9qBF0ge
         PkvNCTMjlgxoTzmwkuEOq+Gck58Uu3Qas1agx+wZsmAe1yDmI1cwkiETBNDE0T/glV5W
         LvTIv4axgdWvlrRWskjsXXZmRwQExGZ3jGgKuLl42XOehPlzHBMtDG06oYJ5NFyW0EwH
         CG7c/C3RnJk51tUPQYYUv2gWRmR2QenxatSh38g/z7rBlWU27n8KYwC/InSlUCKDpI9z
         blFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Exb272KJql0vCNZeHNmY0TUnaGDiFjdCHNepL2+FZxg=;
        b=UU3zTZfVeDJOCf3tkDPP/2TJlMeSGf2oxVCB8oS6zKDi31QzHp/P3VdnFgBbkllC1C
         Gxbed4oNE9YYpeIPAomUtmV1+4yWpJLedy+KXN/sFLMFrhiFO9LtVW1GYXUPKeGSMbkR
         OiG4PJBebwboChMktOhHcMfGwDuL1kuzD0hsKh5dJhWfO59KImB5AH9nFzHEuzcDXOm+
         l9q2PfyUZNB/IS+zu75aKs3VYkBYinFHEtjHcQJymEoERSQJ2LTua7W6EPGF3NJoozJx
         mHMKVnOpWI0F98AnJdJzRc5GeQCYcN+UuhWW5o3GDFR94FebdNpLCQ8UN6THrtcMnGzA
         I80w==
X-Gm-Message-State: ABuFfoie2P/X3TCdCfryfX3rBypml/+oEylXaW3f9m7DAQ5tnSmjDls7
        kMY+9+f62yUWDXKGnwtsS0r/YA==
X-Google-Smtp-Source: ACcGV63PRAVToXw7++HF8A5TRRqOZetUm9dak/ScSS0PaviXhpOMbO2SHsFMe6IEx5Q3Y4n+7b9ddQ==
X-Received: by 2002:a63:450b:: with SMTP id s11-v6mr25696528pga.301.1539083664689;
        Tue, 09 Oct 2018 04:14:24 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:23 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 21/45] lightnvm: pblk: remove debug from pblk_[down/up]_page
Date:   Tue,  9 Oct 2018 13:11:51 +0200
Message-Id: <20181009111215.7653-22-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
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

Also, rename the functions pblk_[down/up]_page to
pblk_[down/up]_chunk, to communicate that it manages the write
pointer of the chunk. Note that it also protects the parallel unit
such that at most one chunk is active per parallel unit.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c     | 34 +++++++++-----------------------
 drivers/lightnvm/pblk-map.c      |  2 +-
 drivers/lightnvm/pblk-recovery.c |  6 +++---
 drivers/lightnvm/pblk-write.c    |  6 +++---
 drivers/lightnvm/pblk.h          |  6 +++---
 5 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index bb1a7cc24cbb..968597d10cc2 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1861,8 +1861,7 @@ void pblk_gen_run_ws(struct pblk *pblk, struct pblk_line *line, void *priv,
 	queue_work(wq, &line_ws->ws);
 }
 
-static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
-			     int nr_ppas, int pos)
+static void __pblk_down_chunk(struct pblk *pblk, int pos)
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
+void pblk_down_chunk(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	int pos = pblk_ppa_to_pos(geo, ppa_list[0]);
+	int pos = pblk_ppa_to_pos(geo, ppa);
 
-	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
+	__pblk_down_chunk(pblk, pos);
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
+	__pblk_down_chunk(pblk, pos);
 }
 
-void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
+void pblk_up_chunk(struct pblk *pblk, struct ppa_addr ppa)
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
index eea901d7cebc..cbcc0828517e 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -227,7 +227,7 @@ static void pblk_end_io_recov(struct nvm_rq *rqd)
 	struct pblk_pad_rq *pad_rq = rqd->private;
 	struct pblk *pblk = pad_rq->pblk;
 
-	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
+	pblk_up_chunk(pblk, ppa_list[0]);
 
 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
 
@@ -339,12 +339,12 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	}
 
 	kref_get(&pad_rq->ref);
-	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_down_chunk(pblk, rqd->ppa_list[0]);
 
 	ret = pblk_submit_io(pblk, rqd);
 	if (ret) {
 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
-		pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+		pblk_up_chunk(pblk, rqd->ppa_list[0]);
 		goto fail_free_bio;
 	}
 
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index cd579b440b56..674ba4d1a9f4 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -270,7 +270,7 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	int sync;
 
-	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
+	pblk_up_chunk(pblk, ppa_list[0]);
 
 	if (rqd->error) {
 		pblk_log_write_err(pblk, rqd);
@@ -420,7 +420,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 		list_del(&meta_line->list);
 	spin_unlock(&l_mg->close_lock);
 
-	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
+	pblk_down_chunk(pblk, ppa_list[0]);
 
 	ret = pblk_submit_io(pblk, rqd);
 	if (ret) {
@@ -431,7 +431,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	return NVM_IO_OK;
 
 fail_rollback:
-	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
+	pblk_up_chunk(pblk, ppa_list[0]);
 	spin_lock(&l_mg->close_lock);
 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
 	list_add(&meta_line->list, &meta_line->list);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 0ca67e8f99d5..429347bcd1fa 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -823,10 +823,10 @@ u64 pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
 u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
 int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
 		   unsigned long secs_to_flush);
-void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
-void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
+void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
 		  unsigned long *lun_bitmap);
-void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
+void pblk_down_chunk(struct pblk *pblk, struct ppa_addr ppa);
+void pblk_up_chunk(struct pblk *pblk, struct ppa_addr ppa);
 void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap);
 int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 		       int nr_pages);
-- 
2.17.1

