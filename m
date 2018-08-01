Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9362BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45ACA20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45ACA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390318AbeHATHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:07:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49254 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389699AbeHATHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:07:44 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D2ABFCE6;
        Wed,  1 Aug 2018 17:21:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 184/246] memory: tegra: Apply interrupts mask per SoC
Date:   Wed,  1 Aug 2018 18:51:34 +0200
Message-Id: <20180801165020.526445411@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 1c74d5c0de0c2cc29fef97a19251da2ad6f579bd ]

Currently we are enabling handling of interrupts specific to Tegra124+
which happen to overlap with previous generations. Let's specify
interrupts mask per SoC generation for consistency and in a preparation
of squashing of Tegra20 driver into the common one that will enable
handling of GART faults which may be undesirable by newer generations.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/memory/tegra/mc.c       |   21 +++------------------
 drivers/memory/tegra/mc.h       |    9 +++++++++
 drivers/memory/tegra/tegra114.c |    2 ++
 drivers/memory/tegra/tegra124.c |    6 ++++++
 drivers/memory/tegra/tegra210.c |    3 +++
 drivers/memory/tegra/tegra30.c  |    2 ++
 include/soc/tegra/mc.h          |    2 ++
 7 files changed, 27 insertions(+), 18 deletions(-)

--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -20,14 +20,6 @@
 #include "mc.h"
 
 #define MC_INTSTATUS 0x000
-#define  MC_INT_DECERR_MTS (1 << 16)
-#define  MC_INT_SECERR_SEC (1 << 13)
-#define  MC_INT_DECERR_VPR (1 << 12)
-#define  MC_INT_INVALID_APB_ASID_UPDATE (1 << 11)
-#define  MC_INT_INVALID_SMMU_PAGE (1 << 10)
-#define  MC_INT_ARBITRATION_EMEM (1 << 9)
-#define  MC_INT_SECURITY_VIOLATION (1 << 8)
-#define  MC_INT_DECERR_EMEM (1 << 6)
 
 #define MC_INTMASK 0x004
 
@@ -248,13 +240,11 @@ static const char *const error_names[8]
 static irqreturn_t tegra_mc_irq(int irq, void *data)
 {
 	struct tegra_mc *mc = data;
-	unsigned long status, mask;
+	unsigned long status;
 	unsigned int bit;
 
 	/* mask all interrupts to avoid flooding */
-	mask = mc_readl(mc, MC_INTMASK);
-	status = mc_readl(mc, MC_INTSTATUS) & mask;
-
+	status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
 	if (!status)
 		return IRQ_NONE;
 
@@ -349,7 +339,6 @@ static int tegra_mc_probe(struct platfor
 	const struct of_device_id *match;
 	struct resource *res;
 	struct tegra_mc *mc;
-	u32 value;
 	int err;
 
 	match = of_match_node(tegra_mc_of_match, pdev->dev.of_node);
@@ -417,11 +406,7 @@ static int tegra_mc_probe(struct platfor
 
 	WARN(!mc->soc->client_id_mask, "Missing client ID mask for this SoC\n");
 
-	value = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
-		MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
-		MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM;
-
-	mc_writel(mc, value, MC_INTMASK);
+	mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
 	return 0;
 }
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -14,6 +14,15 @@
 
 #include <soc/tegra/mc.h>
 
+#define MC_INT_DECERR_MTS (1 << 16)
+#define MC_INT_SECERR_SEC (1 << 13)
+#define MC_INT_DECERR_VPR (1 << 12)
+#define MC_INT_INVALID_APB_ASID_UPDATE (1 << 11)
+#define MC_INT_INVALID_SMMU_PAGE (1 << 10)
+#define MC_INT_ARBITRATION_EMEM (1 << 9)
+#define MC_INT_SECURITY_VIOLATION (1 << 8)
+#define MC_INT_DECERR_EMEM (1 << 6)
+
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
 {
 	return readl(mc->regs + offset);
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -930,4 +930,6 @@ const struct tegra_mc_soc tegra114_mc_so
 	.atom_size = 32,
 	.client_id_mask = 0x7f,
 	.smmu = &tegra114_smmu_soc,
+	.intmask = MC_INT_INVALID_SMMU_PAGE | MC_INT_SECURITY_VIOLATION |
+		   MC_INT_DECERR_EMEM,
 };
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1020,6 +1020,9 @@ const struct tegra_mc_soc tegra124_mc_so
 	.smmu = &tegra124_smmu_soc,
 	.emem_regs = tegra124_mc_emem_regs,
 	.num_emem_regs = ARRAY_SIZE(tegra124_mc_emem_regs),
+	.intmask = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 };
 #endif /* CONFIG_ARCH_TEGRA_124_SOC */
 
@@ -1042,5 +1045,8 @@ const struct tegra_mc_soc tegra132_mc_so
 	.atom_size = 32,
 	.client_id_mask = 0x7f,
 	.smmu = &tegra132_smmu_soc,
+	.intmask = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 };
 #endif /* CONFIG_ARCH_TEGRA_132_SOC */
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -1077,4 +1077,7 @@ const struct tegra_mc_soc tegra210_mc_so
 	.atom_size = 64,
 	.client_id_mask = 0xff,
 	.smmu = &tegra210_smmu_soc,
+	.intmask = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 };
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -952,4 +952,6 @@ const struct tegra_mc_soc tegra30_mc_soc
 	.atom_size = 16,
 	.client_id_mask = 0x7f,
 	.smmu = &tegra30_smmu_soc,
+	.intmask = MC_INT_INVALID_SMMU_PAGE | MC_INT_SECURITY_VIOLATION |
+		   MC_INT_DECERR_EMEM,
 };
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -99,6 +99,8 @@ struct tegra_mc_soc {
 	u8 client_id_mask;
 
 	const struct tegra_smmu_soc *smmu;
+
+	u32 intmask;
 };
 
 struct tegra_mc {


