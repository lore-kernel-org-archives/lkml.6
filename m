Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41737C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0367220867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0367220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeIRM72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:59:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727228AbeIRM72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:59:28 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0A676F5A2409E;
        Tue, 18 Sep 2018 15:28:07 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Tue, 18 Sep 2018 15:28:04 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <michael.chan@broadcom.com>, <davem@davemloft.net>,
        <vasundhara-v.volam@broadcom.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCHv3] net: bnxt: Fix a uninitialized variable warning.
Date:   Tue, 18 Sep 2018 15:15:44 +0800
Message-ID: <1537254944-41068-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c:49:5: warning: nvm_param.dir_type may be used uninitialized in this function [-Wmaybe-uninitialized]
  if (nvm_param.dir_type == BNXT_NVM_PORT_CFG)

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index f3b9fbc..790c684 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -46,6 +46,9 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
 		}
 	}
 
+	if (i == ARRAY_SIZE(nvm_params))
+		return -EOPNOTSUPP;
+
 	if (nvm_param.dir_type == BNXT_NVM_PORT_CFG)
 		idx = bp->pf.port_id;
 	else if (nvm_param.dir_type == BNXT_NVM_FUNC_CFG)
-- 
1.7.12.4

