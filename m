Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935179AbeCHJ1T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:27:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755537AbeCHJ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:27:16 -0500
Date: Thu, 8 Mar 2018 01:27:07 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-d8c3b52c00a05036e0a6b315b4b17921a7b67997@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        thomas.lendacky@amd.com, mingo@kernel.org, arjan.van.de.ven@intel.com,
        bp@suse.de, hpa@zytor.com, tglx@linutronix.de
Reply-To: arjan.van.de.ven@intel.com, hpa@zytor.com, bp@suse.de,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com, mingo@kernel.org
In-Reply-To: <20180228102846.13447-6-bp@alien8.de>
References: <20180228102846.13447-6-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/microcode/intel: Look into the patch cache first
Git-Commit-ID: d8c3b52c00a05036e0a6b315b4b17921a7b67997
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

Commit-ID:  d8c3b52c00a05036e0a6b315b4b17921a7b67997
Gitweb:     https://git.kernel.org/tip/d8c3b52c00a05036e0a6b315b4b17921a7b67997
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 28 Feb 2018 11:28:44 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 10:19:26 +0100

x86/microcode/intel: Look into the patch cache first

The cache might contain a newer patch - look in there first.

A follow-on change will make sure newest patches are loaded into the
cache of microcode patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: https://lkml.kernel.org/r/20180228102846.13447-6-bp@alien8.de

---
 arch/x86/kernel/cpu/microcode/intel.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index e2864bc2d575..2aded9db1d42 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -791,9 +791,9 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 
 static enum ucode_state apply_microcode_intel(int cpu)
 {
-	struct microcode_intel *mc;
-	struct ucode_cpu_info *uci;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	struct microcode_intel *mc;
 	static int prev_rev;
 	u32 rev;
 
@@ -801,11 +801,10 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	uci = ucode_cpu_info + cpu;
-	mc = uci->mc;
+	/* Look for a newer patch in our cache: */
+	mc = find_patch(uci);
 	if (!mc) {
-		/* Look for a newer patch in our cache: */
-		mc = find_patch(uci);
+		mc = uci->mc;
 		if (!mc)
 			return UCODE_NFOUND;
 	}
