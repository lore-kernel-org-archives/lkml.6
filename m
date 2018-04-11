Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbeDKOJz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:09:55 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59914 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeDKOJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:09:54 -0400
X-Auth-Info: y4/TjYT6Vk6bz874jIZ5wshD01twXbISAG1KFYebbF8=
From: Lukasz Majewski <lukma@denx.de>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] mfd: mc13xxx: Add mc34708 adc support
Date: Wed, 11 Apr 2018 16:09:29 +0200
Message-Id: <20180411140929.30357-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The mc34708 has an improved adc. The older variants will always convert
a fixed order of channels. The mc34708 can do up to eight conversions
in arbitrary channel order. Currently this extended feature is not
supported. We only support touchscreen conversions now, which will
be sampled in a data format compatible to the older chips in order
to keep the API between the mfd and the touchscreen driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes from the original patches:
- ADC conversion functions prototypes added to fix build error
- Adjustments to make checkpatch clean (-ENOSYS, line over 80 char)
---
 drivers/mfd/mc13xxx-core.c | 118 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mfd/mc13xxx.h      |   3 ++
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index d7f54e492aa6..f48945c9be5b 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -48,6 +48,25 @@
 
 #define MC13XXX_ADC2		45
 
+#define MC34708_ADC3		46
+#define MC34708_ADC4		47
+
+#define MC13XXX_ADC_WORKING		(1 << 0)
+#define	MC34708_IRQ_TSDONE		1
+
+#define MC34708_ADC0_TSEN		(1 << 12)
+#define MC34708_ADC0_TSSTART		(1 << 13)
+#define MC34708_ADC0_TSSTOP(x)		(((x) & 0x7) << 16)
+
+#define MC34708_ADC3_TSSEL(step, ch)	((ch) << (8 + 2 * (step)))
+#define MC34708_ADC1_TSDLY1(d)		((d) << 12)
+#define MC34708_ADC1_TSDLY2(d)		((d) << 16)
+#define MC34708_ADC1_TSDLY3(d)		((d) << 20)
+
+#define MC34708_TS_X			1
+#define MC34708_TS_Y			2
+#define MC34708_TS_R			3
+
 void mc13xxx_lock(struct mc13xxx *mc13xxx)
 {
 	if (!mutex_trylock(&mc13xxx->lock)) {
@@ -201,22 +220,30 @@ static void mc34708_print_revision(struct mc13xxx *mc13xxx, u32 revision)
 			maskval(revision, MC34708_REVISION_FAB));
 }
 
+static int mc13xxx_adc_conversion(struct mc13xxx *, unsigned int,
+				  unsigned int, u8, bool, unsigned int *);
+static int mc34708_adc_conversion(struct mc13xxx *, unsigned int,
+				  unsigned int, u8, bool, unsigned int *);
+
 /* These are only exported for mc13xxx-i2c and mc13xxx-spi */
 struct mc13xxx_variant mc13xxx_variant_mc13783 = {
 	.name = "mc13783",
 	.print_revision = mc13xxx_print_revision,
+	.adc_do_conversion = mc13xxx_adc_conversion,
 };
 EXPORT_SYMBOL_GPL(mc13xxx_variant_mc13783);
 
 struct mc13xxx_variant mc13xxx_variant_mc13892 = {
 	.name = "mc13892",
 	.print_revision = mc13xxx_print_revision,
+	.adc_do_conversion = mc13xxx_adc_conversion,
 };
 EXPORT_SYMBOL_GPL(mc13xxx_variant_mc13892);
 
 struct mc13xxx_variant mc13xxx_variant_mc34708 = {
 	.name = "mc34708",
 	.print_revision = mc34708_print_revision,
+	.adc_do_conversion = mc34708_adc_conversion,
 };
 EXPORT_SYMBOL_GPL(mc13xxx_variant_mc34708);
 
@@ -252,7 +279,7 @@ static irqreturn_t mc13xxx_handler_adcdone(int irq, void *data)
 
 #define MC13XXX_ADC_WORKING (1 << 0)
 
-int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
+static int mc13xxx_adc_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 		unsigned int channel, u8 ato, bool atox,
 		unsigned int *sample)
 {
@@ -345,6 +372,95 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 
 	return ret;
 }
