Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52404ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BA7206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BA7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbeGTLrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:47:11 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12052 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbeGTLrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:47:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b51c08a0000>; Fri, 20 Jul 2018 03:59:22 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 20 Jul 2018 03:59:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 20 Jul 2018 03:59:28 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 20 Jul
 2018 10:59:27 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 20 Jul 2018 10:59:28 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b51c08e0000>; Fri, 20 Jul 2018 03:59:28 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
CC:     Aapo Vienamo <avienamo@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/7] soc/tegra: pmc: Implement tegra_io_pad_is_powered()
Date:   Fri, 20 Jul 2018 13:59:11 +0300
Message-ID: <1532084355-31482-4-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532084355-31482-1-git-send-email-avienamo@nvidia.com>
References: <1532084355-31482-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a function to query whether a pad is in deep power down mode.
This will is needed by the pinctrl callbacks.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 393ca72..784c182 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1075,6 +1075,22 @@ int tegra_io_pad_power_disable(enum tegra_io_pad id)
 }
 EXPORT_SYMBOL(tegra_io_pad_power_disable);
 
+static int tegra_io_pad_is_powered(enum tegra_io_pad id)
+{
+	unsigned long request, status;
+	u32 mask;
+	u32 value;
+	int err;
+
+	err = tegra_io_pad_get_dpd_register_bit(id, &request, &status, &mask);
+	if (err)
+		return err;
+
+	value = tegra_pmc_readl(status);
+
+	return !(value & mask);
+}
+
 int tegra_io_pad_set_voltage(enum tegra_io_pad id,
 			     enum tegra_io_pad_voltage voltage)
 {
-- 
2.7.4

