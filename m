Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755578AbeCHJ0Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:26:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45497 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754883AbeCHJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:26:23 -0500
Date: Thu, 8 Mar 2018 01:26:14 -0800
From: tip-bot for Ashok Raj <tipbot@zytor.com>
Message-ID: <tip-91df9fdf51492aec9fed6b4cbd33160886740f47@git.kernel.org>
Cc: hpa@zytor.com, thomas.lendacky@amd.com, mingo@kernel.org,
        tglx@linutronix.de, bp@suse.de, arjan.van.de.ven@intel.com,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Reply-To: bp@suse.de, linux-kernel@vger.kernel.org, arjan.van.de.ven@intel.com,
        ashok.raj@intel.com, hpa@zytor.com, thomas.lendacky@amd.com,
        mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180228102846.13447-4-bp@alien8.de>
References: <1519352533-15992-3-git-send-email-ashok.raj@intel.com>
        <20180228102846.13447-4-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/microcode/intel: Writeback and invalidate caches
 before updating microcode
Git-Commit-ID: 91df9fdf51492aec9fed6b4cbd33160886740f47
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

Commit-ID:  91df9fdf51492aec9fed6b4cbd33160886740f47
Gitweb:     https://git.kernel.org/tip/91df9fdf51492aec9fed6b4cbd33160886740f47
Author:     Ashok Raj <ashok.raj@intel.com>
AuthorDate: Wed, 28 Feb 2018 11:28:42 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 10:19:25 +0100

x86/microcode/intel: Writeback and invalidate caches before updating microcode

Updating microcode is less error prone when caches have been flushed and
depending on what exactly the microcode is updating. For example, some
of the issues around certain Broadwell parts can be addressed by doing a
full cache flush.

[ Borislav: Massage it and use native_wbinvd() in both cases. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: http://lkml.kernel.org/r/1519352533-15992-3-git-send-email-ashok.raj@intel.com
Link: https://lkml.kernel.org/r/20180228102846.13447-4-bp@alien8.de

---
 arch/x86/kernel/cpu/microcode/intel.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 87bd6dc94081..e2864bc2d575 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -600,6 +600,12 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 		return UCODE_OK;
 	}
 
+	/*
+	 * Writeback and invalidate caches before updating microcode to avoid
+	 * internal issues depending on what the microcode is updating.
+	 */
+	native_wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -816,6 +822,12 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		return UCODE_OK;
 	}
 
+	/*
+	 * Writeback and invalidate caches before updating microcode to avoid
+	 * internal issues depending on what the microcode is updating.
+	 */
+	native_wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
