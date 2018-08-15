Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCF1C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9583821501
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9583821501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeHOJZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:25:01 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38238 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeHOJZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:25:01 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A94F11A01F1;
        Wed, 15 Aug 2018 08:34:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C3251A008E;
        Wed, 15 Aug 2018 08:34:03 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 75317402B3;
        Wed, 15 Aug 2018 14:33:56 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, marek.vasut@gmail.com, richard@nod.at
Cc:     cyrille.pitchen@wedev4u.fr, broonie@kernel.org, pp@emlix.com,
        Zhiqiang.Hou@nxp.com, chuanhua.han@nxp.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: m25p80: consider max message size in m25p80_read when use the spi_mem_xx() API
Date:   Wed, 15 Aug 2018 14:33:43 +0800
Message-Id: <1534314823-14048-1-git-send-email-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a message size limit when calculating the maximum amount
of data that can be read.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 drivers/mtd/devices/m25p80.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index e84563d..87efa56 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -128,7 +128,12 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
 
 	while (remaining) {
-		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
+		op.data.nbytes = min3(remaining,
+				spi_max_transfer_size(flash->spimem->spi),
+				spi_max_message_size(flash->spimem->spi) -
+				sizeof(op.cmd.opcode) -
+				op.addr.nbytes -
+				op.dummy.nbytes);
 		ret = spi_mem_adjust_op_size(flash->spimem, &op);
 		if (ret)
 			return ret;
-- 
2.7.4

