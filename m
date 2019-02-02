Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E96C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E8B2084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="m2Nl8SXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfBBPwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:52:23 -0500
Received: from plaes.org ([188.166.43.21]:35760 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbfBBPwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:52:23 -0500
Received: from localhost (unknown [IPv6:2001:bb8:4008:ff:21a:64ff:fe97:f62])
        by plaes.org (Postfix) with ESMTPSA id 0279A4003E;
        Sat,  2 Feb 2019 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1549122741; bh=isQ1PNLGngLF+hkA36+pToonDFuNYA8D+QXexEq6xD8=;
        h=From:To:Cc:Subject:Date:From;
        b=m2Nl8SXMmVIiKz7p3W6cwLNNd+8uW9K3I1SyBY8lKgWj3Kvs3Q/Ixf3MstQuugfTU
         6CDzAcPxT/EKK8I5j+hOnYaY0FZKxsTaxs+YhavKZuAh5pcgJIWqzjqO3r4kemtCtd
         +KO4JUOs2IRrKgb97DphZYdPxryiLEOwt+rexboSHnozXZudSAdfzc8ShpVtKzaX+d
         LRCPfVkPF8qfXGhu3sdtUVcE524Os1DVPysM1xkFEmtm1UX0qXiVBLTtoY735sMJ/N
         pA7LhRjqdm4q+TABcLqqyHHliQ/2dd+GhSskzvJdqXMJNgWtmtkbXZY7q2hh5sb+dn
         E7VoRzWBcFSOA==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Priit Laes <plaes@plaes.org>
Subject: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for mmc2 clock
Date:   Sat,  2 Feb 2019 17:52:09 +0200
Message-Id: <20190202155209.31617-1-plaes@plaes.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent patch of improving MP clock rate calculations by taking
into account whether adjusting parent rate is allowed, have
unfortunately broken eMMC support on A20 Olinuxino-Lime2-eMMC
boards which fail with following error:

[snip]
EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
EXT4-fs (mmcblk1p4): write access will be enabled during recovery
sunxi-mmc 1c11000.mmc: data error, sending stop command
sunxi-mmc 1c11000.mmc: send stop command failed
[/snip]

Previously, mmc2 clock was requesting 520MHz and settling at 512MHz
clock rate with following parents:
[snip]
pll-ddr-base        2  2        0   768000000 0     0  50000
   pll-ddr-other    1  1        0   768000000 0     0  50000
      mmc2          0  0        0    51200000 0     0  50000
[/snip]

Now, after the improvements, requested and settled rate are both
520MHz, but as mmc2 clock cannot adjust parent rate, the situation
ends up like this:
[snip]
pll-periph-base     3  3        0  1200000000 0     0  50000
   pll-periph       6  6        0   600000000 0     0  50000
      mmc2          3  3        0    50000000 0     0  50000
[/snip]

With this patch (allowing mmc2 to set parent rate), we end up with
working tree with both mmc0 (sd-card) and mmc2 (eMMC) working:
[snip]
pll-periph-base     3  3        0   312000000 0     0  50000
   mbus             1  1        0    78000000 0     0  50000
   pll-periph-sata  1  1        0    26000000 0     0  50000
      sata          1  1        0    26000000 0     0  50000
   pll-periph       5  5        0   156000000 0     0  50000
      mmc2          0  0        0    52000000 0     0  50000
      mmc0          0  0        0    39000000 0     0  50000
[/snip]

Fixes: 3f790433c3cb ("clk: sunxi-ng: Adjust MP clock parent rate when allowed")
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index 129ebd2588fd..605e13b4ef90 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -498,7 +498,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mod0_default_parents, 0x090,
 				  16, 2,	/* P */
 				  24, 2,	/* mux */
 				  BIT(31),	/* gate */
-				  0);
+				  CLK_SET_RATE_PARENT);
 
 /* MMC output and sample clocks are not present on A10 */
 static SUNXI_CCU_PHASE(mmc2_output_clk, "mmc2_output", "mmc2",
-- 
2.11.0

