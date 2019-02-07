Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D0EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBB02175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qk42Ydko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBGVr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:47:27 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17684 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBGVr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:47:26 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5ca74d0000>; Thu, 07 Feb 2019 13:46:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 13:47:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 07 Feb 2019 13:47:25 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 21:47:25 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 7 Feb 2019 21:47:25 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.121]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5ca76d0000>; Thu, 07 Feb 2019 13:47:25 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <digetx@gmail.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V15 3/6] i2c: tegra: fix maximum transfer size
Date:   Thu, 7 Feb 2019 13:47:17 -0800
Message-ID: <1549576040-15907-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549576013; bh=RxKh1tL75blYbssNzu8yYwX8hZ44J6kqbGyfmMOUYJo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=qk42YdkojKo8h9lL81EiNvVyYoFcI3C93Mzigfv6bOQp5luJl/JQHQLRSblavp1V1
         5gTBIFtR251iiF59EJDUMAnU9sOVcqBrcXbHhw23iRM7q6u/xq3nTLKNEsYOq//yS9
         cwvuk4gqrpvH4Rgwjq5t/gJ4cRZahP43qxr+31kjPmBRCs1+ArxSkPRNfGSxODkJ6i
         367JdOjbt0cNKXF9A8fB2o8Elm+t0HYpZWAuTGrZPma21WJidUOGBytyab8NsIeX/k
         o/R0ypCyqSef9btNLTs1LbbQlFNN+AZdsH5cejUOKjAtWtrBlGCJNSJjPI4obrZyEN
         oHyJX5Y/+ACHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 supports maximum 64K bytes transfer per packet.
Tegra186 and prior supports maximum 4K bytes transfer per packet.
This includes 12 bytes of packet header.

This patch fixes max write length to account for packet header size
for transfers.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V15]	: This is new patch in this series.

 drivers/i2c/busses/i2c-tegra.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 3758c7a2c781..ab474cc86e0a 100644
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
@@ -900,11 +903,13 @@ static const struct i2c_algorithm tegra_i2c_algo = {
 static const struct i2c_adapter_quirks tegra_i2c_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
 	.max_read_len = 4096,
-	.max_write_len = 4096,
+	.max_write_len = 4096 - I2C_PACKET_HEADER_SIZE,
 };
 
 static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
+	.max_read_len = 65535,
+	.max_write_len = 65535 - I2C_PACKET_HEADER_SIZE,
 };
 
 static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
-- 
2.7.4

