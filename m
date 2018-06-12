Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BF49FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB9B20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB9B20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934476AbeFLUIu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:08:50 -0400
Received: from mailoutvs6.siol.net ([185.57.226.197]:38300 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933845AbeFLUCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:02:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id A5AE5522184;
        Tue, 12 Jun 2018 22:02:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6kuzesZzNrcI; Tue, 12 Jun 2018 22:02:00 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 856A5521FAC;
        Tue, 12 Jun 2018 22:02:00 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 02BBE522148;
        Tue, 12 Jun 2018 22:01:57 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 05/27] drm/sun4i: Add TCON TOP driver
Date:   Tue, 12 Jun 2018 22:00:14 +0200
Message-Id: <20180612200036.21483-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As already described in DT binding, TCON TOP is responsible for
configuring display pipeline. In this initial driver focus is on HDMI
pipeline, so TVE and LCD configuration is not implemented.

Implemented features:
- HDMI source selection
- clock driver (TCON and DSI gating)
- connecting mixers and TCONS

Something similar also existed in previous SoCs, except that it was part
of first TCON.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/Makefile         |   3 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 248 +++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h |  38 ++++
 3 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.h

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 2589f4acd5ae..09fbfd6304ba 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -16,7 +16,8 @@ sun8i-drm-hdmi-y		+= sun8i_hdmi_phy_clk.o
 
 sun8i-mixer-y			+= sun8i_mixer.o sun8i_ui_layer.o \
 				   sun8i_vi_layer.o sun8i_ui_scaler.o \
