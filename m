Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeEVMMH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:12:07 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:23173 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeEVMIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:08:20 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="14214832"
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <thierry.reding@gmail.com>, <shc_work@mail.ru>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <corbet@lwn.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>
CC: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 1/9] pwm: extend PWM framework with PWM modes
Date: Tue, 22 May 2018 15:07:05 +0300
Message-ID: <1526990833-30707-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526990833-30707-1-git-send-email-claudiu.beznea@microchip.com>
References: <1526990833-30707-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic PWM modes: normal and complementary. These modes should
differentiate the single output PWM channels from two outputs PWM
channels. These modes could be set as follow:
1. PWM channels with one output per channel:
- normal mode
2. PWM channels with two outputs per channel:
- normal mode
- complementary mode
Since users could use a PWM channel with two output as one output PWM
channel, the PWM normal mode is allowed to be set for PWM channels with
two outputs; in fact PWM normal mode should be supported by all PWMs.

The PWM capabilities were implemented per PWM channel. Every PWM controller
will register a function to get PWM capabilities. If this is not explicitly
set by the driver a default function will be used to retrieve the PWM
capabilities (in this case the PWM capabilities will contain only PWM
normal mode). This function is set in pwmchip_add_with_polarity() as a
member of "struct pwm_chip". To retrieve capabilities the pwm_get_caps()
function could be used.

Every PWM channel have associated a mode in the PWM state. Proper
support was added to get/set PWM mode. The mode could also be set
from DT via flag cells. The valid DT modes are located in
include/dt-bindings/pwm/pwm.h. Only modes supported by PWM channel could be
set. If nothing is specified for a PWM channel, via DT, the first available
mode will be used (normally, this will be PWM normal mode).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/core.c  | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/pwm/sysfs.c |  61 ++++++++++++++++++++++++++
 include/linux/pwm.h |  39 +++++++++++++++++
 3 files changed, 221 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6ab1b1f..59a9df9120de 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -136,6 +136,7 @@ struct pwm_device *
 of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
+	int modebit;
 
 	/* check, whether the driver supports a third cell for flags */
 	if (pc->of_pwm_n_cells < 3)
@@ -154,9 +155,23 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 
 	pwm->args.period = args->args[1];
 	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	pwm->args.mode = pwm_mode_get_valid(pc, pwm);
 
-	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity = PWM_POLARITY_INVERSED;
+	if (args->args_count > 2) {
+		if (args->args[2] & PWM_POLARITY_INVERTED)
+			pwm->args.polarity = PWM_POLARITY_INVERSED;
+
+		for (modebit = PWMC_MODE_COMPLEMENTARY_BIT;
+		     modebit < PWMC_MODE_CNT; modebit++) {
+			unsigned long mode = BIT(modebit);
+
+			if ((args->args[2] & mode) &&
+			    pwm_mode_valid(pwm, mode)) {
+				pwm->args.mode = mode;
+				break;
+			}
+		}
+	}
 
 	return pwm;
 }
@@ -183,6 +198,7 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 		return pwm;
 
 	pwm->args.period = args->args[1];
+	pwm->args.mode = pwm_mode_get_valid(pc, pwm);
 
 	return pwm;
 }
