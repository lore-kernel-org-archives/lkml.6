Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669C4C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2F82075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="SFNBM31E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2F82075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeJIScO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:32:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42204 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeJIScO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:32:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so648246pgq.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLwddzeUooCY4Cr2FryTJ4j9wyROsN2nO3k/jrXsCYU=;
        b=SFNBM31E+D65YFsUDBTL+yWYVhCIk2L2VO60Nk3rBPNJZxv6LhGPKUeTGy4yfR1Y/7
         SlMjnqlvQbM78TINvU7fUK1RY6pWo4kj/2IqfhGRdajXW0bHoJ+a6oosyL9el1iVuXRJ
         X1jDO/16gp0IWbryPTlaK7Gk6OR3HJuLn+wW1VzWjGm/TnIj4j/tV2IXalcEytPUxrov
         +aWUIpCqMiv0C0A3O3OuVMkUZEijowdGuMUNPZqGpXa+aMdOCuapolSgTnL5PrQlttSc
         3AkDJN/f/otX0QYIVxj8n0Upr4FbeRX3o1oTj8QRxFPflhFqeNcymW41FmH4CqpM/BMa
         7HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLwddzeUooCY4Cr2FryTJ4j9wyROsN2nO3k/jrXsCYU=;
        b=TOWJuWoOe+6Cx0DGFTBDqAXeEfB4mxqFCyyv8xTJ3b9QRPWoZhNkJz+LmNQhD2iRn6
         8e7L0ja33kKkpJgzmw/leHOeMURgmy53Kuw6NOEzT7fvKpJQB6xLuJdmKr/qPwZZrHw+
         837qaSqJKQWpbYt60rMrubG3qaQ4GqBPueVC3lSV2zKsr4zHF+j/NiYno+UocrJB6Mst
         Es/FWgvCSGqt3DUEN/XoSZ/K7qg9M9SAUVQi6+09h6ako01O6nKKNFBG2b5Yz34Fo5by
         UyDAmEvYgGmkG3TewTzYbSqbLtDlHXjXzasR6u5iPWFwLP9NmF9kx8SeG8PrcFpMhrE6
         ULrA==
X-Gm-Message-State: ABuFfojVI0UiKIf7l38akuo0Fuk6S0GslgWgrpeAiN6N60ffl0hcMhtj
        is0RX5PQWCSF8Og6drqryesx5A==
X-Google-Smtp-Source: ACcGV60GflOYvu35paToK3BztWJdfHro6qadiOTH544KOVjfEJIa0GRUYO2qAT1UIZlgIIm6wcFp1Q==
X-Received: by 2002:a62:3047:: with SMTP id w68-v6mr5081631pfw.19.1539083746829;
        Tue, 09 Oct 2018 04:15:46 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:15:45 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 45/45] lightnvm: pblk: guarantee that backpointer is respected on writer stall
Date:   Tue,  9 Oct 2018 13:12:15 +0200
Message-Id: <20181009111215.7653-46-mb@lightnvm.io>
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

From: Javier González <javier@javigon.com>

pblk's write buffer must guarantee that it respects the device's
constrains for reads (i.e., mw_cunits). This is done by maintaining a
backpointer that updates the L2P table as entries wrap up, making them
point to the media instead of pointing to the write buffer.

This mechanism can race in case that the write thread stalls, as the
write pointer will protect the last written entry, thus disregarding the
read constrains.

This patch adds an extra check on wrap up, making sure that the
threshold is respected at all times, preventing new entries to overwrite
committed data, also in case of write thread stall.

Reported-by: Heiner Litz <hlitz@ucsc.edu>
Signed-off-by: Javier González <javier@cnexlabs.com>
Reviewed-by: Heiner Litz <hlitz@ucsc.edu>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 5 +++--
 drivers/lightnvm/pblk-rb.c   | 9 +++++++--
 drivers/lightnvm/pblk.h      | 8 +++++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index e5239aba806b..13822594647c 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -193,8 +193,9 @@ static int pblk_rwb_init(struct pblk *pblk)
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	unsigned long buffer_size;
-	int pgs_in_buffer;
+	int pgs_in_buffer, threshold;
 
+	threshold = geo->mw_cunits * geo->all_luns;
 	pgs_in_buffer = (max(geo->mw_cunits, geo->ws_opt) + geo->ws_opt)
 								* geo->all_luns;
 
@@ -203,7 +204,7 @@ static int pblk_rwb_init(struct pblk *pblk)
 	else
 		buffer_size = pgs_in_buffer;
 
-	return pblk_rb_init(&pblk->rwb, buffer_size, geo->csecs);
+	return pblk_rb_init(&pblk->rwb, buffer_size, threshold, geo->csecs);
 }
 
 /* Minimum pages needed within a lun */
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index f653faa6a9ed..b1f4b51783f4 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -56,7 +56,8 @@ static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
  * allocated and their size must be a power of two
  * (Documentation/core-api/circular-buffers.rst)
  */
-int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_size)
+int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
+		 unsigned int seg_size)
 {
 	struct pblk *pblk = container_of(rb, struct pblk, rwb);
 	struct pblk_rb_entry *entries;
@@ -79,6 +80,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_size)
 	rb->seg_size = (1 << power_seg_sz);
 	rb->nr_entries = (1 << power_size);
 	rb->mem = rb->subm = rb->sync = rb->l2p_update = 0;
+	rb->back_thres = threshold;
 	rb->flush_point = EMPTY_ENTRY;
 
 	spin_lock_init(&rb->w_lock);
@@ -404,11 +406,14 @@ static int __pblk_rb_may_write(struct pblk_rb *rb, unsigned int nr_entries,
 {
 	unsigned int mem;
 	unsigned int sync;
+	unsigned int threshold;
 
 	sync = READ_ONCE(rb->sync);
 	mem = READ_ONCE(rb->mem);
 
-	if (pblk_rb_ring_space(rb, mem, sync, rb->nr_entries) < nr_entries)
+	threshold = nr_entries + rb->back_thres;
+
+	if (pblk_rb_ring_space(rb, mem, sync, rb->nr_entries) < threshold)
 		return 0;
 
 	if (pblk_rb_update_l2p(rb, nr_entries, mem, sync))
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 0f98ea24ee59..02bb2e98f8a9 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -203,6 +203,11 @@ struct pblk_rb {
 					 * will be 4KB
 					 */
 
+	unsigned int back_thres;	/* Threshold that shall be maintained by
+					 * the backpointer in order to respect
+					 * geo->mw_cunits on a per chunk basis
+					 */
+
 	struct list_head pages;		/* List of data pages */
 
 	spinlock_t w_lock;		/* Write lock */
@@ -734,7 +739,8 @@ struct pblk_line_ws {
 /*
  * pblk ring buffer operations
  */
-int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_sz);
+int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
+		 unsigned int seg_sz);
 int pblk_rb_may_write_user(struct pblk_rb *rb, struct bio *bio,
 			   unsigned int nr_entries, unsigned int *pos);
 int pblk_rb_may_write_gc(struct pblk_rb *rb, unsigned int nr_entries,
-- 
2.17.1

