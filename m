Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B92C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9691521877
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9691521877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeHRMqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 08:46:14 -0400
Received: from smtprz15.163.net ([106.3.154.248]:21697 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbeHRMqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 08:46:13 -0400
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id 6744DB00D44
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 17:14:31 +0800 (CST)
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id 8D5AB81397
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 17:14:30 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam2.tom.com
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DfKv496tZyKl for <linux-kernel@vger.kernel.org>;
        Sat, 18 Aug 2018 17:14:29 +0800 (CST)
Received: from localhost (unknown [222.209.17.135])
        by antispam2.tom.com (Postfix) with ESMTPA id 18EDD81258;
        Sat, 18 Aug 2018 17:14:29 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, han.xu@nxp.com,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] mtd: spi-nor: fsl-quadspi: fix read error for flash size larger than 16MB
Date:   Sat, 18 Aug 2018 17:14:23 +0800
Message-Id: <1534583663-2842-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the size of spi-nor flash is larger than 16MB, the read_opcode
is set to SPINOR_OP_READ_1_1_4_4B, and fsl_qspi_get_seqid() will
return -EINVAL when cmd is SPINOR_OP_READ_1_1_4_4B. This can
cause read operation fail.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 7d9620c..64304a3 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -478,6 +478,7 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
 {
 	switch (cmd) {
 	case SPINOR_OP_READ_1_1_4:
+	case SPINOR_OP_READ_1_1_4_4B:
 		return SEQID_READ;
 	case SPINOR_OP_WREN:
 		return SEQID_WREN;
-- 
1.9.1

