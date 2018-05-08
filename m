Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932117AbeEHQ7I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:59:08 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41923 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754506AbeEHQ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:59:05 -0400
X-Google-Smtp-Source: AB8JxZoUjsD9CU+nMIlR3rD30pAPVCCdJ6C8kBq8QaPsp6F89/q55SNsf77MqSLw+hqscQkvHQ+VuA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1] memory: tegra: Block DMA for clients HW on a faulty memory access
Date: Tue,  8 May 2018 19:58:41 +0300
Message-Id: <20180508165841.13758-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently Memory Controller informs about erroneous memory accesses done
by memory clients and that's it. Let's make it to block whole HW unit
that corresponds to the misbehaving memory client in order to try to avoid
memory corruptions and to stop deliberate attempts of manipulation by a
misbehaving client.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c       | 40 ++++++++++++++++++
 drivers/memory/tegra/tegra114.c | 64 +++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra124.c | 66 +++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra20.c  | 52 +++++++++++++++++++++++
 drivers/memory/tegra/tegra210.c | 73 +++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra30.c  | 66 +++++++++++++++++++++++++++++
 include/soc/tegra/mc.h          |  3 ++
 7 files changed, 364 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 22ec959db7d3..2b5e3ceb1349 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -448,6 +448,42 @@ static const char *const error_names[8] = {
 	[6] = "SMMU translation error",
 };
 
+static int tegra_mc_error_block_unit_dma(struct tegra_mc *mc,
+					 unsigned int client)
+{
+	const struct tegra_mc_reset_ops *rst_ops;
+	const struct tegra_mc_reset *rst;
+	unsigned int id;
+	int err;
+
+	id = mc->soc->clients[client].reset_id;
+	if (id == TEGRA_MC_CLIENT_NO_RESET)
+		return -ENXIO;
+
+	rst_ops = mc->soc->reset_ops;
+	if (!rst_ops)
+		return -EINVAL;
+
+	if (!rst_ops->block_dma)
+		return -EINVAL;
+
+	rst = tegra_mc_reset_find(mc, id);
+	if (!rst)
+		return -ENODEV;
+
+	err = rst_ops->block_dma(mc, rst);
+	if (err) {
+		dev_err_ratelimited(mc->dev, "Failed to block %s DMA: %d\n",
+				    rst->name, err);
+		return err;
+	}
+
+	dev_warn_ratelimited(mc->dev, "Faulty DMA blocked for %s unit\n",
+			     rst->name);
+
+	return 0;
+}
+
 static irqreturn_t tegra_mc_irq(int irq, void *data)
 {
 	struct tegra_mc *mc = data;
@@ -534,6 +570,8 @@ static irqreturn_t tegra_mc_irq(int irq, void *data)
 		value = mc_readl(mc, MC_ERR_ADR);
 		addr |= value;
 
+		tegra_mc_error_block_unit_dma(mc, i);
+
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
 				    client, secure, direction, &addr, error,
 				    desc, perm);
@@ -616,6 +654,8 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 			continue;
 		}
 
+		tegra_mc_error_block_unit_dma(mc, id);
+
 		client = mc->soc->clients[id].name;
 
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s)\n",
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 12528aa3062b..416450451d85 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -18,6 +18,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 		.id = 0x00,
 		.name = "ptcr",
 		.swgroup = TEGRA_SWGROUP_PTC,
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x01,
 		.name = "display0a",
@@ -32,6 +33,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x02,
 		.name = "display0ab",
@@ -46,6 +48,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x03,
 		.name = "display0b",
@@ -60,6 +63,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x04,
 		.name = "display0bb",
@@ -74,6 +78,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x05,
 		.name = "display0c",
@@ -88,6 +93,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x06,
 		.name = "display0cb",
@@ -102,6 +108,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x09,
 		.name = "eppup",
@@ -116,6 +123,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x33,
 		},
+		.reset_id = TEGRA114_MC_RESET_EPP,
 	}, {
 		.id = 0x0a,
 		.name = "g2pr",
@@ -130,6 +138,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x09,
 		},
+		.reset_id = TEGRA114_MC_RESET_2D,
 	}, {
 		.id = 0x0b,
 		.name = "g2sr",
@@ -144,6 +153,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x09,
 		},
+		.reset_id = TEGRA114_MC_RESET_2D,
 	}, {
 		.id = 0x0f,
 		.name = "avpcarm7r",
@@ -158,6 +168,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x10,
 		.name = "displayhc",
@@ -172,6 +183,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x68,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x11,
 		.name = "displayhcb",
@@ -186,6 +198,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x68,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x12,
 		.name = "fdcdrd",
@@ -200,6 +213,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0c,
 		},
+		.reset_id = TEGRA114_MC_RESET_3D,
 	}, {
 		.id = 0x13,
 		.name = "fdcdrd2",
@@ -214,6 +228,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0c,
 		},
+		.reset_id = TEGRA114_MC_RESET_3D2,
 	}, {
 		.id = 0x14,
 		.name = "g2dr",
@@ -228,6 +243,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0a,
 		},
+		.reset_id = TEGRA114_MC_RESET_2D,
 	}, {
 		.id = 0x15,
 		.name = "hdar",
@@ -242,6 +258,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x16,
 		.name = "host1xdmar",
@@ -256,6 +273,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.reset_id = TEGRA114_MC_RESET_HC,
 	}, {
 		.id = 0x17,
 		.name = "host1xr",
@@ -270,6 +288,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xa5,
 		},
+		.reset_id = TEGRA114_MC_RESET_HC,
 	}, {
 		.id = 0x18,
 		.name = "idxsrd",
@@ -284,6 +303,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0b,
 		},
