Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx484UhmUsuqTlBKuTiRHC0FniX3VxVt6asm4ijZdCjqkoj11nbm2EkGyWi0QIvSBEu561Qz/
ARC-Seal: i=1; a=rsa-sha256; t=1524505588; cv=none;
        d=google.com; s=arc-20160816;
        b=MDqRK+uvUgLV8j8kq+Zk/mIbs1A44WBjTuoIUcjVsu/33V9HBrCtAV/3ByutxFEEAi
         KVaqUjJOWoRIM4AMIgfnXA6AFEdGXskR2LeVFdoC1sd2BNqRi8x7uc0eRbKo71KosqY9
         ClQdNONmdCy9lHp9+8DFmB6g0kWopY63DswEggsm2SpoaGyXLe68IQ9LD9b6V5KX1DsK
         yBs4TS+vm4+9/EEB8RIeeIUXStFv439hX2EX/ty5c5PrXHwKHdsS4syrgO3Ajzxly7CS
         K4OhuKcrHzzPTPZCgjEFh3fN6W5lgszmmXO5mlrzAntSATAQku3OUk08tdmgra25+vlp
         fEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Wncy+4c0r0ibHzc/MEO6e4aitPu9iGGJ+6NKS//nfv8=;
        b=E+YeGbthZYST1uDfVMOCHJOW3pld2xYYcsepeF2HVx//rrV/802ne6LHurG7TMVU0T
         oOx53537L79T6ojkdCboMH300Gl6oVKIU/4Q8oTGuPqw/69/wxDUH5xNeFORABp7pgPW
         u+YuYga25tfmzcxWcCH7cFGKsgUGC7Q+oZGOZL6ds1FS2Fr/xD0DeS2sQipbohXL/Rzq
         oQoLtGYUE81A19ca2JtTCVAsfy00vYqvQXt9xJdLgpiRUhu6AUGwsyGGhcMT1V/P+EIY
         +M0ciYqmOkatqZesjQgN8fLogRd9Q3Z/JsPDkuHhGaYI4AxoFn3G9qhwwXk9NFaHIH8Z
         wzqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>,
	Suman Anna <s-anna@ti.com>,
	Tero Kristo <t-kristo@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 09/16] bus: ti-sysc: Add handling for clkctrl opt clocks
Date: Mon, 23 Apr 2018 10:45:42 -0700
Message-Id: <20180423174549.57412-10-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559971820741391?=
X-GMAIL-MSGID: =?utf-8?q?1598559971820741391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There can be up to eight optional device functional gate gate clocks for
each clkctrl instance in clkctrl register bits 8 to 15. Some of them are
only needed for module level reset while others may always be needed
during use. Let's add support for those and update the binding doc
accordingly.

Note that the optional clkctrl mux and divider clocks starting at bit 20
can be directly mapped to the child devices, and ti-sysc does not need to
manage those.

And as GPIOs need the optional clocks for reset, we can now add it with
SYSC_QUIRK_OPT_CLKS_IN_RESET.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/bus/ti-sysc.txt       |   6 +-
 drivers/bus/ti-sysc.c                         | 140 ++++++++++++++----
 2 files changed, 120 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -79,7 +79,11 @@ Optional properties:
 		mode as for example omap4 L4_CFG_CLKCTRL
 
 - clock-names	should contain at least "fck", and optionally also "ick"
-		depending on the SoC and the interconnect target module
+		depending on the SoC and the interconnect target module,
+		some interconnect target modules also need additional
+		optional clocks that can be specified as listed in TRM
+		for the related CLKCTRL register bits 8 to 15 such as
+		"dbclk" or "clk32k" depending on their role
 
 - ti,hwmods	optional TI interconnect module name to use legacy
 		hwmod platform data
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -32,10 +32,18 @@ static const char * const reg_names[] = { "rev", "sysc", "syss", };
 enum sysc_clocks {
 	SYSC_FCK,
 	SYSC_ICK,
+	SYSC_OPTFCK0,
+	SYSC_OPTFCK1,
+	SYSC_OPTFCK2,
+	SYSC_OPTFCK3,
+	SYSC_OPTFCK4,
+	SYSC_OPTFCK5,
+	SYSC_OPTFCK6,
+	SYSC_OPTFCK7,
 	SYSC_MAX_CLOCKS,
 };
 
