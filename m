Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C230C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDF5213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDF5213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbeGLMCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:02:41 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15532 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeGLMCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:02:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b47410b0000>; Thu, 12 Jul 2018 04:52:43 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 12 Jul 2018 04:53:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 12 Jul 2018 04:53:28 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 12 Jul
 2018 11:53:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 12 Jul 2018 11:53:06 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b4741200000>; Thu, 12 Jul 2018 04:53:06 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v6 0/4] Multiplex sdmmc low jitter clock path
Date:   Thu, 12 Jul 2018 14:52:58 +0300
Message-ID: <1531396382-5579-1-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDMMC clocks have a Low Jitter (LJ) clock path which bypasses a
divider to achieve better jitter performance with high speed signaling
modes. The clock path with the divider is needed by some of the slower
signaling modes. This series automatically multiplexes the LJ and
non-LJ clock paths based on the requested frequency.

Changelog:
v6:
	- Rename div-frac.c to clk-utils.c
	- Fix checkpatch errors and warnings introduced in v5
	- Replace int mul = 2 with a macro in clk-sdmmc-mux.c
	- Remove unnecessary space from clk_sdmmc_mux_enable() return
	- Free sdmmc_mux if clk_register() fails in
	  tegra_clk_register_sdmmc_mux_div()

v5:
	- Rename div71_get() to div_frac_get()
	- Rename div71.c to div-frac.c

v4:
	- Add a changelog

v3:
	- Use <asm/div64.h> include instead of <linux/kernel.h> for
	  do_div()
	- Use SPDX tags for new files
	- Make mux_lj_idx[] and mux_non_lj_idx[] const
	- Make tegra_clk_sdmmc_mux_ops static
	- Fix the includes for fence_udelay() in a separate patch

v2:
	- Fix the type compatibility error on do_div

Aapo Vienamo (1):
  clk: tegra: Fix includes required by fence_udelay()

Peter De Schrijver (1):
  clk: tegra: Refactor fractional divider calculation

Peter De-Schrijver (2):
  clk: tegra: Add sdmmc mux divider clock
  clk: tegra: make sdmmc2 and sdmmc4 as sdmmc clocks

 drivers/clk/tegra/Makefile           |   2 +
 drivers/clk/tegra/clk-divider.c      |  30 +----
 drivers/clk/tegra/clk-id.h           |   2 -
 drivers/clk/tegra/clk-sdmmc-mux.c    | 251 +++++++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk-tegra-periph.c |  11 --
 drivers/clk/tegra/clk-tegra210.c     |  14 +-
 drivers/clk/tegra/clk-utils.c        |  43 ++++++
 drivers/clk/tegra/clk.h              |  30 +++++
 8 files changed, 343 insertions(+), 40 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-sdmmc-mux.c
 create mode 100644 drivers/clk/tegra/clk-utils.c

-- 
2.7.4

