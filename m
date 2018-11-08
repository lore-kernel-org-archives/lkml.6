Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FDBC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB7220818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQVu8NgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB7220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbeKIHmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731566AbeKIHml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:41 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42307208A3;
        Thu,  8 Nov 2018 22:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714711;
        bh=zWnltgflHGpdbFAxCfZC48y7rWUoO4iC0vArquteJ/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQVu8NgL+7xRx2vg9qIUJf0HePzTse3snGaXRRFTw0nt7NMoHOwZS9mMy9ZKKMmpH
         Mlp5iPlMdeaDmCpaHTRNZVE6fzmH9DPswgxGTWjNWBWClmqjRnphhbYTMvw8dXBcrw
         0lVxEA7dhyxX6XF59c8aUeAgo3M3vGByhd8G5P+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 082/171] clk: samsung: Fix m2m scaler clock on Exynos542x
Date:   Thu,  8 Nov 2018 13:50:52 -0800
Message-Id: <20181108215133.456439356@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c07c1a0f68d0f2f7ca9aff924e2772526027b019 ]

The TOP "aclk400_mscl" clock should be kept enabled all the time
to allow proper access to power management control for MSC power
domain and devices that are a part of it. This change is required
for the scaler to work properly after domain power on/off sequence.

Fixes: 318fa46cc60d ("clk/samsung: exynos542x: mark some clocks as critical")
Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-exynos5420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index cdc092a1d9ef..07fb667e258f 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -987,7 +987,7 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 	GATE(0, "aclk400_isp", "mout_user_aclk400_isp",
 			GATE_BUS_TOP, 16, 0, 0),
 	GATE(0, "aclk400_mscl", "mout_user_aclk400_mscl",
-			GATE_BUS_TOP, 17, 0, 0),
+			GATE_BUS_TOP, 17, CLK_IS_CRITICAL, 0),
 	GATE(0, "aclk200_disp1", "mout_user_aclk200_disp1",
 			GATE_BUS_TOP, 18, CLK_IS_CRITICAL, 0),
 	GATE(CLK_SCLK_MPHY_IXTAL24, "sclk_mphy_ixtal24", "mphy_refclk_ixtal24",
-- 
2.17.1



