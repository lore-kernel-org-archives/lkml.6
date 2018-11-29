Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A109C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E999120834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E999120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeK2Q4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:56:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727406AbeK2Q4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:56:18 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 84D2F35D8CB1F;
        Thu, 29 Nov 2018 13:52:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 29 Nov 2018 13:51:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <noralf@tronnes.org>, <airlied@linux.ie>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/tinydrm: Use kmemdup rather than duplicating its implementation in repaper_spi_transfer()
Date:   Thu, 29 Nov 2018 06:00:33 +0000
Message-ID: <1543471233-159568-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use kmemdup rather than duplicating its implementation

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/tinydrm/repaper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tinydrm/repaper.c b/drivers/gpu/drm/tinydrm/repaper.c
index 07f45a0..54d6fe0 100644
--- a/drivers/gpu/drm/tinydrm/repaper.c
+++ b/drivers/gpu/drm/tinydrm/repaper.c
@@ -108,12 +108,11 @@ static int repaper_spi_transfer(struct spi_device *spi, u8 header,
 
 	/* Stack allocated tx? */
 	if (tx && len <= 32) {
-		txbuf = kmalloc(len, GFP_KERNEL);
+		txbuf = kmemdup(tx, len, GFP_KERNEL);
 		if (!txbuf) {
 			ret = -ENOMEM;
 			goto out_free;
 		}
-		memcpy(txbuf, tx, len);
 	}
 
 	if (rx) {



