Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx48LMcmI4qxZDKtvEG0HBE3Fy1WhqIznoWweYgQ44+edBQRtt6p0FPuLxfFlUdlFcmk8wuj1
ARC-Seal: i=1; a=rsa-sha256; t=1524505590; cv=none;
        d=google.com; s=arc-20160816;
        b=R8p8Fv2Ica2WHe0kIp0rCy5vZUjxiXQMm27/OWh0JUyfnJabaJdyjn2ZZPosReWeD1
         wb5wcfQMqe+UwsDEQOZVCGZCqQHV57Eil8dJ/hWAvgME13qgGuttv4SzW8ukWx2mVfYX
         D7qY8nYOte/D6oRyqJ6borOS/ThJQpnPZLdlFwLycJoFnEIBtY1BhCWBVf+C93e6NN+M
         m78OugkPHBcpfYosbR8MIj5ilPo+li1mnUiueIe88ejkk1TuIPnEu1oMoF8dPriTMeyG
         a1biGahfkaAU89cJyiocv1eKjl23pylPzMlp7QlNDDM3c7QKQsdZ6oNB6SY6L0UFMANA
         yF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rZkTukPsRqKgaOVewjiXh9bso0oVrsV1kum+1b0Izec=;
        b=wwIpugrcFNESpEaaStEybmxbkoV3QB4RFYlYxP78BY3addWii+LzBhBjSpIhQ/PC43
         MIk7qC3XdBSlFHvcV1trKajxtPkIZXUNDCF+tRmKky8EL8hXZnnresTZL4v8dKGXOKfQ
         o5Fqb/+hgRtRh0CVwx7nXGN7uXA3NdARgs5s0zIPkTWSlgZGFC7+8L4icdW3etH8eIqp
         +MPbJR9PmJf+Qk0mkvEQrmt6WmgBJ9szrZDHShPEFAbJ0CDx5orvFiZduJk+ZAqWsBXS
         eLqPWmj6/eD5nHvmxW7yjLV0b6Az9fCPHpWAVam93UMZRtU4sHg5be4CKwo5n4f1wwWN
         ulTA==
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
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/16] bus: ti-sysc: Tag some modules resource providers for noirq suspend
Date: Mon, 23 Apr 2018 10:45:43 -0700
Message-Id: <20180423174549.57412-11-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559974507556205?=
X-GMAIL-MSGID: =?utf-8?q?1598559974507556205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Modules that provide resources for other modules need to be suspended
and resumed in the noirq calls. Tag the resource providing modules.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c                 | 77 +++++++++++++++++++++++++++
 include/linux/platform_data/ti-sysc.h |  1 +
 2 files changed, 78 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -665,6 +665,10 @@ static int sysc_suspend(struct device *dev)
 
 	ddata = dev_get_drvdata(dev);
 
+	if (ddata->cfg.quirks & (SYSC_QUIRK_RESOURCE_PROVIDER |
+				 SYSC_QUIRK_LEGACY_IDLE))
+		return 0;
+
 	if (!ddata->enabled)
 		return 0;
 
@@ -678,6 +682,58 @@ static int sysc_resume(struct device *dev)
 	struct sysc *ddata;
 
 	ddata = dev_get_drvdata(dev);
+
+	if (ddata->cfg.quirks & (SYSC_QUIRK_RESOURCE_PROVIDER |
+				 SYSC_QUIRK_LEGACY_IDLE))
+		return 0;
+
+	if (ddata->needs_resume) {
+		dev_dbg(ddata->dev, "%s %s\n", __func__,
+			ddata->name ? ddata->name : "");
+
+		ddata->needs_resume = false;
+
+		return sysc_runtime_resume(dev);
+	}
+
+	return 0;
+}
+
+static int sysc_noirq_suspend(struct device *dev)
+{
+	struct sysc *ddata;
+
+	ddata = dev_get_drvdata(dev);
+
+	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
+		return 0;
+
+	if (!(ddata->cfg.quirks & SYSC_QUIRK_RESOURCE_PROVIDER))
+		return 0;
+
+	if (!ddata->enabled)
+		return 0;
+
+	dev_dbg(ddata->dev, "%s %s\n", __func__,
+		ddata->name ? ddata->name : "");
+
+	ddata->needs_resume = true;
+
+	return sysc_runtime_suspend(dev);
+}
+
+static int sysc_noirq_resume(struct device *dev)
+{
+	struct sysc *ddata;
+
+	ddata = dev_get_drvdata(dev);
+
+	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
+		return 0;
+
+	if (!(ddata->cfg.quirks & SYSC_QUIRK_RESOURCE_PROVIDER))
+		return 0;
+
 	if (ddata->needs_resume) {
 		ddata->needs_resume = false;
 
@@ -690,6 +746,7 @@ static int sysc_resume(struct device *dev)
 
 static const struct dev_pm_ops sysc_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sysc_suspend, sysc_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(sysc_noirq_suspend, sysc_noirq_resume)
 	SET_RUNTIME_PM_OPS(sysc_runtime_suspend,
 			   sysc_runtime_resume,
 			   NULL)
@@ -721,6 +778,26 @@ struct sysc_revision_quirk {
 	}
 
 static const struct sysc_revision_quirk sysc_revision_quirks[] = {
+	/* These need to use noirq_suspend */
+	SYSC_QUIRK("control", 0, 0, 0x10, -1, 0x40000900, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("i2c", 0, 0, 0x10, 0x90, 0x5040000a, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("mcspi", 0, 0, 0x10, -1, 0x40300a0b, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x40000100, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("ocp2scp", 0, 0, 0x10, 0x14, 0x50060005, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("padconf", 0, 0, 0x10, -1, 0x4fff0800, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("scm", 0, 0, 0x10, -1, 0x40000900, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("scrm", 0, 0, -1, -1, 0x00000010, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+	SYSC_QUIRK("sdma", 0, 0, 0x2c, 0x28, 0x00010900, 0xffffffff,
+		   SYSC_QUIRK_RESOURCE_PROVIDER),
+
 	/* These drivers need to be fixed to not use pm_runtime_irq_safe() */
 	SYSC_QUIRK("gpio", 0, 0, 0x10, 0x114, 0x50600801, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE | SYSC_QUIRK_OPT_CLKS_IN_RESET),
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -45,6 +45,7 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_QUIRK_RESOURCE_PROVIDER	BIT(9)
 #define SYSC_QUIRK_LEGACY_IDLE		BIT(8)
 #define SYSC_QUIRK_RESET_STATUS		BIT(7)
 #define SYSC_QUIRK_NO_IDLE_ON_INIT	BIT(6)
-- 
2.17.0
