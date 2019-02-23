Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C384C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309AC20661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957053;
	bh=XUTtZmUFbPSrwmmk+ThJ6D/WQFFTxX/7RE5MINTm2Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WuBieIGUeVlqq1dgzOT1F5gISxbItWKFmhID83rT4qM+RQoCUmFfm68CLC8F4Pbxa
	 AOcY/w5BG6VhMpfBYaUGtPLrn+a/8SpmJ6GdlOuvcw9YG5+h5mqTVnJ4VR9gx0RP4b
	 TAfZEtr1wwQW4Dxl4t3Sc15OPT5R5+DWCrxyuUcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfBWVYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:24:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbfBWVHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8F52086D;
        Sat, 23 Feb 2019 21:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956074;
        bh=XUTtZmUFbPSrwmmk+ThJ6D/WQFFTxX/7RE5MINTm2Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmQWQ6hxkH2+hhEw6lGCYAXnvm1gj0dqpGfjBvdTeqpl4qiWFkIWTmQR72H+hfGPX
         8oTZkLrhxDKpHLigiCABfndYR0bJcMTb4SxYKoZ/kegCXnrso4nN1ZxUXulpxzzjc7
         FrmtBY62Amw/ZnCsQG3Q8SyH7Vs67m2Lj5aJbyB0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 47/65] scsi: 53c700: pass correct "dev" to dma_alloc_attrs()
Date:   Sat, 23 Feb 2019 16:06:22 -0500
Message-Id: <20190223210640.200911-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
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

