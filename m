Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05699C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32B920870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32B920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933738AbeGDIGd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:06:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39047 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbeGDIGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:06:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1faco0-0004Fs-89; Wed, 04 Jul 2018 08:06:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Aviad Krawczyk <aviad.krawczyk@huawei.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: hinic: remove redundant pointer pfhwdev
Date:   Wed,  4 Jul 2018 09:06:27 +0100
Message-Id: <20180704080627.16393-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer pfhwdev is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'pfhwdev' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
index 79b567447084..6b19607a4caa 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
@@ -264,7 +264,6 @@ static int init_fw_ctxt(struct hinic_hwdev *hwdev)
 	struct hinic_hwif *hwif = hwdev->hwif;
 	struct pci_dev *pdev = hwif->pdev;
 	struct hinic_cmd_fw_ctxt fw_ctxt;
-	struct hinic_pfhwdev *pfhwdev;
 	u16 out_size;
 	int err;
 
@@ -276,8 +275,6 @@ static int init_fw_ctxt(struct hinic_hwdev *hwdev)
 	fw_ctxt.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
 	fw_ctxt.rx_buf_sz = HINIC_RX_BUF_SZ;
 
-	pfhwdev = container_of(hwdev, struct hinic_pfhwdev, hwdev);
-
 	err = hinic_port_msg_cmd(hwdev, HINIC_PORT_CMD_FWCTXT_INIT,
 				 &fw_ctxt, sizeof(fw_ctxt),
 				 &fw_ctxt, &out_size);
-- 
2.17.1

