Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbeDPR61 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:58:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35244 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752806AbeDPR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:57:50 -0400
X-Google-Smtp-Source: AIpwx4+5C5/ojnw+b/VWxP78YRai51TGSrEfzCPEkrufEkhPpT8uJXEDegGsOQHElDPHtBEhBhOVoQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: add duty cycle support
Date: Mon, 16 Apr 2018 19:57:41 +0200
Message-Id: <20180416175743.20826-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180416175743.20826-1-jbrunet@baylibre.com>
References: <20180416175743.20826-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the possibility to apply and query the clock signal duty cycle ratio.
This is useful when the duty cycle of the clock signal depends on some
other parameters controlled by the clock framework.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c            | 196 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/clk-provider.h |  17 ++++
 include/linux/clk.h          |  32 +++++++
 include/trace/events/clk.h   |  36 ++++++++
 4 files changed, 276 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7af555f0e60c..fff7890ae355 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -68,6 +68,8 @@ struct clk_core {
 	unsigned long		max_rate;
 	unsigned long		accuracy;
 	int			phase;
+	unsigned int		duty_num;
+	unsigned int		duty_den;
 	struct hlist_head	children;
 	struct hlist_node	child_node;
 	struct hlist_head	clks;
@@ -2401,6 +2403,164 @@ int clk_get_phase(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_get_phase);
 
+static int clk_core_update_duty_cycle_nolock(struct clk_core *core)
+{
+	int ret;
+	unsigned int num, den;
+
+	if (!core || !core->ops->get_duty_cycle)
+		return 0;
+
+	/* Update the duty cycle if the callback is available */
+	ret = core->ops->get_duty_cycle(core->hw, &num, &den);
+	if (ret)
+		return ret;
+
+	/* Don't trust the clock provider too much */
+	if (den == 0 || (num > den))
+		return -EINVAL;
+
+	core->duty_num = num;
+	core->duty_den = den;
+
+	return 0;
+}
+
+static int clk_core_get_duty_cycle_nolock(struct clk_core *core,
+					  unsigned int *num,
+					  unsigned int *den)
+{
+	int ret;
+
+	if (!core)
+		return 0;
+
+	ret = clk_core_update_duty_cycle_nolock(core);
+
+	if (!ret) {
+		*num = core->duty_num;
+		*den = core->duty_den;
+	}
+
+	return ret;
+}
+
+static int clk_core_set_duty_cycle_nolock(struct clk_core *core,
+					  unsigned int num,
+					  unsigned int den)
+{
+	int ret;
+
+	lockdep_assert_held(&prepare_lock);
+
+	if (!core || !core->ops->set_duty_cycle)
+		return 0;
+
+	if (clk_core_rate_is_protected(core))
+		return -EBUSY;
+
+	trace_clk_set_duty_cycle(core, num, den);
+
+	ret = core->ops->set_duty_cycle(core->hw, num, den);
+	if (ret)
+		return ret;
+
+	core->duty_num = num;
+	core->duty_den = den;
+
+	trace_clk_set_duty_cycle_complete(core, num, den);
+
+	return ret;
+}
+
+/**
+ * clk_set_duty_cycle - adjust the duty cycle ratio of a clock signal
+ * @clk: clock signal source
+ * @ratio: duty cycle ratio in milli-percent
+ *
+ * ADD BLURB HERE
+ */
+int clk_set_duty_cycle(struct clk *clk, unsigned int num, unsigned int den)
+{
+	int ret;
+
+	if (!clk)
+		return 0;
+
+	/* sanity check the ratio */
+	if (den == 0 || (num > den))
+		return -EINVAL;
+
+	clk_prepare_lock();
+
+	if (clk->exclusive_count)
+		clk_core_rate_unprotect(clk->core);
+
+	ret = clk_core_set_duty_cycle_nolock(clk->core, num, den);
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
+static unsigned int clk_core_get_scaled_duty_cycle(struct clk_core *core,
+						   unsigned int scale)
+{
+	int ret;
+	unsigned int duty;
+
+	clk_prepare_lock();
+	ret = clk_core_update_duty_cycle_nolock(core);
+	if (ret)
+		return 0;
+
+	duty = DIV_ROUND_CLOSEST_ULL((u64)core->duty_num * scale,
+				     core->duty_den);
+
+	clk_prepare_unlock();
+
+	return duty;
+}
+
+/**
+ * clk_get_scaled_duty_cycle - return the duty cycle ratio of a clock signal
+ * @clk: clock signal source
+ * @scale: scaling factor to be applied to represent the ratio as an integer
+ *
+ * Returns the duty cycle ratio of a clock node multiplied by the provided
+ * scaling factor.
+ */
+unsigned int clk_get_scaled_duty_cycle(struct clk *clk, unsigned int scale)
+{
+	if (!clk)
+		return 0;
+
+	return clk_core_get_scaled_duty_cycle(clk->core, scale);
+}
+EXPORT_SYMBOL_GPL(clk_get_scaled_duty_cycle);
+
+int __clk_set_duty_cycle_passthrough(struct clk_hw *hw, unsigned int num,
+				     unsigned int den)
+{
+	struct clk_core *parent = hw->core->parent;
+
+	return clk_core_set_duty_cycle_nolock(parent, num, den);
+}
+EXPORT_SYMBOL_GPL(__clk_set_duty_cycle_passthrough);
+
+int __clk_get_duty_cycle_passthrough(struct clk_hw *hw, unsigned int *num,
+				     unsigned int *den)
+{
+	struct clk_core *parent = hw->core->parent;
+
+	return clk_core_get_duty_cycle_nolock(parent, num, den);
+}
+EXPORT_SYMBOL_GPL(__clk_get_duty_cycle_passthrough);
+
 /**
  * clk_is_match - check if two clk's point to the same hardware clock
  * @p: clk compared against q
@@ -2454,12 +2614,13 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
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
@@ -2481,9 +2642,9 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	struct clk_core *c;
 	struct hlist_head **lists = (struct hlist_head **)s->private;
 
-	seq_puts(s, "                                 enable  prepare  protect                               \n");
-	seq_puts(s, "   clock                          count    count    count        rate   accuracy   phase\n");
-	seq_puts(s, "----------------------------------------------------------------------------------------\n");
+	seq_puts(s, "                                 enable  prepare  protect                                duty\n");
+	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle\n");
+	seq_puts(s, "---------------------------------------------------------------------------------------------\n");
 
 	clk_prepare_lock();
 
@@ -2510,6 +2671,8 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 	seq_printf(s, "\"rate\": %lu,", clk_core_get_rate(c));
 	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy(c));
 	seq_printf(s, "\"phase\": %d", clk_core_get_phase(c));
+	seq_printf(s, "\"duty_cycle\": %u",
+		   clk_core_get_scaled_duty_cycle(c, 100000));
 }
 
 static void clk_dump_subtree(struct seq_file *s, struct clk_core *c, int level)
@@ -2638,6 +2801,16 @@ static int clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 	if (!d)
 		goto err_out;
 
+	d = debugfs_create_u32("clk_duty_num", 0444, core->dentry,
+			       &core->duty_num);
+	if (!d)
+		goto err_out;
+
+	d = debugfs_create_u32("clk_duty_den", 0444, core->dentry,
+			       &core->duty_den);
+	if (!d)
+		goto err_out;
+
 	d = debugfs_create_file("clk_flags", 0444, core->dentry, core,
 				&clk_flags_fops);
 	if (!d)
@@ -2926,6 +3099,19 @@ static int __clk_core_init(struct clk_core *core)
 	else
 		core->phase = 0;
 
+	/*
+	 * Set clk's duty cycle.
+	 */
+	if (core->ops->get_duty_cycle) {
+		core->ops->get_duty_cycle(core->hw, &core->duty_num,
+					  &core->duty_den);
+	} else {
+		/* if the operation is not available, assume 50% */
+		core->duty_num = 1;
+		core->duty_den = 2;
+	}
+
+
 	/*
 	 * Set clk's rate.  The preferred method is to use .recalc_rate.  For
 	 * simple clocks and lazy developers the default fallback is to use the
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1d25e149c1c5..91e0e37e736b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -168,6 +168,15 @@ struct clk_rate_request {
  *		by the second argument. Valid values for degrees are
  *		0-359. Return 0 on success, otherwise -EERROR.
  *
+ * @get_duty_cycle: Queries the hardware to get the current duty cycle ratio
+ *              of a clock. Returned values denominator cannot be 0 and must be
+ *              superior or egal to the numerator.
+ *
+ * @set_duty_cycle: Apply the duty cycle ratio to this clock signal specified by
+ *              the numerator (2nd argurment) and denominator (3rd  argument).
+ *              Argument must be a valid ratio (denominator > 0
+ *              and >= numerator) Return 0 on success, otherwise -EERROR.
+ *
  * @init:	Perform platform-specific initialization magic.
  *		This is not not used by any of the basic clock types.
  *		Please consider other ways of solving initialization problems
@@ -217,6 +226,10 @@ struct clk_ops {
 					   unsigned long parent_accuracy);
 	int		(*get_phase)(struct clk_hw *hw);
 	int		(*set_phase)(struct clk_hw *hw, int degrees);
+	int		(*get_duty_cycle)(struct clk_hw *hw, unsigned int *num,
+					  unsigned int *den);
+	int		(*set_duty_cycle)(struct clk_hw *hw, unsigned int num,
+					  unsigned int den);
 	void		(*init)(struct clk_hw *hw);
 	int		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
 };
@@ -771,6 +784,10 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent);
 void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 			   unsigned long max_rate);
+int __clk_set_duty_cycle_passthrough(struct clk_hw *hw, unsigned int num,
+				     unsigned int den);
+int __clk_get_duty_cycle_passthrough(struct clk_hw *hw, unsigned int *num,
+				     unsigned int *den);
 
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0dbd0885b2c2..ef363fd6218a 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -141,6 +141,26 @@ int clk_set_phase(struct clk *clk, int degrees);
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
+ * Returns the duty cycle ratio multiplied by the scale provided
+ */
+unsigned int clk_get_scaled_duty_cycle(struct clk *clk, unsigned int scale);
+
 /**
  * clk_is_match - check if two clk's point to the same hardware clock
  * @p: clk compared against q
@@ -183,6 +203,18 @@ static inline long clk_get_phase(struct clk *clk)
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
index 2cd449328aee..9625a19cc159 100644
--- a/include/trace/events/clk.h
+++ b/include/trace/events/clk.h
@@ -192,6 +192,42 @@ DEFINE_EVENT(clk_phase, clk_set_phase_complete,
 	TP_ARGS(core, phase)
 );
 
+DECLARE_EVENT_CLASS(clk_duty_cycle,
+
+	TP_PROTO(struct clk_core *core, unsigned int num, unsigned int den),
+
+		    TP_ARGS(core, num, den),
+
+	TP_STRUCT__entry(
+		__string(        name,           core->name              )
+		__field( unsigned int,           num                     )
+		__field( unsigned int,           den                     )
+	),
+
+	TP_fast_assign(
+		__assign_str(name, core->name);
+		__entry->num = num;
+		__entry->den = den;
+	),
+
+	TP_printk("%s %u/%u", __get_str(name), (unsigned int)__entry->num,
+		  (unsigned int)__entry->den)
+);
+
+DEFINE_EVENT(clk_duty_cycle, clk_set_duty_cycle,
+
+	TP_PROTO(struct clk_core *core, unsigned int num, unsigned int den),
+
+	TP_ARGS(core, num, den)
+);
+
+DEFINE_EVENT(clk_duty_cycle, clk_set_duty_cycle_complete,
+
+	TP_PROTO(struct clk_core *core, unsigned int num, unsigned int den),
+
+	TP_ARGS(core, num, den)
+);
+
 #endif /* _TRACE_CLK_H */
 
 /* This part must be outside protection */
-- 
2.14.3
