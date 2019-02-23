Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DCEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB38220651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956736;
	bh=XUTtZmUFbPSrwmmk+ThJ6D/WQFFTxX/7RE5MINTm2Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2kYbX6HJ93w+0AkdUC/ncO8t++QKoyvsyx3CnWSV+YN5mgL4YvZwXwMfR+RdcPPbD
	 4rrj9OeNVNIJ1ipSDd1G0Ad0zzFt+wDtmTLQGvv0btZSkdWedzuHVbr80Lzq+7bzmb
	 yn4LqoLqKRybrsqlij5qihabUWdwoHTJhzdPEaNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfBWVJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729168AbfBWVJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:09:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD80820855;
        Sat, 23 Feb 2019 21:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956164;
        bh=XUTtZmUFbPSrwmmk+ThJ6D/WQFFTxX/7RE5MINTm2Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNyOA5KL8k0Q/n3iCrZA7V0HDbqD4+QGO35hy+XDgv5uQn8Wf9V373Vi7E62X8OeV
         SCwHjFz0wRHaooeHOFN+xQYZCSgcWtY4pvBosVSzoQYvgTKZlhmTbkt+LevY9Y+1DF
         SHw3yTwA9mBFllLACUbb34Uzh1/V4d8MwqjuD4Xo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 31/45] scsi: 53c700: pass correct "dev" to dma_alloc_attrs()
Date:   Sat, 23 Feb 2019 16:08:21 -0500
Message-Id: <20190223210835.201708-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210835.201708-1-sashal@kernel.org>
References: <20190223210835.201708-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 8437fcf14deed67e5ad90b5e8abf62fb20f30881 ]

The "hostdata->dev" pointer is NULL here.  We set "hostdata->dev = dev;"
later in the function and we also use "hostdata->dev" when we call
dma_free_attrs() in NCR_700_release().

This bug predates git version control.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/53c700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 6be77b3aa8a5f..ac79f2088b316 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -295,7 +295,7 @@ NCR_700_detect(struct scsi_host_template *tpnt,
 	if(tpnt->sdev_attrs == NULL)
 		tpnt->sdev_attrs = NCR_700_dev_attrs;
 
-	memory = dma_alloc_attrs(hostdata->dev, TOTAL_MEM_SIZE, &pScript,
+	memory = dma_alloc_attrs(dev, TOTAL_MEM_SIZE, &pScript,
 				 GFP_KERNEL, DMA_ATTR_NON_CONSISTENT);
 	if(memory == NULL) {
 		printk(KERN_ERR "53c700: Failed to allocate memory for driver, detaching\n");
-- 
2.19.1