+		.reset_id = TEGRA114_MC_RESET_3D,
 	}, {
 		.id = 0x1c,
 		.name = "msencsrd",
@@ -312,6 +332,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x1e,
 		.name = "ppcsahbslvr",
@@ -326,6 +347,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xe8,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x20,
 		.name = "texl2srd",
@@ -340,6 +362,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0c,
 		},
+		.reset_id = TEGRA114_MC_RESET_3D2,
 	}, {
 		.id = 0x22,
 		.name = "vdebsevr",
@@ -354,6 +377,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA114_MC_RESET_VDE,
 	}, {
 		.id = 0x23,
 		.name = "vdember",
@@ -368,6 +392,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA114_MC_RESET_VDE,
 	}, {
 		.id = 0x24,
 		.name = "vdemcer",
@@ -382,6 +407,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xb8,
 		},
+		.reset_id = TEGRA114_MC_RESET_VDE,
 	}, {
 		.id = 0x25,
 		.name = "vdetper",
@@ -396,6 +422,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xee,
 		},
+		.reset_id = TEGRA114_MC_RESET_VDE,
 	}, {
 		.id = 0x26,
 		.name = "mpcorelpr",
@@ -406,6 +433,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x27,
 		.name = "mpcorer",
@@ -416,6 +444,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x28,
 		.name = "eppu",
@@ -430,6 +459,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x33,
 		},
+		.reset_id = TEGRA114_MC_RESET_EPP,
 	}, {
 		.id = 0x29,
 		.name = "eppv",
@@ -444,6 +474,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x6c,
 		},
+		.reset_id = TEGRA114_MC_RESET_EPP,
 	}, {
 		.id = 0x2a,
 		.name = "eppy",
@@ -458,6 +489,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x6c,
 		},
+		.reset_id = TEGRA114_MC_RESET_EPP,
 	}, {
 		.id = 0x2b,
 		.name = "msencswr",
@@ -472,6 +504,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA114_MC_RESET_MPE,
 	}, {
 		.id = 0x2c,
 		.name = "viwsb",
@@ -486,6 +519,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x47,
 		},
+		.reset_id = TEGRA114_MC_RESET_VI,
 	}, {
 		.id = 0x2d,
 		.name = "viwu",
@@ -500,6 +534,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA114_MC_RESET_VI,
 	}, {
 		.id = 0x2e,
 		.name = "viwv",
@@ -514,6 +549,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA114_MC_RESET_VI,
 	}, {
 		.id = 0x2f,
 		.name = "viwy",
@@ -528,6 +564,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x47,
 		},
+		.reset_id = TEGRA114_MC_RESET_VI,
 	}, {
 		.id = 0x30,
 		.name = "g2dw",
@@ -542,6 +579,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x9,
 		},
+		.reset_id = TEGRA114_MC_RESET_2D,
 	}, {
 		.id = 0x32,
 		.name = "avpcarm7w",
@@ -556,6 +594,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x33,
 		.name = "fdcdwr",
@@ -570,6 +609,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.reset_id = TEGRA114_MC_RESET_3D,
 	}, {
 		.id = 0x34,
 		.name = "fdcwr2",
@@ -584,6 +624,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.reset_id = TEGRA114_MC_RESET_3D2,
 	}, {
 		.id = 0x35,
 		.name = "hdaw",
@@ -598,6 +639,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x36,
 		.name = "host1xw",
@@ -612,6 +654,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x25,
 		},
+		.reset_id = TEGRA114_MC_RESET_HC,
 	}, {
 		.id = 0x37,
 		.name = "ispw",
@@ -626,6 +669,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA114_MC_RESET_ISP,
 	}, {
 		.id = 0x38,
 		.name = "mpcorelpw",
@@ -636,6 +680,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x39,
 		.name = "mpcorew",
@@ -646,6 +691,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3b,
 		.name = "ppcsahbdmaw",
@@ -660,6 +706,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xa5,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3c,
 		.name = "ppcsahbslvw",
@@ -674,6 +721,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xe8,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3e,
 		.name = "vdebsevw",
@@ -688,6 +736,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA114_MC_RESET_VDE,
 	}, {
 		.id = 0x3f,
 		.name = "vdedbgw",
@@ -702,6 +751,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA114_MC_RESET_VDE,
 	}, {
 		.id = 0x40,
 		.name = "vdembew",
@@ -716,6 +766,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x89,
 		},
+		.reset_id = TEGRA114_MC_RESET_VDE,
 	}, {
 		.id = 0x41,
 		.name = "vdetpmw",
@@ -730,6 +781,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x59,
 		},
+		.reset_id = TEGRA114_MC_RESET_VDE,
 	}, {
 		.id = 0x4a,
 		.name = "xusb_hostr",
@@ -744,6 +796,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xa5,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x4b,
 		.name = "xusb_hostw",
@@ -758,6 +811,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xa5,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x4c,
 		.name = "xusb_devr",
@@ -772,6 +826,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xa5,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x4d,
 		.name = "xusb_devw",
@@ -786,6 +841,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xa5,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x4e,
 		.name = "fdcdwr3",
@@ -800,6 +856,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x4f,
 		.name = "fdcdrd3",
@@ -814,6 +871,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0c,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x50,
 		.name = "fdcwr4",
@@ -828,6 +886,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x51,
 		.name = "fdcrd4",
@@ -842,6 +901,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0c,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x52,
 		.name = "emucifr",
@@ -852,6 +912,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x53,
 		.name = "emucifw",
@@ -862,6 +923,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x54,
 		.name = "tsecsrd",
@@ -876,6 +938,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x55,
 		.name = "tsecswr",
@@ -890,6 +953,7 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	},
 };
 
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index b561a1fe7f46..bc303282b42f 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -60,6 +60,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 		.id = 0x00,
 		.name = "ptcr",
 		.swgroup = TEGRA_SWGROUP_PTC,
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x01,
 		.name = "display0a",
