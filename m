Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9458CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD672175F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM88Lo/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD672175F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeHRTRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:17:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42807 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeHRTRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:17:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4-v6so6106940edp.9;
        Sat, 18 Aug 2018 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zud3fnRRc1A/EmHayDTnkRDCfwFTioPdxC2SN4HWKtk=;
        b=bM88Lo/83gOC9peMRtz69fwkm0bcMN5r6/VDp/MQqAXkWWM1eC/2CM4Bxfu0KiRUdx
         YH7zv1AEQV+kVn/OEjnuOFbI95gpj5UaPy/R+XDw5DQq/noqliAJQCqZUCjVzVXyAVDz
         KbkvnTuknnv23ObZVBfuadCJGrgM4Ut95oUTz9s9G8z6GrmoYQQQfVw8PGs2WVlb1BO3
         fR/71QadTXkKf9miQ0lHqRI/sT+R8nq686SYVn+hBBEHoq8zUrQSfkYLnYiMbdiOHvTB
         jTmudhpGV4J18QMPtz2umWjk3GRVB4a8ChDRseTUWVE68DxojRjML+uC0vezkC0Ckbpc
         ixfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zud3fnRRc1A/EmHayDTnkRDCfwFTioPdxC2SN4HWKtk=;
        b=HP8nP9ECeVbhslp37Njr+ZmHyNXZMnG1DvGfDtKtZ4e0T5SiSPqzDz/6Vb6dP+QNVj
         wQjXavh5rfmBxZCJfdVR53KMpGoKJhL07TkLlxEQUfBUi77zNeC3aXBr/MGEGGzNaDuW
         8ZdbeZn/IlE1iV8E8NupXWUcwKHE8GhbV3Ir44xjG0bAiF+037LQfT7mdu9fEC3mdM1V
         SfNreMYCVMOKNs2oUe157ku3vI0g+d/WgcPbp5l+szzntk+tczeT/ow7Ee/st3C+nPiC
         XYS18rQ6SvXwAWfMDC71Z1QNvlcf80xl01rUSoEY2IxX1YtbFBcP9YWurRvwjk7DX7q2
         b04A==
X-Gm-Message-State: AOUpUlHZNnEcZREzZQojsS/RAekvw1vAyCLlPOsnW8dx1yLU68ZEvBGD
        ApIxVewf73nw2XY1SZWZ0DE=
X-Google-Smtp-Source: AA+uWPzNVjmYOLNN20JQ3QeMWdpqp2JMbzsbrrKXyJPVGkPm/fJC72s3vIAchKboB6nc9BxY0FI2Zg==
X-Received: by 2002:a50:b86f:: with SMTP id k44-v6mr46264243ede.310.1534608546888;
        Sat, 18 Aug 2018 09:09:06 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j10-v6sm2751211eds.8.2018.08.18.09.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 09:09:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] clk: tegra20: Enable lock-status polling for PLLs
Date:   Sat, 18 Aug 2018 19:08:28 +0300
Message-Id: <20180818160828.8198-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818160828.8198-1-digetx@gmail.com>
References: <20180818160828.8198-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all PLL's on Tegra20 use a hardcoded delay despite of having
a lock-status bit. The lock-status polling was disabled ~7 years ago
because apparently some PLL was failing to lock. That issue isn't
observable with the modern kernel, hence let's assume it was some
unrelated bug and enable the lock-status polling. This significantly
reduces delay of any operation that require PLL to lock.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index cc857d4d4a86..75415854ce12 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -298,7 +298,8 @@ static struct tegra_clk_pll_params pll_c_params = {
 	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
 	.lock_delay = 300,
 	.freq_table = pll_c_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static struct tegra_clk_pll_params pll_m_params = {
@@ -314,7 +315,8 @@ static struct tegra_clk_pll_params pll_m_params = {
 	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
 	.lock_delay = 300,
 	.freq_table = pll_m_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static struct tegra_clk_pll_params pll_p_params = {
@@ -331,7 +333,7 @@ static struct tegra_clk_pll_params pll_p_params = {
 	.lock_delay = 300,
 	.freq_table = pll_p_freq_table,
 	.flags = TEGRA_PLL_FIXED | TEGRA_PLL_HAS_CPCON |
-		 TEGRA_PLL_HAS_LOCK_ENABLE,
+		 TEGRA_PLL_HAS_LOCK_ENABLE | TEGRA_PLL_USE_LOCK,
 	.fixed_rate =  216000000,
 };
 
@@ -348,7 +350,8 @@ static struct tegra_clk_pll_params pll_a_params = {
 	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
 	.lock_delay = 300,
 	.freq_table = pll_a_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static struct tegra_clk_pll_params pll_d_params = {
@@ -364,7 +367,8 @@ static struct tegra_clk_pll_params pll_d_params = {
 	.lock_enable_bit_idx = PLLDU_MISC_LOCK_ENABLE,
 	.lock_delay = 1000,
 	.freq_table = pll_d_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static const struct pdiv_map pllu_p[] = {
@@ -387,7 +391,8 @@ static struct tegra_clk_pll_params pll_u_params = {
 	.lock_delay = 1000,
 	.pdiv_tohw = pllu_p,
 	.freq_table = pll_u_freq_table,
-	.flags = TEGRA_PLLU | TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLLU | TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static struct tegra_clk_pll_params pll_x_params = {
@@ -403,7 +408,8 @@ static struct tegra_clk_pll_params pll_x_params = {
 	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
 	.lock_delay = 300,
 	.freq_table = pll_x_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static struct tegra_clk_pll_params pll_e_params = {
@@ -421,7 +427,7 @@ static struct tegra_clk_pll_params pll_e_params = {
 	.pdiv_tohw = plle_p,
 	.freq_table = pll_e_freq_table,
 	.flags = TEGRA_PLL_FIXED | TEGRA_PLL_LOCK_MISC |
-		 TEGRA_PLL_HAS_LOCK_ENABLE,
+		 TEGRA_PLL_HAS_LOCK_ENABLE | TEGRA_PLL_USE_LOCK,
 	.fixed_rate = 100000000,
 };
 
-- 
2.18.0

