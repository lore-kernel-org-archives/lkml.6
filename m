Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754368AbeCROqR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 10:46:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55157 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeCROqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 10:46:14 -0400
X-Google-Smtp-Source: AG47ELui924T8EpW7mieuhQJayfwjDTSfovPProH+2HEdwoUFNJ9LbJ6L/h0l3t4hDONkb7FK06BvQ==
From: srinivas.kandagatla@linaro.org
To: Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: david.brown@linaro.org, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] clk: qcom: rpmcc: Add support to XO buffered clocks
Date: Sun, 18 Mar 2018 14:44:01 +0000
Message-Id: <20180318144401.21904-1-srinivas.kandagatla@linaro.org>
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
Changes since v1:
 - Made buffer clk word global and protected it by mutex, suggested by S Boyd.
 - removed rate from clock define as it can be derived from parent clk rate,
	 suggested by S Boyd.

 drivers/clk/qcom/clk-rpm.c             | 79 +++++++++++++++++++++++++++++++++-
 include/dt-bindings/clock/qcom,rpmcc.h |  5 +++
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
index c60f61b10c7f..b94981447664 100644
--- a/drivers/clk/qcom/clk-rpm.c
+++ b/drivers/clk/qcom/clk-rpm.c
@@ -29,6 +29,7 @@
 
 #define QCOM_RPM_MISC_CLK_TYPE				0x306b6c63
 #define QCOM_RPM_SCALING_ENABLE_ID			0x2
+#define QCOM_RPM_XO_MODE_ON				0x2
 
 #define DEFINE_CLK_RPM(_platform, _name, _active, r_id)			      \
 	static struct clk_rpm _platform##_##_active;			      \
@@ -56,6 +57,18 @@
 		},							      \
 	}
 
+#define DEFINE_CLK_RPM_XO_BUFFER(_platform, _name, _active, offset)	      \
+	static struct clk_rpm _platform##_##_name = {			      \
+		.rpm_clk_id = QCOM_RPM_CXO_BUFFERS,			      \
+		.xo_offset = (offset),					      \
+		.hw.init = &(struct clk_init_data){			      \
+			.ops = &clk_rpm_xo_ops,			      \
+			.name = #_name,					      \
+			.parent_names = (const char *[]){ "cxo_board" },      \
+			.num_parents = 1,				      \
+		},							      \
+	}
+
 #define DEFINE_CLK_RPM_FIXED(_platform, _name, _active, r_id, r)	      \
 	static struct clk_rpm _platform##_##_name = {			      \
 		.rpm_clk_id = (r_id),					      \
@@ -126,8 +139,11 @@
 
 #define to_clk_rpm(_hw) container_of(_hw, struct clk_rpm, hw)
 
+struct rpm_cc;
+
 struct clk_rpm {
 	const int rpm_clk_id;
+	const int xo_offset;
 	const bool active_only;
 	unsigned long rate;
 	bool enabled;
@@ -135,12 +151,15 @@ struct clk_rpm {
 	struct clk_rpm *peer;
 	struct clk_hw hw;
 	struct qcom_rpm *rpm;
+	struct rpm_cc *rpm_cc;
 };
 
 struct rpm_cc {
 	struct qcom_rpm *rpm;
 	struct clk_rpm **clks;
 	size_t num_clks;
+	u32 xo_buffer_value;
+	struct mutex xo_lock;
 };
 
 struct rpm_clk_desc {
@@ -159,7 +178,8 @@ static int clk_rpm_handoff(struct clk_rpm *r)
 	 * The vendor tree simply reads the status for this
 	 * RPM clock.
 	 */
-	if (r->rpm_clk_id == QCOM_RPM_PLL_4)
+	if (r->rpm_clk_id == QCOM_RPM_PLL_4 ||
+		r->rpm_clk_id == QCOM_RPM_CXO_BUFFERS)
 		return 0;
 
 	ret = qcom_rpm_write(r->rpm, QCOM_RPM_ACTIVE_STATE,
@@ -288,6 +308,46 @@ static void clk_rpm_unprepare(struct clk_hw *hw)
 	mutex_unlock(&rpm_clk_lock);
 }
 
+static int clk_rpm_xo_prepare(struct clk_hw *hw)
+{
+	struct clk_rpm *r = to_clk_rpm(hw);
+	struct rpm_cc *rcc = r->rpm_cc;
+	int ret, clk_id = r->rpm_clk_id;
+	u32 value;
+
+	mutex_lock(&rcc->xo_lock);
+
+	value = rcc->xo_buffer_value | (QCOM_RPM_XO_MODE_ON << r->xo_offset);
+	ret = qcom_rpm_write(r->rpm, QCOM_RPM_ACTIVE_STATE, clk_id, &value, 1);
+	if (!ret) {
+		r->enabled = true;
+		rcc->xo_buffer_value = value;
+	}
+
+	mutex_unlock(&rcc->xo_lock);
+
+	return ret;
+}
+
+static void clk_rpm_xo_unprepare(struct clk_hw *hw)
+{
+	struct clk_rpm *r = to_clk_rpm(hw);
+	struct rpm_cc *rcc = r->rpm_cc;
+	int ret, clk_id = r->rpm_clk_id;
+	u32 value;
+
+	mutex_lock(&rcc->xo_lock);
+
+	value = rcc->xo_buffer_value & ~(QCOM_RPM_XO_MODE_ON << r->xo_offset);
+	ret = qcom_rpm_write(r->rpm, QCOM_RPM_ACTIVE_STATE, clk_id, &value, 1);
+	if (!ret) {
+		r->enabled = false;
+		rcc->xo_buffer_value = value;
+	}
+
+	mutex_unlock(&rcc->xo_lock);
+}
+
 static int clk_rpm_fixed_prepare(struct clk_hw *hw)
 {
 	struct clk_rpm *r = to_clk_rpm(hw);
@@ -378,6 +438,11 @@ static unsigned long clk_rpm_recalc_rate(struct clk_hw *hw,
 	return r->rate;
 }
 
+static const struct clk_ops clk_rpm_xo_ops = {
+	.prepare	= clk_rpm_xo_prepare,
+	.unprepare	= clk_rpm_xo_unprepare,
+};
+
 static const struct clk_ops clk_rpm_fixed_ops = {
 	.prepare	= clk_rpm_fixed_prepare,
 	.unprepare	= clk_rpm_fixed_unprepare,
@@ -449,6 +514,11 @@ DEFINE_CLK_RPM(apq8064, mmfpb_clk, mmfpb_a_clk, QCOM_RPM_MMFPB_CLK);
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
@@ -469,6 +539,11 @@ static struct clk_rpm *apq8064_clks[] = {
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
@@ -526,12 +601,14 @@ static int rpm_clk_probe(struct platform_device *pdev)
 
 	rcc->clks = rpm_clks;
 	rcc->num_clks = num_clks;
+	mutex_init(&rcc->xo_lock);
 
 	for (i = 0; i < num_clks; i++) {
 		if (!rpm_clks[i])
 			continue;
 
 		rpm_clks[i]->rpm = rpm;
+		rpm_clks[i]->rpm_cc = rcc;
 
 		ret = clk_rpm_handoff(rpm_clks[i]);
 		if (ret)
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
