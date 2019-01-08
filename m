Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D734C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0FD205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976218;
	bh=AS0Lcg7EUjrAApw8R/DxVov4SQKgnyGsifYuACuYiGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IzMLsNhemh0OMPckMvSUtiF84jxyE77SZqTrkfEay7rICjsvuYUmLHwbpSHd/EjSX
	 BZr4VxcihwdOUojCn2kL4PpUErXyONkuvjbEcwTByw41CRVVu2wbClnmPO05Av7mem
	 VwovNZCggEEAYbYZGnAaVPx0niOQsZ/AQOTJRhCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbfAHTg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:36:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732356AbfAHTfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:35:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5779B20645;
        Tue,  8 Jan 2019 19:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976145;
        bh=AS0Lcg7EUjrAApw8R/DxVov4SQKgnyGsifYuACuYiGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIFMd3xoKwNJJRWzR0jjBNErm/phlvNkIKQjEmq9l6jFkwcF3nhMdaufaJWNWIimR
         IYmriVBHuCp6AAWfToJuTur1nRfcEs8N2pO4ql6F5QVS7aTvQIieiSD9ViD0BWhmPI
         qM6l59adwDCKJNNSlXz5cbo6nanSguoCA9x+tbGk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 09/19] clk: imx6q: reset exclusive gates on init
Date:   Tue,  8 Jan 2019 14:35:21 -0500
Message-Id: <20190108193534.124555-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193534.124555-1-sashal@kernel.org>
References: <20190108193534.124555-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit f7542d817733f461258fd3a47d77da35b2d9fc81 ]

The exclusive gates may be set up in the wrong way by software running
before the clock driver comes up. In that case the exclusive setup is
locked in its initial state, as the complementary function can't be
activated without disabling the initial setup first.

To avoid this lock situation, reset the exclusive gates to the off
state and allow the kernel to provide the proper setup.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Dong Aisheng <Aisheng.dong@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-imx/clk-imx6q.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 5474a76803f0..936ed9bae595 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -222,8 +222,12 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	 * lvds1_gate and lvds2_gate are pseudo-gates.  Both can be
 	 * independently configured as clock inputs or outputs.  We treat
 	 * the "output_enable" bit as a gate, even though it's really just
-	 * enabling clock output.
+	 * enabling clock output. Initially the gate bits are cleared, as
+	 * otherwise the exclusive configuration gets locked in the setup done
+	 * by software running before the clock driver, with no way to change
+	 * it.
 	 */
+	writel(readl(base + 0x160) & ~0x3c00, base + 0x160);
 	clk[IMX6QDL_CLK_LVDS1_GATE] = imx_clk_gate_exclusive("lvds1_gate", "lvds1_sel", base + 0x160, 10, BIT(12));
 	clk[IMX6QDL_CLK_LVDS2_GATE] = imx_clk_gate_exclusive("lvds2_gate", "lvds2_sel", base + 0x160, 11, BIT(13));
 
-- 
2.19.1

