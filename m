Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FACC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E42214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="tz+xhY9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E42214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeJISbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32817 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeJISbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id s4-v6so681083plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7JGJXrZcJTYtzXBSO8ITsCgwbjUBsGV01Gzzox45vg=;
        b=tz+xhY9ACp5KFI7zzphhvo5ziTKg+83Vod4TGZsG20KJD+lYbNJ/VLxIpQKG6XiNuZ
         ltYCs7YlEZfENZPDr8uSSVfPbTRBhc3s6c0Io6m26XfW0G/7nLiCr8Ojkl9bnvqAI7Vq
         qsBWzVDQmkJ9RCsEyZ+H3rUuIVSoP4BNMMWYsQhQX/y5iGjAn2yYycbtA+pMKEJjEIh5
         Zem44DdR58slri92Oyxu5z8jrkmX9uyNjZ89mI1lSkW9t/zlmibq09fRNQ24UChT8pHZ
         06t1d3h+0EmHvVxw7bfUPskBWbQSRiaUbrZmTmqBFpS9Xy4cM6tnPXr0hZ3lRZvvj4fQ
         ESEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7JGJXrZcJTYtzXBSO8ITsCgwbjUBsGV01Gzzox45vg=;
        b=tNAe0lt9Z/htgSegJ11wrtHVWfHhLwyqil5wpwEEJ+jzCvgAltoYgh7QCSbp8Avp4U
         Va2Bc9kusR+M4V+3N/JA8iRSzkwqJ4PTCkwqXrNYYkHh+A8FIuTvRmVOZ7dmDDWdyQPR
         kPVTJjIrOOeyZoi8NA82/mcotcNZxZ7X6bJC3IirwrDGVVr2qcMPLcVYBcVh7ZjDAUyP
         TwBi4I8Bn33yTWc5Ifh0wCMXyybnspHhJQcAQJ/QW2mGACjocL8C1wqC9JpxnNoYQLNj
         93LhTG/uePzOgy11rHwRNDedJS0lnFxlUfQbEURhNWeRc/wIF5LrbGcXALBefgBfjfyU
         jlJQ==
X-Gm-Message-State: ABuFfohOFqWZ5k0FIQ2hz7U4U7prtMOfjWc09jyccXxfBZyeuM7ni0Dt
        QXPYhPjQAy6vm34SboQdYi/b7g==
X-Google-Smtp-Source: ACcGV62XNXA1EPUnKNqn5uB34ctiUSqBVZaoDhxoYSuBmW1MmMn58i83VtyXXCZSZPnoiFOF21SP9g==
X-Received: by 2002:a17:902:263:: with SMTP id 90-v6mr28088003plc.190.1539083708369;
        Tue, 09 Oct 2018 04:15:08 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:15:06 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 34/45] lightnvm: pblk: take write semaphore on metadata
Date:   Tue,  9 Oct 2018 13:12:04 +0200
Message-Id: <20181009111215.7653-35-mb@lightnvm.io>
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

pblk guarantees write ordering at a chunk level through a per open chunk
semaphore. At this point, since we only have an open I/O stream for both
user and GC data, the semaphore is per parallel unit.

For the metadata I/O that is synchronous, the semaphore is not needed as
ordering is guaranteed. However, if the metadata scheme changes or
multiple streams are open, this guarantee might not be preserved.

This patch makes sure that all writes go through the semaphore, even for
synchronous I/O. This is consistent with pblk's write I/O model. It also
simplifies maintenance since changes in the metadata scheme could cause
ordering issues.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 16 +++++++++++++++-
 drivers/lightnvm/pblk.h      |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 49cef93e328e..a3ce4a36dd33 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -557,6 +557,20 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 	return ret;
 }
 
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list;
+	int ret;
+
+	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+
+	pblk_down_chunk(pblk, ppa_list[0]);
+	ret = pblk_submit_io_sync(pblk, rqd);
+	pblk_up_chunk(pblk, ppa_list[0]);
+
+	return ret;
+}
+
 static void pblk_bio_map_addr_endio(struct bio *bio)
 {
 	bio_put(bio);
@@ -787,7 +801,7 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 		meta_list[i].lba = lba_list[paddr] = addr_empty;
 	}
 
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd);
 	if (ret) {
 		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 02e2c02b0cf4..4c015c457197 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -792,6 +792,7 @@ void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
 void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd);
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
-- 
2.17.1

