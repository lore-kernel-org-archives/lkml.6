Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB6AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054142082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr2VrJEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054142082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbeKMPrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731427AbeKMPrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:02 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E17922512;
        Tue, 13 Nov 2018 05:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088235;
        bh=UuUHSKkdjTsKtFuVjWmhFt6iCKBBr/7GenZ5RUuNggk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lr2VrJEf87Hfu3mYLnIOmCJXC7jO1Ud5jJU0NHa1pdWX8m8K4ZKKLrGHSwW6TO6C5
         OFMz7BZZOAgUidMXdQIqijB8XKRBUXzjN/LwUK72wL9JMYAmAcSRysbxBTVoDUpO2K
         qH9QD2B6uTWA/P6CPjKSXuJMZvekdOEhpnis8SAs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 31/44] clk: meson-axg: pcie: drop the mpll3 clock parent
Date:   Tue, 13 Nov 2018 00:49:37 -0500
Message-Id: <20181113054950.77898-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113054950.77898-1-sashal@kernel.org>
References: <20181113054950.77898-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yixun Lan <yixun.lan@amlogic.com>

[ Upstream commit 69b93104c7ec5668019caf5d2dbfd0e182df06db ]

We found the PCIe driver doesn't really work with
the mpll3 clock which is actually reserved for debug,
So drop it from the mux list.

Fixes: 33b89db68236 ("clk: meson-axg: add clocks required by pcie driver")
Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/axg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 00ce62ad6416..a95152071087 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -700,12 +700,14 @@ static struct clk_regmap axg_pcie_mux = {
 		.offset = HHI_PCIE_PLL_CNTL6,
 		.mask = 0x1,
 		.shift = 2,
+		/* skip the parent mpll3, reserved for debug */
+		.table = (u32[]){ 1 },
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "pcie_mux",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ "mpll3", "pcie_pll" },
-		.num_parents = 2,
+		.parent_names = (const char *[]){ "pcie_pll" },
+		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
-- 
2.17.1