@@ -74,6 +75,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xc2,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x02,
 		.name = "display0ab",
@@ -88,6 +90,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xc6,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x03,
 		.name = "display0b",
@@ -102,6 +105,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x04,
 		.name = "display0bb",
@@ -116,6 +120,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x05,
 		.name = "display0c",
@@ -130,6 +135,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x06,
 		.name = "display0cb",
@@ -144,6 +150,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x0e,
 		.name = "afir",
@@ -158,6 +165,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.reset_id = TEGRA124_MC_RESET_AFI,
 	}, {
 		.id = 0x0f,
 		.name = "avpcarm7r",
@@ -172,6 +180,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x10,
 		.name = "displayhc",
@@ -186,6 +195,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x11,
 		.name = "displayhcb",
@@ -200,6 +210,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x15,
 		.name = "hdar",
@@ -214,6 +225,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x24,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x16,
 		.name = "host1xdmar",
@@ -228,6 +240,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x1e,
 		},
+		.reset_id = TEGRA124_MC_RESET_HC,
 	}, {
 		.id = 0x17,
 		.name = "host1xr",
@@ -242,6 +255,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA124_MC_RESET_HC,
 	}, {
 		.id = 0x1c,
 		.name = "msencsrd",
@@ -256,6 +270,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x23,
 		},
+		.reset_id = TEGRA124_MC_RESET_MSENC,
 	}, {
 		.id = 0x1d,
 		.name = "ppcsahbdmar",
@@ -270,6 +285,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x49,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x1e,
 		.name = "ppcsahbslvr",
@@ -284,6 +300,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x1a,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x1f,
 		.name = "satar",
@@ -298,6 +315,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x65,
 		},
+		.reset_id = TEGRA124_MC_RESET_SATA,
 	}, {
 		.id = 0x22,
 		.name = "vdebsevr",
@@ -312,6 +330,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4f,
 		},
+		.reset_id = TEGRA124_MC_RESET_VDE,
 	}, {
 		.id = 0x23,
 		.name = "vdember",
@@ -326,6 +345,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x3d,
 		},
+		.reset_id = TEGRA124_MC_RESET_VDE,
 	}, {
 		.id = 0x24,
 		.name = "vdemcer",
@@ -340,6 +360,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x66,
 		},
+		.reset_id = TEGRA124_MC_RESET_VDE,
 	}, {
 		.id = 0x25,
 		.name = "vdetper",
@@ -354,6 +375,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xa5,
 		},
+		.reset_id = TEGRA124_MC_RESET_VDE,
 	}, {
 		.id = 0x26,
 		.name = "mpcorelpr",
@@ -364,6 +386,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x27,
 		.name = "mpcorer",
@@ -374,6 +397,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x2b,
 		.name = "msencswr",
@@ -388,6 +412,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_MSENC,
 	}, {
 		.id = 0x31,
 		.name = "afiw",
@@ -402,6 +427,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_AFI,
 	}, {
 		.id = 0x32,
 		.name = "avpcarm7w",
@@ -416,6 +442,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x35,
 		.name = "hdaw",
@@ -430,6 +457,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x36,
 		.name = "host1xw",
@@ -454,6 +482,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x39,
 		.name = "mpcorew",
@@ -464,6 +493,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3b,
 		.name = "ppcsahbdmaw",
@@ -478,6 +508,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3c,
 		.name = "ppcsahbslvw",
@@ -492,6 +523,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3d,
 		.name = "sataw",
@@ -506,6 +538,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x65,
 		},
+		.reset_id = TEGRA124_MC_RESET_SATA,
 	}, {
 		.id = 0x3e,
 		.name = "vdebsevw",
@@ -520,6 +553,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_VDE,
 	}, {
 		.id = 0x3f,
 		.name = "vdedbgw",
@@ -534,6 +568,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_VDE,
 	}, {
 		.id = 0x40,
 		.name = "vdembew",
@@ -548,6 +583,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_VDE,
 	}, {
 		.id = 0x41,
 		.name = "vdetpmw",
@@ -562,6 +598,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_VDE,
 	}, {
 		.id = 0x44,
 		.name = "ispra",
@@ -576,6 +613,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x18,
 		},
+		.reset_id = TEGRA124_MC_RESET_ISP2,
 	}, {
 		.id = 0x46,
 		.name = "ispwa",
@@ -590,6 +628,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_ISP2,
 	}, {
 		.id = 0x47,
 		.name = "ispwb",
@@ -604,6 +643,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_ISP2,
 	}, {
 		.id = 0x4a,
 		.name = "xusb_hostr",
@@ -618,6 +658,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x39,
 		},
+		.reset_id = TEGRA124_MC_RESET_XUSB_HOST,
 	}, {
 		.id = 0x4b,
 		.name = "xusb_hostw",
@@ -632,6 +673,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_XUSB_HOST,
 	}, {
 		.id = 0x4c,
 		.name = "xusb_devr",
@@ -646,6 +688,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x39,
 		},
+		.reset_id = TEGRA124_MC_RESET_XUSB_DEV,
 	}, {
 		.id = 0x4d,
 		.name = "xusb_devw",
@@ -660,6 +703,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_XUSB_DEV,
 	}, {
 		.id = 0x4e,
 		.name = "isprab",
@@ -674,6 +718,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x18,
 		},
