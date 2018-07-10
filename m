Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3790DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0CC208F7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0CC208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933427AbeGJMsq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:48:46 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18454 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933399AbeGJMso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:48:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b44ab270000>; Tue, 10 Jul 2018 05:48:39 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 10 Jul 2018 05:48:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 10 Jul 2018 05:48:43 -0700
Received: from dhcp-10-21-25-168.Nvidia.com (10.21.25.201) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Tue, 10 Jul 2018 12:48:41 +0000
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     Aapo Vienamo <avienamo@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] soc/tegra: pmc: Implement tegra_io_pad_is_powered()
Date:   Tue, 10 Jul 2018 15:47:56 +0300
Message-ID: <1531226879-11802-4-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531226879-11802-1-git-send-email-avienamo@nvidia.com>
References: <1531226879-11802-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a function to query whether a pad is in deep power down mode.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 17 +++++++++++++++++
 include/soc/tegra/pmc.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 83b39cd..3f5b69fd 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1075,6 +1075,23 @@ int tegra_io_pad_power_disable(enum tegra_io_pad id)
 }
 EXPORT_SYMBOL(tegra_io_pad_power_disable);
 
+int tegra_io_pad_is_powered(enum tegra_io_pad id)
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
+EXPORT_SYMBOL(tegra_io_pad_is_powered);
+
 int tegra_io_pad_set_voltage(enum tegra_io_pad id,
 			     enum tegra_io_pad_voltage voltage)
 {
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index c32bf91..f88c6e2 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -162,6 +162,7 @@ int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
 
 int tegra_io_pad_power_enable(enum tegra_io_pad id);
 int tegra_io_pad_power_disable(enum tegra_io_pad id);
+int tegra_io_pad_is_powered(enum tegra_io_pad id);
 int tegra_io_pad_set_voltage(enum tegra_io_pad id,
 			     enum tegra_io_pad_voltage voltage);
 int tegra_io_pad_get_voltage(enum tegra_io_pad id);
-- 
2.7.4

