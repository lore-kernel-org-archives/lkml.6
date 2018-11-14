Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C38C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C336D2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C336D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbeKNXMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:12:30 -0500
Received: from smtprz15.163.net ([106.3.154.248]:34930 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727731AbeKNXMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:12:30 -0500
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 296491C80EEF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 20:56:17 +0800 (CST)
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id DBAC2100156A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 20:56:15 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cZHxs1Qxvr-X for <linux-kernel@vger.kernel.org>;
        Wed, 14 Nov 2018 20:56:15 +0800 (CST)
Received: from localhost (unknown [110.184.153.105])
        by antispam1.tom.com (Postfix) with ESMTPA id 7DDBB1001423;
        Wed, 14 Nov 2018 20:56:14 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] mtd: spi-nor: Return error when nor->addr_width not match the device size
Date:   Wed, 14 Nov 2018 20:56:05 +0800
Message-Id: <1542200165-3073-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In is25lp256, the DWORD1 of JEDEC Basic Flash Parameter Header
is 0xfff920e5. So the DWORD1[18:17] Address Bytes bits are 0b00,
means that 3-Byte only addressing. But the device size is larger
than 16MB, nor->addr_width must be 4 to access the whole address.
An error should be returned when nor->addr_width not match
the device size in spi_nor_parse_sfdp().

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 3eba13a..77eaf22 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2669,6 +2669,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	}
 	params->size >>= 3; /* Convert to bytes. */
 
+	/*if the device exceeds 16MiB, addr_width must be 4*/
+	if ((params->size > 0x1000000) && (nor->addr_width == 3))
+		return -EINVAL;
+
 	/* Fast Read settings. */
 	for (i = 0; i < ARRAY_SIZE(sfdp_bfpt_reads); i++) {
 		const struct sfdp_bfpt_read *rd = &sfdp_bfpt_reads[i];
-- 
1.9.1

