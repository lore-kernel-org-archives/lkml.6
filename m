Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954C9222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kFnGwnhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfBPQdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 11:33:11 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5388 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfBPQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 11:33:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c683b200000>; Sat, 16 Feb 2019 08:32:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 16 Feb 2019 08:33:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 16 Feb 2019 08:33:09 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 16 Feb
 2019 16:33:09 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Sat, 16 Feb 2019 16:33:09 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.150]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c683b430001>; Sat, 16 Feb 2019 08:33:08 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>
CC:     <wsa@the-dreams.de>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>
Subject: [PATCH V1] i2c: tegra: fix tegra186 hw supported features
Date:   Sat, 16 Feb 2019 08:33:07 -0800
Message-ID: <1550334787-27703-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550334753; bh=FCGvePV8fcmwsXS9Dvc+k147k+2e/qxrSyDCs009Jy8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=kFnGwnhXzdXfWCPJFoBGdhBB5hvIWhTZykXl6gf1haN723oO1lvL57KB/1j9KRdN8
         ovKROH3R93EBfRln4ghvSAQ+ZuEWpKmm6grOirvLO+BEdRpBs5egiGsvaDcPpmW5+L
         ePseR6NbMoi5An7nKNuLCN4Phbi9uidcPRGwXj7Dm8FfYh5L/S0C2k+VH/wvaW+aIt
         yx7hbHme0+4leOXyYVIDZu0r4fvmXBNfuAil2sFPianKIVuklmFzX5ctTXU/8lcavz
         sLEaSnNJXIL4IkF/0/b0uvhkxjxpTGJ8FbrGWSWTqQkQDBPbYpTSYwmEj41rWvT4bR
         ux5VxGesnFEsw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 does not support multi-master mode and also there is no
master fifo control register.

This patch fixes supported features of Tegra186 and prevents
crashing during boot as master fifo control register are not
present on Tegra186 and prior.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index a4cd79c9f7a7..24c206db70a4 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1434,9 +1434,9 @@ static const struct tegra_i2c_hw_feature tegra186_i2c_hw = {
 	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
-	.has_multi_master_mode = true,
+	.has_multi_master_mode = false,
 	.has_slcg_override_reg = true,
-	.has_mst_fifo = true,
+	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
 	.has_apb_dma = false,
-- 
2.7.4

