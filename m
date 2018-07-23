Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B7FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8C120880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8C120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389732AbeGWNsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbeGWNsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:17 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6B60BBB3;
        Mon, 23 Jul 2018 12:47:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <dev@lynxeye.de>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 4.4 101/107] clk: tegra: Fix PLL_U post divider and initial rate on Tegra30
Date:   Mon, 23 Jul 2018 14:42:35 +0200
Message-Id: <20180723122418.571880390@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <dev@lynxeye.de>

commit 797097301860c64b63346d068ba4fe4992bd5021 upstream.

The post divider value in the frequency table is wrong as it would lead
to the PLL producing an output rate of 960 MHz instead of the desired
480 MHz. This wasn't a problem as nothing used the table to actually
initialize the PLL rate, but the bootloader configuration was used
unaltered.

If the bootloader does not set up the PLL it will fail to come when used
under Linux. To fix this don't rely on the bootloader, but set the
correct rate in the clock driver.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
[jonathanh@nvidia.com: Back-ported to stable v4.4.y]
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/tegra/clk-tegra30.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -333,11 +333,11 @@ static struct pdiv_map pllu_p[] = {
 };
 
 static struct tegra_clk_pll_freq_table pll_u_freq_table[] = {
-	{ 12000000, 480000000, 960, 12, 0, 12},
-	{ 13000000, 480000000, 960, 13, 0, 12},
-	{ 16800000, 480000000, 400, 7,  0, 5},
-	{ 19200000, 480000000, 200, 4,  0, 3},
-	{ 26000000, 480000000, 960, 26, 0, 12},
+	{ 12000000, 480000000, 960, 12, 2, 12 },
+	{ 13000000, 480000000, 960, 13, 2, 12 },
+	{ 16800000, 480000000, 400,  7, 2,  5 },
+	{ 19200000, 480000000, 200,  4, 2,  3 },
+	{ 26000000, 480000000, 960, 26, 2, 12 },
 	{ 0, 0, 0, 0, 0, 0 },
 };
 
@@ -1372,6 +1372,7 @@ static struct tegra_clk_init_table init_
 	{TEGRA30_CLK_GR2D, TEGRA30_CLK_PLL_C, 300000000, 0},
 	{TEGRA30_CLK_GR3D, TEGRA30_CLK_PLL_C, 300000000, 0},
 	{TEGRA30_CLK_GR3D2, TEGRA30_CLK_PLL_C, 300000000, 0},
+	{ TEGRA30_CLK_PLL_U, TEGRA30_CLK_CLK_MAX, 480000000, 0 },
 	{TEGRA30_CLK_CLK_MAX, TEGRA30_CLK_CLK_MAX, 0, 0}, /* This MUST be the last entry. */
 };
 


