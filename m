Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33EAECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828B220856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828B220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbeGWPO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:14:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53357 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388125AbeGWPO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:14:27 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AAD5C7E0E9B19;
        Mon, 23 Jul 2018 22:12:41 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.382.0; Mon, 23 Jul 2018
 22:12:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <qiang.zhao@nxp.com>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] wan/fsl_ucc_hdlc: use IS_ERR_VALUE() to check return value of qe_muram_alloc
Date:   Mon, 23 Jul 2018 22:12:33 +0800
Message-ID: <20180723141233.19948-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qe_muram_alloc return a unsigned long integer,which should not
compared with zero. check it using IS_ERR_VALUE() to fix this.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 9b09c9d..5f0366a 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -192,7 +192,7 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	priv->ucc_pram_offset = qe_muram_alloc(sizeof(struct ucc_hdlc_param),
 				ALIGNMENT_OF_UCC_HDLC_PRAM);
 
-	if (priv->ucc_pram_offset < 0) {
+	if (IS_ERR_VALUE(priv->ucc_pram_offset)) {
 		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
 		ret = -ENOMEM;
 		goto free_tx_bd;
@@ -230,14 +230,14 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 
 	/* Alloc riptr, tiptr */
 	riptr = qe_muram_alloc(32, 32);
-	if (riptr < 0) {
+	if (IS_ERR_VALUE(riptr)) {
 		dev_err(priv->dev, "Cannot allocate MURAM mem for Receive internal temp data pointer\n");
 		ret = -ENOMEM;
 		goto free_tx_skbuff;
 	}
 
 	tiptr = qe_muram_alloc(32, 32);
-	if (tiptr < 0) {
+	if (IS_ERR_VALUE(tiptr)) {
 		dev_err(priv->dev, "Cannot allocate MURAM mem for Transmit internal temp data pointer\n");
 		ret = -ENOMEM;
 		goto free_riptr;
-- 
2.7.0


