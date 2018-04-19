Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx4/NV/VCYKD7ZJWStaHJHOMPwVGat8mipesizTVEoQrfox/ix66lJm7IlTZK8rVbngXtkui3
ARC-Seal: i=1; a=rsa-sha256; t=1524135877; cv=none;
        d=google.com; s=arc-20160816;
        b=b7tHueCVpaYlFUaFQZJgPiFsgiJZSGImfovub6Lcy33hoy9FHJ38kb1sl49N6A1h3r
         ELXjWrWc97W+7zRBIfkdmeTIEV/o95fSYTdMsYnEu1JxAsop+CLvY4saqcS3wV+6sNfM
         h25TseOOMyjm12avUzs8By8leNOmQe4vyigYK6AnhHtyOe1oKoqqQGmU4wA88b/8yWCm
         JFm9caCD7W1wTXed6PGznJaj442yk+W4ZBWNRYpcDNWCRLdoefuxFY0FhrkPDTp7ZYl8
         hp7a3nsN+NAPbv+GodDRXCzaV79MLm+V8oF7G9grEvQmGZ1MllaeeIzzz39fWkIw0eAZ
         mq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=XOhdjxxnobuxpEtybpk81F84gRJ4Z7rS7l8ZmVyxYEw=;
        b=f02uxvz8K4LDzEKtm3r38347vmKEpEK5tuI8jKlHuFdZ+R5GMuI9dNBhsMbpKA18SI
         DAAmxh/NZXkGJOU4UfqJ3b1oVY+zenMgZ07qK78Qr6OeKjUIANpZBZLGOJpPIpksWLgx
         CR+GDq99Un+9ZTNNAj+e4Ii67J3iceq4FqryzSqZwaBcWaR1nFJErJWAIoYf/2EAeLo5
         PPUHrigKGERS7574HMhF12+BAq9rekQ0YMlijV5CHHiC8eDmbST7GoViMnv8AG+kxJJa
         Mu+HoFLwFemtzfopaA0FrttqHlcKe9WqqkyU3Xgfgnlz5YVe2u+Gih90ruNzXvO9KoBo
         VSHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=bdXAf2nv;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.78 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=bdXAf2nv;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.78 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w3JB42us024223
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-usb@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 2/2] usb: dwc3: support clocks and resets for DWC3 core
Date: Thu, 19 Apr 2018 20:03:38 +0900
Message-Id: <1524135818-14825-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598172301797892822?=
X-GMAIL-MSGID: =?utf-8?q?1598172301797892822?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Historically, the clocks and resets are handled on the glue layer
side instead of the DWC3 core.  For simple cases, dwc3-of-simple.c
takes care of arbitrary number of clocks and resets.  The DT node
structure typically looks like as follows:

  dwc3-glue {
          compatible = "foo,dwc3";
          clocks = ...;
          resets = ...;
          ...

          dwc3 {
                  compatible = "snps,dwc3";
                  ...
          };
  }

By supporting the clocks and the reset in the dwc3/core.c, it will
be turned into a single node:

  dwc3 {
          compatible = "foo,dwc3", "snps,dwc3";
          clocks = ...;
          resets = ...;
          ...
  }

This commit adds the binding of clocks and resets specific to this IP.
The number of clocks should generally be the same across SoCs, it is
just some SoCs either tie clocks together or do not provide software
control of some of the clocks.

I took the clock names from the Synopsys datasheet: "ref" (ref_clk),
"bus_early" (bus_clk_early), and "suspend" (suspend_clk).

I found only one reset line in the datasheet, hence the reset-names
property is omitted.

Supporting those clocks and resets is the requirement for new platforms.
Enforcing the new binding breaks existing platforms since they specify
clocks and resets in their glue layer node, but nothing in the core
node.  I listed such exceptional cases in the DT binding.  The driver
code is loosened up to accept no clock/reset.  This change is based
on the discussion [1].

I inserted reset_control_deassert() and clk_bulk_enable() before the
first register access, i.e. dwc3_cache_hwparams().

[1] https://patchwork.kernel.org/patch/10284265/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Make clocks specific to this IP based on Synopsys datasheet
  - Use clk_bulk API
  - Add description to struct header

 Documentation/devicetree/bindings/usb/dwc3.txt | 21 ++++++
 drivers/usb/dwc3/core.c                        | 89 +++++++++++++++++++++++++-
 drivers/usb/dwc3/core.h                        |  8 +++
 3 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 0dbd308..feb1cc33 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -7,6 +7,27 @@ Required properties:
  - compatible: must be "snps,dwc3"
  - reg : Address and length of the register set for the device
  - interrupts: Interrupts used by the dwc3 controller.
