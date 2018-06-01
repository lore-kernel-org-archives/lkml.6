Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750795AbeFABiq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:38:46 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42457 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFABim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:38:42 -0400
X-Google-Smtp-Source: ADUXVKI0iu8WuCyapxo4V9fyHhdU2HF2zzHKJEv31/IXaZ5Q9X86ASJKJW8a4ImvXuFf8H92FhF65A==
From: Fabio Estevam <festevam@gmail.com>
To: daniel.lezcano@linaro.org
Cc: tglx@linutronix.de, steve_longerbeam@mentor.com,
        linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] clocksource/drivers/imx: add input capture support
Date: Thu, 31 May 2018 22:38:06 -0300
Message-Id: <1527817086-26905-1-git-send-email-festevam@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Longerbeam <steve_longerbeam@mentor.com>

This patch adds support for the input capture function in the
i.MX GPT. Output compare and input capture functions are mixed
in the same register block, so we need to modify the irq ack/enable/
disable primitives to not stomp on the other function.

The input capture API is modelled after request/free irq:

typedef void (*mxc_icap_handler_t)(int, void *, struct timespec *);

int mxc_request_input_capture(unsigned int chan,
			      mxc_icap_handler_t handler,
			      unsigned long capflags, void *dev_id);

    - chan: the channel number being requested (0 or 1).

    - handler: a callback when there is an input capture event. The
      handler is given the channel number, the dev_id, and a timespec
      marking the input capture event.

    - capflags: IRQF_TRIGGER_RISING and/or IRQF_TRIGGER_FALLING. If
      both are specified, events will be triggered on both rising and
      falling edges of the input capture signal.

    - dev_id: a context pointer given back to the handler.

void mxc_free_input_capture(unsigned int chan, void *dev_id);

    This disables the given input capture channel in the GPT.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/clocksource/timer-imx-gpt.c | 479 ++++++++++++++++++++++++++++++++----
 include/linux/mxc_icap.h            |  14 ++
 2 files changed, 443 insertions(+), 50 deletions(-)
 create mode 100644 include/linux/mxc_icap.h

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 6ec6d79..64f3b61 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -21,9 +21,11 @@
  * MA 02110-1301, USA.
  */
 
