Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A01C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFB7222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894871;
	bh=MWuz8As0fElrjSqDzMxgqYltaiWXMlwVlmGeAtuAt7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AA2ln9AlqWkeF+jmnS8SQvpqesduHWDJLvEyGRSWeCKRCjwRSDEsfkbjq9kpjzbys
	 i2U8Hvgs8KC1zczYOU72T5e8/vC8qeTo0PzIsE/PMM8GSR0YYNHt1v/mVir8ofPE8F
	 NueUPPoVNWYejKZeeMI1RBuT4pTMbGYmKJj8yx9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfBKOVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:21:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbfBKOVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B50120838;
        Mon, 11 Feb 2019 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894866;
        bh=MWuz8As0fElrjSqDzMxgqYltaiWXMlwVlmGeAtuAt7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNgOTDTb6T2sIzuulpHa9UNPZGOqsqv0NP3xwBKzai7BL0hHo7t62BimiH69YxP51
         Lk/c56QRX7GEvmQtyHi9Pk5q5iHcBJ7M39W2FUadz1kWXa7sVPr+vXq2XTr0YO2W2W
         a0rSZz6LcenfdS2DScklZNXE22DM+rWz3GlTle00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 006/352] clk: sunxi-ng: h6: Set video PLLs limits
Date:   Mon, 11 Feb 2019 15:13:53 +0100
Message-Id: <20190211141846.888888662@linuxfoundation.org>
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

[ Upstream commit ed4433419d45bf8b58aef34c4450a27e1c8699e8 ]

Video PLL factors can be set in a way that final PLL rate is outside
stable range. H6 user manual specifically says that N factor should not
be below 12. While it doesn't says anything about maximum stable rate, it
is clear that PLL doesn't work at 6.096 GHz (254 * 24 MHz).

Set minimum allowed PLL video rate to 288 MHz (12 * 24 MHz) and maximum
to 2.4 GHz, which is maximum in BSP driver.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 2193e1495086..19ff09f610e4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -120,6 +120,8 @@ static struct ccu_nm pll_video0_clk = {
 	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
 	.fixed_post_div	= 4,
+	.min_rate	= 288000000,
+	.max_rate	= 2400000000UL,
 	.common		= {
 		.reg		= 0x040,
 		.features	= CCU_FEATURE_FIXED_POSTDIV,
@@ -136,6 +138,8 @@ static struct ccu_nm pll_video1_clk = {
 	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
 	.fixed_post_div	= 4,
+	.min_rate	= 288000000,
+	.max_rate	= 2400000000UL,
 	.common		= {
 		.reg		= 0x048,
 		.features	= CCU_FEATURE_FIXED_POSTDIV,
-- 
2.19.1



