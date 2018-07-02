Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EDCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3B8248D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="chbA8unZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3B8248D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754067AbeGBICw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:02:52 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43446 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeGBICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:02:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id m12-v6so10704654lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1849dU4tG59McCnf2+NkKCCjXyKjWmv/jftBj2/tZ8A=;
        b=chbA8unZ5vuTHwgR4Egg8bzm1Q+v6UmYVlENtQTOSkMuAOk69qDF9zAV7RVzrsGcf3
         LvXtD0Tpe1H/DqfANLL8L/MyJcYYcVgnKKSXf4JuUDn9PYef6n5aVtLPlTK4EuVmqCkJ
         7+EIhgu6/lgHFSXTe8sV6vm2SVOqYvDybnaiKnRDMDgc6NqIzdhkmGCORjUlpu/ywuTp
         WeZvR4zjS9bQAKQNtYowrpHOk9kQ+LlhJBSZu+akx6gf84NgEaL3KpVchw9JlT5yauA+
         6EhUkxD/pfvS6C5z9sSE2Yv6G3brS4Lhb0vdAQA3px+ucswrIR5suq6SSarHDHUoxZ5Y
         y1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1849dU4tG59McCnf2+NkKCCjXyKjWmv/jftBj2/tZ8A=;
        b=t7u19B/XhVxdF+CKGiqLqmwe/fFYhVHhlauFMnEEsHIKLU6BbAOsL46EeqmccWYb7O
         k25Xm5DyYIZuOq39YOTFeiK3FIdc+ZGOt2j2HZp+bo0TqgSG7iwnTv3d3t6QetD9scru
         /+jN+aDzVtboqJE8mSFiccnJXe85Xh+qgtz2KCaNFG4J5QsTJVb/FhC1B4K9iUt3nGdx
         i2OyhaCcldUxoD40C76J0mR+AynLeUla+AiLjQ8g4BPGorqG52PQsCY4fQgRpAT913FT
         wR5/P3W5TTvrCnSs+45T6TdKRhATijP4QYCx7RtjoVryt4nQ6G/JBXzHmfIto7nzMmPu
         9uvA==
X-Gm-Message-State: APt69E3NPlrZBejz4Mw1FGfoMygH2jlg6HBESvk2eYgNZaYphzP7c9lt
        g5Bt8lJ007OOJkyoSORpKJJTyQ==
X-Google-Smtp-Source: AAOMgpfOo9PR5tBkImaHkHp1HlpHr8nStHBPXrRi6T7G1KSpbGhGPVowWhQvs0LC+40kUbgIhyqdLQ==
X-Received: by 2002:a19:c301:: with SMTP id t1-v6mr14037606lff.45.1530518564857;
        Mon, 02 Jul 2018 01:02:44 -0700 (PDT)
Received: from Macroninja.cnexlabs.com (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id 1-v6sm595041ljd.11.2018.07.02.01.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 01:02:43 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: limit get chunk meta request size
Date:   Mon,  2 Jul 2018 10:02:23 +0200
Message-Id: <20180702080223.13214-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices that does not specify a limit on its transfer size, the
get_chk_meta command may send down a single I/O retrieving the full
chunk metadata table. Resulting in large 2-4MB I/O requests. Instead,
split up the I/Os to a maximum of 256KB and issue them separately to
reduce memory requirements.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index b9989717418d..3b644b0e9713 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -583,7 +583,13 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	struct ppa_addr ppa;
 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
 	size_t log_pos, offset, len;
-	int ret, i;
+	int ret, i, max_len;
+
+	/*
+	 * limit requests to maximum 256K to avoid issuing arbitrary large
+	 * requests when the device does not specific a maximum transfer size.
+	 */
+	max_len = min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * 1024);
 
 	/* Normalize lba address space to obtain log offset */
 	ppa.ppa = slba;
@@ -596,7 +602,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	offset = log_pos * sizeof(struct nvme_nvm_chk_meta);
 
 	while (left) {
-		len = min_t(unsigned int, left, ctrl->max_hw_sectors << 9);
+		len = min_t(unsigned int, left, max_len);
 
 		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
 				dev_meta, len, offset);
-- 
2.11.0

