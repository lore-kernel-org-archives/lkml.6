Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030589AbeEYVmL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:42:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:16715 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030386AbeEYVmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:42:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,441,1520924400";
   d="scan'208";a="202546806"
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86/mce: Check for alternate indication of machine check recovery on Skylake
Date: Fri, 25 May 2018 14:42:09 -0700
Message-Id: <03cbed6e99ddafb51c2eadf9a3b7c8d7a0cc204e.1527283897.git.tony.luck@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1527283897.git.tony.luck@intel.com>
References: <cover.1527283897.git.tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we just check the "CAPID0" register to see whether the CPU
can recover from machine checks.

But there are also some special SKUs which do not have all advanced
RAS features, but do enable machine check recovery for use with NVDIMMs.

Add a check for any of bits {8:5} in the "CAPID5" register (each
reports some NVDIMM mode available, if any of them are set, then
the system supports memory machine check recovery).

Cc: stable@vger.kernel.org # 4.9
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/quirks.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 697a4ce04308..736348ead421 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -645,12 +645,19 @@ static void quirk_intel_brickland_xeon_ras_cap(struct pci_dev *pdev)
 /* Skylake */
 static void quirk_intel_purley_xeon_ras_cap(struct pci_dev *pdev)
 {
-	u32 capid0;
+	u32 capid0, capid5;
 
 	pci_read_config_dword(pdev, 0x84, &capid0);
+	pci_read_config_dword(pdev, 0x98, &capid5);
 
-	if ((capid0 & 0xc0) == 0xc0)
+	/*
+	 * CAPID0{7:6} indicate whether this is an advanced RAS SKU
+	 * CAPID5{8:5} indicate that various NVDIMM usage modes are
+	 * enabled, so memory machine check recovery is also enabled.
+	 */
+	if ((capid0 & 0xc0) == 0xc0 || (capid5 & 0x1e0))
 		static_branch_inc(&mcsafe_key);
+
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0ec3, quirk_intel_brickland_xeon_ras_cap);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, quirk_intel_brickland_xeon_ras_cap);
-- 
2.17.0