+		.reset_id = TEGRA124_MC_RESET_ISP2B,
 	}, {
 		.id = 0x50,
 		.name = "ispwab",
@@ -688,6 +733,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_ISP2B,
 	}, {
 		.id = 0x51,
 		.name = "ispwbb",
@@ -702,6 +748,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_ISP2B,
 	}, {
 		.id = 0x54,
 		.name = "tsecsrd",
@@ -716,6 +763,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x9b,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x55,
 		.name = "tsecswr",
@@ -730,6 +778,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x56,
 		.name = "a9avpscr",
@@ -744,6 +793,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x57,
 		.name = "a9avpscw",
@@ -758,6 +808,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x58,
 		.name = "gpusrd",
@@ -773,6 +824,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x1a,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x59,
 		.name = "gpuswr",
@@ -788,6 +840,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x5a,
 		.name = "displayt",
@@ -802,6 +855,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x60,
 		.name = "sdmmcra",
@@ -816,6 +870,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x49,
 		},
+		.reset_id = TEGRA124_MC_RESET_SDMMC1,
 	}, {
 		.id = 0x61,
 		.name = "sdmmcraa",
@@ -830,6 +885,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x49,
 		},
+		.reset_id = TEGRA124_MC_RESET_SDMMC2,
 	}, {
 		.id = 0x62,
 		.name = "sdmmcr",
@@ -844,6 +900,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x49,
 		},
+		.reset_id = TEGRA124_MC_RESET_SDMMC3,
 	}, {
 		.id = 0x63,
 		.swgroup = TEGRA_SWGROUP_SDMMC4A,
@@ -858,6 +915,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x49,
 		},
+		.reset_id = TEGRA124_MC_RESET_SDMMC4,
 	}, {
 		.id = 0x64,
 		.name = "sdmmcwa",
@@ -872,6 +930,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_SDMMC1,
 	}, {
 		.id = 0x65,
 		.name = "sdmmcwaa",
@@ -886,6 +945,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_SDMMC2,
 	}, {
 		.id = 0x66,
 		.name = "sdmmcw",
@@ -900,6 +960,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_SDMMC3,
 	}, {
 		.id = 0x67,
 		.name = "sdmmcwab",
@@ -914,6 +975,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_SDMMC4,
 	}, {
 		.id = 0x6c,
 		.name = "vicsrd",
@@ -928,6 +990,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x1a,
 		},
+		.reset_id = TEGRA124_MC_RESET_VIC,
 	}, {
 		.id = 0x6d,
 		.name = "vicswr",
@@ -942,6 +1005,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_VIC,
 	}, {
 		.id = 0x72,
 		.name = "viw",
@@ -956,6 +1020,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA124_MC_RESET_VI,
 	}, {
 		.id = 0x73,
 		.name = "displayd",
@@ -970,6 +1035,7 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	},
 };
 
diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
index 7119e532471c..930454c7b15b 100644
--- a/drivers/memory/tegra/tegra20.c
+++ b/drivers/memory/tegra/tegra20.c
@@ -14,159 +14,211 @@ static const struct tegra_mc_client tegra20_mc_clients[] = {
 	{
 		.id = 0x00,
 		.name = "display0a",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x01,
 		.name = "display0ab",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x02,
 		.name = "display0b",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x03,
 		.name = "display0bb",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x04,
 		.name = "display0c",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x05,
 		.name = "display0cb",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x06,
 		.name = "display1b",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x07,
 		.name = "display1bb",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x08,
 		.name = "eppup",
+		.reset_id = TEGRA20_MC_RESET_EPP,
 	}, {
 		.id = 0x09,
 		.name = "g2pr",
+		.reset_id = TEGRA20_MC_RESET_2D,
 	}, {
 		.id = 0x0a,
 		.name = "g2sr",
+		.reset_id = TEGRA20_MC_RESET_2D,
 	}, {
 		.id = 0x0b,
 		.name = "mpeunifbr",
+		.reset_id = TEGRA20_MC_RESET_MPEB,
 	}, {
 		.id = 0x0c,
 		.name = "viruv",
+		.reset_id = TEGRA20_MC_RESET_VI,
 	}, {
 		.id = 0x0d,
 		.name = "avpcarm7r",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x0e,
 		.name = "displayhc",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x0f,
 		.name = "displayhcb",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x10,
 		.name = "fdcdrd",
+		.reset_id = TEGRA20_MC_RESET_3D,
 	}, {
 		.id = 0x11,
 		.name = "g2dr",
+		.reset_id = TEGRA20_MC_RESET_2D,
 	}, {
 		.id = 0x12,
 		.name = "host1xdmar",
+		.reset_id = TEGRA20_MC_RESET_HC,
 	}, {
 		.id = 0x13,
 		.name = "host1xr",
+		.reset_id = TEGRA20_MC_RESET_HC,
 	}, {
 		.id = 0x14,
 		.name = "idxsrd",
+		.reset_id = TEGRA20_MC_RESET_3D,
 	}, {
 		.id = 0x15,
 		.name = "mpcorer",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x16,
 		.name = "mpe_ipred",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x17,
 		.name = "mpeamemrd",
+		.reset_id = TEGRA20_MC_RESET_MPEA,
 	}, {
 		.id = 0x18,
 		.name = "mpecsrd",
+		.reset_id = TEGRA20_MC_RESET_MPEC,
 	}, {
 		.id = 0x19,
 		.name = "ppcsahbdmar",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x1a,
 		.name = "ppcsahbslvr",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x1b,
 		.name = "texsrd",
+		.reset_id = TEGRA20_MC_RESET_3D,
 	}, {
 		.id = 0x1c,
 		.name = "vdebsevr",
+		.reset_id = TEGRA20_MC_RESET_VDE,
 	}, {
 		.id = 0x1d,
 		.name = "vdember",
+		.reset_id = TEGRA20_MC_RESET_VDE,
 	}, {
 		.id = 0x1e,
 		.name = "vdemcer",
+		.reset_id = TEGRA20_MC_RESET_VDE,
 	}, {
 		.id = 0x1f,
 		.name = "vdetper",
+		.reset_id = TEGRA20_MC_RESET_VDE,
 	}, {
 		.id = 0x20,
 		.name = "eppu",
+		.reset_id = TEGRA20_MC_RESET_EPP,
 	}, {
 		.id = 0x21,
 		.name = "eppv",
+		.reset_id = TEGRA20_MC_RESET_EPP,
 	}, {
 		.id = 0x22,
 		.name = "eppy",
+		.reset_id = TEGRA20_MC_RESET_EPP,
 	}, {
 		.id = 0x23,
 		.name = "mpeunifbw",
+		.reset_id = TEGRA20_MC_RESET_MPEB,
 	}, {
 		.id = 0x24,
 		.name = "viwsb",
+		.reset_id = TEGRA20_MC_RESET_VI,
 	}, {
 		.id = 0x25,
 		.name = "viwu",
+		.reset_id = TEGRA20_MC_RESET_VI,
 	}, {
 		.id = 0x26,
 		.name = "viwv",
+		.reset_id = TEGRA20_MC_RESET_VI,
 	}, {
 		.id = 0x27,
 		.name = "viwy",
+		.reset_id = TEGRA20_MC_RESET_VI,
 	}, {
 		.id = 0x28,
 		.name = "g2dw",
+		.reset_id = TEGRA20_MC_RESET_2D,
 	}, {
 		.id = 0x29,
 		.name = "avpcarm7w",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x2a,
 		.name = "fdcdwr",
+		.reset_id = TEGRA20_MC_RESET_3D,
 	}, {
 		.id = 0x2b,
 		.name = "host1xw",
+		.reset_id = TEGRA20_MC_RESET_HC,
 	}, {
 		.id = 0x2c,
 		.name = "ispw",
+		.reset_id = TEGRA20_MC_RESET_ISP,
 	}, {
 		.id = 0x2d,
 		.name = "mpcorew",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x2e,
 		.name = "mpecswr",
+		.reset_id = TEGRA20_MC_RESET_MPEC,
 	}, {
 		.id = 0x2f,
 		.name = "ppcsahbdmaw",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x30,
 		.name = "ppcsahbslvw",
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x31,
 		.name = "vdebsevw",
+		.reset_id = TEGRA20_MC_RESET_VDE,
 	}, {
 		.id = 0x32,
 		.name = "vdembew",
+		.reset_id = TEGRA20_MC_RESET_VDE,
 	}, {
 		.id = 0x33,
 		.name = "vdetpmw",
+		.reset_id = TEGRA20_MC_RESET_VDE,
 	},
 };
 
diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index d00a77160407..d4daca501038 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -15,6 +15,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 		.id = 0x00,
 		.name = "ptcr",
 		.swgroup = TEGRA_SWGROUP_PTC,
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x01,
 		.name = "display0a",
@@ -29,6 +30,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xc2,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x02,
 		.name = "display0ab",
@@ -43,6 +45,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xc6,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x03,
 		.name = "display0b",
@@ -57,6 +60,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x04,
 		.name = "display0bb",
@@ -71,6 +75,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x05,
 		.name = "display0c",
@@ -85,6 +90,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x06,
 		.name = "display0cb",
@@ -99,6 +105,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x0e,
 		.name = "afir",
@@ -113,6 +120,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.reset_id = TEGRA210_MC_RESET_AFI,
 	}, {
 		.id = 0x0f,
 		.name = "avpcarm7r",
@@ -127,6 +135,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x10,
 		.name = "displayhc",
@@ -141,6 +150,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x11,
 		.name = "displayhcb",
@@ -155,6 +165,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x15,
 		.name = "hdar",
@@ -169,6 +180,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x24,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x16,
 		.name = "host1xdmar",
@@ -183,6 +195,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x1e,
 		},
+		.reset_id = TEGRA210_MC_RESET_HC,
 	}, {
 		.id = 0x17,
 		.name = "host1xr",
@@ -197,6 +210,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA210_MC_RESET_HC,
 	}, {
 		.id = 0x1c,
 		.name = "nvencsrd",
@@ -211,6 +225,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x23,
 		},
+		.reset_id = TEGRA210_MC_RESET_NVENC,
 	}, {
 		.id = 0x1d,
 		.name = "ppcsahbdmar",
@@ -225,6 +240,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x49,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x1e,
 		.name = "ppcsahbslvr",
@@ -239,6 +255,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x1a,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x1f,
 		.name = "satar",
@@ -253,6 +270,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x65,
 		},
