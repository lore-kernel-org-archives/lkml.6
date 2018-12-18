Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAE2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B0C206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J797nWrE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="akg4KkbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeLRCM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:12:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56414 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeLRCM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:12:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D161F6021A; Tue, 18 Dec 2018 02:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545099146;
        bh=y/4n2cNWK2JRyr395uAopRw/3ZJmUBfWa/HsxDcVcg0=;
        h=From:To:Cc:Subject:Date:From;
        b=J797nWrEgIpM+830XLqkvAQ6wo9wDhwXCMBDOkah05UZK9emkih7NuCvxBZ4T6tFZ
         44AESIb43PBtvBEJo64Mrihto5T+Ga+AL0l+AGXvI6cuyGpo81lgIIhvIHc3T5v2u7
         jfdxwe/RxlNoXam4iueGHeBpoZ4sIyMKVATxQPGI=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0CBC602F7;
        Tue, 18 Dec 2018 02:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545099145;
        bh=y/4n2cNWK2JRyr395uAopRw/3ZJmUBfWa/HsxDcVcg0=;
        h=From:To:Cc:Subject:Date:From;
        b=akg4KkbOAgbAaqPmTjEsnLx07ZTTNUXIlQdp1m+WSwbQFsXQnMlEEQgLxHLgkBoVL
         9RYqcr4kFR/4DY1xrmleB6IrD7rvwBtsibIsX1YWmsEU/XWuH0EHEV8Mm67n3qGLfi
         3qBSdSgtLvd1D6BXvQL2inhp5hr0/3eIGMvrBBrQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0CBC602F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     bjorn.andersson@linaro.org, marc.w.gonzalez@free.fr,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] clk: qcom: Add CLK_SET_RATE_PARENT for 8998 branch clocks
Date:   Mon, 17 Dec 2018 19:12:14 -0700
Message-Id: <1545099134-26471-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A branch clock is basically a clock that can be gated for power savings,
but is also what devices/drivers consume.  Configuring a branch clock's
rate needs to be done at the source, so for all branch clocks which have
a defined parent, set CLK_SET_RATE_PARENT so that clk_set_rate() calls on
branch clocks can do what is expected.  This is important as most drivers
do not check the resulting clock rate after a successful clk_set_rate()
call, thus the driver may get out of sync with the actual hardware state
and weird issues might crop up.  This has been observed with issues
getting SDHCI to reliably support "fast" cards such as SDR104.

Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8998.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 1b77939..b618bbf 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -1189,6 +1189,7 @@ enum {
 				"ufs_axi_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1206,6 +1207,7 @@ enum {
 				"usb30_master_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1288,6 +1290,7 @@ enum {
 				"blsp1_qup1_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1305,6 +1308,7 @@ enum {
 				"blsp1_qup1_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1322,6 +1326,7 @@ enum {
 				"blsp1_qup2_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1339,6 +1344,7 @@ enum {
 				"blsp1_qup2_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1356,6 +1362,7 @@ enum {
 				"blsp1_qup3_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1373,6 +1380,7 @@ enum {
 				"blsp1_qup3_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1390,6 +1398,7 @@ enum {
 				"blsp1_qup4_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1407,6 +1416,7 @@ enum {
 				"blsp1_qup4_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1424,6 +1434,7 @@ enum {
 				"blsp1_qup5_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1441,6 +1452,7 @@ enum {
 				"blsp1_qup5_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1458,6 +1470,7 @@ enum {
 				"blsp1_qup6_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1475,6 +1488,7 @@ enum {
 				"blsp1_qup6_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1505,6 +1519,7 @@ enum {
 				"blsp1_uart1_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1522,6 +1537,7 @@ enum {
 				"blsp1_uart2_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1539,6 +1555,7 @@ enum {
 				"blsp1_uart3_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1569,6 +1586,7 @@ enum {
 				"blsp2_qup1_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1586,6 +1604,7 @@ enum {
 				"blsp2_qup1_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1603,6 +1622,7 @@ enum {
 				"blsp2_qup2_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1620,6 +1640,7 @@ enum {
 				"blsp2_qup2_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1637,6 +1658,7 @@ enum {
 				"blsp2_qup3_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1654,6 +1676,7 @@ enum {
 				"blsp2_qup3_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1671,6 +1694,7 @@ enum {
 				"blsp2_qup4_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1688,6 +1712,7 @@ enum {
 				"blsp2_qup4_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1705,6 +1730,7 @@ enum {
 				"blsp2_qup5_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1722,6 +1748,7 @@ enum {
 				"blsp2_qup5_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1739,6 +1766,7 @@ enum {
 				"blsp2_qup6_i2c_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1756,6 +1784,7 @@ enum {
 				"blsp2_qup6_spi_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1786,6 +1815,7 @@ enum {
 				"blsp2_uart1_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1803,6 +1833,7 @@ enum {
 				"blsp2_uart2_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1820,6 +1851,7 @@ enum {
 				"blsp2_uart3_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1837,6 +1869,7 @@ enum {
 				"usb30_master_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1854,6 +1887,7 @@ enum {
 				"gp1_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1871,6 +1905,7 @@ enum {
 				"gp2_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1888,6 +1923,7 @@ enum {
 				"gp3_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1957,6 +1993,7 @@ enum {
 				"hmss_ahb_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1987,6 +2024,7 @@ enum {
 				"hmss_rbcpr_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2088,6 +2126,7 @@ enum {
 				"pcie_aux_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2157,6 +2196,7 @@ enum {
 				"pcie_aux_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2174,6 +2214,7 @@ enum {
 				"pdm2_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2243,6 +2284,7 @@ enum {
 				"sdcc2_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2273,6 +2315,7 @@ enum {
 				"sdcc4_apps_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2316,6 +2359,7 @@ enum {
 				"tsif_ref_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2346,6 +2390,7 @@ enum {
 				"ufs_axi_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2441,6 +2486,7 @@ enum {
 				"usb30_master_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2458,6 +2504,7 @@ enum {
 				"usb30_mock_utmi_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2488,6 +2535,7 @@ enum {
 				"usb3_phy_aux_clk_src",
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

