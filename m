Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E1713F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A127D20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A127D20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeG3ODf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:03:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:19158 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbeG3ODf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:03:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 05:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="220253238"
Received: from otc-brkl-02.jf.intel.com ([10.54.39.19])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2018 05:28:45 -0700
From:   kan.liang@linux.intel.com
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     msys.mizuma@gmail.com, tglx@linutronix.de, hpa@zytor.com,
        x86@kernel.org, m.mizuma@jp.fujitsu.com, stable@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Fix hardcode index of Broadwell extra PCI DEV
Date:   Mon, 30 Jul 2018 08:28:08 -0400
Message-Id: <1532953688-15008-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Masa reports that a warning message is shown while CPU hot-removing on
Broadwell server.

  WARNING: CPU: 126 PID: 6 at arch/x86/events/intel/uncore.c:988
  uncore_pci_remove+0x10b/0x150
  Call Trace:
   pci_device_remove+0x42/0xd0
   device_release_driver_internal+0x148/0x220
   pci_stop_bus_device+0x76/0xa0
   pci_stop_root_bus+0x44/0x60
   acpi_pci_root_remove+0x1f/0x80
   acpi_bus_trim+0x57/0x90
   acpi_bus_trim+0x2e/0x90
   acpi_device_hotplug+0x2bc/0x4b0
   acpi_hotplug_work_fn+0x1a/0x30
   process_one_work+0x174/0x3a0
   worker_thread+0x4c/0x3d0
   kthread+0xf8/0x130

This bug was introduced in:

  commit 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
Broadwell CPUs")

The index of "QPI Port 2 filter" was hardcode to 2. The index of
"PCU.3" used enumerator "HSWEP_PCI_PCU_3", which equals to 2 as well.

To fix the conflict, the hardcode index needs to be cleaned up.
Introduce a new enumerator "BDX_PCI_QPI_PORT2_FILTER" for "QPI Port 2
filter" on Broadwell, and increase the UNCORE_EXTRA_PCI_DEV_MAX.
Clean up hardcode index.

Reported-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Debugged-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Fixes: 15a3e845b01c ("perf/x86/intel/uncore: Fix SBOX support for
Broadwell CPUs")
---
 arch/x86/events/intel/uncore.h       |  2 +-
 arch/x86/events/intel/uncore_snbep.c | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index c9e1e0b..e17ab88 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -28,7 +28,7 @@
 #define UNCORE_PCI_DEV_TYPE(data)	((data >> 8) & 0xff)
 #define UNCORE_PCI_DEV_IDX(data)	(data & 0xff)
 #define UNCORE_EXTRA_PCI_DEV		0xff
-#define UNCORE_EXTRA_PCI_DEV_MAX	3
+#define UNCORE_EXTRA_PCI_DEV_MAX	4
 
 #define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 87dc026..51d7c11 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1029,6 +1029,7 @@ void snbep_uncore_cpu_init(void)
 enum {
 	SNBEP_PCI_QPI_PORT0_FILTER,
 	SNBEP_PCI_QPI_PORT1_FILTER,
+	BDX_PCI_QPI_PORT2_FILTER,
 	HSWEP_PCI_PCU_3,
 };
 
@@ -3286,15 +3287,18 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
 	},
 	{ /* QPI Port 0 filter  */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f86),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 0),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   SNBEP_PCI_QPI_PORT0_FILTER),
 	},
 	{ /* QPI Port 1 filter  */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f96),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 1),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   SNBEP_PCI_QPI_PORT1_FILTER),
 	},
 	{ /* QPI Port 2 filter  */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
-		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   BDX_PCI_QPI_PORT2_FILTER),
 	},
 	{ /* PCU.3 (for Capability registers) */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
-- 
2.4.11

