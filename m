Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EF6C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8D720881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697962;
	bh=9+xFrBKnLhnCrq8hNwyS1xybdnWKmpBli2oJfvmYdHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IeYZ3/vOMKW9zUipSkP2IkRTjZzqujggWa6xnR3hUjfRIeTt59OKycxZU5/MzqYuS
	 MZHX+HTZZxGlYcQXDTMcwRyhfzHAM25rWOBDyY47NpISlzv0Z/XuRbkv+mukirjnOM
	 C/N6ptjmSdudeSCxIAHJh+o1o0iuloCv4vR9iZTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfA1Rwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfA1Pnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:43:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 160B82171F;
        Mon, 28 Jan 2019 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690228;
        bh=9+xFrBKnLhnCrq8hNwyS1xybdnWKmpBli2oJfvmYdHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6EEbu57NY2VFeP52ZXdYAjZr1+3oSzu3Mh3K6CEgek0pfG1m5TIWCx0EzcSaHp9V
         dNA9aR0Mjqs51a52JPMO9D6oQRlLHiEYydELps3FwNRoCPAMg3faxNt1MZesdHJX1i
         w460FqP/WV9pRFVkJihbW00Wrk1Z1eCXVHqRfp5A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 006/304] clk: sunxi-ng: h6: Set video PLLs limits
Date:   Mon, 28 Jan 2019 10:38:43 -0500
Message-Id: <20190128154341.47195-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

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

