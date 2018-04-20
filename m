Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbeDTVNK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 17:13:10 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32874 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752706AbeDTVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 17:11:48 -0400
X-Google-Smtp-Source: AB8JxZpnRMRwJI2NFxFTJOLA0/wdbLidYhjWqfYs8KDNges0uRPxaWsa4CogsY4SwQuDuASpkD8pig==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] clk: add duty cycle support
Date: Fri, 20 Apr 2018 23:11:41 +0200
Message-Id: <20180420211141.28929-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the possibility to apply and query the clock signal duty cycle ratio.

This is useful when the duty cycle of the clock signal depends on some
other parameters controlled by the clock framework.

For example, the duty cycle of a divider may depends on the raw divider
setting (ratio = N / div) , which is controlled by the CCF. In such case,
going through the pwm framework to control the duty cycle ratio of this
clock would be a burden.

A clock provider is not required to implement the operation to set and get
the duty cycle. If it does not implement .get_duty_cycle(), the ratio is
assumed to be 50%.

This change also adds a new flag, CLK_DUTY_CYCLE_PARENT. This flag should
be used to indicate that a clock, such as gates and muxes, may inherit
the duty cycle ratio of its parent clock. If a clock does not provide a
get_duty_cycle() callback and has CLK_DUTY_CYCLE_PARENT, then the call
will be directly forwarded to its parent clock, if any. For
set_duty_cycle(), the clock should also have CLK_SET_RATE_PARENT for the
call to be forwarded

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

The series has been developed to handled the sample clocks provided by
audio clock controller of amlogic's A113 SoC. To support i2s modes, this
clock need to have a 50% duty cycle ratio, while it should be just one
pulse of the parent clock in dsp modes.

Changes since v2 [1]:
 - Fix kbuild robot issue with the trace file (imcomplete change related
   to clk_duty structure)

Changes since v1 [0]:
 - Use a structure to hold the duty cycle ratio
 - Change the way parent traversal is done, so the core framework is
   more aware of what is going on. Pass-through ops dropped as a result
 - Only one debugfs entry for the duty cycle ratio, instead of 2
 - Minor fixes as pointed out by Stephen

