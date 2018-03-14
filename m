Return-Path: <neil@brown.name>
X-Google-Smtp-Source: AG47ELucr8eOqznsIBu02l/kZO2+ZE5cU3UMNdk+g6KZPGKiODThKFWuA4WO4MG4iVau5WW+pna3
ARC-Seal: i=1; a=rsa-sha256; t=1521058993; cv=none;
        d=google.com; s=arc-20160816;
        b=Tg6GePN1V7G9ViVLziSkV62p0azOs2lJIYHayowX++fL4kNZEOHjkLPWp5apH5A9tJ
         LZW66Ns45PGG1VwQV+jic/MXJFM03EOonABP2msm+tQTi+p+91jBPSy4b9BPYVP9u/eY
         o8twonmB1oIsDN6Gpm/p8DSlNdm3B9pcozlYTCY8JGcmicuKc1QboS7UgDfnjdvK2IUS
         0NembDHnz3K2ESSPxo4g8qzhRBJIHbhwHfHM8Igze80ZkknMp1lLP4HaThdnmT/uZ3vI
         c8TnOQ5vDPExpgqLZCg16zhWnvUF5fEQgBVokTaenFCgmlOtnVgJbncvGZuvsfogQL3c
         0SJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=4QAt1IjjOUwOQKYps7NBx+dzWqxCL2qKvE5ys3vp/qY=;
        b=X2TN9mpvKC8hsf7Yjt//Pz05ReUBsU7/vcMwziwJRVhnb6xsa24lvTHk1ukhhULPIv
         fUsGDQBAJq0j7Mn1H86ZhXaJptV/w569ewqqJDgaiqXDpaf4GEJraqGok/tDmnDshKba
         ZaF5oHo5Ru2xi8H6mRNqR+2mHd8km2yfiU4cxX0r7yt1L6yHc6r/CH3yjrQvEcqgBoHH
         Ln4/RFbp9EA2wIR0RM0u28MPns3Zvdgvd9S1TtpboiwcpTYgakWMHoqWqy4nnul/U/Qs
         w1LAXd65uPXbBkhaMmsXxLUfdk301IdEVgBaEDcD+2/tcvBQjeDRgez5vKdD0pQ1bXjy
         ciSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Mar 2018 07:22:35 +1100
Subject: [PATCH 02/13] staging: mt7621-pinctrl: ralink: add pinctrl driver
Cc: devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
 John Crispin <blogic@openwrt.org>
Message-ID: <152105895506.22262.17783863404921290235.stgit@noble>
In-Reply-To: <152105892255.22262.1902152685410223215.stgit@noble>
References: <152105892255.22262.1902152685410223215.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594945955840240833?=
X-GMAIL-MSGID: =?utf-8?q?1594945955840240833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Crispin <blogic@openwrt.org>

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/Kconfig                         |    2 
 drivers/staging/Makefile                        |    1 
 drivers/staging/mt7621-pinctrl/Kconfig          |    4 
 drivers/staging/mt7621-pinctrl/Makefile         |    3 
 drivers/staging/mt7621-pinctrl/TODO             |    6 
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c |  472 +++++++++++++++++++++++
 6 files changed, 488 insertions(+)
 create mode 100644 drivers/staging/mt7621-pinctrl/Kconfig
 create mode 100644 drivers/staging/mt7621-pinctrl/Makefile
 create mode 100644 drivers/staging/mt7621-pinctrl/TODO
 create mode 100644 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index e95ab683331e..cdd04c8b4445 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -122,4 +122,6 @@ source "drivers/staging/vboxvideo/Kconfig"
 
 source "drivers/staging/pi433/Kconfig"
 
+source "drivers/staging/mt7621-pinctrl/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 4e79a4ad6cf6..db90d85a80d3 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_CRYPTO_DEV_CCREE)	+= ccree/
 obj-$(CONFIG_DRM_VBOXVIDEO)	+= vboxvideo/
 obj-$(CONFIG_PI433)		+= pi433/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-pci/
