Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAC9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85652089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCN6OVUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85652089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbeKZV4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbeKZV4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FAA72089F;
        Mon, 26 Nov 2018 11:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230152;
        bh=uI6R94bC9cVV0856vDCMPip4AzeRZHG8NoXO1PEtDhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCN6OVUJP8ZDrZr3JlFdm3Rh0+zRqpADxajFYGPLXMAlPpRdwOXHL5YYHmAkc4Un6
         l8dhxrYSlHVOqbdTe7WoDd+0U6JY7cY49j1SN3xg/LfUQ0slwAKNjZ5ajvTlMHkx9n
         pxWKigt0v84OFMHvupghcUpbc2YYLflvQn79mtZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianxin Qin <jianxin.qin@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/118] clk: meson-axg: pcie: drop the mpll3 clock parent
Date:   Mon, 26 Nov 2018 11:50:21 +0100
Message-Id: <20181126105100.912940259@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 8cf74fc423e6..baabcf7c0a24 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -713,12 +713,14 @@ static struct clk_regmap axg_pcie_mux = {
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



