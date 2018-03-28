Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeC1SkB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:40:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33919 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753050AbeC1SkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:40:00 -0400
Date: Wed, 28 Mar 2018 11:39:48 -0700
From: tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-e2efacb6a54ab54626da3507be1008d0040492cc@git.kernel.org>
Cc: yazen.ghannam@amd.com, Yazen.Ghannam@amd.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, yazen.ghannam@amd.com,
        mingo@kernel.org, Yazen.Ghannam@amd.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] Revert "x86/mce/AMD: Collect error info even if
 valid bits are not set"
Git-Commit-ID: e2efacb6a54ab54626da3507be1008d0040492cc
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

Commit-ID:  e2efacb6a54ab54626da3507be1008d0040492cc
Gitweb:     https://git.kernel.org/tip/e2efacb6a54ab54626da3507be1008d0040492cc
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Mon, 26 Mar 2018 14:15:25 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Mar 2018 20:34:59 +0200

Revert "x86/mce/AMD: Collect error info even if valid bits are not set"

This reverts commit 4b1e84276a6172980c5bf39aa091ba13e90d6dad.

Software uses the valid bits to decide if the values can be used for
further processing or other actions. So setting the valid bits will have
software act on values that it shouldn't be acting on.

The recommendation to save all the register values does not mean that
the values are always valid.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: tony.luck@intel.com
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: bp@suse.de
Cc: linux-edac@vger.kernel.org
Link: https://lkml.kernel.org/r/20180326191526.64314-1-Yazen.Ghannam@amd.com

---
 arch/x86/kernel/cpu/mcheck/mce.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 21962c48dad7..3c1eec17312b 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -446,20 +446,6 @@ static inline void mce_gather_info(struct mce *m, struct pt_regs *regs)
 		if (mca_cfg.rip_msr)
 			m->ip = mce_rdmsrl(mca_cfg.rip_msr);
 	}
-
-	/*
-	 * Error handlers should save the values in MCA_ADDR, MCA_MISC0, and
-	 * MCA_SYND even if MCA_STATUS[AddrV], MCA_STATUS[MiscV], and
-	 * MCA_STATUS[SyndV] are zero.
-	 */
-	if (m->cpuvendor == X86_VENDOR_AMD) {
-		u64 status = MCI_STATUS_ADDRV | MCI_STATUS_MISCV;
-
-		if (mce_flags.smca)
-			status |= MCI_STATUS_SYNDV;
-
-		m->status |= status;
-	}
 }
 
 int mce_available(struct cpuinfo_x86 *c)