+		.reset_id = TEGRA210_MC_RESET_SATA,
 	}, {
 		.id = 0x27,
 		.name = "mpcorer",
@@ -263,6 +281,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x2b,
 		.name = "nvencswr",
@@ -277,6 +296,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_NVENC,
 	}, {
 		.id = 0x31,
 		.name = "afiw",
@@ -291,6 +311,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_AFI,
 	}, {
 		.id = 0x32,
 		.name = "avpcarm7w",
@@ -305,6 +326,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x35,
 		.name = "hdaw",
@@ -319,6 +341,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x36,
 		.name = "host1xw",
@@ -333,6 +356,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_HC,
 	}, {
 		.id = 0x39,
 		.name = "mpcorew",
@@ -343,6 +367,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3b,
 		.name = "ppcsahbdmaw",
@@ -357,6 +382,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3c,
 		.name = "ppcsahbslvw",
@@ -371,6 +397,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3d,
 		.name = "sataw",
@@ -385,6 +412,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x65,
 		},
+		.reset_id = TEGRA210_MC_RESET_SATA,
 	}, {
 		.id = 0x44,
 		.name = "ispra",
@@ -399,6 +427,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x18,
 		},
+		.reset_id = TEGRA210_MC_RESET_ISP2,
 	}, {
 		.id = 0x46,
 		.name = "ispwa",
@@ -413,6 +442,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_ISP2,
 	}, {
 		.id = 0x47,
 		.name = "ispwb",
@@ -427,6 +457,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_ISP2,
 	}, {
 		.id = 0x4a,
 		.name = "xusb_hostr",
@@ -441,6 +472,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x39,
 		},
+		.reset_id = TEGRA210_MC_RESET_XUSB_HOST,
 	}, {
 		.id = 0x4b,
 		.name = "xusb_hostw",
@@ -455,6 +487,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_XUSB_HOST,
 	}, {
 		.id = 0x4c,
 		.name = "xusb_devr",
@@ -469,6 +502,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x39,
 		},
+		.reset_id = TEGRA210_MC_RESET_XUSB_DEV,
 	}, {
 		.id = 0x4d,
 		.name = "xusb_devw",
@@ -483,6 +517,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_XUSB_DEV,
 	}, {
 		.id = 0x4e,
 		.name = "isprab",
@@ -497,6 +532,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x18,
 		},
+		.reset_id = TEGRA210_MC_RESET_ISP2B,
 	}, {
 		.id = 0x50,
 		.name = "ispwab",
@@ -511,6 +547,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_ISP2B,
 	}, {
 		.id = 0x51,
 		.name = "ispwbb",
@@ -525,6 +562,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_ISP2B,
 	}, {
 		.id = 0x54,
 		.name = "tsecsrd",
@@ -539,6 +577,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x9b,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x55,
 		.name = "tsecswr",
@@ -553,6 +592,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x56,
 		.name = "a9avpscr",
@@ -567,6 +607,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x57,
 		.name = "a9avpscw",
@@ -581,6 +622,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x58,
 		.name = "gpusrd",
@@ -596,6 +638,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x1a,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x59,
 		.name = "gpuswr",
@@ -611,6 +654,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x5a,
 		.name = "displayt",
@@ -625,6 +669,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x60,
 		.name = "sdmmcra",
@@ -639,6 +684,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x49,
 		},
+		.reset_id = TEGRA210_MC_RESET_SDMMC1,
 	}, {
 		.id = 0x61,
 		.name = "sdmmcraa",
@@ -653,6 +699,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x49,
 		},
+		.reset_id = TEGRA210_MC_RESET_SDMMC2,
 	}, {
 		.id = 0x62,
 		.name = "sdmmcr",
@@ -667,6 +714,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x49,
 		},
+		.reset_id = TEGRA210_MC_RESET_SDMMC3,
 	}, {
 		.id = 0x63,
 		.swgroup = TEGRA_SWGROUP_SDMMC4A,
@@ -681,6 +729,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x49,
 		},
+		.reset_id = TEGRA210_MC_RESET_SDMMC4,
 	}, {
 		.id = 0x64,
 		.name = "sdmmcwa",
@@ -695,6 +744,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_SDMMC1,
 	}, {
 		.id = 0x65,
 		.name = "sdmmcwaa",
@@ -709,6 +759,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_SDMMC2,
 	}, {
 		.id = 0x66,
 		.name = "sdmmcw",
@@ -723,6 +774,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_SDMMC3,
 	}, {
 		.id = 0x67,
 		.name = "sdmmcwab",
@@ -737,6 +789,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_SDMMC4,
 	}, {
 		.id = 0x6c,
 		.name = "vicsrd",
@@ -751,6 +804,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x1a,
 		},
+		.reset_id = TEGRA210_MC_RESET_VIC,
 	}, {
 		.id = 0x6d,
 		.name = "vicswr",
@@ -765,6 +819,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_VIC,
 	}, {
 		.id = 0x72,
 		.name = "viw",
@@ -779,6 +834,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_VI,
 	}, {
 		.id = 0x73,
 		.name = "displayd",
@@ -793,6 +849,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA210_MC_RESET_DC,
 	}, {
 		.id = 0x78,
 		.name = "nvdecsrd",
@@ -807,6 +864,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x23,
 		},
+		.reset_id = TEGRA210_MC_RESET_NVDEC,
 	}, {
 		.id = 0x79,
 		.name = "nvdecswr",
@@ -821,6 +879,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_NVDEC,
 	}, {
 		.id = 0x7a,
 		.name = "aper",
@@ -835,6 +894,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA210_MC_RESET_APE,
 	}, {
 		.id = 0x7b,
 		.name = "apew",
@@ -849,6 +909,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_APE,
 	}, {
 		.id = 0x7e,
 		.name = "nvjpgsrd",
@@ -863,6 +924,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x23,
 		},