-static const char * const clock_names[] = { "fck", "ick", };
+static const char * const clock_names[SYSC_ICK + 1] = { "fck", "ick", };
 
 #define SYSC_IDLEMODE_MASK		3
 #define SYSC_CLOCKACTIVITY_MASK		3
@@ -48,6 +56,8 @@ static const char * const clock_names[] = { "fck", "ick", };
  * @module_va: virtual address of the interconnect target module
  * @offsets: register offsets from module base
  * @clocks: clocks used by the interconnect target module
+ * @clock_roles: clock role names for the found clocks
+ * @nr_clocks: number of clocks used by the interconnect target module
  * @legacy_mode: configured for legacy mode if set
  * @cap: interconnect target module capabilities
  * @cfg: interconnect target module configuration
@@ -61,7 +71,9 @@ struct sysc {
 	u32 module_size;
 	void __iomem *module_va;
 	int offsets[SYSC_MAX_REGS];
-	struct clk *clocks[SYSC_MAX_CLOCKS];
+	struct clk **clocks;
+	const char **clock_roles;
+	int nr_clocks;
 	const char *legacy_mode;
 	const struct sysc_capabilities *cap;
 	struct sysc_config cfg;
@@ -88,6 +100,11 @@ static u32 sysc_read(struct sysc *ddata, int offset)
 	return readl_relaxed(ddata->module_va + offset);
 }
 
+static bool sysc_opt_clks_needed(struct sysc *ddata)
+{
+	return !!(ddata->cfg.quirks & SYSC_QUIRK_OPT_CLKS_NEEDED);
+}
+
 static u32 sysc_read_revision(struct sysc *ddata)
 {
 	int offset = ddata->offsets[SYSC_REVISION];
@@ -98,21 +115,28 @@ static u32 sysc_read_revision(struct sysc *ddata)
 	return sysc_read(ddata, offset);
 }
 
