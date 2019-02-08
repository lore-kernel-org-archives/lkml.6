Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AE1C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEBD2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kSRW5iB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfBHS7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:59:51 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9150 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfBHS7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:59:48 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5dd1900000>; Fri, 08 Feb 2019 10:59:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 10:59:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 Feb 2019 10:59:47 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 18:59:47 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 8 Feb 2019 18:59:47 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.121]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5dd1a20004>; Fri, 08 Feb 2019 10:59:47 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <wsa@the-dreams.de>, <peda@axentia.se>, <digetx@gmail.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        <stable@vger.kernel.org>
Subject: [PATCH V18 3/6] i2c: tegra: fix maximum transfer size
Date:   Fri, 8 Feb 2019 10:59:39 -0800
Message-ID: <1549652382-5476-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
References: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549652368; bh=Iy0n9Z/yzTpMsna10ucNoS7HcMqr3r6IBebGqyEoUt8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kSRW5iB4HbyjPaFGdmvIOVPXJ94MbLHX0B80ix6L1pVBeXsQbH1t584yj87b1Y3S8
         bKXlCntAh+YHivhh19jtAQc8y2g/LBa33swyccBtDJUgIfOyF9g/YXi2DJRUnLWGd9
         Mp8OjxqW7fd2m1SV3kJw+T5qp6l0mtbQh36mWHVD+lalXrV1Bk4WS1oXN5lpW22QFV
         rOvBioibJABNdsLIGEFV3GwxoG+BeNv567BJhG/dQI2Ca8YQQb32pzbmhop16eMTSs
         gMLWsSAa3vFVtfeuYoYffWMkDpiIBbB/lom7dY5WKXOscYElJrMNFwtqPBLPy7oFex
         5p121ZuZy0Xcw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 supports maximum 64K bytes transfer per packet.
Tegra186 and prior supports maximum 4K bytes transfer per packet.
This includes 12 bytes of packet header and this limit is
applicable irrespective of PIO or DMA mode transfers.

This patch fixes max write length to account for packet header size
for transfers.

Cc: stable@vger.kernel.org

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V18] 	: Using Max of SZ_64K (65536) size for dma buffer instead of 65535
 [V16/V17] : I2C core max message size is 65535. So, max_read_len of 65535 is NOP.
	  Removed it leaving max_write_len
 [V15]	: This is new patch in this series.


 drivers/i2c/busses/i2c-tegra.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 3758c7a2c781..08bdefd2810e 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -125,6 +125,9 @@
 #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
 #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
 
+/* Packet header size in bytes */
+#define I2C_PACKET_HEADER_SIZE			12
+
 /*
  * msg_end_type: The bus control which need to be send at end of transfer.
  * @MSG_END_STOP: Send stop pulse at end of transfer.
@@ -899,12 +902,13 @@ static const struct i2c_algorithm tegra_i2c_algo = {
 /* payload size is only 12 bit */
 static const struct i2c_adapter_quirks tegra_i2c_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
-	.max_read_len = 4096,
-	.max_write_len = 4096,
+	.max_read_len = SZ_4K,
+	.max_write_len = SZ_4K - I2C_PACKET_HEADER_SIZE,
 };
 
 static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
+	.max_write_len = SZ_64K - I2C_PACKET_HEADER_SIZE,
 };
 
 static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
-- 
2.7.4

