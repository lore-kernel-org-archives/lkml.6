Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEFAC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A022087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JFLYTlis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A022087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLCK3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:29:25 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12055 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLCK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:29:24 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c0505690000>; Mon, 03 Dec 2018 02:28:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Dec 2018 02:28:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Dec 2018 02:28:57 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Dec
 2018 10:28:57 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Dec
 2018 10:28:56 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 10:28:56 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.11.194]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c0505660000>; Mon, 03 Dec 2018 02:28:56 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>
CC:     <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH 2/2] clk: tegra30: Use Tegra CPU powergate helper function
Date:   Mon, 3 Dec 2018 10:28:41 +0000
Message-ID: <1543832921-11661-2-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543832921-11661-1-git-send-email-jonathanh@nvidia.com>
References: <1543832921-11661-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543832937; bh=Nf8TdHPJznc3Bv0GPyY2wAgrS6nktrQG6QPsnThAx/0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=JFLYTlisa/TJ7bX8fEa7gJG6rFHrG7cHCTTbvPoU7tYjVMc5vdn6L7sTGfvtA9oyl
         Wn3KoAb/tkS0OAVMcLSLrl8/1YXcPGk+Y+ssdBnMYXc06dJ7n8HTUVeeaBrqjX5lKj
         5eqDw3l0e1oAbnZ34Q61vpTRP3ElVi0PxB6kuKPBY2WeZHgIzJobpAQy3QHvSV62H7
         q6t9wEJAv6U4dcuXlFbpKGKcQLRgzWGYG1hr8qUm8+8jqJvh5Lhel/UNwkEom26UBY
         f5ybp1bQfrA/dlXez9pD7s4dhVmu3vu/OfW7dwUeeDRFkBDXMR5ZA6hrDPl/OtBP9d
         2n5OcBwG89qzQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than using the tegra_powergate_is_powered() function for
determining if a CPU is powered, use the tegra_pmc_cpu_is_powered()
instead which was created to get the CPU power status. Internally
tegra_pmc_cpu_is_powered() calls tegra_powergate_is_powered() and so
is equivalent.

The Tegra30 clock driver is the only public user of
tegra_powergate_is_powered() and so by updating the Tegra30 clock
driver to use tegra_pmc_cpu_is_powered(), we can then make
tegra_powergate_is_powered() a non-public function.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
Resending with Thierry's ACK and CC'ing clock maintainers.

drivers/clk/tegra/clk-tegra30.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index e0aaecd98fbf..fa8d573ac626 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1148,9 +1148,9 @@ static bool tegra30_cpu_rail_off_ready(void)
 
 	cpu_rst_status = readl(clk_base +
 				TEGRA30_CLK_RST_CONTROLLER_CPU_CMPLX_STATUS);
-	cpu_pwr_status = tegra_powergate_is_powered(TEGRA_POWERGATE_CPU1) ||
-			 tegra_powergate_is_powered(TEGRA_POWERGATE_CPU2) ||
-			 tegra_powergate_is_powered(TEGRA_POWERGATE_CPU3);
+	cpu_pwr_status = tegra_pmc_cpu_is_powered(1) ||
+			 tegra_pmc_cpu_is_powered(2) ||
+			 tegra_pmc_cpu_is_powered(3);
 
 	if (((cpu_rst_status & 0xE) != 0xE) || cpu_pwr_status)
 		return false;
-- 
2.7.4

