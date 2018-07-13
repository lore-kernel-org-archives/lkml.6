Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84816ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362BA208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="foilrSbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362BA208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbeGMJDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:03:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43243 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeGMJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:09 -0400
Received: by mail-pl0-f68.google.com with SMTP id o7-v6so1546317plk.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/o6TouuzMj4hAi/E4zlw4tY9U6hfVq7zhgS150k4CM=;
        b=foilrSbQSZom81iuiqYfaxUok7w1mneZNBxCI++JvGoHvh5RiUV9SONRYjUbZiwvP4
         QkBVuol9LRqgI907dfBs7hJbWr6AsfyuVdIC2JiSS82iR//x0tj8A+B58PZIgBWNfZPt
         r7hYMbfD0qGSanagYk6n1usZCpyqlsvy1nJmXfSIUrQCPJyLPJktk68SZ5IrQLQWSH6y
         nYAO63xlHuG5pPJtRxoM1DRb2BwTMv0tf1vT6BpJC36ku6sujaVM+WUosB2V8xxUdnXH
         mznswZnTvj6vDxQJwMzfWjDKSCHjSDggEW1z9F6htHQBnYOEWCaJd+KXkJJZrMJu2K9s
         QYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/o6TouuzMj4hAi/E4zlw4tY9U6hfVq7zhgS150k4CM=;
        b=FUXBA6wlAoFk6Y+6MzUrjpxxqqfRoslfbiAYFQ1GFVpzPqMPJd/a5sIIjzcR7rwDZZ
         0b5VBpLc2yqVpLr1/yV43d3ihaYV8FSnqntFfE9rPC8U9wnR+heQIpDivwpwqCeJCz5S
         ZazglM1/3zGs30FjtTFquPdpTkAqG3SDMhkUH4aYRfVNeaw/st4APKYPDRlxTYxq5/FE
         0Ng0tz0Mw1s+L1CNVblqQNtq86fgMrSd4Q2qSVxPVf9cdLRhwNfZh8jFFlo75xDYOdEV
         FqcvM0udA7WZGNULfDRprQZek0a9IWpx8mtAWEf8cbCm4IfoGXpzJ0j8CwXIJxrHmdcB
         EPkw==
X-Gm-Message-State: AOUpUlGPACTVH8t4JcJ8KeduimYOmKxTg0NIeFMxChtzLfNsIta5dO1Y
        egAG4ttpUA28dx/F2GVd50tBQQ==
X-Google-Smtp-Source: AAOMgpc0ADWCGD87DLoBJ08bgCba6VNkNjtWLt9FzzLNov9q9KdP4OxDUI6M7vXFQrI1zONBzTApqA==
X-Received: by 2002:a17:902:5a3:: with SMTP id f32-v6mr5433741plf.109.1531471769737;
        Fri, 13 Jul 2018 01:49:29 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id d18-v6sm569357pgo.74.2018.07.13.01.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 01:49:28 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 05/10] lightnvm: pblk: fix read_bitmap for 32bit archs
Date:   Fri, 13 Jul 2018 10:48:40 +0200
Message-Id: <20180713084845.19511-6-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
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
Reviewed-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 6e93c489ce57..bcfc6ea86e9d 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -401,7 +401,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	struct pblk_g_ctx *r_ctx;
 	struct nvm_rq *rqd;
 	unsigned int bio_init_idx;
-	unsigned long read_bitmap; /* Max 64 ppas per request */
+	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
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

