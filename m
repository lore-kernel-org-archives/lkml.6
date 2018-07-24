Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5786ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4113720875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4113720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbeGXGc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:32:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388109AbeGXGc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:32:28 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8DCCFC6B94902;
        Tue, 24 Jul 2018 13:27:43 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Tue, 24 Jul 2018
 13:27:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <michael.chan@broadcom.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] bnxt_en: Fix logic of forward the VF MAC address to PF in bnxt_vf_validate_set_mac
Date:   Tue, 24 Jul 2018 13:24:54 +0800
Message-ID: <20180724052454.21524-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the comments,req->l2addr must match the VF MAC address
if firmware spec >= 1.2.2, mac_ok can be true.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index a649108..7925964 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -954,12 +954,9 @@ static int bnxt_vf_validate_set_mac(struct bnxt *bp, struct bnxt_vf_info *vf)
 		if (ether_addr_equal((const u8 *)req->l2_addr, vf->mac_addr))
 			mac_ok = true;
 	} else if (is_valid_ether_addr(vf->vf_mac_addr)) {
-		if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr))
+		if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr) &&
+		    bp->hwrm_spec_code >= 0x10202)
 			mac_ok = true;
-	} else if (bp->hwrm_spec_code < 0x10202) {
-		mac_ok = true;
-	} else {
-		mac_ok = true;
 	}
 	if (mac_ok)
 		return bnxt_hwrm_exec_fwd_resp(bp, vf, msg_size);
-- 
2.7.0