+
+static int mc34708_adc_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
+		unsigned int channel, u8 ato, bool atox,
+		unsigned int *sample)
+{
+	int ret, i;
+	u32 adc0, adc3, adc1, old_adc0;
+	struct mc13xxx_adcdone_data adcdone_data = {
+		.mc13xxx = mc13xxx,
+	};
+
+	switch (mode) {
+	case MC13XXX_ADC_MODE_TS:
+		adc0 = MC34708_ADC0_TSEN | MC34708_ADC0_TSSTART |
+			MC34708_ADC0_TSSTOP(7);
+
+		adc1 = MC34708_ADC1_TSDLY1(0xf) |
+			MC34708_ADC1_TSDLY2(0xf) |
+			MC34708_ADC1_TSDLY3(0xf);
+
+		adc3 = MC34708_ADC3_TSSEL(0, MC34708_TS_X) |
+			MC34708_ADC3_TSSEL(1, MC34708_TS_Y) |
+			MC34708_ADC3_TSSEL(2, MC34708_TS_X) |
+			MC34708_ADC3_TSSEL(3, MC34708_TS_Y) |
+			MC34708_ADC3_TSSEL(4, MC34708_TS_X) |
+			MC34708_ADC3_TSSEL(5, MC34708_TS_R) |
+			MC34708_ADC3_TSSEL(6, MC34708_TS_Y) |
+			MC34708_ADC3_TSSEL(7, MC34708_TS_R);
+		break;
+
+	case MC13XXX_ADC_MODE_SINGLE_CHAN:
+	case MC13XXX_ADC_MODE_MULT_CHAN:
+	default:
+		return -EINVAL;
+	}
+
+	init_completion(&adcdone_data.done);
+
+	mc13xxx_lock(mc13xxx);
+
+	if (mc13xxx->adcflags & MC13XXX_ADC_WORKING) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	mc13xxx->adcflags |= MC13XXX_ADC_WORKING;
+
+	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
+
+	mc13xxx_irq_request(mc13xxx, MC34708_IRQ_TSDONE,
+			mc13xxx_handler_adcdone, __func__, &adcdone_data);
+	mc13xxx_irq_ack(mc13xxx, MC34708_IRQ_TSDONE);
+
+	mc13xxx_reg_write(mc13xxx, MC34708_ADC3, adc3);
+	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC1, adc1);
+	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC0, adc0);
+
+	mc13xxx_unlock(mc13xxx);
+
+	ret = wait_for_completion_interruptible_timeout(&adcdone_data.done, HZ);
+
+	mc13xxx_lock(mc13xxx);
+
+	mc13xxx_irq_free(mc13xxx, MC34708_IRQ_TSDONE, &adcdone_data);
+
+	if (!ret) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	for (i = 0; i < 4; i++)
+		mc13xxx_reg_read(mc13xxx, MC34708_ADC4 + i, &sample[i]);
+
+out:
+	ret = mc13xxx_reg_write(mc13xxx, MC13XXX_ADC0, old_adc0);
+
+	mc13xxx->adcflags &= ~MC13XXX_ADC_WORKING;
+	mc13xxx_unlock(mc13xxx);
+
+	return ret;
+}
+
+int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
+		unsigned int channel, u8 ato, bool atox,
+		unsigned int *sample)
+{
+	return mc13xxx->variant->adc_do_conversion(mc13xxx, mode, channel, ato,
+			atox, sample);
+}
 EXPORT_SYMBOL_GPL(mc13xxx_adc_do_conversion);
 
 static int mc13xxx_add_subdevice_pdata(struct mc13xxx *mc13xxx,
diff --git a/drivers/mfd/mc13xxx.h b/drivers/mfd/mc13xxx.h
index 33677d1dcf66..17001116d638 100644
--- a/drivers/mfd/mc13xxx.h
+++ b/drivers/mfd/mc13xxx.h
@@ -22,6 +22,9 @@ struct mc13xxx;
 struct mc13xxx_variant {
 	const char *name;
 	void (*print_revision)(struct mc13xxx *mc13xxx, u32 revision);
+	int (*adc_do_conversion)(struct mc13xxx *mc13xxx, unsigned int mode,
+		unsigned int channel, u8 ato, bool atox,
+		unsigned int *sample);
 };
 
 extern struct mc13xxx_variant
-- 
2.11.0
