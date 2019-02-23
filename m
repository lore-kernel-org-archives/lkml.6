Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E768FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B378B2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957425;
	bh=XUTtZmUFbPSrwmmk+ThJ6D/WQFFTxX/7RE5MINTm2Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ayMfHu50zYtCA9Phb7LFVIYuvadJO0NAVHBWGz/M3MMzehrAn3bN95+s7qOv6Hm9
	 ljCQeFnZ9301gG9+XJzdQMFoQwh5QI5KIqdp6oLDcWXTHg9SHoFwKE7kVD6nmFSLe9
	 81A/7tv3SwkClgRRgTnnkfwjXTTgfsYA8Djz7Lbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfBWVaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfBWVFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:05:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ECED20855;
        Sat, 23 Feb 2019 21:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955944;
        bh=XUTtZmUFbPSrwmmk+ThJ6D/WQFFTxX/7RE5MINTm2Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpZO/wlExz8VYBLFJflBMOD2Waco+Uu486WKjKIu5Hi7oGmAvE01tv5cptaNjp25J
         5GcXuEzpZl5DzsyLAmbLYKkBoVgjZBs7eXlLaMjMlceG88aIssVj9aQg0VYOVbOxKc
         M0r32xkkfIYr6+uZMCq5jLLbaaNLVJdl+FEmHti4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 51/72] scsi: 53c700: pass correct "dev" to dma_alloc_attrs()
Date:   Sat, 23 Feb 2019 16:04:01 -0500
Message-Id: <20190223210422.199966-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
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

