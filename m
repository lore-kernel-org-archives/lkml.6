Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59296C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5532145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMfCEGWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5532145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeLCSfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:35:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42126 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeLCSfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:35:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so2086975plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OgjejpvvybYqYgPgu9pyioScdhfquILFMatsfrKQqTQ=;
        b=VMfCEGWvIxhPctLzM6oVz1mYwwer16KmoDOFl8TEGbS8BmqbIUxSlIYr2XD6fR5Tek
         CS4+/FZ73aC6NQNLlaOYKVhYwOpGGVKxbEBoEbplleXhRO/6fyzfVZpLpsK8XDonBEUI
         AP4JL09sDkcxaMNBRsis5B8l6vSrWUzMHFO0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OgjejpvvybYqYgPgu9pyioScdhfquILFMatsfrKQqTQ=;
        b=Giuuph89kwkUSXZadffRAR7MTNgFe+Hf+rhWL/qRVvpRjApaQxfY1AcLCQq0gblCAZ
         RpIs9Ex+SzLNEwOoYwfPMXz9GaNgtyYZDORyjgvGmzn1t6RmH1owr3VM0JIhfgGF9+a/
         izyUSlaztyodTerg9d401DIGCwtXvS7f75opV5dnVVhTOGDd2cHTrrXsLkukRhOI6S1S
         enm63zm89goZXdvm/O1H9wbdgsT2LgSmv5KxPhbQKrKEHF2E5Tp+ednbyafG/8ts8U3a
         89qjIW4SAr8hLbBADFPsMZ2wXe6QCt2uKb0un8cFwWwsucSJ9elHT+c3Kn++dwbltCQs
         5iuA==
X-Gm-Message-State: AA+aEWY4bsxZy0tIuPdEY2OCpGpIdsZJdNBkWwfVpWVFqReINNea89ka
        DqWMPyHVM8D8dRD7gXNWrmYKRw==
X-Google-Smtp-Source: AFSGD/UCl5/vwnhp9TI9FLWppXN546cKSlQ8OnLmZdfyxoTlGTV5ijoVZFiVZ/gVqX3lvTYJpfdGlw==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr16802137plm.234.1543862137072;
        Mon, 03 Dec 2018 10:35:37 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f6sm20180969pfg.188.2018.12.03.10.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:35:36 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 3/3] clk: qcom: gcc-msm8998: Add clkref clocks
Date:   Mon,  3 Dec 2018 10:33:30 -0800
Message-Id: <20181203183330.2073-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181203183330.2073-1-bjorn.andersson@linaro.org>
References: <20181203183330.2073-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clkref clocks for usb3, hdmi, ufs, pcie, and usb2. They are all
sourced off CXO_IN, so parent them off "xo" until a proper link to the
rpmcc can be described in DT.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/clk/qcom/gcc-msm8998.c               | 75 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8998.h |  5 ++
 2 files changed, 80 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 792b431f9945..717210f61d27 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2515,6 +2515,76 @@ static struct clk_branch gcc_usb_phy_cfg_ahb2phy_clk = {
 	},
 };
 
+static struct clk_branch gcc_hdmi_clkref_clk = {
+	.halt_reg = 0x88000,
+	.clkr = {
+		.enable_reg = 0x88000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_hdmi_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_clkref_clk = {
+	.halt_reg = 0x88004,
+	.clkr = {
+		.enable_reg = 0x88004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_clkref_clk = {
+	.halt_reg = 0x88008,
+	.clkr = {
+		.enable_reg = 0x88008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb3_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_clkref_clk = {
+	.halt_reg = 0x8800c,
+	.clkr = {
+		.enable_reg = 0x8800c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_pcie_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_rx1_usb2_clkref_clk = {
+	.halt_reg = 0x88014,
+	.clkr = {
+		.enable_reg = 0x88014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_rx1_usb2_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct gdsc pcie_0_gdsc = {
 	.gdscr = 0x6b004,
 	.gds_hw_ctrl = 0x0,
@@ -2705,6 +2775,11 @@ static struct clk_regmap *gcc_msm8998_clocks[] = {
 	[USB30_MASTER_CLK_SRC] = &usb30_master_clk_src.clkr,
 	[USB30_MOCK_UTMI_CLK_SRC] = &usb30_mock_utmi_clk_src.clkr,
 	[USB3_PHY_AUX_CLK_SRC] = &usb3_phy_aux_clk_src.clkr,
+	[GCC_HDMI_CLKREF_CLK] = &gcc_hdmi_clkref_clk.clkr,
+	[GCC_UFS_CLKREF_CLK] = &gcc_ufs_clkref_clk.clkr,
+	[GCC_USB3_CLKREF_CLK] = &gcc_usb3_clkref_clk.clkr,
+	[GCC_PCIE_CLKREF_CLK] = &gcc_pcie_clkref_clk.clkr,
+	[GCC_RX1_USB2_CLKREF_CLK] = &gcc_rx1_usb2_clkref_clk.clkr,
 };
 
 static struct gdsc *gcc_msm8998_gdscs[] = {
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8998.h b/include/dt-bindings/clock/qcom,gcc-msm8998.h
index 58a242e656b1..b3448800980a 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8998.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8998.h
@@ -180,6 +180,11 @@
 #define USB30_MASTER_CLK_SRC					163
 #define USB30_MOCK_UTMI_CLK_SRC					164
 #define USB3_PHY_AUX_CLK_SRC					165
+#define GCC_USB3_CLKREF_CLK					166
+#define GCC_HDMI_CLKREF_CLK					167
+#define GCC_UFS_CLKREF_CLK					168
+#define GCC_PCIE_CLKREF_CLK					169
+#define GCC_RX1_USB2_CLKREF_CLK					170
 
 #define PCIE_0_GDSC						0
 #define UFS_GDSC						1
-- 
2.18.0