+		.reset_id = TEGRA210_MC_RESET_NVJPG,
 	}, {
 		.id = 0x7f,
 		.name = "nvjpgswr",
@@ -877,6 +939,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA210_MC_RESET_NVJPG,
 	}, {
 		.id = 0x80,
 		.name = "sesrd",
@@ -891,6 +954,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x2e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x81,
 		.name = "seswr",
@@ -905,6 +969,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x82,
 		.name = "axiapr",
@@ -919,6 +984,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x83,
 		.name = "axiapw",
@@ -933,6 +999,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x84,
 		.name = "etrr",
@@ -947,6 +1014,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x85,
 		.name = "etrw",
@@ -961,6 +1029,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x86,
 		.name = "tsecsrdb",
@@ -975,6 +1044,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x9b,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x87,
 		.name = "tsecswrb",
@@ -989,6 +1059,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x88,
 		.name = "gpusrd2",
@@ -1004,6 +1075,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x1a,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x89,
 		.name = "gpuswr2",
@@ -1019,6 +1091,7 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	},
 };
 
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index bee5314ed404..7649752ac2fc 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -18,6 +18,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 		.id = 0x00,
 		.name = "ptcr",
 		.swgroup = TEGRA_SWGROUP_PTC,
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x01,
 		.name = "display0a",
@@ -32,6 +33,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x02,
 		.name = "display0ab",
@@ -46,6 +48,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x03,
 		.name = "display0b",
@@ -60,6 +63,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x04,
 		.name = "display0bb",
@@ -74,6 +78,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x05,
 		.name = "display0c",
@@ -88,6 +93,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x06,
 		.name = "display0cb",
@@ -102,6 +108,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x07,
 		.name = "display1b",
@@ -116,6 +123,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x08,
 		.name = "display1bb",
@@ -130,6 +138,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x4e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x09,
 		.name = "eppup",
@@ -144,6 +153,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x17,
 		},
+		.reset_id = TEGRA30_MC_RESET_EPP,
 	}, {
 		.id = 0x0a,
 		.name = "g2pr",
@@ -158,6 +168,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x09,
 		},
+		.reset_id = TEGRA30_MC_RESET_2D,
 	}, {
 		.id = 0x0b,
 		.name = "g2sr",
@@ -172,6 +183,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x09,
 		},
+		.reset_id = TEGRA30_MC_RESET_2D,
 	}, {
 		.id = 0x0c,
 		.name = "mpeunifbr",
@@ -186,6 +198,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA30_MC_RESET_MPE,
 	}, {
 		.id = 0x0d,
 		.name = "viruv",
@@ -200,6 +213,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x2c,
 		},
+		.reset_id = TEGRA30_MC_RESET_VI,
 	}, {
 		.id = 0x0e,
 		.name = "afir",
@@ -214,6 +228,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.reset_id = TEGRA30_MC_RESET_AFI,
 	}, {
 		.id = 0x0f,
 		.name = "avpcarm7r",
@@ -228,6 +243,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x10,
 		.name = "displayhc",
@@ -242,6 +258,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x11,
 		.name = "displayhcb",
@@ -256,6 +273,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x12,
 		.name = "fdcdrd",
@@ -270,6 +288,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0a,
 		},
+		.reset_id = TEGRA30_MC_RESET_3D,
 	}, {
 		.id = 0x13,
 		.name = "fdcdrd2",
@@ -284,6 +303,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0a,
 		},
+		.reset_id = TEGRA30_MC_RESET_3D2,
 	}, {
 		.id = 0x14,
 		.name = "g2dr",
@@ -298,6 +318,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0a,
 		},
+		.reset_id = TEGRA30_MC_RESET_2D,
 	}, {
 		.id = 0x15,
 		.name = "hdar",
@@ -312,6 +333,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x16,
 		.name = "host1xdmar",
@@ -326,6 +348,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x05,
 		},
+		.reset_id = TEGRA30_MC_RESET_HC,
 	}, {
 		.id = 0x17,
 		.name = "host1xr",
@@ -340,6 +363,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x50,
 		},
+		.reset_id = TEGRA30_MC_RESET_HC,
 	}, {
 		.id = 0x18,
 		.name = "idxsrd",
@@ -354,6 +378,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.reset_id = TEGRA30_MC_RESET_3D,
 	}, {
 		.id = 0x19,
 		.name = "idxsrd2",
@@ -368,6 +393,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.reset_id = TEGRA30_MC_RESET_3D2,
 	}, {
 		.id = 0x1a,
 		.name = "mpe_ipred",
@@ -382,6 +408,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x80,
 		},
+		.reset_id = TEGRA30_MC_RESET_MPE,
 	}, {
 		.id = 0x1b,
 		.name = "mpeamemrd",
@@ -396,6 +423,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x42,
 		},
+		.reset_id = TEGRA30_MC_RESET_MPE,
 	}, {
 		.id = 0x1c,
 		.name = "mpecsrd",
@@ -410,6 +438,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA30_MC_RESET_MPE,
 	}, {
 		.id = 0x1d,
 		.name = "ppcsahbdmar",
@@ -424,6 +453,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x1e,
 		.name = "ppcsahbslvr",
@@ -438,6 +468,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x12,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x1f,
 		.name = "satar",
@@ -452,6 +483,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x33,
 		},
+		.reset_id = TEGRA30_MC_RESET_SATA,
 	}, {
 		.id = 0x20,
 		.name = "texsrd",
@@ -466,6 +498,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.reset_id = TEGRA30_MC_RESET_3D,
 	}, {
 		.id = 0x21,
 		.name = "texsrd2",
@@ -480,6 +513,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.reset_id = TEGRA30_MC_RESET_3D2,
 	}, {
 		.id = 0x22,
 		.name = "vdebsevr",
@@ -494,6 +528,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA30_MC_RESET_VDE,
 	}, {
 		.id = 0x23,
 		.name = "vdember",
@@ -508,6 +543,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xd0,
 		},
