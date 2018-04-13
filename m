Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754741AbeDMLhd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:37:33 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33912 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754105AbeDMLgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:36:10 -0400
X-Google-Smtp-Source: AIpwx48eCu+UXQBh0RstOHmIoArGButQahwe7wv+8jzN+EvGfWq9La70YdgaTdYvS5vJL11655paJg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/15] memory: tegra: Add Tegra124 memory controller hot resets
Date: Fri, 13 Apr 2018 14:33:51 +0300
Message-Id: <0afee59fe60d661e8068763e66db109242a81554.1523301400.git.digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <b063a7d44509189495825e73942329aca51e9e69.1523301400.git.digetx@gmail.com>
References: <b063a7d44509189495825e73942329aca51e9e69.1523301400.git.digetx@gmail.com>
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the table of memory controller hot resets for Tegra124.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra124.c | 42 +++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index bd16555cca0f..b561a1fe7f46 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1012,6 +1012,42 @@ static const struct tegra_smmu_group_soc tegra124_groups[] = {
 	},
 };
 
+#define TEGRA124_MC_RESET(_name, _control, _status, _bit)	\
+	{							\
+		.name = #_name,					\
+		.id = TEGRA124_MC_RESET_##_name,		\
+		.control = _control,				\
+		.status = _status,				\
+		.bit = _bit,					\
+	}
+
+static const struct tegra_mc_reset tegra124_mc_resets[] = {
+	TEGRA124_MC_RESET(AFI,       0x200, 0x204,  0),
+	TEGRA124_MC_RESET(AVPC,      0x200, 0x204,  1),
+	TEGRA124_MC_RESET(DC,        0x200, 0x204,  2),
+	TEGRA124_MC_RESET(DCB,       0x200, 0x204,  3),
+	TEGRA124_MC_RESET(HC,        0x200, 0x204,  6),
+	TEGRA124_MC_RESET(HDA,       0x200, 0x204,  7),
+	TEGRA124_MC_RESET(ISP2,      0x200, 0x204,  8),
+	TEGRA124_MC_RESET(MPCORE,    0x200, 0x204,  9),
+	TEGRA124_MC_RESET(MPCORELP,  0x200, 0x204, 10),
+	TEGRA124_MC_RESET(MSENC,     0x200, 0x204, 11),
+	TEGRA124_MC_RESET(PPCS,      0x200, 0x204, 14),
+	TEGRA124_MC_RESET(SATA,      0x200, 0x204, 15),
+	TEGRA124_MC_RESET(VDE,       0x200, 0x204, 16),
+	TEGRA124_MC_RESET(VI,        0x200, 0x204, 17),
+	TEGRA124_MC_RESET(VIC,       0x200, 0x204, 18),
+	TEGRA124_MC_RESET(XUSB_HOST, 0x200, 0x204, 19),
+	TEGRA124_MC_RESET(XUSB_DEV,  0x200, 0x204, 20),
+	TEGRA124_MC_RESET(TSEC,      0x200, 0x204, 21),
+	TEGRA124_MC_RESET(SDMMC1,    0x200, 0x204, 22),
+	TEGRA124_MC_RESET(SDMMC2,    0x200, 0x204, 23),
+	TEGRA124_MC_RESET(SDMMC3,    0x200, 0x204, 25),
+	TEGRA124_MC_RESET(SDMMC4,    0x970, 0x974,  0),
+	TEGRA124_MC_RESET(ISP2B,     0x970, 0x974,  1),
+	TEGRA124_MC_RESET(GPU,       0x970, 0x974,  2),
+};
+
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 static const struct tegra_smmu_soc tegra124_smmu_soc = {
 	.clients = tegra124_mc_clients,
@@ -1038,6 +1074,9 @@ const struct tegra_mc_soc tegra124_mc_soc = {
 	.intmask = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
 		   MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
 		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
+	.reset_ops = &terga_mc_reset_ops_common,
+	.resets = tegra124_mc_resets,
+	.num_resets = ARRAY_SIZE(tegra124_mc_resets),
 };
 #endif /* CONFIG_ARCH_TEGRA_124_SOC */
 
@@ -1065,5 +1104,8 @@ const struct tegra_mc_soc tegra132_mc_soc = {
 	.intmask = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
 		   MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
 		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
+	.reset_ops = &terga_mc_reset_ops_common,
+	.resets = tegra124_mc_resets,
+	.num_resets = ARRAY_SIZE(tegra124_mc_resets),
 };
 #endif /* CONFIG_ARCH_TEGRA_132_SOC */
-- 
2.17.0
