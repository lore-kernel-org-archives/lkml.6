Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993D4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A62206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A62206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbeJBUOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbeJBUOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:16 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2DAB2C3F;
        Tue,  2 Oct 2018 13:30:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 170/228] ARM: OMAP2+: Fix module address for modules using mpu_rt_idx
Date:   Tue,  2 Oct 2018 06:24:27 -0700
Message-Id: <20181002132510.188083487@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 1dbcb97c656eed1a244c960b8b3a469c3d20ce7b ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/omap_hwmod.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2161,6 +2161,37 @@ static int of_dev_hwmod_lookup(struct de
 }
 
 /**
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
+/**
  * omap_hwmod_parse_module_range - map module IO range from device tree
  * @oh: struct omap_hwmod *
  * @np: struct device_node *
@@ -2222,6 +2253,12 @@ int omap_hwmod_parse_module_range(struct
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