+obj-$(CONFIG_SOC_MT7621)	+= mt7621-pinctrl/
diff --git a/drivers/staging/mt7621-pinctrl/Kconfig b/drivers/staging/mt7621-pinctrl/Kconfig
new file mode 100644
index 000000000000..37cf9c3273be
--- /dev/null
+++ b/drivers/staging/mt7621-pinctrl/Kconfig
@@ -0,0 +1,4 @@
+config PINCTRL_RT2880
+	bool "RT2800 pinctrl driver for RALINK/Mediatek SOCs"
+	depends on RALINK
+	select PINMUX
diff --git a/drivers/staging/mt7621-pinctrl/Makefile b/drivers/staging/mt7621-pinctrl/Makefile
new file mode 100644
index 000000000000..856102137a1e
--- /dev/null
+++ b/drivers/staging/mt7621-pinctrl/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_PINCTRL_RT2880)   += pinctrl-rt2880.o
+
+ccflags-y += -I$(srctree)/drivers/pinctrl
diff --git a/drivers/staging/mt7621-pinctrl/TODO b/drivers/staging/mt7621-pinctrl/TODO
new file mode 100644
index 000000000000..b2c235a16d5c
--- /dev/null
+++ b/drivers/staging/mt7621-pinctrl/TODO
@@ -0,0 +1,6 @@
+
+- general code review and cleanup
+- should probably be always selected by 'config RALINK'
+- ensure device-tree requirements are documented
+
+Cc: NeilBrown <neil@brown.name>
diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
new file mode 100644
index 000000000000..3d2d1c2a006f
--- /dev/null
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -0,0 +1,472 @@
+/*
+ *  linux/drivers/pinctrl/pinctrl-rt2880.c
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ *
+ *  Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/machine.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+#include <asm/mach-ralink/pinmux.h>
+#include <asm/mach-ralink/mt7620.h>
+
+#include "core.h"
+
+#define SYSC_REG_GPIO_MODE	0x60
+#define SYSC_REG_GPIO_MODE2	0x64
+
+struct rt2880_priv {
+	struct device *dev;
+
+	struct pinctrl_pin_desc *pads;
+	struct pinctrl_desc *desc;
+
+	struct rt2880_pmx_func **func;
+	int func_count;
+
+	struct rt2880_pmx_group *groups;
+	const char **group_names;
+	int group_count;
+
+	uint8_t *gpio;
+	int max_pins;
+};
+
+static int rt2880_get_group_count(struct pinctrl_dev *pctrldev)
+{
+	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
+
+	return p->group_count;
+}
+
+static const char *rt2880_get_group_name(struct pinctrl_dev *pctrldev,
+					 unsigned group)
+{
+	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
+
+	if (group >= p->group_count)
+		return NULL;
+
+	return p->group_names[group];
+}
+
+static int rt2880_get_group_pins(struct pinctrl_dev *pctrldev,
+				 unsigned group,
+				 const unsigned **pins,
+				 unsigned *num_pins)
+{
+	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
+
+	if (group >= p->group_count)
+		return -EINVAL;
+
+	*pins = p->groups[group].func[0].pins;
+	*num_pins = p->groups[group].func[0].pin_count;
+
+	return 0;
+}
+
+static void rt2880_pinctrl_dt_free_map(struct pinctrl_dev *pctrldev,
+				    struct pinctrl_map *map, unsigned num_maps)
+{
+	int i;
+
+	for (i = 0; i < num_maps; i++)
+		if (map[i].type == PIN_MAP_TYPE_CONFIGS_PIN ||
+		    map[i].type == PIN_MAP_TYPE_CONFIGS_GROUP)
+			kfree(map[i].data.configs.configs);
+	kfree(map);
+}
+
+static void rt2880_pinctrl_pin_dbg_show(struct pinctrl_dev *pctrldev,
+					struct seq_file *s,
+					unsigned offset)
+{
+	seq_printf(s, "ralink pio");
+}
+
+static void rt2880_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctrldev,
+				struct device_node *np,
+				struct pinctrl_map **map)
+{
+        const char *function;
+	int func = of_property_read_string(np, "ralink,function", &function);
+	int grps = of_property_count_strings(np, "ralink,group");
+	int i;
+
+	if (func || !grps)
+		return;
+
+	for (i = 0; i < grps; i++) {
+	        const char *group;
+
+		of_property_read_string_index(np, "ralink,group", i, &group);
+
+		(*map)->type = PIN_MAP_TYPE_MUX_GROUP;
+		(*map)->name = function;
+		(*map)->data.mux.group = group;
+		(*map)->data.mux.function = function;
+		(*map)++;
+	}
+}
+
+static int rt2880_pinctrl_dt_node_to_map(struct pinctrl_dev *pctrldev,
+				struct device_node *np_config,
+				struct pinctrl_map **map,
+				unsigned *num_maps)
+{
+	int max_maps = 0;
+	struct pinctrl_map *tmp;
+	struct device_node *np;
+
+	for_each_child_of_node(np_config, np) {
+		int ret = of_property_count_strings(np, "ralink,group");
+
+		if (ret >= 0)
+			max_maps += ret;
+	}
+
+	if (!max_maps)
+		return max_maps;
+
+	*map = kzalloc(max_maps * sizeof(struct pinctrl_map), GFP_KERNEL);
+	if (!*map)
+		return -ENOMEM;
+
+	tmp = *map;
+
+	for_each_child_of_node(np_config, np)
+		rt2880_pinctrl_dt_subnode_to_map(pctrldev, np, &tmp);
+	*num_maps = max_maps;
+
+	return 0;
+}
+
+static const struct pinctrl_ops rt2880_pctrl_ops = {
+	.get_groups_count	= rt2880_get_group_count,
+	.get_group_name		= rt2880_get_group_name,
+	.get_group_pins		= rt2880_get_group_pins,
+	.pin_dbg_show		= rt2880_pinctrl_pin_dbg_show,
+	.dt_node_to_map		= rt2880_pinctrl_dt_node_to_map,
+	.dt_free_map		= rt2880_pinctrl_dt_free_map,
+};
+
+static int rt2880_pmx_func_count(struct pinctrl_dev *pctrldev)
+{
+	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
+
+	return p->func_count;
+}
+
+static const char *rt2880_pmx_func_name(struct pinctrl_dev *pctrldev,
+					 unsigned func)
+{
+	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
+
+	return p->func[func]->name;
+}
+
+static int rt2880_pmx_group_get_groups(struct pinctrl_dev *pctrldev,
+				unsigned func,
+				const char * const **groups,
+				unsigned * const num_groups)
+{
+	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
+
+	if (p->func[func]->group_count == 1)
+		*groups = &p->group_names[p->func[func]->groups[0]];
+	else
+		*groups = p->group_names;
+
+	*num_groups = p->func[func]->group_count;
+
+	return 0;
+}
+
+static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
+				unsigned func,
+				unsigned group)
+{
+	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
+        u32 mode = 0;
+	u32 reg = SYSC_REG_GPIO_MODE;
+	int i;
+	int shift;
+
+	/* dont allow double use */
+	if (p->groups[group].enabled) {
+		dev_err(p->dev, "%s is already enabled\n", p->groups[group].name);
+		return -EBUSY;
+	}
+
+	p->groups[group].enabled = 1;
+	p->func[func]->enabled = 1;
+
+	shift = p->groups[group].shift;
+	if (shift >= 32) {
+		shift -= 32;
+		reg = SYSC_REG_GPIO_MODE2;
+	}
+	mode = rt_sysc_r32(reg);
+	mode &= ~(p->groups[group].mask << shift);
+
+	/* mark the pins as gpio */
+	for (i = 0; i < p->groups[group].func[0].pin_count; i++)
+		p->gpio[p->groups[group].func[0].pins[i]] = 1;
+
+	/* function 0 is gpio and needs special handling */
+	if (func == 0) {
+		mode |= p->groups[group].gpio << shift;
+	} else {
+		for (i = 0; i < p->func[func]->pin_count; i++)
+			p->gpio[p->func[func]->pins[i]] = 0;
+		mode |= p->func[func]->value << shift;
+	}
+	rt_sysc_w32(mode, reg);
+
+	return 0;
+}
+
+static int rt2880_pmx_group_gpio_request_enable(struct pinctrl_dev *pctrldev,
+				struct pinctrl_gpio_range *range,
+				unsigned pin)
+{
+	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
+
+	if (!p->gpio[pin]) {
+		dev_err(p->dev, "pin %d is not set to gpio mux\n", pin);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct pinmux_ops rt2880_pmx_group_ops = {
+	.get_functions_count	= rt2880_pmx_func_count,
+	.get_function_name	= rt2880_pmx_func_name,
+	.get_function_groups	= rt2880_pmx_group_get_groups,
+	.set_mux		= rt2880_pmx_group_enable,
+	.gpio_request_enable	= rt2880_pmx_group_gpio_request_enable,
+};
+
+static struct pinctrl_desc rt2880_pctrl_desc = {
+	.owner		= THIS_MODULE,
+	.name		= "rt2880-pinmux",
+	.pctlops	= &rt2880_pctrl_ops,
+	.pmxops		= &rt2880_pmx_group_ops,
+};
+
+static struct rt2880_pmx_func gpio_func = {
+	.name = "gpio",
+};
+
+static int rt2880_pinmux_index(struct rt2880_priv *p)
+{
+	struct rt2880_pmx_func **f;
+	struct rt2880_pmx_group *mux = p->groups;
+	int i, j, c = 0;
+
+	/* count the mux functions */
+	while (mux->name) {
+		p->group_count++;
+		mux++;
+	}
+
+	/* allocate the group names array needed by the gpio function */
+	p->group_names = devm_kzalloc(p->dev, sizeof(char *) * p->group_count, GFP_KERNEL);
+	if (!p->group_names)
+		return -1;
+
+	for (i = 0; i < p->group_count; i++) {
+		p->group_names[i] = p->groups[i].name;
+		p->func_count += p->groups[i].func_count;
+	}
+
+	/* we have a dummy function[0] for gpio */
+	p->func_count++;
+
+	/* allocate our function and group mapping index buffers */
+	f = p->func = devm_kzalloc(p->dev, sizeof(struct rt2880_pmx_func) * p->func_count, GFP_KERNEL);
+	gpio_func.groups = devm_kzalloc(p->dev, sizeof(int) * p->group_count, GFP_KERNEL);
+	if (!f || !gpio_func.groups)
+		return -1;
+
+	/* add a backpointer to the function so it knows its group */
+	gpio_func.group_count = p->group_count;
+	for (i = 0; i < gpio_func.group_count; i++)
+		gpio_func.groups[i] = i;
+
+	f[c] = &gpio_func;
+	c++;
+
+	/* add remaining functions */
+	for (i = 0; i < p->group_count; i++) {
+		for (j = 0; j < p->groups[i].func_count; j++) {
+			f[c] = &p->groups[i].func[j];
+			f[c]->groups = devm_kzalloc(p->dev, sizeof(int), GFP_KERNEL);
+			f[c]->groups[0] = i;
+			f[c]->group_count = 1;
+			c++;
+		}
+	}
+	return 0;
+}
+
+static int rt2880_pinmux_pins(struct rt2880_priv *p)
+{
+	int i, j;
+
+	/* loop over the functions and initialize the pins array. also work out the highest pin used */
+	for (i = 0; i < p->func_count; i++) {
+		int pin;
+
+		if (!p->func[i]->pin_count)
+			continue;
+
+		p->func[i]->pins = devm_kzalloc(p->dev, sizeof(int) * p->func[i]->pin_count, GFP_KERNEL);
+		for (j = 0; j < p->func[i]->pin_count; j++)
+			p->func[i]->pins[j] = p->func[i]->pin_first + j;
+
+		pin = p->func[i]->pin_first + p->func[i]->pin_count;
+		if (pin > p->max_pins)
+			p->max_pins = pin;
+	}
+
+	/* the buffer that tells us which pins are gpio */
+	p->gpio = devm_kzalloc(p->dev,sizeof(uint8_t) * p->max_pins,
+		GFP_KERNEL);
+	/* the pads needed to tell pinctrl about our pins */
+	p->pads = devm_kzalloc(p->dev,
+		sizeof(struct pinctrl_pin_desc) * p->max_pins,
+		GFP_KERNEL);
+	if (!p->pads || !p->gpio ) {
+		dev_err(p->dev, "Failed to allocate gpio data\n");
+		return -ENOMEM;
+	}
+
+	memset(p->gpio, 1, sizeof(uint8_t) * p->max_pins);
+	for (i = 0; i < p->func_count; i++) {
+		if (!p->func[i]->pin_count)
+			continue;
+
+		for (j = 0; j < p->func[i]->pin_count; j++)
+			p->gpio[p->func[i]->pins[j]] = 0;
+	}
+
+	/* pin 0 is always a gpio */
+	p->gpio[0] = 1;
+
+	/* set the pads */
+	for (i = 0; i < p->max_pins; i++) {
+		/* strlen("ioXY") + 1 = 5 */
+		char *name = devm_kzalloc(p->dev, 5, GFP_KERNEL);
+
+		if (!name) {
+			dev_err(p->dev, "Failed to allocate pad name\n");
+			return -ENOMEM;
+		}
+		snprintf(name, 5, "io%d", i);
+		p->pads[i].number = i;
+		p->pads[i].name = name;
+	}
+	p->desc->pins = p->pads;
+	p->desc->npins = p->max_pins;
+
+	return 0;
+}
+
+static int rt2880_pinmux_probe(struct platform_device *pdev)
+{
+	struct rt2880_priv *p;
+	struct pinctrl_dev *dev;
+	struct device_node *np;
+
+	if (!rt2880_pinmux_data)
+		return -ENOSYS;
+
+	/* setup the private data */
+	p = devm_kzalloc(&pdev->dev, sizeof(struct rt2880_priv), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	p->dev = &pdev->dev;
+	p->desc = &rt2880_pctrl_desc;
+	p->groups = rt2880_pinmux_data;
+	platform_set_drvdata(pdev, p);
+
+	/* init the device */
+	if (rt2880_pinmux_index(p)) {
+		dev_err(&pdev->dev, "failed to load index\n");
+		return -EINVAL;
+	}
+	if (rt2880_pinmux_pins(p)) {
+		dev_err(&pdev->dev, "failed to load pins\n");
+		return -EINVAL;
+	}
+	dev = pinctrl_register(p->desc, &pdev->dev, p);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	/* finalize by adding gpio ranges for enables gpio controllers */
+	for_each_compatible_node(np, NULL, "ralink,rt2880-gpio") {
+		const __be32 *ngpio, *gpiobase;
+		struct pinctrl_gpio_range *range;
+		char *name;
+
+		if (!of_device_is_available(np))
+			continue;
+
+		ngpio = of_get_property(np, "ralink,num-gpios", NULL);
+		gpiobase = of_get_property(np, "ralink,gpio-base", NULL);
+		if (!ngpio || !gpiobase) {
+			dev_err(&pdev->dev, "failed to load chip info\n");
+			return -EINVAL;
+		}
+
+		range = devm_kzalloc(p->dev, sizeof(struct pinctrl_gpio_range) + 4, GFP_KERNEL);
+		range->name = name = (char *) &range[1];
+		sprintf(name, "pio");
+		range->npins = __be32_to_cpu(*ngpio);
+		range->base = __be32_to_cpu(*gpiobase);
+		range->pin_base = range->base;
+		pinctrl_add_gpio_range(dev, range);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id rt2880_pinmux_match[] = {
+	{ .compatible = "ralink,rt2880-pinmux" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt2880_pinmux_match);
+
+static struct platform_driver rt2880_pinmux_driver = {
+	.probe = rt2880_pinmux_probe,
+	.driver = {
+		.name = "rt2880-pinmux",
+		.owner = THIS_MODULE,
+		.of_match_table = rt2880_pinmux_match,
+	},
+};
+
+int __init rt2880_pinmux_init(void)
+{
+	return platform_driver_register(&rt2880_pinmux_driver);
+}
+
+core_initcall_sync(rt2880_pinmux_init);
