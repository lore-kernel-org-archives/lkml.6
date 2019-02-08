Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E106EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D1120863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="G99fghsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfBHRuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:50:05 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11948 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfBHRuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:50:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5dc12a0001>; Fri, 08 Feb 2019 09:49:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 09:50:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 Feb 2019 09:50:03 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 17:50:02 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 8 Feb 2019 17:50:02 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.121]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5dc14a0000>; Fri, 08 Feb 2019 09:50:02 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <wsa@the-dreams.de>, <peda@axentia.se>, <digetx@gmail.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        <stable@vger.kernel.org>
Subject: [PATCH V17 3/6] i2c: tegra: fix maximum transfer size
Date:   Fri, 8 Feb 2019 09:49:52 -0800
Message-ID: <1549648195-3989-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549648195-3989-1-git-send-email-skomatineni@nvidia.com>
References: <1549648195-3989-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549648170; bh=IOeL4vhcG5RAeJwHes+FWsw6zoW6MyaTU8Aw9vMZTNg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=G99fghsB2HIWPR8paWFQUinkdg3TtFvj4W7pUNrRQBd8e5epS1XrpbIDJ4raXoi2s
         ntuLC+lBLQbLiwLn3N3AF+74O9fSylCD206faINOf0SQnH4STq3Bz9ay+Z3FCsF38o
         cHqIzdz3ieotOcbRLtW+SFgpelSTMZ/+3QUJGPRmpGS2ETHtoO6Dv8QbILOuSDrfPl
         FUr53KgJ+U162uMlUAk4fkV7lJ0rqrZGRi5gy3tMVr2x211HooDJfUFqDwiPftIBLB
         moIhSAvIAkiW3tj/vhpaibX8XVQjf/0mNPLtFpbYaptFtlmxasRFpHtOgcjkIqOuHw
         ErJHiS30HDfqw==
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

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V16/V17] : I2C core max message size is 65536. So, max_read_len of 65535 is NOP.
	  Removed it leaving max_write_len
 [V15]	: This is new patch in this series.


 drivers/i2c/busses/i2c-tegra.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 3758c7a2c781..e4bf85e8dc14 100644
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
+	.max_write_len = 65535 - I2C_PACKET_HEADER_SIZE,
 };
 
 static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
-- 
2.7.4