+#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/clockchips.h>
+#include <linux/timecounter.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -32,6 +34,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/mxc_icap.h>
 #include <soc/imx/timer.h>
 
 /*
@@ -65,16 +69,52 @@
 #define V2_TCTL_CLK_PER		(2 << 6)
 #define V2_TCTL_CLK_OSC_DIV8	(5 << 6)
 #define V2_TCTL_FRR		(1 << 9)
+#define V2_TCTL_IM1_BIT		16
+#define V2_TCTL_IM2_BIT		18
+#define V2_IM_DISABLE		0
+#define V2_IM_RISING		1
+#define V2_IM_FALLING		2
+#define V2_IM_BOTH		3
 #define V2_TCTL_24MEN		(1 << 10)
 #define V2_TPRER_PRE24M		12
 #define V2_IR			0x0c
+#define V2_IR_OF1		(1 << 0)
+#define V2_IR_IF1		(1 << 3)
+#define V2_IR_IF2		(1 << 4)
 #define V2_TSTAT		0x08
 #define V2_TSTAT_OF1		(1 << 0)
+#define V2_TSTAT_IF1		(1 << 3)
+#define V2_TSTAT_IF2		(1 << 4)
 #define V2_TCN			0x24
 #define V2_TCMP			0x10
+#define V2_TCAP1		0x1c
+#define V2_TCAP2		0x20
 
 #define V2_TIMER_RATE_OSC_DIV8	3000000
 
+struct imx_timer;
+
+struct icap_channel {
+	struct imx_timer *imxtm;
+
+	int chan;
+
+	u32 cnt_reg;
+	u32 irqen_bit;
+	u32 status_bit;
+	u32 mode_bit;
+
+	mxc_icap_handler_t handler;
+	void *dev_id;
+
+	struct cyclecounter cc;
+	struct timecounter tc;
+};
+
+/* FIXME, for now can't find icap unless it's statically allocated */
+static struct icap_channel icap_channel[2];
+static DEFINE_SPINLOCK(icap_lock);
+
 struct imx_timer {
 	enum imx_gpt_type type;
 	void __iomem *base;
@@ -90,12 +130,20 @@ struct imx_gpt_data {
 	int reg_tstat;
 	int reg_tcn;
 	int reg_tcmp;
-	void (*gpt_setup_tctl)(struct imx_timer *imxtm);
-	void (*gpt_irq_enable)(struct imx_timer *imxtm);
-	void (*gpt_irq_disable)(struct imx_timer *imxtm);
-	void (*gpt_irq_acknowledge)(struct imx_timer *imxtm);
+	void (*gpt_oc_setup_tctl)(struct imx_timer *imxtm);
+	void (*gpt_oc_irq_enable)(struct imx_timer *imxtm);
+	void (*gpt_oc_irq_disable)(struct imx_timer *imxtm);
+	void (*gpt_oc_irq_acknowledge)(struct imx_timer *imxtm);
+	bool (*gpt_is_oc_irq)(struct imx_timer *imxtm, unsigned int tstat);
 	int (*set_next_event)(unsigned long evt,
 			      struct clock_event_device *ced);
+
+	void (*gpt_ic_irq_enable)(struct icap_channel *ic);
+	void (*gpt_ic_irq_disable)(struct icap_channel *ic);
+	void (*gpt_ic_irq_acknowledge)(struct icap_channel *ic);
+	bool (*gpt_is_ic_irq)(struct icap_channel *ic, unsigned int tstat);
+	void (*gpt_ic_enable)(struct icap_channel *ic, unsigned int mode);
+	void (*gpt_ic_disable)(struct icap_channel *ic);
 };
 
 static inline struct imx_timer *to_imx_timer(struct clock_event_device *ced)
@@ -103,52 +151,144 @@ static inline struct imx_timer *to_imx_timer(struct clock_event_device *ced)
 	return container_of(ced, struct imx_timer, ced);
 }
 
