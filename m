Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40E7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D812087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D812087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeH1RNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:13:18 -0400
Received: from smtprz15.163.net ([106.3.154.248]:63521 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728142AbeH1RNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:13:17 -0400
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 861901C80E2C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 21:21:22 +0800 (CST)
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 842AD1001349
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 21:21:22 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CM8JIxksNRtJ for <linux-kernel@vger.kernel.org>;
        Tue, 28 Aug 2018 21:21:21 +0800 (CST)
Received: from localhost (unknown [110.184.152.116])
        by antispam1.tom.com (Postfix) with ESMTPA id DF82F10012D0;
        Tue, 28 Aug 2018 21:21:20 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        han.xu@nxp.com, marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH v2] mtd: spi-nor: fsl-quadspi: fix read error for flash size  larger than 16MB
Date:   Tue, 28 Aug 2018 21:21:16 +0800
Message-Id: <1535462476-3540-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the size of spi-nor flash is larger than 16MB, the read_opcode
is set to SPINOR_OP_READ_1_1_4_4B, and fsl_qspi_get_seqid() will
return -EINVAL when cmd is SPINOR_OP_READ_1_1_4_4B. This can
cause read operation fail.

---
v2:
  add Fixes tag and CC stable suggested by Boris.
---

Fixes: e46ecda764dc ("mtd: spi-nor: Add Freescale QuadSPI driver")
Cc: <stable@vger.kernel.org>
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

