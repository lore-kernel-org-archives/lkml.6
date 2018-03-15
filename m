Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbeCOOjc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:39:32 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35500 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbeCOOj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:39:29 -0400
X-Google-Smtp-Source: AG47ELtcMMI/xi4QWEPKr1ctdnz0DTsY54OAZo0q/+vVJn/YFI2QCXpv/AbZlUX+2d3SDL+N14p/LA==
From: srinivas.kandagatla@linaro.org
To: Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: david.brown@linaro.org, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] clk: qcom: rpmcc: Add support to XO buffered clocks
Date: Thu, 15 Mar 2018 14:37:24 +0000
Message-Id: <20180315143724.13859-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

XO is onchip buffer clock to generate 19.2MHz.

This patch adds support to 5 XO buffer clocks found on PMIC8921,
these buffer clocks can be controlled from external pin or in
manual mode.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/clk/qcom/clk-rpm.c             | 39 +++++++++++++++++++++++++++++++++-
 include/dt-bindings/clock/qcom,rpmcc.h |  5 +++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
index c60f61b10c7f..261f5505e714 100644
--- a/drivers/clk/qcom/clk-rpm.c
+++ b/drivers/clk/qcom/clk-rpm.c
@@ -29,6 +29,7 @@
 
 #define QCOM_RPM_MISC_CLK_TYPE				0x306b6c63
 #define QCOM_RPM_SCALING_ENABLE_ID			0x2
+#define QCOM_RPM_XO_MODE_ON				0x2
 
 #define DEFINE_CLK_RPM(_platform, _name, _active, r_id)			      \
 	static struct clk_rpm _platform##_##_active;			      \
@@ -56,6 +57,19 @@
 		},							      \
 	}
 
+#define DEFINE_CLK_RPM_XO_BUFFER(_platform, _name, _active, offset)	      \
+	static struct clk_rpm _platform##_##_name = {			      \
+		.rpm_clk_id = QCOM_RPM_CXO_BUFFERS,			      \
+		.xo_offset = (offset),					      \
+		.rate = 19200000,					      \
+		.hw.init = &(struct clk_init_data){			      \
+			.ops = &clk_rpm_fixed_ops,			      \
+			.name = #_name,					      \
+			.parent_names = (const char *[]){ "pxo_board" },      \
+			.num_parents = 1,				      \
+		},							      \
+	}
+
 #define DEFINE_CLK_RPM_FIXED(_platform, _name, _active, r_id, r)	      \
 	static struct clk_rpm _platform##_##_name = {			      \
 		.rpm_clk_id = (r_id),					      \
@@ -128,6 +142,8 @@
 
 struct clk_rpm {
 	const int rpm_clk_id;
+	const int xo_offset;
+	u32 xo_buffer_value;
 	const bool active_only;
 	unsigned long rate;
 	bool enabled;
@@ -159,7 +175,8 @@ static int clk_rpm_handoff(struct clk_rpm *r)
 	 * The vendor tree simply reads the status for this
 	 * RPM clock.
 	 */
-	if (r->rpm_clk_id == QCOM_RPM_PLL_4)
+	if (r->rpm_clk_id == QCOM_RPM_PLL_4 ||
+		r->rpm_clk_id == QCOM_RPM_CXO_BUFFERS)
 		return 0;
 
 	ret = qcom_rpm_write(r->rpm, QCOM_RPM_ACTIVE_STATE,
@@ -294,6 +311,11 @@ static int clk_rpm_fixed_prepare(struct clk_hw *hw)
 	u32 value = 1;
 	int ret;
 
+	if (r->rpm_clk_id == QCOM_RPM_CXO_BUFFERS) {
+		r->xo_buffer_value |= (QCOM_RPM_XO_MODE_ON << r->xo_offset);
+		value = r->xo_buffer_value;
+	}
+
 	ret = qcom_rpm_write(r->rpm, QCOM_RPM_ACTIVE_STATE,
 			     r->rpm_clk_id, &value, 1);
 	if (!ret)
@@ -308,6 +330,11 @@ static void clk_rpm_fixed_unprepare(struct clk_hw *hw)
 	u32 value = 0;
 	int ret;
 
+	if (r->rpm_clk_id == QCOM_RPM_CXO_BUFFERS) {
+		r->xo_buffer_value &= ~(QCOM_RPM_XO_MODE_ON << r->xo_offset);
+		value = r->xo_buffer_value;
+	}
+
 	ret = qcom_rpm_write(r->rpm, QCOM_RPM_ACTIVE_STATE,
 			     r->rpm_clk_id, &value, 1);
 	if (!ret)
@@ -449,6 +476,11 @@ DEFINE_CLK_RPM(apq8064, mmfpb_clk, mmfpb_a_clk, QCOM_RPM_MMFPB_CLK);
 DEFINE_CLK_RPM(apq8064, sfab_clk, sfab_a_clk, QCOM_RPM_SYS_FABRIC_CLK);
 DEFINE_CLK_RPM(apq8064, sfpb_clk, sfpb_a_clk, QCOM_RPM_SFPB_CLK);
 DEFINE_CLK_RPM(apq8064, qdss_clk, qdss_a_clk, QCOM_RPM_QDSS_CLK);
+DEFINE_CLK_RPM_XO_BUFFER(apq8064, xo_d0_clk, xo_d0_a_clk, 0);
+DEFINE_CLK_RPM_XO_BUFFER(apq8064, xo_d1_clk, xo_d1_a_clk, 8);
+DEFINE_CLK_RPM_XO_BUFFER(apq8064, xo_a0_clk, xo_a0_a_clk, 16);
+DEFINE_CLK_RPM_XO_BUFFER(apq8064, xo_a1_clk, xo_a1_a_clk, 24);
+DEFINE_CLK_RPM_XO_BUFFER(apq8064, xo_a2_clk, xo_a2_a_clk, 28);
 
 static struct clk_rpm *apq8064_clks[] = {
 	[RPM_APPS_FABRIC_CLK] = &apq8064_afab_clk,
@@ -469,6 +501,11 @@ static struct clk_rpm *apq8064_clks[] = {
 	[RPM_SFPB_A_CLK] = &apq8064_sfpb_a_clk,
 	[RPM_QDSS_CLK] = &apq8064_qdss_clk,
 	[RPM_QDSS_A_CLK] = &apq8064_qdss_a_clk,
+	[RPM_XO_D0] = &apq8064_xo_d0_clk,
+	[RPM_XO_D1] = &apq8064_xo_d1_clk,
+	[RPM_XO_A0] = &apq8064_xo_a0_clk,
+	[RPM_XO_A1] = &apq8064_xo_a1_clk,
+	[RPM_XO_A2] = &apq8064_xo_a2_clk,
 };
 
 static const struct rpm_clk_desc rpm_clk_apq8064 = {
diff --git a/include/dt-bindings/clock/qcom,rpmcc.h b/include/dt-bindings/clock/qcom,rpmcc.h
index b8337a5fa347..c585b82b9c05 100644
--- a/include/dt-bindings/clock/qcom,rpmcc.h
+++ b/include/dt-bindings/clock/qcom,rpmcc.h
@@ -40,6 +40,11 @@
 #define RPM_SMI_CLK				22
 #define RPM_SMI_A_CLK				23
 #define RPM_PLL4_CLK				24
+#define RPM_XO_D0				25
+#define RPM_XO_D1				26
+#define RPM_XO_A0				27
+#define RPM_XO_A1				28
+#define RPM_XO_A2				29
 
 /* SMD RPM clocks */
 #define RPM_SMD_XO_CLK_SRC				0
-- 
2.16.2