-static int sysc_get_one_clock(struct sysc *ddata,
-			      enum sysc_clocks index)
+static int sysc_get_one_clock(struct sysc *ddata, const char *name)
 {
-	const char *name;
-	int error;
+	int error, i, index = -ENODEV;
+
+	if (!strncmp(clock_names[SYSC_FCK], name, 3))
+		index = SYSC_FCK;
+	else if (!strncmp(clock_names[SYSC_ICK], name, 3))
+		index = SYSC_ICK;
+
+	if (index < 0) {
+		for (i = SYSC_OPTFCK0; i < SYSC_MAX_CLOCKS; i++) {
+			if (!clock_names[i]) {
+				index = i;
+				break;
+			}
+		}
+	}
 
-	switch (index) {
-	case SYSC_FCK:
-		break;
-	case SYSC_ICK:
-		break;
-	default:
-		return -EINVAL;
+	if (index < 0) {
+		dev_err(ddata->dev, "clock %s not added\n", name);
+		return index;
 	}
-	name = clock_names[index];
 
 	ddata->clocks[index] = devm_clk_get(ddata->dev, name);
 	if (IS_ERR(ddata->clocks[index])) {
@@ -138,10 +162,50 @@ static int sysc_get_one_clock(struct sysc *ddata,
 
 static int sysc_get_clocks(struct sysc *ddata)
 {
-	int i, error;
+	struct device_node *np = ddata->dev->of_node;
+	struct property *prop;
+	const char *name;
+	int nr_fck = 0, nr_ick = 0, i, error = 0;
 
-	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
-		error = sysc_get_one_clock(ddata, i);
+	ddata->clock_roles = devm_kzalloc(ddata->dev,
+					  sizeof(*ddata->clock_roles) *
+					  SYSC_MAX_CLOCKS,
+					  GFP_KERNEL);
+	if (!ddata->clock_roles)
+		return -ENOMEM;
+
+	of_property_for_each_string(np, "clock-names", prop, name) {
+		if (!strncmp(clock_names[SYSC_FCK], name, 3))
+			nr_fck++;
+		if (!strncmp(clock_names[SYSC_ICK], name, 3))
+			nr_ick++;
+		ddata->clock_roles[ddata->nr_clocks] = name;
+		ddata->nr_clocks++;
+	}
+
+	if (ddata->nr_clocks < 1)
+		return 0;
+
+	if (ddata->nr_clocks > SYSC_MAX_CLOCKS) {
+		dev_err(ddata->dev, "too many clocks for %pOF\n", np);
+
+		return -EINVAL;
+	}
+
+	if (nr_fck > 1 || nr_ick > 1) {
+		dev_err(ddata->dev, "max one fck and ick for %pOF\n", np);
+
+		return -EINVAL;
+	}
+
+	ddata->clocks = devm_kzalloc(ddata->dev,
+				     sizeof(*ddata->clocks) * ddata->nr_clocks,
+				     GFP_KERNEL);
+	if (!ddata->clocks)
+		return -ENOMEM;
+
+	for (i = 0; i < ddata->nr_clocks; i++) {
+		error = sysc_get_one_clock(ddata, ddata->clock_roles[i]);
 		if (error && error != -ENOENT)
 			return error;
 	}
@@ -533,9 +597,13 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 		goto idled;
 	}
 
-	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
+	for (i = 0; i < ddata->nr_clocks; i++) {
 		if (IS_ERR_OR_NULL(ddata->clocks[i]))
 			continue;
+
+		if (i >= SYSC_OPTFCK0 && !sysc_opt_clks_needed(ddata))
+			break;
+
 		clk_disable(ddata->clocks[i]);
 	}
 
@@ -572,9 +640,13 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 		goto awake;
 	}
 
-	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
+	for (i = 0; i < ddata->nr_clocks; i++) {
 		if (IS_ERR_OR_NULL(ddata->clocks[i]))
 			continue;
+
+		if (i >= SYSC_OPTFCK0 && !sysc_opt_clks_needed(ddata))
+			break;
+
 		error = clk_enable(ddata->clocks[i]);
 		if (error)
 			return error;
@@ -651,7 +723,7 @@ struct sysc_revision_quirk {
 static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	/* These drivers need to be fixed to not use pm_runtime_irq_safe() */
 	SYSC_QUIRK("gpio", 0, 0, 0x10, 0x114, 0x50600801, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_LEGACY_IDLE | SYSC_QUIRK_OPT_CLKS_IN_RESET),
 	SYSC_QUIRK("mmu", 0, 0, 0x10, 0x14, 0x00000020, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("mmu", 0, 0, 0x10, 0x14, 0x00000030, 0xffffffff,
@@ -845,6 +917,26 @@ static int sysc_child_add_named_clock(struct sysc *ddata,
 	return error;
 }
 
+static int sysc_child_add_clocks(struct sysc *ddata,
+				 struct device *child)
+{
+	int i, error;
+
+	for (i = 0; i < ddata->nr_clocks; i++) {
+		error = sysc_child_add_named_clock(ddata,
+						   child,
+						   ddata->clock_roles[i]);
+		if (error && error != -EEXIST) {
+			dev_err(ddata->dev, "could not add child clock %s: %i\n",
+				ddata->clock_roles[i], error);
+
+			return error;
+		}
+	}
+
+	return 0;
+}
+
 static struct device_type sysc_device_type = {
 };
 
@@ -992,11 +1084,9 @@ static int sysc_notifier_call(struct notifier_block *nb,
 
 	switch (event) {
 	case BUS_NOTIFY_ADD_DEVICE:
-		error = sysc_child_add_named_clock(ddata, dev,
-						   clock_names[SYSC_FCK]);
-		if (error && error != -EEXIST)
-			dev_warn(ddata->dev, "could not add %s fck: %i\n",
-				 dev_name(dev), error);
+		error = sysc_child_add_clocks(ddata, dev);
+		if (error)
+			return error;
 		sysc_legacy_idle_quirk(ddata, dev);
 		break;
 	default:
-- 
2.17.0