+ - clock-names: should contain "ref", "bus_early", "suspend"
+ - clocks: list of phandle and clock specifier pairs corresponding to
+           entries in the clock-names property.
+ - resets: a single pair of phandle and reset specifier
+
+Exception for clocks and resets:
+  clocks and resets are optional if the parent node (i.e. glue-layer)
+  is compatible to one of the following:
+    "amlogic,meson-axg-dwc3"
+    "amlogic,meson-gxl-dwc3"
+    "cavium,octeon-7130-usb-uctl"
+    "qcom,dwc3"
+    "samsung,exynos5250-dwusb3"
+    "samsung,exynos7-dwusb3"
+    "sprd,sc9860-dwc3"
+    "st,stih407-dwc3"
+    "ti,am437x-dwc3"
+    "ti,dwc3"
+    "ti,keystone-dwc3"
+    "rockchip,rk3399-dwc3"
+    "xlnx,zynqmp-dwc3"
 
 Optional properties:
  - usb-phy : array of phandle for the PHY device.  The first element
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8e66edd..15e1613 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -8,6 +8,7 @@
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
+#include <linux/clk.h>
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -24,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/reset.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -266,6 +268,12 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	return 0;
 }
 
+static const struct clk_bulk_data dwc3_core_clks[] = {
+	{ .id = "ref" },
+	{ .id = "bus_early" },
+	{ .id = "suspend" },
+};
+
 /*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
@@ -667,6 +675,9 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
+	clk_bulk_disable(dwc->num_clks, dwc->clks);
+	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	reset_control_assert(dwc->reset);
 }
 
 static bool dwc3_core_is_valid(struct dwc3 *dwc)
@@ -1256,6 +1267,12 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (!dwc)
 		return -ENOMEM;
 
+	dwc->clks = devm_kmemdup(dev, dwc3_core_clks, sizeof(dwc3_core_clks),
+				 GFP_KERNEL);
+	if (!dwc->clks)
+		return -ENOMEM;
+
+	dwc->num_clks = ARRAY_SIZE(dwc3_core_clks);
 	dwc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1286,6 +1303,33 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	/* Reset is optional to save existing platforms. */
+	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
+	if (IS_ERR(dwc->reset))
+		return PTR_ERR(dwc->reset);
+
+	ret = clk_bulk_get(dev, dwc->num_clks, dwc->clks);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	/*
+	 * Clocks are optional to save existing platforms. New platforms should
+	 * support all clocks as required by the DT-binding.
+	 */
+	if (ret)
+		dwc->num_clks = 0;
+
+	ret = reset_control_deassert(dwc->reset);
+	if (ret)
+		goto put_clks;
+
+	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto assert_reset;
+
+	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto unprepare_clks;
+
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
 
@@ -1349,6 +1393,14 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	clk_bulk_disable(dwc->num_clks, dwc->clks);
+unprepare_clks:
+	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+assert_reset:
+	reset_control_assert(dwc->reset);
+put_clks:
+	clk_bulk_put(dwc->num_clks, dwc->clks);
+
 	return ret;
 }
 
@@ -1370,11 +1422,44 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
+	clk_bulk_put(dwc->num_clks, dwc->clks);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM
+static int dwc3_core_init_for_resume(struct dwc3 *dwc)
+{
+	int ret;
+
+	ret = reset_control_deassert(dwc->reset);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto assert_reset;
+
+	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto unprepare_clks;
+
+	ret = dwc3_core_init(dwc);
+	if (ret)
+		goto disable_clks;
+
+	return 0;
+
+disable_clks:
+	clk_bulk_disable(dwc->num_clks, dwc->clks);
+unprepare_clks:
+	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+assert_reset:
+	reset_control_assert(dwc->reset);
+
+	return ret;
+}
+
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
@@ -1420,7 +1505,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		ret = dwc3_core_init(dwc);
+		ret = dwc3_core_init_for_resume(dwc);
 		if (ret)
 			return ret;
 
@@ -1432,7 +1517,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_HOST:
 		/* nothing to do on host runtime_resume */
 		if (!PMSG_IS_AUTO(msg)) {
-			ret = dwc3_core_init(dwc);
+			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
 			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4f3b438..1765e01 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -891,6 +891,9 @@ struct dwc3_scratchpad_array {
  * @eps: endpoint array
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
+ * @clks: array of clocks
+ * @num_clks: number of clocks
+ * @reset: reset control
  * @regs: base address for our registers
  * @regs_size: address space size
  * @fladj: frame length adjustment
@@ -1013,6 +1016,11 @@ struct dwc3 {
 	struct usb_gadget	gadget;
 	struct usb_gadget_driver *gadget_driver;
 
+	struct clk_bulk_data	*clks;
+	int			num_clks;
+
+	struct reset_control	*reset;
+
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
 
-- 
2.7.4