+		.reset_id = TEGRA30_MC_RESET_VDE,
 	}, {
 		.id = 0x24,
 		.name = "vdemcer",
@@ -522,6 +558,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x2a,
 		},
+		.reset_id = TEGRA30_MC_RESET_VDE,
 	}, {
 		.id = 0x25,
 		.name = "vdetper",
@@ -536,6 +573,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x74,
 		},
+		.reset_id = TEGRA30_MC_RESET_VDE,
 	}, {
 		.id = 0x26,
 		.name = "mpcorelpr",
@@ -546,6 +584,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x27,
 		.name = "mpcorer",
@@ -556,6 +595,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x04,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x28,
 		.name = "eppu",
@@ -570,6 +610,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x6c,
 		},
+		.reset_id = TEGRA30_MC_RESET_EPP,
 	}, {
 		.id = 0x29,
 		.name = "eppv",
@@ -584,6 +625,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x6c,
 		},
+		.reset_id = TEGRA30_MC_RESET_EPP,
 	}, {
 		.id = 0x2a,
 		.name = "eppy",
@@ -598,6 +640,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x6c,
 		},
+		.reset_id = TEGRA30_MC_RESET_EPP,
 	}, {
 		.id = 0x2b,
 		.name = "mpeunifbw",
@@ -612,6 +655,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x13,
 		},
+		.reset_id = TEGRA30_MC_RESET_MPE,
 	}, {
 		.id = 0x2c,
 		.name = "viwsb",
@@ -626,6 +670,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x12,
 		},
+		.reset_id = TEGRA30_MC_RESET_VI,
 	}, {
 		.id = 0x2d,
 		.name = "viwu",
@@ -640,6 +685,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xb2,
 		},
+		.reset_id = TEGRA30_MC_RESET_VI,
 	}, {
 		.id = 0x2e,
 		.name = "viwv",
@@ -654,6 +700,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xb2,
 		},
+		.reset_id = TEGRA30_MC_RESET_VI,
 	}, {
 		.id = 0x2f,
 		.name = "viwy",
@@ -668,6 +715,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x12,
 		},
+		.reset_id = TEGRA30_MC_RESET_VI,
 	}, {
 		.id = 0x30,
 		.name = "g2dw",
@@ -682,6 +730,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x9,
 		},
+		.reset_id = TEGRA30_MC_RESET_2D,
 	}, {
 		.id = 0x31,
 		.name = "afiw",
@@ -696,6 +745,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0c,
 		},
+		.reset_id = TEGRA30_MC_RESET_AFI,
 	}, {
 		.id = 0x32,
 		.name = "avpcarm7w",
@@ -710,6 +760,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x33,
 		.name = "fdcdwr",
@@ -724,6 +775,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0a,
 		},
+		.reset_id = TEGRA30_MC_RESET_3D,
 	}, {
 		.id = 0x34,
 		.name = "fdcwr2",
@@ -738,6 +790,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0a,
 		},
+		.reset_id = TEGRA30_MC_RESET_3D2,
 	}, {
 		.id = 0x35,
 		.name = "hdaw",
@@ -752,6 +805,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x36,
 		.name = "host1xw",
@@ -766,6 +820,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.reset_id = TEGRA30_MC_RESET_HC,
 	}, {
 		.id = 0x37,
 		.name = "ispw",
@@ -780,6 +835,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA30_MC_RESET_ISP,
 	}, {
 		.id = 0x38,
 		.name = "mpcorelpw",
@@ -790,6 +846,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x39,
 		.name = "mpcorew",
@@ -800,6 +857,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x0e,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3a,
 		.name = "mpecswr",
@@ -814,6 +872,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA30_MC_RESET_MPE,
 	}, {
 		.id = 0x3b,
 		.name = "ppcsahbdmaw",
@@ -828,6 +887,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x10,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3c,
 		.name = "ppcsahbslvw",
@@ -842,6 +902,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x06,
 		},
+		.reset_id = TEGRA_MC_CLIENT_NO_RESET,
 	}, {
 		.id = 0x3d,
 		.name = "sataw",
@@ -856,6 +917,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x33,
 		},
+		.reset_id = TEGRA30_MC_RESET_SATA,
 	}, {
 		.id = 0x3e,
 		.name = "vdebsevw",
@@ -870,6 +932,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA30_MC_RESET_VDE,
 	}, {
 		.id = 0x3f,
 		.name = "vdedbgw",
@@ -884,6 +947,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0xff,
 		},
+		.reset_id = TEGRA30_MC_RESET_VDE,
 	}, {
 		.id = 0x40,
 		.name = "vdembew",
@@ -898,6 +962,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x42,
 		},
+		.reset_id = TEGRA30_MC_RESET_VDE,
 	}, {
 		.id = 0x41,
 		.name = "vdetpmw",
@@ -912,6 +977,7 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 			.mask = 0xff,
 			.def = 0x2a,
 		},
+		.reset_id = TEGRA30_MC_RESET_VDE,
 	},
 };
 
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 5bf72eb4dd51..ba64cb7a1d0c 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -35,10 +35,13 @@ struct tegra_mc_la {
 	unsigned int def;
 };
 
+#define TEGRA_MC_CLIENT_NO_RESET	UINT_MAX
+
 struct tegra_mc_client {
 	unsigned int id;
 	const char *name;
 	unsigned int swgroup;
+	unsigned int reset_id;
 
 	unsigned int fifo_size;
 
-- 
2.17.0