[0]: https://lkml.kernel.org/r/20180416175743.20826-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20180420153431.13003-1-jbrunet@baylibre.com


 drivers/clk/clk.c            | 202 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/clk-provider.h |  26 ++++++
 include/linux/clk.h          |  33 +++++++
 include/trace/events/clk.h   |  36 ++++++++
 4 files changed, 292 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7af555f0e60c..a1874f2932ee 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -68,6 +68,7 @@ struct clk_core {
 	unsigned long		max_rate;
 	unsigned long		accuracy;
 	int			phase;
+	struct clk_duty		duty;
 	struct hlist_head	children;
 	struct hlist_node	child_node;
 	struct hlist_head	clks;
@@ -2401,6 +2402,172 @@ int clk_get_phase(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_get_phase);
 
+static void clk_core_reset_duty_cycle_nolock(struct clk_core *core)
+{
+	/* Assume a default value of 50% */
+	core->duty.num = 1;
+	core->duty.den = 2;
+}
+
+static int clk_core_update_duty_cycle_parent_nolock(struct clk_core *core);
+
+static int clk_core_update_duty_cycle_nolock(struct clk_core *core)
+{
+	struct clk_duty *duty = &core->duty;
+	int ret = 0;
+
+	if (!core->ops->get_duty_cycle)
+		return clk_core_update_duty_cycle_parent_nolock(core);
+
+	ret = core->ops->get_duty_cycle(core->hw, duty);
+	if (ret)
+		goto reset;
+
+	/* Don't trust the clock provider too much */
+	if (duty->den == 0 || duty->num > duty->den) {
+		ret = -EINVAL;
+		goto reset;
+	}
+
+	return 0;
+
+reset:
+	clk_core_reset_duty_cycle_nolock(core);
+	return ret;
+}
+
+static int clk_core_update_duty_cycle_parent_nolock(struct clk_core *core)
+{
+	int ret = 0;
+
+	if (core->parent &&
+	    core->flags & CLK_DUTY_CYCLE_PARENT) {
+		ret = clk_core_update_duty_cycle_nolock(core->parent);
+		memcpy(&core->duty, &core->parent->duty, sizeof(core->duty));
+	} else {
+		clk_core_reset_duty_cycle_nolock(core);
+	}
+
+	return ret;
+}
+
+static int clk_core_set_duty_cycle_parent_nolock(struct clk_core *core,
+						 struct clk_duty *duty);
+
+static int clk_core_set_duty_cycle_nolock(struct clk_core *core,
+					  struct clk_duty *duty)
+{
+	int ret;
+
+	lockdep_assert_held(&prepare_lock);
+
+	if (clk_core_rate_is_protected(core))
+		return -EBUSY;
+
+	trace_clk_set_duty_cycle(core, duty);
+
+	if (!core->ops->set_duty_cycle)
+		return clk_core_set_duty_cycle_parent_nolock(core, duty);
+
+	ret = core->ops->set_duty_cycle(core->hw, duty);
+	if (!ret)
+		memcpy(&core->duty, duty, sizeof(*duty));
+
+	trace_clk_set_duty_cycle_complete(core, duty);
+
+	return ret;
+}
+
+static int clk_core_set_duty_cycle_parent_nolock(struct clk_core *core,
+						 struct clk_duty *duty)
+{
+	int ret = 0;
+
+	if (core->parent &&
+	    core->flags & (CLK_DUTY_CYCLE_PARENT | CLK_SET_RATE_PARENT)) {
+		ret = clk_core_set_duty_cycle_nolock(core->parent, duty);
+		memcpy(&core->duty, &core->parent->duty, sizeof(core->duty));
+	}
+
+	return ret;
+}
+
+/**
+ * clk_set_duty_cycle - adjust the duty cycle ratio of a clock signal
+ * @clk: clock signal source
+ * @num: numerator of the duty cycle ratio to be applied
+ * @den: denominator of the duty cycle ratio to be applied
+ *
+ * Apply the duty cycle ratio if the ratio is valid and the clock can
+ * perform this operation
+ *
+ * Returns (0) on success, a negative errno otherwise.
+ */
+int clk_set_duty_cycle(struct clk *clk, unsigned int num, unsigned int den)
+{
+	int ret;
+	struct clk_duty duty;
+
+	if (!clk)
+		return 0;
+
+	/* sanity check the ratio */
+	if (den == 0 || num > den)
+		return -EINVAL;
+
+	duty.num = num;
+	duty.den = den;
+
+	clk_prepare_lock();
+
+	if (clk->exclusive_count)
+		clk_core_rate_unprotect(clk->core);
+
+	ret = clk_core_set_duty_cycle_nolock(clk->core, &duty);
+
+	if (clk->exclusive_count)
+		clk_core_rate_protect(clk->core);
+
+	clk_prepare_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_duty_cycle);
+
+static int clk_core_get_scaled_duty_cycle(struct clk_core *core,
+					  unsigned int scale)
+{
+	struct clk_duty *duty = &core->duty;
+	int ret;
+
+	clk_prepare_lock();
+
+	ret = clk_core_update_duty_cycle_nolock(core);
+	if (!ret)
+		ret = mult_frac(scale, duty->num, duty->den);
+
+	clk_prepare_unlock();
+
+	return ret;
+}
+
+/**
+ * clk_get_scaled_duty_cycle - return the duty cycle ratio of a clock signal
+ * @clk: clock signal source
+ * @scale: scaling factor to be applied to represent the ratio as an integer
+ *
+ * Returns the duty cycle ratio of a clock node multiplied by the provided
+ * scaling factor, or negative errno on error.
+ */
+int clk_get_scaled_duty_cycle(struct clk *clk, unsigned int scale)
+{
+	if (!clk)
+		return 0;
+
+	return clk_core_get_scaled_duty_cycle(clk->core, scale);
+}
+EXPORT_SYMBOL_GPL(clk_get_scaled_duty_cycle);
+
 /**
  * clk_is_match - check if two clk's point to the same hardware clock
  * @p: clk compared against q
@@ -2454,12 +2621,13 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 	if (!c)
 		return;
 
-	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu %-3d\n",
+	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu %5d %6d\n",
 		   level * 3 + 1, "",
 		   30 - level * 3, c->name,
 		   c->enable_count, c->prepare_count, c->protect_count,
 		   clk_core_get_rate(c), clk_core_get_accuracy(c),
-		   clk_core_get_phase(c));
+		   clk_core_get_phase(c),
+		   clk_core_get_scaled_duty_cycle(c, 100000));
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
@@ -2481,9 +2649,9 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	struct clk_core *c;
 	struct hlist_head **lists = (struct hlist_head **)s->private;
 
-	seq_puts(s, "                                 enable  prepare  protect                               \n");
-	seq_puts(s, "   clock                          count    count    count        rate   accuracy   phase\n");
-	seq_puts(s, "----------------------------------------------------------------------------------------\n");
+	seq_puts(s, "                                 enable  prepare  protect                                duty\n");
+	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle\n");
+	seq_puts(s, "---------------------------------------------------------------------------------------------\n");
 
 	clk_prepare_lock();
 
@@ -2510,6 +2678,8 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 	seq_printf(s, "\"rate\": %lu,", clk_core_get_rate(c));
 	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy(c));
 	seq_printf(s, "\"phase\": %d", clk_core_get_phase(c));
+	seq_printf(s, "\"duty_cycle\": %u",
+		   clk_core_get_scaled_duty_cycle(c, 100000));
 }
 
 static void clk_dump_subtree(struct seq_file *s, struct clk_core *c, int level)
@@ -2571,6 +2741,7 @@ static const struct {
 	ENTRY(CLK_SET_RATE_UNGATE),
 	ENTRY(CLK_IS_CRITICAL),
 	ENTRY(CLK_OPS_PARENT_ENABLE),
+	ENTRY(CLK_DUTY_CYCLE_PARENT),
 #undef ENTRY
 };
 
@@ -2609,6 +2780,17 @@ static int possible_parents_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(possible_parents);
 
+static int clk_duty_cycle_show(struct seq_file *s, void *data)
+{
+	struct clk_core *core = s->private;
+	struct clk_duty *duty = &core->duty;
+
+	seq_printf(s, "%u/%u\n", duty->num, duty->den);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(clk_duty_cycle);
+
 static int clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 {
 	struct dentry *d;
@@ -2638,6 +2820,11 @@ static int clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 	if (!d)
 		goto err_out;
 
+	d = debugfs_create_file("clk_duty_cycle", 0444, core->dentry, core,
+				&clk_duty_cycle_fops);
+	if (!d)
+		goto err_out;
+
 	d = debugfs_create_file("clk_flags", 0444, core->dentry, core,
 				&clk_flags_fops);
 	if (!d)
@@ -2926,6 +3113,11 @@ static int __clk_core_init(struct clk_core *core)
 	else
 		core->phase = 0;
 
+	/*
+	 * Set clk's duty cycle.
+	 */
+	clk_core_update_duty_cycle_nolock(core);
+
 	/*
 	 * Set clk's rate.  The preferred method is to use .recalc_rate.  For
 	 * simple clocks and lazy developers the default fallback is to use the
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1d25e149c1c5..48a47d17261f 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -37,6 +37,8 @@
 #define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
 /* parents need enable during gate/ungate, set rate and re-parent */
 #define CLK_OPS_PARENT_ENABLE	BIT(12)
+/* duty cycle call may be forwarded to the parent clock */
+#define CLK_DUTY_CYCLE_PARENT	BIT(13)
 
 struct clk;
 struct clk_hw;
@@ -65,6 +67,17 @@ struct clk_rate_request {
 	struct clk_hw *best_parent_hw;
 };
 
+/**
+ * struct clk_duty - Struture encoding the duty cycle ratio of a clock
+ *
+ * @num:	Numerator of the duty cycle ratio
+ * @den:	Denominator of the duty cycle ratio
+ */
+struct clk_duty {
+	unsigned int num;
+	unsigned int den;
+};
+
 /**
  * struct clk_ops -  Callback operations for hardware clocks; these are to
  * be provided by the clock implementation, and will be called by drivers
@@ -168,6 +181,15 @@ struct clk_rate_request {
  *		by the second argument. Valid values for degrees are
  *		0-359. Return 0 on success, otherwise -EERROR.
  *
+ * @get_duty_cycle: Queries the hardware to get the current duty cycle ratio
+ *              of a clock. Returned values denominator cannot be 0 and must be
+ *              superior or equal to the numerator.
+ *
+ * @set_duty_cycle: Apply the duty cycle ratio to this clock signal specified by
+ *              the numerator (2nd argurment) and denominator (3rd  argument).
+ *              Argument must be a valid ratio (denominator > 0
+ *              and >= numerator) Return 0 on success, otherwise -EERROR.
+ *
  * @init:	Perform platform-specific initialization magic.
  *		This is not not used by any of the basic clock types.
  *		Please consider other ways of solving initialization problems
@@ -217,6 +239,10 @@ struct clk_ops {
 					   unsigned long parent_accuracy);
 	int		(*get_phase)(struct clk_hw *hw);
 	int		(*set_phase)(struct clk_hw *hw, int degrees);
+	int		(*get_duty_cycle)(struct clk_hw *hw,
+					  struct clk_duty *duty);
+	int		(*set_duty_cycle)(struct clk_hw *hw,
+					  struct clk_duty *duty);
 	void		(*init)(struct clk_hw *hw);
 	int		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
 };
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0dbd0885b2c2..4f750c481b82 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -141,6 +141,27 @@ int clk_set_phase(struct clk *clk, int degrees);
  */
 int clk_get_phase(struct clk *clk);
 
+/**
+ * clk_set_duty_cycle - adjust the duty cycle ratio of a clock signal
+ * @clk: clock signal source
+ * @num: numerator of the duty cycle ratio to be applied
+ * @den: denominator of the duty cycle ratio to be applied
+ *
+ * Adjust the duty cycle of a clock signal by the specified ratio. Returns 0 on
+ * success, -EERROR otherwise.
+ */
+int clk_set_duty_cycle(struct clk *clk, unsigned int num, unsigned int den);
+
+/**
+ * clk_get_duty_cycle - return the duty cycle ratio of a clock signal
+ * @clk: clock signal source
+ * @scale: scaling factor to be applied to represent the ratio as an integer
+ *
+ * Returns the duty cycle ratio multiplied by the scale provided, otherwise
+ * returns -EERROR.
+ */
+int clk_get_scaled_duty_cycle(struct clk *clk, unsigned int scale);
+
 /**
  * clk_is_match - check if two clk's point to the same hardware clock
  * @p: clk compared against q
@@ -183,6 +204,18 @@ static inline long clk_get_phase(struct clk *clk)
 	return -ENOTSUPP;
 }
 
+static inline int clk_set_duty_cycle(struct clk *clk, unsigned int num,
+				     unsigned int den)
+{
+	return -ENOTSUPP;
+}
+
+static inline unsigned int clk_get_scaled_duty_cycle(struct clk *clk,
+						     unsigned int scale)
+{
+	return 0;
+}
+
 static inline bool clk_is_match(const struct clk *p, const struct clk *q)
 {
 	return p == q;
diff --git a/include/trace/events/clk.h b/include/trace/events/clk.h
index 2cd449328aee..9004ffff7f32 100644
--- a/include/trace/events/clk.h
+++ b/include/trace/events/clk.h
@@ -192,6 +192,42 @@ DEFINE_EVENT(clk_phase, clk_set_phase_complete,
 	TP_ARGS(core, phase)
 );
 
+DECLARE_EVENT_CLASS(clk_duty_cycle,
+
+	TP_PROTO(struct clk_core *core, struct clk_duty *duty),
+
+	TP_ARGS(core, duty),
+
+	TP_STRUCT__entry(
+		__string(        name,           core->name              )
+		__field( unsigned int,           num                     )
+		__field( unsigned int,           den                     )
+	),
+
+	TP_fast_assign(
+		__assign_str(name, core->name);
+		__entry->num = duty->num;
+		__entry->den = duty->den;
+	),
+
+	TP_printk("%s %u/%u", __get_str(name), (unsigned int)__entry->num,
+		  (unsigned int)__entry->den)
+);
+
+DEFINE_EVENT(clk_duty_cycle, clk_set_duty_cycle,
+
+	TP_PROTO(struct clk_core *core, struct clk_duty *duty),
+
+	TP_ARGS(core, duty)
+);
+
+DEFINE_EVENT(clk_duty_cycle, clk_set_duty_cycle_complete,
+
+	TP_PROTO(struct clk_core *core, struct clk_duty *duty),
+
+	TP_ARGS(core, duty)
+);
+
 #endif /* _TRACE_CLK_H */
 
 /* This part must be outside protection */
-- 
2.14.3
