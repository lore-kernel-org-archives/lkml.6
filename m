Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97958C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDFF218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfBAOk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:40:26 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:39388 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfBAOk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:40:26 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id E859313F86A;
        Fri,  1 Feb 2019 15:40:10 +0100 (CET)
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: msm8998: Hacking the USB3 controller (force controller to host/source
 mode)
Message-ID: <00358fd5-1702-ec4c-8400-3807d50614c6@free.fr>
Date:   Fri, 1 Feb 2019 15:40:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Still no cookie. Perhaps VBUS needs to be kicked in the nads...
Boot log at https://pastebin.ubuntu.com/p/3fqgQkRmyF/
---
 drivers/base/regmap/regmap.c |  1 +
 drivers/mfd/qcom-spmi-pmic.c |  8 +++++++-
 drivers/spmi/spmi-pmic-arb.c | 10 +++++++++
 drivers/spmi/spmi.c          |  4 ++--
 lib/Makefile                 |  2 ++
 lib/usb.c                    | 39 ++++++++++++++++++++++++++++++++++++
 6 files changed, 61 insertions(+), 3 deletions(-)
 create mode 100644 lib/usb.c

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4f822e087def..7957a803683b 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2879,6 +2879,7 @@ static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 
 		tmp = orig & ~mask;
 		tmp |= val & mask;
+		printk("%s: reg=%x old=%x new=%x\n", __func__, reg, orig, tmp);
 
 		if (force_write || (tmp != orig)) {
 			ret = _regmap_write(map, reg, tmp);
diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index e2e95de649a4..2b2283d1f2cf 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -124,8 +124,11 @@ static const struct regmap_config spmi_regmap_config = {
 	.fast_io	= true,
 };
 
+extern int my_smblib_set_prop_typec_power_role(struct regmap *map);
+
 static int pmic_spmi_probe(struct spmi_device *sdev)
 {
+	int err;
 	struct regmap *regmap;
 
 	regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
@@ -136,7 +139,10 @@ static int pmic_spmi_probe(struct spmi_device *sdev)
 	if (sdev->usid % 2 == 0)
 		pmic_spmi_show_revid(regmap, &sdev->dev);
 
-	return devm_of_platform_populate(&sdev->dev);
+	err = devm_of_platform_populate(&sdev->dev);
+	if (sdev->usid == 2) // Trying to reach pmi8998_pdphy
+		my_smblib_set_prop_typec_power_role(regmap);
+	return err;
 }
 
 MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 360b8218f322..4ffed22c77ed 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -341,6 +341,12 @@ static int pmic_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
 	return pmic_arb->ver_ops->non_data_cmd(ctrl, opc, sid);
 }
 
+#ifdef FOO
+extern void my_dump_stack(int depth);
+#else
+static void my_dump_stack(int depth) { }
+#endif
+
 static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 			     u16 addr, u8 *buf, size_t len)
 {
@@ -351,6 +357,8 @@ static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	int rc;
 	u32 offset;
 
+	printk("%s: opcode=%x sid=%x addr=%x len=%zu\n", __func__, opc, sid, addr, len);
+	my_dump_stack(14);
 	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr,
 				       PMIC_ARB_CHANNEL_OBS);
 	if (rc < 0)
@@ -404,6 +412,8 @@ static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	int rc;
 	u32 offset;
 
+	printk("%s: opcode=%x sid=%x addr=%x len=%zu\n", __func__, opc, sid, addr, len);
+	my_dump_stack(14);
 	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr,
 					PMIC_ARB_CHANNEL_RW);
 	if (rc < 0)
diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index aa3edabc2b0f..f8d42895c905 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -109,7 +109,7 @@ spmi_cmd(struct spmi_controller *ctrl, u8 opcode, u8 sid)
 	return ret;
 }
 
-static inline int spmi_read_cmd(struct spmi_controller *ctrl, u8 opcode,
+static int spmi_read_cmd(struct spmi_controller *ctrl, u8 opcode,
 				u8 sid, u16 addr, u8 *buf, size_t len)
 {
 	int ret;
@@ -123,7 +123,7 @@ static inline int spmi_read_cmd(struct spmi_controller *ctrl, u8 opcode,
 	return ret;
 }
 
-static inline int spmi_write_cmd(struct spmi_controller *ctrl, u8 opcode,
+static int spmi_write_cmd(struct spmi_controller *ctrl, u8 opcode,
 				 u8 sid, u16 addr, const u8 *buf, size_t len)
 {
 	int ret;
diff --git a/lib/Makefile b/lib/Makefile
index bff7337b46f8..8b2665edb68c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -3,6 +3,8 @@
 # Makefile for some libs needed in the kernel.
 #
 
+obj-y += usb.o
+
 ifdef CONFIG_FUNCTION_TRACER
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
diff --git a/lib/usb.c b/lib/usb.c
new file mode 100644
index 000000000000..cb5d4f850620
--- /dev/null
+++ b/lib/usb.c
@@ -0,0 +1,39 @@
+#include <linux/regmap.h>
+
+#define DFP_EN_CMD_BIT BIT(1)
+
+#define USBIN_BASE	0x1300
+#define MISC_BASE	0x1600
+
+#define TM_IO_DTEST4_SEL (MISC_BASE + 0xe9)
+#define TYPE_C_INTRPT_ENB_SOFTWARE_CTRL_REG (USBIN_BASE + 0x68)
+#define TYPEC_POWER_ROLE_CMD_MASK GENMASK(2, 0)
+
+static int smblib_write(struct regmap *map, u16 addr, u8 val)
+{
+	printk("%s: addr=%x val=%x", __func__, addr, val);
+	return regmap_write(map, addr, val);
+}
+
+static int smblib_masked_write(struct regmap *map, u16 addr, u8 mask, u8 val)
+{
+	printk("%s: addr=%x val=%x", __func__, addr, val);
+	return regmap_update_bits(map, addr, mask, val);
+}
+
+int my_smblib_set_prop_typec_power_role(struct regmap *map)
+{
+	int rc = 0;
+	int power_role = DFP_EN_CMD_BIT;
+
+	/* restore PBS workaround back to 0xA5 */
+	rc = smblib_write(map, TM_IO_DTEST4_SEL, 0xA5);
+	if (rc < 0)
+		pr_err("Couldn't write to TM_IO_DTEST4_SEL rc=%d\n", rc);
+
+	rc = smblib_masked_write(map, TYPE_C_INTRPT_ENB_SOFTWARE_CTRL_REG, TYPEC_POWER_ROLE_CMD_MASK, power_role);
+	if (rc < 0)
+		pr_err("Couldn't write 0x%02x to TYPE_C_INTRPT_ENB_SOFTWARE_CTRL rc=%d\n", power_role, rc);
+
+	return rc;
+}
-- 
2.17.1
