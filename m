Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5CEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D7C2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbeLTIYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:24:24 -0500
Received: from ozlabs.ru ([107.173.13.209]:54307 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbeLTIYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:24:23 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 5CDBBAE802FA;
        Thu, 20 Dec 2018 03:24:19 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        Reza Arbab <arbab@linux.ibm.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= 
        <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH kernel v7 07/20] powerpc/pseries/npu: Enable platform support
Date:   Thu, 20 Dec 2018 19:23:37 +1100
Message-Id: <20181220082350.58113-8-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already changed NPU API for GPUs to not to call OPAL and the remaining
bit is initializing NPU structures.

This searches for POWER9 NVLinks attached to any device on a PHB and
initializes an NPU structure if any found.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v5:
* added WARN_ON_ONCE

v4:
* dropped "IBM,npu-vphb" compatible type on PHB and use the type of NVLink
---
 arch/powerpc/platforms/pseries/pci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 41d8a4d..7725825 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -29,6 +29,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/prom.h>
 #include <asm/ppc-pci.h>
+#include <asm/pci.h>
 #include "pseries.h"
 
 #if 0
@@ -237,6 +238,8 @@ static void __init pSeries_request_regions(void)
 
 void __init pSeries_final_fixup(void)
 {
+	struct pci_controller *hose;
+
 	pSeries_request_regions();
 
 	eeh_probe_devices();
@@ -246,6 +249,25 @@ void __init pSeries_final_fixup(void)
 	ppc_md.pcibios_sriov_enable = pseries_pcibios_sriov_enable;
 	ppc_md.pcibios_sriov_disable = pseries_pcibios_sriov_disable;
 #endif
+	list_for_each_entry(hose, &hose_list, list_node) {
+		struct device_node *dn = hose->dn, *nvdn;
+
+		while (1) {
+			dn = of_find_all_nodes(dn);
+			if (!dn)
+				break;
+			nvdn = of_parse_phandle(dn, "ibm,nvlink", 0);
+			if (!nvdn)
+				continue;
+			if (!of_device_is_compatible(nvdn, "ibm,npu-link"))
+				continue;
+			if (!of_device_is_compatible(nvdn->parent,
+						"ibm,power9-npu"))
+				continue;
+			WARN_ON_ONCE(pnv_npu2_init(hose));
+			break;
+		}
+	}
 }
 
 /*
-- 
2.17.1

