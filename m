Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938959AbeBUSAJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:00:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42959 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754174AbeBUSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:00:05 -0500
Date: Wed, 21 Feb 2018 09:59:38 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-4b1e84276a6172980c5bf39aa091ba13e90d6dad@git.kernel.org>
Cc: bp@suse.de, bp@alien8.de, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, torvalds@linux-foundation.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: bp@suse.de, peterz@infradead.org, bp@alien8.de, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com,
        torvalds@linux-foundation.org
In-Reply-To: <20180221101900.10326-5-bp@alien8.de>
References: <20180221101900.10326-5-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce/AMD: Collect error info even if valid bits
 are not set
Git-Commit-ID: 4b1e84276a6172980c5bf39aa091ba13e90d6dad
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4b1e84276a6172980c5bf39aa091ba13e90d6dad
Gitweb:     https://git.kernel.org/tip/4b1e84276a6172980c5bf39aa091ba13e90d6dad
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 21 Feb 2018 11:18:56 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 17:00:54 +0100

x86/mce/AMD: Collect error info even if valid bits are not set

The MCA banks log error info into MCA_ADDR, MCA_MISC0, and MCA_SYND even
if the corresponding valid bits are not set:

"Error handlers should save the values in MCA_ADDR, MCA_MISC0,
and MCA_SYND even if MCA_STATUS[AddrV], MCA_STATUS[MiscV], and
MCA_STATUS[SyndV] are zero."

Do so by setting those bits so that code down the MCE processing path
doesn't need to be changed.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180221101900.10326-5-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index d7dff23..3c9a25b 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -441,6 +441,20 @@ static inline void mce_gather_info(struct mce *m, struct pt_regs *regs)
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
