Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945D0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8C220684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BxDZW0S+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8C220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeIZSkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:40:39 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12113 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbeIZSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:40:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bab7b260000>; Wed, 26 Sep 2018 05:27:18 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Sep 2018 05:27:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Sep 2018 05:27:53 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Sep
 2018 12:27:53 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Sep 2018 12:27:53 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.143]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bab7b470000>; Wed, 26 Sep 2018 05:27:53 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 4/5] soc/tegra: pmc: Don't power-up XUSB power-domains
Date:   Wed, 26 Sep 2018 13:27:37 +0100
Message-ID: <1537964858-30332-5-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537964858-30332-1-git-send-email-jonathanh@nvidia.com>
References: <1537964858-30332-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1537964838; bh=qy5cYZy2tUNDZUCDXLLRF30Px9H2650Lc8nDv7ApZRE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=BxDZW0S+F3UjFLXDZ/fnzBt78BEHLaHALlIifLn4heeI0p/9LqmTry1tMZ7j7XZHf
         eZmthZUICt7ALTKZX2kFRQPoSemUXwF3SljcrjxbkBYSvVXnapfXtMrlIOOI6ttyfn
         HQJ0+rvYBtlLxzA++Lj8E8SPxyTc906JURshJR9LPvascX4K0vsDBYzO5n2kDdNR+7
         X1VHWzCyhNNa4/l2oTO2REJ7E6fG/XY71rIwhhRh/Fs3Jxs2/zL89MOcxCFJjp1GEU
         BdOE4JBGB3xZ1A+Omcf+W5L0YrSV7a2RPTCpmb7t2VVQjK/fewrzCKUSIDCx6aKCxT
         a6u6tlEOPfQEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the Tegra xHCI driver manages the XUSB power-domains itself,
remove the code to power-up the power-domains used by the xHCI device
from the PMC driver on boot.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ab719fa90150..a68b4476b4ee 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -847,22 +847,6 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 		goto remove_resets;
 	}
 
-	/*
-	 * FIXME: If XHCI is enabled for Tegra, then power-up the XUSB
-	 * host and super-speed partitions. Once the XHCI driver
-	 * manages the partitions itself this code can be removed. Note
-	 * that we don't register these partitions with the genpd core
-	 * to avoid it from powering down the partitions as they appear
-	 * to be unused.
-	 */
-	if (IS_ENABLED(CONFIG_USB_XHCI_TEGRA) &&
-	    (id == TEGRA_POWERGATE_XUSBA || id == TEGRA_POWERGATE_XUSBC)) {
-		if (off)
-			WARN_ON(tegra_powergate_power_up(pg, true));
-
-		goto remove_resets;
-	}
-
 	err = pm_genpd_init(&pg->genpd, NULL, off);
 	if (err < 0) {
 		pr_err("failed to initialise PM domain %s: %d\n", np->name,
-- 
2.7.4

