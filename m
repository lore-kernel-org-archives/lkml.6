Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4659AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8A1214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8A1214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbeKVGgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:36:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35314 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeKVGgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:36:40 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gPYfF-0003pC-AE; Wed, 21 Nov 2018 19:59:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Aviad Krawczyk <aviad.krawczyk@huawei.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][net-next] net: hinic: fix null pointer dereference on pointer hwdev
Date:   Wed, 21 Nov 2018 19:59:56 +0000
Message-Id: <20181121195956.2730-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer hwdev is being dereferenced when declaring hwif , however, later
on hwdev is being null checked, hence we have dereference before null
check error. Fix this by assigning hwiw and pdef only once hwdev has
been null checked.

Detected by CoverityScan, CID#1485581 ("Dereference before null check")

Fixes: 4a61abb100c8 ("net-next/hinic:add rx checksum offload for HiNIC")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_port.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
index e9f76e904610..be2fdf3dfa87 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
@@ -414,14 +414,17 @@ int hinic_set_rx_csum_offload(struct hinic_dev *nic_dev, u32 en)
 {
 	struct hinic_checksum_offload rx_csum_cfg = {0};
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
-	struct hinic_hwif *hwif = hwdev->hwif;
-	struct pci_dev *pdev = hwif->pdev;
+	struct hinic_hwif *hwif;
+	struct pci_dev *pdev;
 	u16 out_size;
 	int err;
 
 	if (!hwdev)
 		return -EINVAL;
 
+	hwif = hwdev->hwif;
+	pdev = hwif->pdev;
+
 	rx_csum_cfg.func_id = HINIC_HWIF_FUNC_IDX(hwif);
 	rx_csum_cfg.rx_csum_offload = en;
 
-- 
2.19.1