@@ -250,6 +266,97 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
 }
 
 /**
+ * pwm_get_caps() - get PWM capabilities of a PWM device
+ * @chip: PWM chip
+ * @pwm: PWM device to get the capabilities for
+ * @caps: returned capabilities
+ *
+ * Returns: 0 on success or a negative error code on failure
+ */
+int pwm_get_caps(struct pwm_chip *chip, struct pwm_device *pwm,
+		 struct pwm_caps *caps)
+{
+	if (!chip || !pwm || !caps)
+		return -EINVAL;
+
+	if (chip->ops && chip->ops->get_caps)
+		pwm->chip->ops->get_caps(chip, pwm, caps);
+	else if (chip->get_default_caps)
+		chip->get_default_caps(caps);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pwm_get_caps);
+
+static void pwmchip_get_default_caps(struct pwm_caps *caps)
+{
+	static const struct pwm_caps default_caps = {
+		.modes = PWMC_MODE(NORMAL),
+	};
+
+	if (!caps)
+		return;
+
+	*caps = default_caps;
+}
+
+/**
+ * pwm_mode_get_valid() - get the first available valid mode for PWM
+ * @chip: PWM chip
+ * @pwm: PWM device to get the valid mode for
+ *
+ * Returns: first valid mode for PWM device
+ */
+unsigned long pwm_mode_get_valid(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_caps caps;
+
+	if (pwm_get_caps(chip, pwm, &caps))
+		return PWMC_MODE(NORMAL);
+
+	return BIT(ffs(caps.modes) - 1);
+}
+EXPORT_SYMBOL_GPL(pwm_mode_get_valid);
+
+/**
+ * pwm_mode_valid() - check if mode is valid for PWM device
+ * @pwm: PWM device
+ * @mode: PWM mode to check if valid
+ *
+ * Returns: true if mode is valid and false otherwise
+ */
+bool pwm_mode_valid(struct pwm_device *pwm, unsigned long mode)
+{
+	struct pwm_caps caps;
+
+	if (!pwm || !mode)
+		return false;
+
+	if (hweight_long(mode) != 1 || ffs(mode) - 1 >= PWMC_MODE_CNT)
+		return false;
+
+	if (pwm_get_caps(pwm->chip, pwm, &caps))
+		return false;
+
+	return (caps.modes & mode);
+}
+EXPORT_SYMBOL_GPL(pwm_mode_valid);
+
+const char *pwm_mode_desc(struct pwm_device *pwm, unsigned long mode)
+{
+	static const char * const modes[] = {
+		"invalid",
+		"normal",
+		"complementary",
+	};
+
+	if (!pwm_mode_valid(pwm, mode))
+		return modes[0];
+
+	return modes[ffs(mode)];
+}
+
+/**
  * pwmchip_add_with_polarity() - register a new PWM chip
  * @chip: the PWM chip to add
  * @polarity: initial polarity of PWM channels
@@ -275,6 +382,8 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 
 	mutex_lock(&pwm_lock);
 
+	chip->get_default_caps = pwmchip_get_default_caps;
+
 	ret = alloc_pwms(chip->base, chip->npwm);
 	if (ret < 0)
 		goto out;
@@ -294,6 +403,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 		pwm->state.polarity = polarity;
+		pwm->state.mode = pwm_mode_get_valid(chip, pwm);
 
 		if (chip->ops->get_state)
 			chip->ops->get_state(chip, pwm, &pwm->state);
@@ -469,7 +579,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 	int err;
 
 	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	    state->duty_cycle > state->period ||
+	    !pwm_mode_valid(pwm, state->mode))
 		return -EINVAL;
 
 	if (!memcmp(state, &pwm->state, sizeof(*state)))
@@ -530,6 +641,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 
 			pwm->state.enabled = state->enabled;
 		}
+
+		/* No mode support for non-atomic PWM. */
+		pwm->state.mode = state->mode;
 	}
 
 	return 0;
@@ -579,6 +693,8 @@ int pwm_adjust_config(struct pwm_device *pwm)
 	pwm_get_args(pwm, &pargs);
 	pwm_get_state(pwm, &state);
 
