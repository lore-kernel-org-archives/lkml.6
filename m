Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADB1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A5B21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KwqI8CU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfBKNJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:09:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfBKNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xr2GjW5/lDOk/1TeZ/bXg96ZoRLQ5b6LFu6hxme6ZdA=; b=KwqI8CU12aJmELjgkkgYxqxQG
        G6aYY8snO//UGMCCjIw2vHiA6C2NLjaW1nQvYAgNQcaC9HrZkplugoSI8I15BZpNcaL6or0X5EalI
        59BetxsXXVCWCylKSVGaP0oBQWyYPK1d2m/JVDcYuCMFuu23EzdLqlgsXVwelFDeI8HpCqcP7/kal
        cxhGnC8pqMgBcMcUTeur129wQ/xgxMBcQDBx4EQ1+E2qhXGpabv5E0qqV8MPxQNjxSdk+/cN06HdZ
        M+qJN6ksRXq+zbHR/6oRJsy204RLklTP735lKJa3ueL/cIl3AQt5KcVMZpeao00v8yjYdWYM2fs5A
        GGx/LddRA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBLE-0002kq-TR; Mon, 11 Feb 2019 13:09:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     stuart.w.hayes@gmail.com, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] platform/x86: dell_rbu: fix lock imbalance in img_update_realloc
Date:   Mon, 11 Feb 2019 14:09:40 +0100
Message-Id: <20190211130940.28206-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to ensure rbu_data.lock is always held on return.

Fixes: 289790a3ea94 ("platform/x86: dell_rbu: stop abusing the DMA API")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/platform/x86/dell_rbu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell_rbu.c
index 8104ca0c44ca..031c68903583 100644
--- a/drivers/platform/x86/dell_rbu.c
+++ b/drivers/platform/x86/dell_rbu.c
@@ -436,6 +436,7 @@ static int img_update_realloc(unsigned long size)
 	ordernum = get_order(size);
 	image_update_buffer =
 		(unsigned char *)__get_free_pages(GFP_DMA32, ordernum);
+	spin_lock(&rbu_data.lock);
 	if (!image_update_buffer) {
 		pr_debug("Not enough memory for image update:"
 			"size = %ld\n", size);
@@ -446,7 +447,6 @@ static int img_update_realloc(unsigned long size)
 	if (WARN_ON_ONCE(img_buf_phys_addr > BIOS_SCAN_LIMIT))
 		return -EINVAL; /* can't happen per definition */
 
-	spin_lock(&rbu_data.lock);
 	rbu_data.image_update_buffer = image_update_buffer;
 	rbu_data.image_update_buffer_size = size;
 	rbu_data.bios_image_size = rbu_data.image_update_buffer_size;
-- 
2.20.1

