Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73CEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B706217DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="BSe/QtU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B706217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeHVGDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:03:32 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:54966 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeHVGDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:03:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 5B9961070E175;
        Wed, 22 Aug 2018 10:44:20 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HrZgkAZqropz; Wed, 22 Aug 2018 10:44:19 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id C9E501070725D;
        Wed, 22 Aug 2018 10:44:19 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai C9E501070725D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1534905859;
        bh=9HjC0pSE0Dk8Qpfpry/Fg/8ppzap3yvWYx5/B7623i0=;
        h=From:To:Subject:Date:Message-Id;
        b=BSe/QtU5habbXCIfh1y6Wl6J20l38jlSCG+hhSo+RkOpc4v5NSdVMIEH/3i4uiGhZ
         M0XyMzs3fnq/P/3/XzTU4NhciVDo19ijxF/Sx2r2t2S8U7mGASbSqjnEgGhfm1xx1w
         0ScJbHLUowec/pRyUEA8NoiGrMqMz8C1xvwLYask=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wCiMhM-WNFeV; Wed, 22 Aug 2018 10:44:19 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 850961070219A;
        Wed, 22 Aug 2018 10:44:19 +0800 (CST)
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     vkoul@kernel.org
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH v2] dma: mic_x100_dma: use devm_kzalloc to fix an issue
Date:   Wed, 22 Aug 2018 10:40:27 +0800
Message-Id: <20180822024027.8984-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch introduced an issue.
    commit f6206f00d8c5 ("dmaengine: mic_x100_dma: use the new helper to simplify the code")

This issue is :

	kfree(mic_dma_dev)
	.....
	dma_async_device_unregister(mic_dma_dev->device);

Free the memory, and use it again.

So use devm_kzalloc to allocate mic_dma_dev to fix it.

When the Devres try to release the resources, it will call release at the
following order:

	dma_async_device_unregister(mic_dma_dev->device);
	.....
	kfree(mic_dma_dev)

Fixes: f6206f00d8c5 ("dmaengine: mic_x100_dma: use the new helper to simplify the code")
Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
v1 --> v2:
     Change the commit message and title
---
 drivers/dma/mic_x100_dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/mic_x100_dma.c b/drivers/dma/mic_x100_dma.c
index b76cb17d879c..adfd316db1a8 100644
--- a/drivers/dma/mic_x100_dma.c
+++ b/drivers/dma/mic_x100_dma.c
@@ -639,7 +639,7 @@ static struct mic_dma_device *mic_dma_dev_reg(struct mbus_device *mbdev,
 	int ret;
 	struct device *dev = &mbdev->dev;
 
-	mic_dma_dev = kzalloc(sizeof(*mic_dma_dev), GFP_KERNEL);
+	mic_dma_dev = devm_kzalloc(dev, sizeof(*mic_dma_dev), GFP_KERNEL);
 	if (!mic_dma_dev) {
 		ret = -ENOMEM;
 		goto alloc_error;
@@ -664,7 +664,6 @@ static struct mic_dma_device *mic_dma_dev_reg(struct mbus_device *mbdev,
 reg_error:
 	mic_dma_uninit(mic_dma_dev);
 init_error:
-	kfree(mic_dma_dev);
 	mic_dma_dev = NULL;
 alloc_error:
 	dev_err(dev, "Error at %s %d ret=%d\n", __func__, __LINE__, ret);
@@ -674,7 +673,6 @@ static struct mic_dma_device *mic_dma_dev_reg(struct mbus_device *mbdev,
 static void mic_dma_dev_unreg(struct mic_dma_device *mic_dma_dev)
 {
 	mic_dma_uninit(mic_dma_dev);
-	kfree(mic_dma_dev);
 }
 
 /* DEBUGFS CODE */
-- 
2.17.1

