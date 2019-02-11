Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2056BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B1D2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895037;
	bh=EWHTQJ4qCk4trEDNVL6G+bYuB14mDOVJ1gpx2DlQHhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e2NWFUsd2yNoxbGtx2vax1/ZeYR3lvF8sKj2tC5iYH08qEfqgb5rlVrR6xfGVhWf3
	 cwgIxNeuGsLXbXHitreTni0NjSpz3YmTPz5r6USmjRf7w/UveavUy7mmklwo2ubYoA
	 NnOZxOBqm23X1Hg6VCb+WV3pOi0JYu34F/iXbeX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfBKOXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfBKOXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:23:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE5BE205C9;
        Mon, 11 Feb 2019 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895032;
        bh=EWHTQJ4qCk4trEDNVL6G+bYuB14mDOVJ1gpx2DlQHhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z9/TFc3RR0R+8CfXOo66eCbfOGandgqk4zgAuDz9bkHJYq812Aw+NsgDdg8Lc9bUw
         9Ic8U60uCjFKY21J9jzMv+FNGWSUtGd+bdtP0XSMCqdi3CLVPggk6UR/4cBro/jrFt
         TFi5iVzx1f45kY4SNnd9nco+267qHvEfdYrDcu9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 068/352] clk: meson: meson8b: fix the width of the cpu_scale_div clock
Date:   Mon, 11 Feb 2019 15:14:55 +0100
Message-Id: <20190211141850.431876133@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a8662eadd1032018f31e37deda811790b2326662 ]

According to the public S805 datasheet HHI_SYS_CPU_CLK_CNTL1[29:20] is
the register for the CPU scale_div clock. This matches the code in
Amlogic's 3.10 GPL kernel sources:
N = (aml_read_reg32(P_HHI_SYS_CPU_CLK_CNTL1) >> 20) & 0x3FF;

This means that the divider register is 10 bit wide instead of 9 bits.
So far this is not a problem since all u-boot versions I have seen are
not using the cpu_scale_div clock at all (instead they are configuring
the CPU clock to run off cpu_in_sel directly).

The fixes tag points to the latest rework of the CPU clocks. However,
even before the rework it was wrong. Commit 7a29a869434e8b ("clk: meson:
Add support for Meson clock controller") defines MESON_N_WIDTH as 9 (in
drivers/clk/meson/clk-cpu.c). But since the old clk-cpu implementation
this only carries the fixes tag for the CPU clock rewordk.

Fixes: 251b6fd38bcb9c ("clk: meson: rework meson8b cpu clock")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lkml.kernel.org/r/20180927085921.24627-3-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 328fcf50d9e8..9160a3b2e668 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -599,7 +599,7 @@ static struct clk_regmap meson8b_cpu_scale_div = {
 	.data = &(struct clk_regmap_div_data){
 		.offset =  HHI_SYS_CPU_CLK_CNTL1,
 		.shift = 20,
-		.width = 9,
+		.width = 10,
 		.table = cpu_scale_table,
 		.flags = CLK_DIVIDER_ALLOW_ZERO,
 	},
-- 
2.19.1



