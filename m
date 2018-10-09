Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB4FC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14516214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="IHwkG3Jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14516214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeJISbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42128 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeJISbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so647257pgq.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XaUrxQqmQTFREgCtPs1kcTaSn0YqIRu/Zt57gy/yJQ=;
        b=IHwkG3JrEofRlZM8EXd70kcb1AYWWLBB+cLBj1ejFwKH1C7aznEJzVRHCKunFeH+Xg
         3F1rf9BqtK4btHcs/m72nZJpM4sMN89j93RMRK2kYDuXUIPmXxUYhr76VifGv4WJUaFs
         gK2vbF3h5t425G40d44twQca48Ym9vU7NlmQDG8/j5/YvxoxxN2Pw8YlzB8ah4Vt+rI7
         yOML+z5fP8s+EctoS/EZ1MZGIB93diDdGSKCkYepk94LLQuFPltj6v4Jroxf9sy7Ilpn
         yLKqxuvyjKywBLxhlIeQXA0FnW6mYVEsTucthq/7tUfxWayySqmHIzJRE0rwX9gDQK4R
         X/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XaUrxQqmQTFREgCtPs1kcTaSn0YqIRu/Zt57gy/yJQ=;
        b=LQAEN+uZV+yHW+ue4YmHUlal9x2UsQnfPfdyjBn8hqQOXgXINpqh6PCJuItB1uqvsP
         TnBu0zuIqhAC9vHDpMfLNGi1/vXo5QRIrkyDYz28oVfw0hPotGHHytakMVeBKqfmvBNL
         2S/U1A3fBf8QT4zrGow30qE+AouFi6AUdQ2VmTAJmTURS+bCe+cnI1Rnrcuul5d5xL3w
         siENqrJd/iEgxQ4pRpxGSmjjPa/OkKZlPdO2fvXIzWdyDuv3LiB8WkNbPLNGhX+CZ416
         xwLcyIGuZuae/TELUEdoMpOjR9UrOZN4W5rnMu6fl9rLFQpTqUJFAniI6RxPHuCog/KZ
         W17A==
X-Gm-Message-State: ABuFfojwmSEq4fA0zuK6AMOYKhgx9O0oifGchGdcd3k/3PfVATKOL3/E
        4k3444RKtGnXQRGdk0R5QoBW/MGavY51lg==
X-Google-Smtp-Source: ACcGV617XUVNbZ8OQmtLKZRKeFCGJcblGaZAMaWvWPfFX260yn1a7vzH4tL/l4YNeu82+oyadJ4g9g==
X-Received: by 2002:aa7:84cc:: with SMTP id x12-v6mr10678355pfn.220.1539083697766;
        Tue, 09 Oct 2018 04:14:57 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:56 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 31/45] lightnvm: use internal allocation for chunk log page
Date:   Tue,  9 Oct 2018 13:12:01 +0200
Message-Id: <20181009111215.7653-32-mb@lightnvm.io>
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

The lightnvm subsystem provides helpers to retrieve chunk metadata,
where the target needs to provide a buffer to store the metadata. An
implicit assumption is that this buffer is contiguous and can be used to
retrieve the data from the device. If the device exposes too many
chunks, then kmalloc might fail, thus failing instance creation.

This patch removes this assumption by implementing an internal buffer in
the lightnvm subsystem to retrieve chunk metadata. Targets can then
use virtual memory allocations. Since this is a target API change, adapt
pblk accordingly.

Signed-off-by: Javier González <javier@cnexlabs.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c |  4 ++--
 drivers/lightnvm/pblk-init.c |  2 +-
 drivers/nvme/host/lightnvm.c | 25 +++++++++++++++++--------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 84f3b4912b92..875f3cf615ac 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -120,7 +120,7 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
 /*
  * Get information for all chunks from the device.
  *
- * The caller is responsible for freeing the returned structure
+ * The caller is responsible for freeing (vmalloc) the returned structure
  */
 struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
 {
@@ -134,7 +134,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
 	ppa.ppa = 0;
 
 	len = geo->all_chunks * sizeof(*meta);
-	meta = kzalloc(len, GFP_KERNEL);
+	meta = vzalloc(len);
 	if (!meta)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index fb66bc84d5ca..7ef8249108f0 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1039,7 +1039,7 @@ static int pblk_lines_init(struct pblk *pblk)
 
 	pblk_set_provision(pblk, nr_free_chks);
 
-	kfree(chunk_meta);
+	vfree(chunk_meta);
 	return 0;
 
 fail_free_lines:
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e42af7771fe5..7d0a4d3b0a48 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -573,7 +573,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	struct nvm_geo *geo = &ndev->geo;
 	struct nvme_ns *ns = ndev->q->queuedata;
 	struct nvme_ctrl *ctrl = ns->ctrl;
-	struct nvme_nvm_chk_meta *dev_meta = (struct nvme_nvm_chk_meta *)meta;
+	struct nvme_nvm_chk_meta *dev_meta, *dev_meta_off;
 	struct ppa_addr ppa;
 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
 	size_t log_pos, offset, len;
@@ -585,6 +585,10 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	 */
 	max_len = min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * 1024);
 
+	dev_meta = kmalloc(max_len, GFP_KERNEL);
+	if (!dev_meta)
+		return -ENOMEM;
+
 	/* Normalize lba address space to obtain log offset */
 	ppa.ppa = slba;
 	ppa = dev_to_generic_addr(ndev, ppa);
@@ -598,6 +602,9 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	while (left) {
 		len = min_t(unsigned int, left, max_len);
 
+		memset(dev_meta, 0, max_len);
+		dev_meta_off = dev_meta;
+
 		ret = nvme_get_log(ctrl, ns->head->ns_id,
 				NVME_NVM_LOG_REPORT_CHUNK, 0, dev_meta, len,
 				offset);
@@ -607,21 +614,23 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 		}
 
 		for (i = 0; i < len; i += sizeof(struct nvme_nvm_chk_meta)) {
-			meta->state = dev_meta->state;
-			meta->type = dev_meta->type;
-			meta->wi = dev_meta->wi;
-			meta->slba = le64_to_cpu(dev_meta->slba);
-			meta->cnlb = le64_to_cpu(dev_meta->cnlb);
-			meta->wp = le64_to_cpu(dev_meta->wp);
+			meta->state = dev_meta_off->state;
+			meta->type = dev_meta_off->type;
+			meta->wi = dev_meta_off->wi;
+			meta->slba = le64_to_cpu(dev_meta_off->slba);
+			meta->cnlb = le64_to_cpu(dev_meta_off->cnlb);
+			meta->wp = le64_to_cpu(dev_meta_off->wp);
 
 			meta++;
-			dev_meta++;
+			dev_meta_off++;
 		}
 
 		offset += len;
 		left -= len;
 	}
 
+	kfree(dev_meta);
+
 	return ret;
 }
 
-- 
2.17.1