-static void imx1_gpt_irq_disable(struct imx_timer *imxtm)
+static void imx1_gpt_oc_irq_disable(struct imx_timer *imxtm)
 {
 	unsigned int tmp;
 
 	tmp = readl_relaxed(imxtm->base + MXC_TCTL);
 	writel_relaxed(tmp & ~MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_irq_disable imx1_gpt_irq_disable
+#define imx21_gpt_oc_irq_disable imx1_gpt_oc_irq_disable
 
-static void imx31_gpt_irq_disable(struct imx_timer *imxtm)
+static void imx31_gpt_oc_irq_disable(struct imx_timer *imxtm)
 {
-	writel_relaxed(0, imxtm->base + V2_IR);
+	unsigned int tmp;
+
+	tmp = readl_relaxed(imxtm->base + V2_IR);
+	writel_relaxed(tmp & ~V2_IR_OF1, imxtm->base + V2_IR);
 }
-#define imx6dl_gpt_irq_disable imx31_gpt_irq_disable
+#define imx6dl_gpt_oc_irq_disable imx31_gpt_oc_irq_disable
 
-static void imx1_gpt_irq_enable(struct imx_timer *imxtm)
+static void imx1_gpt_oc_irq_enable(struct imx_timer *imxtm)
 {
 	unsigned int tmp;
 
 	tmp = readl_relaxed(imxtm->base + MXC_TCTL);
 	writel_relaxed(tmp | MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_irq_enable imx1_gpt_irq_enable
+#define imx21_gpt_oc_irq_enable imx1_gpt_oc_irq_enable
 
-static void imx31_gpt_irq_enable(struct imx_timer *imxtm)
+static void imx31_gpt_oc_irq_enable(struct imx_timer *imxtm)
 {
-	writel_relaxed(1<<0, imxtm->base + V2_IR);
+	unsigned int tmp;
+
+	tmp = readl_relaxed(imxtm->base + V2_IR);
+	writel_relaxed(tmp | V2_IR_OF1, imxtm->base + V2_IR);
 }
-#define imx6dl_gpt_irq_enable imx31_gpt_irq_enable
+#define imx6dl_gpt_oc_irq_enable imx31_gpt_oc_irq_enable
 
-static void imx1_gpt_irq_acknowledge(struct imx_timer *imxtm)
+static void imx1_gpt_oc_irq_acknowledge(struct imx_timer *imxtm)
 {
 	writel_relaxed(0, imxtm->base + MX1_2_TSTAT);
 }
 
-static void imx21_gpt_irq_acknowledge(struct imx_timer *imxtm)
+static void imx21_gpt_oc_irq_acknowledge(struct imx_timer *imxtm)
 {
 	writel_relaxed(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
 				imxtm->base + MX1_2_TSTAT);
 }
 
-static void imx31_gpt_irq_acknowledge(struct imx_timer *imxtm)
+static bool imx1_gpt_is_oc_irq(struct imx_timer *imxtm, unsigned int tstat)
+{
+	return true;
+}
+
+static bool imx21_gpt_is_oc_irq(struct imx_timer *imxtm, unsigned int tstat)
+{
+	return (tstat & MX2_TSTAT_COMP) != 0;
+}
+
+static bool imx31_gpt_is_oc_irq(struct imx_timer *imxtm, unsigned int tstat)
+{
+	return (tstat & V2_TSTAT_OF1) != 0;
+}
+#define imx6dl_gpt_is_oc_irq imx31_gpt_is_oc_irq
+
+static void imx31_gpt_oc_irq_acknowledge(struct imx_timer *imxtm)
 {
 	writel_relaxed(V2_TSTAT_OF1, imxtm->base + V2_TSTAT);
 }
-#define imx6dl_gpt_irq_acknowledge imx31_gpt_irq_acknowledge
+#define imx6dl_gpt_oc_irq_acknowledge imx31_gpt_oc_irq_acknowledge
+
+static void imx31_gpt_ic_irq_disable(struct icap_channel *ic)
+{
+	struct imx_timer *imxtm = ic->imxtm;
+	unsigned int tmp;
+
+	tmp = readl_relaxed(imxtm->base + V2_IR);
+	tmp &= ~ic->irqen_bit;
+	writel_relaxed(tmp, imxtm->base + V2_IR);
+}
+#define imx6dl_gpt_ic_irq_disable imx31_gpt_ic_irq_disable
+
+static void imx31_gpt_ic_irq_enable(struct icap_channel *ic)
+{
+	struct imx_timer *imxtm = ic->imxtm;
+	unsigned int tmp;
+
+	tmp = readl_relaxed(imxtm->base + V2_IR);
+	tmp |= ic->irqen_bit;
+	writel_relaxed(tmp, imxtm->base + V2_IR);
+}
+#define imx6dl_gpt_ic_irq_enable imx31_gpt_ic_irq_enable
+
+static void imx31_gpt_ic_irq_acknowledge(struct icap_channel *ic)
+{
+	struct imx_timer *imxtm = ic->imxtm;
+
+	writel_relaxed(ic->status_bit, imxtm->base + V2_TSTAT);
+}
+#define imx6dl_gpt_ic_irq_acknowledge imx31_gpt_ic_irq_acknowledge
+
+static bool imx1_gpt_is_ic_irq(struct icap_channel *ic, unsigned int tstat)
+{
+	return false;
+}
+#define imx21_gpt_is_ic_irq imx1_gpt_is_ic_irq
+
+static bool imx31_gpt_is_ic_irq(struct icap_channel *ic, unsigned int tstat)
+{
+	return (tstat & ic->status_bit) != 0;
+}
+#define imx6dl_gpt_is_ic_irq imx31_gpt_is_ic_irq
+
+static void imx31_gpt_ic_enable(struct icap_channel *ic, unsigned int mode)
+{
+	struct imx_timer *imxtm = ic->imxtm;
+	unsigned int tctl, mask;
+
+	mask = 0x3 << ic->mode_bit;
+	mode <<= ic->mode_bit;
+
+	tctl = readl_relaxed(imxtm->base + MXC_TCTL);
+	tctl &= ~mask;
+	tctl |= mode;
+	writel_relaxed(tctl, imxtm->base + MXC_TCTL);
+}
+#define imx6dl_gpt_ic_enable imx31_gpt_ic_enable
+
+static void imx31_gpt_ic_disable(struct icap_channel *ic)
+{
+	struct imx_timer *imxtm = ic->imxtm;
+	unsigned int tctl, mask;
+
+	mask = 0x3 << ic->mode_bit;
+
+	tctl = readl_relaxed(imxtm->base + MXC_TCTL);
+	tctl &= ~mask;
+	writel_relaxed(tctl, imxtm->base + MXC_TCTL);
+}
+#define imx6dl_gpt_ic_disable imx31_gpt_ic_disable
 
 static void __iomem *sched_clock_reg;
 
@@ -164,6 +304,19 @@ static unsigned long imx_read_current_timer(void)
 	return readl_relaxed(sched_clock_reg);
 }
 
+static u64 mxc_clocksource_read(struct clocksource *cs)
+{
+	return mxc_read_sched_clock();
+}
+
+static struct clocksource clocksource_mxc = {
+	.name = "mxc_timer1",
+	.rating = 200,
+	.mask = CLOCKSOURCE_MASK(32),
+	.read = mxc_clocksource_read,
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 static int __init mxc_clocksource_init(struct imx_timer *imxtm)
 {
 	unsigned int c = clk_get_rate(imxtm->clk_per);
@@ -176,8 +329,7 @@ static int __init mxc_clocksource_init(struct imx_timer *imxtm)
 	sched_clock_reg = reg;
 
 	sched_clock_register(mxc_read_sched_clock, 32, c);
-	return clocksource_mmio_init(reg, "mxc_timer1", c, 200, 32,
-			clocksource_mmio_readl_up);
+	return clocksource_register_hz(&clocksource_mxc, c);
 }
 
 /* clock event */
@@ -224,14 +376,14 @@ static int mxc_shutdown(struct clock_event_device *ced)
 	local_irq_save(flags);
 
 	/* Disable interrupt in GPT module */
-	imxtm->gpt->gpt_irq_disable(imxtm);
+	imxtm->gpt->gpt_oc_irq_disable(imxtm);
 
 	tcn = readl_relaxed(imxtm->base + imxtm->gpt->reg_tcn);
 	/* Set event time into far-far future */
 	writel_relaxed(tcn - 3, imxtm->base + imxtm->gpt->reg_tcmp);
 
 	/* Clear pending interrupt */
-	imxtm->gpt->gpt_irq_acknowledge(imxtm);
+	imxtm->gpt->gpt_oc_irq_acknowledge(imxtm);
 
 #ifdef DEBUG
 	printk(KERN_INFO "%s: changing mode\n", __func__);
@@ -254,7 +406,7 @@ static int mxc_set_oneshot(struct clock_event_device *ced)
 	local_irq_save(flags);
 
 	/* Disable interrupt in GPT module */
-	imxtm->gpt->gpt_irq_disable(imxtm);
+	imxtm->gpt->gpt_oc_irq_disable(imxtm);
 
 	if (!clockevent_state_oneshot(ced)) {
 		u32 tcn = readl_relaxed(imxtm->base + imxtm->gpt->reg_tcn);
@@ -262,7 +414,7 @@ static int mxc_set_oneshot(struct clock_event_device *ced)
 		writel_relaxed(tcn - 3, imxtm->base + imxtm->gpt->reg_tcmp);
 
 		/* Clear pending interrupt */
-		imxtm->gpt->gpt_irq_acknowledge(imxtm);
+		imxtm->gpt->gpt_oc_irq_acknowledge(imxtm);
 	}
 
 #ifdef DEBUG
@@ -275,7 +427,7 @@ static int mxc_set_oneshot(struct clock_event_device *ced)
 	 * to call mxc_set_next_event() or shutdown clock after
 	 * mode switching
 	 */
-	imxtm->gpt->gpt_irq_enable(imxtm);
+	imxtm->gpt->gpt_oc_irq_enable(imxtm);
 	local_irq_restore(flags);
 
 	return 0;
@@ -289,12 +441,29 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *ced = dev_id;
 	struct imx_timer *imxtm = to_imx_timer(ced);
 	uint32_t tstat;
+	int i;
 
 	tstat = readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
 
-	imxtm->gpt->gpt_irq_acknowledge(imxtm);
+	for (i = 0; i < 2; i++) {
+		struct icap_channel *ic = &icap_channel[i];
+		struct timespec ts;
+
+		if (!imxtm->gpt->gpt_is_ic_irq(ic, tstat))
+			continue;
 
-	ced->event_handler(ced);
+		imxtm->gpt->gpt_ic_irq_acknowledge(ic);
+
+		ts = ns_to_timespec(timecounter_read(&ic->tc));
+
+		if (ic->handler)
+			ic->handler(ic->chan, ic->dev_id, &ts);
+	}
+
+	if (imxtm->gpt->gpt_is_oc_irq(imxtm, tstat)) {
+		imxtm->gpt->gpt_oc_irq_acknowledge(imxtm);
+		ced->event_handler(ced);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -324,16 +493,16 @@ static int __init mxc_clockevent_init(struct imx_timer *imxtm)
 	return setup_irq(imxtm->irq, act);
 }
 
-static void imx1_gpt_setup_tctl(struct imx_timer *imxtm)
+static void imx1_gpt_oc_setup_tctl(struct imx_timer *imxtm)
 {
 	u32 tctl_val;
 
 	tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
 	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_setup_tctl imx1_gpt_setup_tctl
+#define imx21_gpt_oc_setup_tctl imx1_gpt_oc_setup_tctl
 
-static void imx31_gpt_setup_tctl(struct imx_timer *imxtm)
+static void imx31_gpt_oc_setup_tctl(struct imx_timer *imxtm)
 {
 	u32 tctl_val;
 
@@ -346,7 +515,7 @@ static void imx31_gpt_setup_tctl(struct imx_timer *imxtm)
 	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
 }
 
-static void imx6dl_gpt_setup_tctl(struct imx_timer *imxtm)
+static void imx6dl_gpt_oc_setup_tctl(struct imx_timer *imxtm)
 {
 	u32 tctl_val;
 
@@ -367,10 +536,12 @@ static const struct imx_gpt_data imx1_gpt_data = {
 	.reg_tstat = MX1_2_TSTAT,
 	.reg_tcn = MX1_2_TCN,
 	.reg_tcmp = MX1_2_TCMP,
-	.gpt_irq_enable = imx1_gpt_irq_enable,
-	.gpt_irq_disable = imx1_gpt_irq_disable,
-	.gpt_irq_acknowledge = imx1_gpt_irq_acknowledge,
-	.gpt_setup_tctl = imx1_gpt_setup_tctl,
+	.gpt_oc_irq_enable = imx1_gpt_oc_irq_enable,
+	.gpt_oc_irq_disable = imx1_gpt_oc_irq_disable,
+	.gpt_oc_irq_acknowledge = imx1_gpt_oc_irq_acknowledge,
+	.gpt_is_oc_irq = imx1_gpt_is_oc_irq,
+	.gpt_is_ic_irq = imx1_gpt_is_ic_irq,
+	.gpt_oc_setup_tctl = imx1_gpt_oc_setup_tctl,
 	.set_next_event = mx1_2_set_next_event,
 };
 
@@ -378,10 +549,12 @@ static const struct imx_gpt_data imx21_gpt_data = {
 	.reg_tstat = MX1_2_TSTAT,
 	.reg_tcn = MX1_2_TCN,
 	.reg_tcmp = MX1_2_TCMP,
-	.gpt_irq_enable = imx21_gpt_irq_enable,
-	.gpt_irq_disable = imx21_gpt_irq_disable,
-	.gpt_irq_acknowledge = imx21_gpt_irq_acknowledge,
-	.gpt_setup_tctl = imx21_gpt_setup_tctl,
+	.gpt_oc_irq_enable = imx21_gpt_oc_irq_enable,
+	.gpt_oc_irq_disable = imx21_gpt_oc_irq_disable,
+	.gpt_oc_irq_acknowledge = imx21_gpt_oc_irq_acknowledge,
+	.gpt_is_oc_irq = imx21_gpt_is_oc_irq,
+	.gpt_is_ic_irq = imx21_gpt_is_ic_irq,
+	.gpt_oc_setup_tctl = imx21_gpt_oc_setup_tctl,
 	.set_next_event = mx1_2_set_next_event,
 };
 
@@ -389,27 +562,160 @@ static const struct imx_gpt_data imx31_gpt_data = {
 	.reg_tstat = V2_TSTAT,
 	.reg_tcn = V2_TCN,
 	.reg_tcmp = V2_TCMP,
-	.gpt_irq_enable = imx31_gpt_irq_enable,
-	.gpt_irq_disable = imx31_gpt_irq_disable,
-	.gpt_irq_acknowledge = imx31_gpt_irq_acknowledge,
-	.gpt_setup_tctl = imx31_gpt_setup_tctl,
+	.gpt_oc_irq_enable = imx31_gpt_oc_irq_enable,
+	.gpt_oc_irq_disable = imx31_gpt_oc_irq_disable,
+	.gpt_oc_irq_acknowledge = imx31_gpt_oc_irq_acknowledge,
+	.gpt_is_oc_irq = imx31_gpt_is_oc_irq,
+	.gpt_oc_setup_tctl = imx31_gpt_oc_setup_tctl,
 	.set_next_event = v2_set_next_event,
+
+	/* input capture methods */
+	.gpt_ic_irq_enable = imx31_gpt_ic_irq_enable,
+	.gpt_ic_irq_disable = imx31_gpt_ic_irq_disable,
+	.gpt_ic_irq_acknowledge = imx31_gpt_ic_irq_acknowledge,
+	.gpt_is_ic_irq = imx31_gpt_is_ic_irq,
+	.gpt_ic_enable = imx31_gpt_ic_enable,
+	.gpt_ic_disable = imx31_gpt_ic_disable,
 };
 
 static const struct imx_gpt_data imx6dl_gpt_data = {
 	.reg_tstat = V2_TSTAT,
 	.reg_tcn = V2_TCN,
 	.reg_tcmp = V2_TCMP,
-	.gpt_irq_enable = imx6dl_gpt_irq_enable,
-	.gpt_irq_disable = imx6dl_gpt_irq_disable,
-	.gpt_irq_acknowledge = imx6dl_gpt_irq_acknowledge,
-	.gpt_setup_tctl = imx6dl_gpt_setup_tctl,
+	.gpt_oc_irq_enable = imx6dl_gpt_oc_irq_enable,
+	.gpt_oc_irq_disable = imx6dl_gpt_oc_irq_disable,
+	.gpt_oc_irq_acknowledge = imx6dl_gpt_oc_irq_acknowledge,
+	.gpt_is_oc_irq = imx6dl_gpt_is_oc_irq,
+	.gpt_oc_setup_tctl = imx6dl_gpt_oc_setup_tctl,
 	.set_next_event = v2_set_next_event,
+
+	/* input capture methods */
+	.gpt_ic_irq_enable = imx6dl_gpt_ic_irq_enable,
+	.gpt_ic_irq_disable = imx6dl_gpt_ic_irq_disable,
+	.gpt_ic_irq_acknowledge = imx6dl_gpt_ic_irq_acknowledge,
+	.gpt_is_ic_irq = imx6dl_gpt_is_ic_irq,
+	.gpt_ic_enable = imx6dl_gpt_ic_enable,
+	.gpt_ic_disable = imx6dl_gpt_ic_disable,
 };
 
+static u64 gpt_ic_read(const struct cyclecounter *cc)
+{
+	struct icap_channel *ic = container_of(cc, struct icap_channel, cc);
+	struct imx_timer *imxtm = ic->imxtm;
+
+	return readl_relaxed(imxtm->base + ic->cnt_reg);
+}
+
+int mxc_request_input_capture(unsigned int chan, mxc_icap_handler_t handler,
+			      unsigned long capflags, void *dev_id)
+{
+	struct imx_timer *imxtm;
+	struct icap_channel *ic;
+	unsigned long flags;
+	u64 start_cycles;
+	int ret = 0;
+	u32 mode;
+
+	/* we only care about rising and falling flags */
+	capflags &= (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING);
+
+	if (chan > 1 || !handler || !capflags)
+		return -EINVAL;
+
+	ic = &icap_channel[chan];
+	imxtm = ic->imxtm;
+
+	if (!imxtm->gpt->gpt_ic_enable)
+		return -ENODEV;
+
+	spin_lock_irqsave(&icap_lock, flags);
+
+	if (ic->handler) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ic->handler = handler;
+	ic->dev_id = dev_id;
+
+	switch (capflags) {
+	case IRQF_TRIGGER_RISING:
+		mode = V2_IM_RISING;
+		break;
+	case IRQF_TRIGGER_FALLING:
+		mode = V2_IM_FALLING;
+		break;
+	default:
+		mode = V2_IM_BOTH;
+		break;
+	}
+
+	/* ack any pending input capture interrupt before enabling */
+	imxtm->gpt->gpt_ic_irq_acknowledge(ic);
+
+	/*
+	 * initialize the cyclecounter. The input capture is capturing
+	 * from the mxc clocksource, so it has the same mask/shift/mult.
+	 */
+	memset(&ic->cc, 0, sizeof(ic->cc));
+	ic->cc.read = gpt_ic_read;
+	ic->cc.mask = clocksource_mxc.mask;
+	ic->cc.shift = clocksource_mxc.shift;
+	ic->cc.mult = clocksource_mxc.mult;
+
+	/* initialize a timecounter for the input capture */
+	start_cycles = mxc_read_sched_clock();
+	timecounter_init(&ic->tc, &ic->cc, ktime_get_ns());
+	/*
+	 * timecounter_init() read the last captured timer count, but
+	 * that's not the start cycle counter, so update it with the
+	 * real start cycles.
+	 */
+	ic->tc.cycle_last = start_cycles;
+
+	imxtm->gpt->gpt_ic_enable(ic, mode);
+	imxtm->gpt->gpt_ic_irq_enable(ic);
+
+out:
+	spin_unlock_irqrestore(&icap_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mxc_request_input_capture);
+
+void mxc_free_input_capture(unsigned int chan, void *dev_id)
+{
+	struct imx_timer *imxtm;
+	struct icap_channel *ic;
+	unsigned long flags;
+
+	if (chan > 1)
+		return;
+
+	ic = &icap_channel[chan];
+	imxtm = ic->imxtm;
+
+	if (!imxtm->gpt->gpt_ic_disable)
+		return;
+
+	spin_lock_irqsave(&icap_lock, flags);
+
+	if (!ic->handler || dev_id != ic->dev_id)
+		goto out;
+
+	imxtm->gpt->gpt_ic_irq_disable(ic);
+	imxtm->gpt->gpt_ic_disable(ic);
+
+	ic->handler = NULL;
+	ic->dev_id = NULL;
+out:
+	spin_unlock_irqrestore(&icap_lock, flags);
+}
+EXPORT_SYMBOL_GPL(mxc_free_input_capture);
+
 static int __init _mxc_timer_init(struct imx_timer *imxtm)
 {
-	int ret;
+	struct icap_channel *ic;
+	int i, ret;
 
 	switch (imxtm->type) {
 	case GPT_TYPE_IMX1:
@@ -445,14 +751,23 @@ static int __init _mxc_timer_init(struct imx_timer *imxtm)
 	writel_relaxed(0, imxtm->base + MXC_TCTL);
 	writel_relaxed(0, imxtm->base + MXC_TPRER); /* see datasheet note */
 
-	imxtm->gpt->gpt_setup_tctl(imxtm);
+	imxtm->gpt->gpt_oc_setup_tctl(imxtm);
 
 	/* init and register the timer to the framework */
 	ret = mxc_clocksource_init(imxtm);
 	if (ret)
 		return ret;
 
-	return mxc_clockevent_init(imxtm);
+	ret = mxc_clockevent_init(imxtm);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < 2; i++) {
+		ic = &icap_channel[i];
+		ic->imxtm = imxtm;
+	}
+
+	return 0;
 }
 
 void __init mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type)
@@ -474,6 +789,70 @@ void __init mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type)
 	_mxc_timer_init(imxtm);
 }
 
+/*
+ * a platform driver is needed in order to acquire pinmux
+ * for input capture pins. The probe call is also useful
+ * for setting up the input capture channel structures.
+ */
+static int mxc_timer_probe(struct platform_device *pdev)
+{
+	struct icap_channel *ic;
+	int i;
+
+	/* setup the input capture channels */
+	for (i = 0; i < 2; i++) {
+		ic = &icap_channel[i];
+		ic->chan = i;
+		if (i == 0) {
+			ic->cnt_reg = V2_TCAP1;
+			ic->irqen_bit = V2_IR_IF1;
+			ic->status_bit = V2_TSTAT_IF1;
+			ic->mode_bit = V2_TCTL_IM1_BIT;
+		} else {
+			ic->cnt_reg = V2_TCAP2;
+			ic->irqen_bit = V2_IR_IF2;
+			ic->status_bit = V2_TSTAT_IF2;
+			ic->mode_bit = V2_TCTL_IM2_BIT;
+		}
+	}
+
+	return 0;
+}
+
+static int mxc_timer_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id timer_of_match[] = {
+	{ .compatible = "fsl,imx1-gpt" },
+	{ .compatible = "fsl,imx21-gpt" },
+	{ .compatible = "fsl,imx27-gpt" },
+	{ .compatible = "fsl,imx31-gpt" },
+	{ .compatible = "fsl,imx25-gpt" },
+	{ .compatible = "fsl,imx50-gpt" },
+	{ .compatible = "fsl,imx51-gpt" },
+	{ .compatible = "fsl,imx53-gpt" },
+	{ .compatible = "fsl,imx6q-gpt" },
+	{ .compatible = "fsl,imx6dl-gpt" },
+	{ .compatible = "fsl,imx6sl-gpt" },
+	{ .compatible = "fsl,imx6sx-gpt" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, timer_of_match);
+
+static struct platform_driver mxc_timer_pdrv = {
+	.probe		= mxc_timer_probe,
+	.remove		= mxc_timer_remove,
+	.driver		= {
+		.name	= "mxc-timer",
+		.owner	= THIS_MODULE,
+		.of_match_table	= timer_of_match,
+	},
+};
+
+module_platform_driver(mxc_timer_pdrv);
+
 static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type type)
 {
 	struct imx_timer *imxtm;
diff --git a/include/linux/mxc_icap.h b/include/linux/mxc_icap.h
new file mode 100644
index 0000000..c34ff41
--- /dev/null
+++ b/include/linux/mxc_icap.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015 Mentor Graphics, Inc. All Rights Reserved.
+ */
+#ifndef __MXC_ICAP_H__
+#define __MXC_ICAP_H__
+
+typedef void (*mxc_icap_handler_t)(int, void *, struct timespec *);
+
+int mxc_request_input_capture(unsigned int chan, mxc_icap_handler_t handler,
+			      unsigned long capflags, void *dev_id);
+void mxc_free_input_capture(unsigned int chan, void *dev_id);
+
+#endif
-- 
2.7.4
