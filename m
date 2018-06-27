Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318EAC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB6325A2F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="igYbhEhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB6325A2F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935128AbeF0Tmc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:42:32 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35357 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935101AbeF0Tma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:42:30 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so2423453lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/omtUHlsPvPWOdxTaiyL1MA4SRecFGeK5/NxG1cOQFU=;
        b=igYbhEhXTY5T8ElOyWfXmm5x49IM9bRd7yzdFb8RcJlN7TBQbOCX6bDKqfUPFRPiWw
         LsXDzEdrCZsQO7yhtocxNTK4RTaSYh4cvK6ypI1zT9efxTMZ3VkaIGD16hET2IdYxxJN
         bppvKLifwANGtsAzSBnp2DcWvIHp84JrTPfGHxitj8ZgJCIVbbvuTa4kDnm3VUE2V7tz
         6PKXVCEr+Y6aXWJUBIhEAYZqDSdg84Nsug3GRSXLmted31tp7haToJLKQrja+z/VyP2Y
         //tTnZwCpC4t6tqAwIfRsR4veVXiBpGaPa0LV/eq3jeUkbfyRWXWmmKltyOLi08YZ3Ed
         DX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/omtUHlsPvPWOdxTaiyL1MA4SRecFGeK5/NxG1cOQFU=;
        b=uL+vLK17saDyU1ch3BRHUSuIkK0zdAKPohHOF0hFXID8tw3e2c3OD2K70sFC7OWMuE
         zdYSoKXWzNrntU6ZgvU0o3RioDhqDIyuUxKGc8S8dTgePl09P3RQpnwWcgYq2pbDZG4j
         gHe2l1m2c0Ndx5zV/cNhX5ot5p2EtUg2YcbHCRu3V7lJXxS7Z+BRPPcqVudzCeyQn7ZA
         pydJp6sT9I1gQYNhyWoPnj/r/DxenV6YKR0bC2VyHMQ/A4B0vS/uco1rpTiiMzsRTlKJ
         0l2rXTXxW0Lfc5V8OSBP1qao7PtaMQQMZLmD++A2p4rFg/NEhb2KxlIeq8KE+qN3sizQ
         yXyA==
X-Gm-Message-State: APt69E3zTerkQ6RtfhaB6o0KS6Ao9PztQLTM/ygNBM6s1iJ+aHMyJTvB
        44CLjvE/r59LIGkRqZYuLnSXzA==
X-Google-Smtp-Source: AAOMgpeuCVVGoMNbrU8B43LFJBK3tVMWQo/qibPwnlvHkY91CCuOPlw7HVME+/MOIsKY+JI2uR6vuw==
X-Received: by 2002:a19:d3c3:: with SMTP id k186-v6mr5272569lfg.62.1530128549370;
        Wed, 27 Jun 2018 12:42:29 -0700 (PDT)
Received: from Macroninja.cnexlabs.com (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id k10-v6sm812915ljh.5.2018.06.27.12.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 12:42:28 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: fix read_bitmap for 32bit archs
Date:   Wed, 27 Jun 2018 21:42:06 +0200
Message-Id: <20180627194206.30384-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If using pblk on a 32bit architecture, and there is a need to
perform a partial read, the partial read bitmap will only have
allocated 32 entries, where as 64 are needed.

Make sure that the read_bitmap is initialized to 64bits on 32bit
architectures as well.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 6e93c489ce57..671635275d56 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -401,7 +401,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	struct pblk_g_ctx *r_ctx;
 	struct nvm_rq *rqd;
 	unsigned int bio_init_idx;
-	unsigned long read_bitmap; /* Max 64 ppas per request */
+	DECLARE_BITMAP(read_bitmap, 64); /* Max 64 ppas per request */
 	int ret = NVM_IO_ERR;
 
 	/* logic error: lba out-of-bounds. Ignore read request */
@@ -413,7 +413,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 
 	generic_start_io_acct(q, READ, bio_sectors(bio), &pblk->disk->part0);
 
-	bitmap_zero(&read_bitmap, nr_secs);
+	bitmap_zero(read_bitmap, nr_secs);
 
 	rqd = pblk_alloc_rqd(pblk, PBLK_READ);
 
@@ -444,19 +444,19 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
 		rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
 
-		pblk_read_ppalist_rq(pblk, rqd, bio, blba, &read_bitmap);
+		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
 	} else {
-		pblk_read_rq(pblk, rqd, bio, blba, &read_bitmap);
+		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
 	}
 
-	if (bitmap_full(&read_bitmap, nr_secs)) {
+	if (bitmap_full(read_bitmap, nr_secs)) {
 		atomic_inc(&pblk->inflight_io);
 		__pblk_end_io_read(pblk, rqd, false);
 		return NVM_IO_DONE;
 	}
 
 	/* All sectors are to be read from the device */
-	if (bitmap_empty(&read_bitmap, rqd->nr_ppas)) {
+	if (bitmap_empty(read_bitmap, rqd->nr_ppas)) {
 		struct bio *int_bio = NULL;
 
 		/* Clone read bio to deal with read errors internally */
@@ -480,7 +480,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	/* The read bio request could be partially filled by the write buffer,
 	 * but there are some holes that need to be read from the drive.
 	 */
-	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, &read_bitmap);
+	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, read_bitmap);
 
 fail_rqd_free:
 	pblk_free_rqd(pblk, rqd, PBLK_READ);
-- 
2.11.0

