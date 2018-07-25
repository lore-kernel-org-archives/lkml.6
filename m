Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5E3C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE5520844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE5520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeGYM02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:26:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728555AbeGYM02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:26:28 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 91E89F236DDC8;
        Wed, 25 Jul 2018 19:15:12 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Wed, 25 Jul 2018
 19:15:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <michael.chan@broadcom.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <vasundhara-v.volam@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] bnxt_en: combine 'else if' and 'else' into single branche
Date:   Wed, 25 Jul 2018 19:14:58 +0800
Message-ID: <20180725111459.10800-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The else-if branch and else branch set mac_ok to true similarly,
so combine the two into single else branch.

Aslo add comments to explain the two conditions, which
from Michael Chan and Vasundhara Volam.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index a649108..f560845 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -956,9 +956,13 @@ static int bnxt_vf_validate_set_mac(struct bnxt *bp, struct bnxt_vf_info *vf)
 	} else if (is_valid_ether_addr(vf->vf_mac_addr)) {
 		if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr))
 			mac_ok = true;
-	} else if (bp->hwrm_spec_code < 0x10202) {
-		mac_ok = true;
 	} else {
+		/* There are two cases:
+		 * 1.If firmware spec < 0x10202,VF MAC address is not forwarded
+		 *   to the PF and so it doesn't have to match
+		 * 2.Allow VF to modify it's own MAC when PF has not assigned a
+		 *   valid MAC address and firmware spec >= 0x10202
+		 */
 		mac_ok = true;
 	}
 	if (mac_ok)
-- 
2.7.0


