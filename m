Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC19C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A4920870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A4920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeIJRLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:11:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56189 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:11:15 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fzL87-0002GC-SR; Mon, 10 Sep 2018 12:17:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] cxgb4: remove redundant assignment to vlan_cmd.dropnovlan_fm
Date:   Mon, 10 Sep 2018 13:17:22 +0100
Message-Id: <20180910121722.15524-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A recent commit updated vlan_cmd.dropnovlan_fm but failed to remove
the older assignment.  Fix this by removing the former redundant
assignment.

Detected by CoverityScan, CID#1473290 ("Unused value")

Fixes: a89cdd8e7c74 ("cxgb4: impose mandatory VLAN usage when non-zero TAG ID")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 6f1bd7bf1a11..c28a1d8b7f33 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -10209,7 +10209,6 @@ int t4_set_vlan_acl(struct adapter *adap, unsigned int mbox, unsigned int vf,
 					 FW_ACL_VLAN_CMD_VFN_V(vf));
 	vlan_cmd.en_to_len16 = cpu_to_be32(enable | FW_LEN16(vlan_cmd));
 	/* Drop all packets that donot match vlan id */
-	vlan_cmd.dropnovlan_fm = FW_ACL_VLAN_CMD_FM_F;
 	vlan_cmd.dropnovlan_fm = (enable
 				  ? (FW_ACL_VLAN_CMD_DROPNOVLAN_F |
 				     FW_ACL_VLAN_CMD_FM_F) : 0);
-- 
2.17.1

