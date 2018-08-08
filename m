Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7083C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B723216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B723216F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeHHKZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:25:56 -0400
Received: from muru.com ([72.249.23.125]:53020 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbeHHKZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:25:56 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A702B81BA;
        Wed,  8 Aug 2018 08:10:55 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: OMAP2+: Fix module address for modules using mpu_rt_idx
Date:   Wed,  8 Aug 2018 01:07:04 -0700
Message-Id: <20180808080706.100389-3-tony@atomide.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180808080706.100389-1-tony@atomide.com>
References: <20180808080706.100389-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we use device tree data for a module interconnect target we want
to map the control registers from the module start. Legacy hwmod platform
data however is using child IP offsets for cpsw module with mpu_rt_idx.

In cases where we have the interconnect target module already using device
tree data with legacy hwmod platform data still around, the sysc register
area is not adjusted for mpu_rt_idx causing wrong registers being accessed.

Let's fix the issue for mixed dts and platform data mode by ioremapping
the module registers using child IP offset if mpu_rt_idx is set. For
device tree only data there's no reason to use mpu_rt_idx.

Fixes: 6c72b3550672 ("ARM: OMAP2+: Parse module IO range from dts for legacy
"ti,hwmods" support")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2160,6 +2160,37 @@ static int of_dev_hwmod_lookup(struct device_node *np,
 	return -ENODEV;
 }
 
+/**
+ * omap_hwmod_fix_mpu_rt_idx - fix up mpu_rt_idx register offsets
+ *
+ * @oh: struct omap_hwmod *
+ * @np: struct device_node *
+ *
+ * Fix up module register offsets for modules with mpu_rt_idx.
+ * Only needed for cpsw with interconnect target module defined
+ * in device tree while still using legacy hwmod platform data
+ * for rev, sysc and syss registers.
+ *
+ * Can be removed when all cpsw hwmod platform data has been
+ * dropped.
+ */
+static void omap_hwmod_fix_mpu_rt_idx(struct omap_hwmod *oh,
+				      struct device_node *np,
+				      struct resource *res)
+{
+	struct device_node *child = NULL;
+	int error;
+
+	child = of_get_next_child(np, child);
+	if (!child)
+		return;
+
+	error = of_address_to_resource(child, oh->mpu_rt_idx, res);
+	if (error)
+		pr_err("%s: error mapping mpu_rt_idx: %i\n",
+		       __func__, error);
+}
+
 /**
  * omap_hwmod_parse_module_range - map module IO range from device tree
  * @oh: struct omap_hwmod *
@@ -2222,6 +2253,12 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 	pr_debug("omap_hwmod: %s %s at 0x%llx size 0x%llx\n",
 		 oh ? oh->name : "", np->name, base, size);
 
+	if (oh && oh->mpu_rt_idx) {
+		omap_hwmod_fix_mpu_rt_idx(oh, np, res);
+
+		return 0;
+	}
+
 	res->start = base;
 	res->end = base + size - 1;
 	res->flags = IORESOURCE_MEM;
-- 
2.17.1
