Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932830AbeBUKTZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:19:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57776 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932794AbeBUKTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:19:22 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] x86/MCE/AMD: Collect error info even if valid bits are not set
Date: Wed, 21 Feb 2018 11:18:56 +0100
Message-Id: <20180221101900.10326-5-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180221101900.10326-1-bp@alien8.de>
References: <20180221101900.10326-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The MCA banks log error info into MCA_ADDR, MCA_MISC0, and MCA_SYND even
if the corresponding valid bits are not set:

"Error handlers should save the values in MCA_ADDR, MCA_MISC0,
and MCA_SYND even if MCA_STATUS[AddrV], MCA_STATUS[MiscV], and
MCA_STATUS[SyndV] are zero."

Do so by setting those bits so that code down the MCE processing path
doesn't need to be changed.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index b16b184d90c5..dd713335f5d9 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -437,6 +437,20 @@ static inline void mce_gather_info(struct mce *m, struct pt_regs *regs)
 		if (mca_cfg.rip_msr)
 			m->ip = mce_rdmsrl(mca_cfg.rip_msr);
 	}
+
+	/*
+	 * Error handlers should save the values in MCA_ADDR, MCA_MISC0, and
+	 * MCA_SYND even if MCA_STATUS[AddrV], MCA_STATUS[MiscV], and
+	 * MCA_STATUS[SyndV] are zero.
+	 */
+	if (m->cpuvendor == X86_VENDOR_AMD) {
+		u64 status = MCI_STATUS_ADDRV | MCI_STATUS_MISCV;
+
+		if (mce_flags.smca)
+			status |= MCI_STATUS_SYNDV;
+
+		m->status |= status;
+	}
 }
 
 int mce_available(struct cpuinfo_x86 *c)
-- 
2.13.0
