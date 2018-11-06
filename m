Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F5DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D652085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3BKmtCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D652085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbeKGBJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:09:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35132 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbeKGBJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:09:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id z16-v6so14061404wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 07:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyNQOO6YaDrbBzaN4x2sXwLMUP+wh63KFQ8W6ySoA48=;
        b=X3BKmtCg4oCRZTcCcapDNRxAjkP1e1Bsj2OI/5VGKNnpS+mnWuPYQt8glAykMvmGMu
         EvQeBn06+iKIaNRGrZdn58dsSUln1gA/AYVOD1SwDWbSlKpMnVqMmjjwkn4F79exXohE
         s3qiCbAVjTRybfDSriJdtwLBPvhQozlBHFUB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyNQOO6YaDrbBzaN4x2sXwLMUP+wh63KFQ8W6ySoA48=;
        b=KMN1YMv1xVONaPFqHBAP03u4fvmH+9ffA5ihKaLBXDqABZyxUmAt2aXvgmI3wa2EGh
         VQeEiJhnPyTcmBzbfpORP7K4sx0oU7EBfnJ+1QpvcWd3JN4x7zzeHbpKIdooSMLvh8JZ
         AD6cS63ZGsvcekpoDig9NqzgTxNm3SXOPPiuqCsr6EdzWyzLVCOm6Spp0OWCM0PcZGcj
         T4o2gT9ZNrq5ychFQtHpv1WL1oG59v4zGqMWyL2Wn4KjbkLT7CJDq8RMUhi17tgyqfl1
         WQD5CMqMXboHJRNFn5KkSe5bqujIqK6uogZnQobSe4IlC0DN+gCYEJ+6sLnkr9r1+JoD
         eAGg==
X-Gm-Message-State: AGRZ1gKgGB2D0kLkVXQpVAsLBPSxTIdjIFYMtILI2gz0PQxedodn1jG8
        DcNz8uZyf4S9f1aupIv6NCdICA==
X-Google-Smtp-Source: AJdET5eFn+TsO6Sjkx+5n50GVAqTVv6zta7ljP202P2SGDdVYnCu6xNPjcXSuBdsx5AfAydzqjCgEw==
X-Received: by 2002:adf:dbc3:: with SMTP id e3-v6mr25299425wrj.165.1541519026574;
        Tue, 06 Nov 2018 07:43:46 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id o81-v6sm1447356wmo.38.2018.11.06.07.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 07:43:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] nvmem: core: fix regression in of_nvmem_cell_get()
Date:   Tue,  6 Nov 2018 15:41:41 +0000
Message-Id: <20181106154141.2260-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMEM DT support seems to be totally broken after
commit e888d445ac33 ("nvmem: resolve cells from DT at registration time")
Fix this!

Index used in of_nvmem_cell_get() to find cell is specific to
consumer, It can not be used for searching the cell in provider.
Use device_node instead of this to find the matching cell in device
tree case.

Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Hi Greg, 

Could you please take this one for next rc, as dt support seems to
be broken in v4.20-rc1

Thanks,
srini

 drivers/nvmem/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9b18ce90f907..27f67dfa649d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -44,6 +44,7 @@ struct nvmem_cell {
 	int			bytes;
 	int			bit_offset;
 	int			nbits;
+	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
 };
@@ -298,6 +299,7 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
 	mutex_lock(&nvmem_mutex);
 	list_del(&cell->node);
 	mutex_unlock(&nvmem_mutex);
+	of_node_put(cell->np);
 	kfree(cell->name);
 	kfree(cell);
 }
@@ -530,6 +532,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 			return -ENOMEM;
 
 		cell->nvmem = nvmem;
+		cell->np = of_node_get(child);
 		cell->offset = be32_to_cpup(addr++);
 		cell->bytes = be32_to_cpup(addr);
 		cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
@@ -960,14 +963,13 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 
 #if IS_ENABLED(CONFIG_OF)
 static struct nvmem_cell *
-nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
+nvmem_find_cell_by_node(struct nvmem_device *nvmem, struct device_node *np)
 {
 	struct nvmem_cell *cell = NULL;
-	int i = 0;
 
 	mutex_lock(&nvmem_mutex);
 	list_for_each_entry(cell, &nvmem->cells, node) {
-		if (index == i++)
+		if (np == cell->np)
 			break;
 	}
 	mutex_unlock(&nvmem_mutex);
@@ -1011,7 +1013,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 	if (IS_ERR(nvmem))
 		return ERR_CAST(nvmem);
 
-	cell = nvmem_find_cell_by_index(nvmem, index);
+	cell = nvmem_find_cell_by_node(nvmem, cell_np);
 	if (!cell) {
 		__nvmem_device_put(nvmem);
 		return ERR_PTR(-ENOENT);
-- 
2.19.1