+	state.mode = pargs.mode;
+
 	/*
 	 * If the current period is zero it means that either the PWM driver
 	 * does not support initial state retrieval or the PWM has not yet
@@ -850,6 +966,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 
 	pwm->args.period = chosen->period;
 	pwm->args.polarity = chosen->polarity;
+	pwm->args.mode = pwm_mode_get_valid(chip, pwm);
 
 	return pwm;
 }
@@ -999,6 +1116,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		seq_printf(s, " duty: %u ns", state.duty_cycle);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
+		seq_printf(s, " mode: %s", pwm_mode_desc(pwm, state.mode));
 
 		seq_puts(s, "\n");
 	}
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 83f2b0b15712..785eda0b1e67 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -223,11 +223,71 @@ static ssize_t capture_show(struct device *child,
 	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
 }
 
+static ssize_t mode_show(struct device *child,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_state state;
+	unsigned long mode;
+	int modebit, len = 0;
+
+	pwm_get_state(pwm, &state);
+
+	for (modebit = PWMC_MODE_NORMAL_BIT;
+	     modebit < PWMC_MODE_CNT; modebit++) {
+		mode = BIT(modebit);
+		if (pwm_mode_valid(pwm, mode)) {
+			if (state.mode == mode)
+				len += scnprintf(buf + len,
+						 PAGE_SIZE - len, "[%s] ",
+						 pwm_mode_desc(pwm, mode));
+			else
+				len += scnprintf(buf + len,
+						 PAGE_SIZE - len, "%s ",
+						 pwm_mode_desc(pwm, mode));
+		}
+	}
+
+	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+	return len;
+}
+
+static ssize_t mode_store(struct device *child,
+			  struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	unsigned long mode;
+	int modebit, ret;
+
+	for (modebit = PWMC_MODE_NORMAL_BIT;
+	     modebit < PWMC_MODE_CNT; modebit++) {
+		mode = BIT(modebit);
+		if (sysfs_streq(buf, pwm_mode_desc(pwm, mode)))
+			break;
+	}
+
+	if (modebit == PWMC_MODE_CNT)
+		return -EINVAL;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.mode = mode;
+	ret = pwm_apply_state(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
 static DEVICE_ATTR_RO(capture);
+static DEVICE_ATTR_RW(mode);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
@@ -235,6 +295,7 @@ static struct attribute *pwm_attrs[] = {
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
+	&dev_attr_mode.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 56518adc31dd..a4ce4ad7edf0 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -26,9 +26,32 @@ enum pwm_polarity {
 };
 
 /**
+ * PWM modes capabilities
+ * @PWMC_MODE_NORMAL_BIT: PWM has one output
+ * @PWMC_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite polarities
+ * @PWMC_MODE_CNT: PWM modes count
+ */
+enum {
+	PWMC_MODE_NORMAL_BIT,
+	PWMC_MODE_COMPLEMENTARY_BIT,
+	PWMC_MODE_CNT,
+};
+
+#define PWMC_MODE(name)		BIT(PWMC_MODE_##name##_BIT)
+
+/**
+ * struct pwm_caps - PWM capabilities
+ * @modes: PWM modes
+ */
+struct pwm_caps {
+	unsigned long modes;
+};
+
+/**
  * struct pwm_args - board-dependent PWM arguments
  * @period: reference period
  * @polarity: reference polarity
+ * @mode: reference mode
  *
  * This structure describes board-dependent arguments attached to a PWM
  * device. These arguments are usually retrieved from the PWM lookup table or
@@ -41,6 +64,7 @@ enum pwm_polarity {
 struct pwm_args {
 	unsigned int period;
 	enum pwm_polarity polarity;
+	unsigned long mode;
 };
 
 enum {
@@ -53,12 +77,14 @@ enum {
  * @period: PWM period (in nanoseconds)
  * @duty_cycle: PWM duty cycle (in nanoseconds)
  * @polarity: PWM polarity
+ * @mode: PWM mode
  * @enabled: PWM enabled status
  */
 struct pwm_state {
 	unsigned int period;
 	unsigned int duty_cycle;
 	enum pwm_polarity polarity;
+	unsigned long mode;
 	bool enabled;
 };
 
@@ -181,6 +207,7 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
 	state->period = args.period;
 	state->polarity = args.polarity;
 	state->duty_cycle = 0;
+	state->mode = args.mode;
 }
 
 /**
@@ -254,6 +281,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
+ * @get_caps: get PWM capabilities.
  * @dbg_show: optional routine to show contents in debugfs
  * @owner: helps prevent removal of modules exporting active PWMs
  */
@@ -272,6 +300,8 @@ struct pwm_ops {
 		     struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
+	void (*get_caps)(struct pwm_chip *chip, struct pwm_device *pwm,
+			 struct pwm_caps *caps);
 #ifdef CONFIG_DEBUG_FS
 	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
 #endif
@@ -287,6 +317,7 @@ struct pwm_ops {
  * @npwm: number of PWMs controlled by this chip
  * @pwms: array of PWM devices allocated by the framework
  * @of_xlate: request a PWM device given a device tree PWM specifier
+ * @get_default_caps: get default PWM capabilities
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
  */
 struct pwm_chip {
@@ -300,6 +331,7 @@ struct pwm_chip {
 
 	struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
 					const struct of_phandle_args *args);
+	void (*get_default_caps)(struct pwm_caps *caps);
 	unsigned int of_pwm_n_cells;
 };
 
@@ -438,6 +470,12 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 					 unsigned int index,
 					 const char *label);
 
+int pwm_get_caps(struct pwm_chip *chip, struct pwm_device *pwm,
+		 struct pwm_caps *caps);
+unsigned long pwm_mode_get_valid(struct pwm_chip *chip,
+				 struct pwm_device *pwm);
+bool pwm_mode_valid(struct pwm_device *pwm, unsigned long mode);
+const char *pwm_mode_desc(struct pwm_device *pwm, unsigned long mode);
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
 
@@ -592,6 +630,7 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
 	state.enabled = false;
 	state.polarity = pwm->args.polarity;
 	state.period = pwm->args.period;
+	state.mode = pwm->args.mode;
 
 	pwm_apply_state(pwm, &state);
 }
-- 
2.7.4