-				   sun8i_vi_scaler.o sun8i_csc.o
+				   sun8i_vi_scaler.o sun8i_csc.o \
+				   sun8i_tcon_top.o
 
 sun4i-tcon-y			+= sun4i_crtc.o
 sun4i-tcon-y			+= sun4i_dotclock.o
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
new file mode 100644
index 000000000000..60b17e893f08
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2018 Jernej Skrabec <jernej.skrabec@siol.net> */
+
+#include <drm/drmP.h>
+
+#include <dt-bindings/clock/sun8i-tcon-top.h>
+
+#include <linux/bitfield.h>
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+
+#include "sun8i_tcon_top.h"
+
+struct sun8i_tcon_top_gate {
+	const char	*name;
+	u8		bit;
+	int		index;
+};
+
+static const struct sun8i_tcon_top_gate gates[] = {
+	{"bus-tcon-top-dsi", TCON_TOP_TCON_DSI_GATE, CLK_BUS_TCON_TOP_DSI},
+	{"bus-tcon-top-tv0", TCON_TOP_TCON_TV0_GATE, CLK_BUS_TCON_TOP_TV0},
+	{"bus-tcon-top-tv1", TCON_TOP_TCON_TV1_GATE, CLK_BUS_TCON_TOP_TV1},
+};
+
+static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
+					      int port_id)
+{
+	struct device_node *ep, *remote, *port;
+	struct of_endpoint endpoint;
+
+	port = of_graph_get_port_by_id(node, port_id);
+	if (!port)
+		return -ENOENT;
+
+	for_each_available_child_of_node(port, ep) {
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote)
+			continue;
+
+		if (of_device_is_available(remote)) {
+			of_graph_parse_endpoint(ep, &endpoint);
+
+			of_node_put(remote);
+
+			return endpoint.id;
+		}
+
+		of_node_put(remote);
+	}
+
+	return -ENOENT;
+}
+
+static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
+			       void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct clk_hw_onecell_data *clk_data;
+	struct sun8i_tcon_top *tcon_top;
+	bool mixer0_unused = false;
+	struct resource *res;
+	void __iomem *regs;
+	const char *parent;
+	int ret, i, id;
+	u32 val;
+
+	tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
+	if (!tcon_top)
+		return -ENOMEM;
+
+	clk_data = devm_kzalloc(dev, sizeof(*clk_data) +
+				sizeof(*clk_data->hws) * CLK_NUM,
+				GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+	tcon_top->clk_data = clk_data;
+
+	spin_lock_init(&tcon_top->reg_lock);
+
+	tcon_top->rst = devm_reset_control_get(dev, "rst");
+	if (IS_ERR(tcon_top->rst)) {
+		dev_err(dev, "Couldn't get our reset line\n");
+		return PTR_ERR(tcon_top->rst);
+	}
+
+	tcon_top->bus = devm_clk_get(dev, "bus");
+	if (IS_ERR(tcon_top->bus)) {
+		dev_err(dev, "Couldn't get the bus clock\n");
+		return PTR_ERR(tcon_top->bus);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	ret = reset_control_deassert(tcon_top->rst);
+	if (ret) {
+		dev_err(dev, "Could not deassert ctrl reset control\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(tcon_top->bus);
+	if (ret) {
+		dev_err(dev, "Could not enable bus clock\n");
+		goto err_assert_reset;
+	}
+
+	val = 0;
+
+	/* check if HDMI mux output is connected */
+	if (sun8i_tcon_top_get_connected_ep_id(dev->of_node, 5) >= 0) {
+		/* find HDMI input endpoint id, if it is connected at all*/
+		id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 4);
+		if (id >= 0)
+			val = FIELD_PREP(TCON_TOP_HDMI_SRC_MSK, id + 1);
+		else
+			DRM_DEBUG_DRIVER("TCON TOP HDMI input is not connected\n");
+	} else {
+		DRM_DEBUG_DRIVER("TCON TOP HDMI output is not connected\n");
+	}
+
+	writel(val, regs + TCON_TOP_GATE_SRC_REG);
+
+	val = 0;
+
+	/* process mixer0 mux output */
+	id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 1);
+	if (id >= 0) {
+		val = FIELD_PREP(TCON_TOP_PORT_DE0_MSK, id);
+	} else {
+		DRM_DEBUG_DRIVER("TCON TOP mixer0 output is not connected\n");
+		mixer0_unused = true;
+	}
+
+	/* process mixer1 mux output */
+	id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 3);
+	if (id >= 0) {
+		val |= FIELD_PREP(TCON_TOP_PORT_DE1_MSK, id);
+
+		/*
+		 * mixer0 mux has priority over mixer1 mux. We have to
+		 * make sure mixer0 doesn't overtake TCON from mixer1.
+		 */
+		if (mixer0_unused && id == 0)
+			val |= FIELD_PREP(TCON_TOP_PORT_DE0_MSK, 1);
+	} else {
+		DRM_DEBUG_DRIVER("TCON TOP mixer1 output is not connected\n");
+	}
+
+	writel(val, regs + TCON_TOP_PORT_SEL_REG);
+
+	parent = __clk_get_name(tcon_top->bus);
+
+	for (i = 0; i < CLK_NUM; i++) {
+		const struct sun8i_tcon_top_gate *gate = &gates[i];
+		struct clk_hw *hw;
+
+		hw = clk_hw_register_gate(dev, gate->name, parent, 0,
+					  regs + TCON_TOP_GATE_SRC_REG,
+					  gate->bit, 0, &tcon_top->reg_lock);
+		if (IS_ERR(hw)) {
+			ret = PTR_ERR(hw);
+			goto err_unregister_gates;
+		}
+
+		clk_data->hws[gate->index] = hw;
+	}
+
+	clk_data->num = CLK_NUM;
+
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+				     clk_data);
+	if (ret)
+		goto err_unregister_gates;
+
+	dev_set_drvdata(dev, tcon_top);
+
+	return 0;
+
+err_unregister_gates:
+	for (i = 0; i < CLK_NUM; i++)
+		if (clk_data->hws[i])
+			clk_hw_unregister_gate(clk_data->hws[i]);
+	clk_disable_unprepare(tcon_top->bus);
+err_assert_reset:
+	reset_control_assert(tcon_top->rst);
+
+	return ret;
+}
+
+static void sun8i_tcon_top_unbind(struct device *dev, struct device *master,
+				  void *data)
+{
+	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
+	struct clk_hw_onecell_data *clk_data = tcon_top->clk_data;
+	int i;
+
+	of_clk_del_provider(dev->of_node);
+	for (i = 0; i < CLK_NUM; i++)
+		clk_hw_unregister_gate(clk_data->hws[i]);
+
+	clk_disable_unprepare(tcon_top->bus);
+	reset_control_assert(tcon_top->rst);
+}
+
+static const struct component_ops sun8i_tcon_top_ops = {
+	.bind	= sun8i_tcon_top_bind,
+	.unbind	= sun8i_tcon_top_unbind,
+};
+
+static int sun8i_tcon_top_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &sun8i_tcon_top_ops);
+}
+
+static int sun8i_tcon_top_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &sun8i_tcon_top_ops);
+
+	return 0;
+}
+
+/* sun4i_drv uses this list to check if a device node is a TCON TOP */
+const struct of_device_id sun8i_tcon_top_of_table[] = {
+	{ .compatible = "allwinner,sun8i-r40-tcon-top" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sun8i_tcon_top_of_table);
+EXPORT_SYMBOL(sun8i_tcon_top_of_table);
+
+static struct platform_driver sun8i_tcon_top_platform_driver = {
+	.probe		= sun8i_tcon_top_probe,
+	.remove		= sun8i_tcon_top_remove,
+	.driver		= {
+		.name		= "sun8i-tcon-top",
+		.of_match_table	= sun8i_tcon_top_of_table,
+	},
+};
+module_platform_driver(sun8i_tcon_top_platform_driver);
+
+MODULE_AUTHOR("Jernej Skrabec <jernej.skrabec@siol.net>");
+MODULE_DESCRIPTION("Allwinner R40 TCON TOP driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.h b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
new file mode 100644
index 000000000000..6cbb9f90d702
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2018 Jernej Skrabec <jernej.skrabec@siol.net> */
+
+#ifndef _SUN8I_TCON_TOP_H_
+#define _SUN8I_TCON_TOP_H_
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define TCON_TOP_PORT_SEL_REG		0x1C
+#define TCON_TOP_PORT_DE0_MSK			GENMASK(1, 0)
+#define TCON_TOP_PORT_DE1_MSK			GENMASK(5, 4)
+
+#define TCON_TOP_GATE_SRC_REG		0x20
+#define TCON_TOP_HDMI_SRC_MSK			GENMASK(29, 28)
+#define TCON_TOP_TCON_TV1_GATE			24
+#define TCON_TOP_TCON_TV0_GATE			20
+#define TCON_TOP_TCON_DSI_GATE			16
+
+#define CLK_NUM					3
+
+struct sun8i_tcon_top {
+	struct clk			*bus;
+	struct clk_hw_onecell_data	*clk_data;
+	struct reset_control		*rst;
+
+	/*
+	 * spinlock is used for locking access to registers from different
+	 * places - tcon driver and clk subsystem.
+	 */
+	spinlock_t			reg_lock;
+};
+
+extern const struct of_device_id sun8i_tcon_top_of_table[];
+
+#endif /* _SUN8I_TCON_TOP_H_ */
-- 
2.17.1

