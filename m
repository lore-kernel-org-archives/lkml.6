Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeCPUB1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:01:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59901 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbeCPUBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:01:24 -0400
Date: Fri, 16 Mar 2018 13:00:58 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-2613f36ed965d0e5a595a1d931fd3b480e82d6fd@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@suse.de,
        xftroxgpx@protonmail.com, mingo@kernel.org, ashok.raj@intel.com,
        hpa@zytor.com, thomas.lendacky@amd.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, bp@suse.de,
        xftroxgpx@protonmail.com, hpa@zytor.com, ashok.raj@intel.com,
        mingo@kernel.org, thomas.lendacky@amd.com
In-Reply-To: <20180314183615.17629-1-bp@alien8.de>
References: <20180314183615.17629-1-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/microcode: Attempt late loading only when new
 microcode is present
Git-Commit-ID: 2613f36ed965d0e5a595a1d931fd3b480e82d6fd
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

Commit-ID:  2613f36ed965d0e5a595a1d931fd3b480e82d6fd
Gitweb:     https://git.kernel.org/tip/2613f36ed965d0e5a595a1d931fd3b480e82d6fd
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 14 Mar 2018 19:36:14 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 16 Mar 2018 20:55:51 +0100

x86/microcode: Attempt late loading only when new microcode is present

Return UCODE_NEW from the scanning functions to denote that new microcode
was found and only then attempt the expensive synchronization dance.

Reported-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20180314183615.17629-1-bp@alien8.de

---
 arch/x86/include/asm/microcode.h      |  1 +
 arch/x86/kernel/cpu/microcode/amd.c   | 34 +++++++++++++++++++++-------------
 arch/x86/kernel/cpu/microcode/core.c  |  8 +++-----
 arch/x86/kernel/cpu/microcode/intel.c |  4 +++-
 4 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 7fb1047d61c7..6cf0e4cb7b97 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -39,6 +39,7 @@ struct device;
 
 enum ucode_state {
 	UCODE_OK	= 0,
+	UCODE_NEW,
 	UCODE_UPDATED,
 	UCODE_NFOUND,
 	UCODE_ERROR,
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a998e1a7d46f..48179928ff38 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -339,7 +339,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 		return -EINVAL;
 
 	ret = load_microcode_amd(true, x86_family(cpuid_1_eax), desc.data, desc.size);
-	if (ret != UCODE_OK)
+	if (ret > UCODE_UPDATED)
 		return -EINVAL;
 
 	return 0;
@@ -683,27 +683,35 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 static enum ucode_state
 load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 {
+	struct ucode_patch *p;
 	enum ucode_state ret;
 
 	/* free old equiv table */
 	free_equiv_cpu_table();
 
 	ret = __load_microcode_amd(family, data, size);
-
-	if (ret != UCODE_OK)
+	if (ret != UCODE_OK) {
 		cleanup();
+		return ret;
+	}
 
-#ifdef CONFIG_X86_32
-	/* save BSP's matching patch for early load */
-	if (save) {
-		struct ucode_patch *p = find_patch(0);
-		if (p) {
-			memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
-			memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data),
-							       PATCH_MAX_SIZE));
-		}
+	p = find_patch(0);
+	if (!p) {
+		return ret;
+	} else {
+		if (boot_cpu_data.microcode == p->patch_id)
+			return ret;
+
+		ret = UCODE_NEW;
 	}
-#endif
+
+	/* save BSP's matching patch for early load */
+	if (!save)
+		return ret;
+
+	memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
+	memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data), PATCH_MAX_SIZE));
+
 	return ret;
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 70ecbc8099c9..9f0fe5bb450d 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -607,7 +607,7 @@ static ssize_t reload_store(struct device *dev,
 		return size;
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
-	if (tmp_ret != UCODE_OK)
+	if (tmp_ret != UCODE_NEW)
 		return size;
 
 	get_online_cpus();
@@ -691,10 +691,8 @@ static enum ucode_state microcode_init_cpu(int cpu, bool refresh_fw)
 	if (system_state != SYSTEM_RUNNING)
 		return UCODE_NFOUND;
 
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev,
-						     refresh_fw);
-
-	if (ustate == UCODE_OK) {
+	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, refresh_fw);
+	if (ustate == UCODE_NEW) {
 		pr_debug("CPU%d updated upon init\n", cpu);
 		apply_microcode_on_target(cpu);
 	}
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 2aded9db1d42..32b8e5724f96 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -862,6 +862,7 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 	unsigned int leftover = size;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
 	unsigned int csig, cpf;
+	enum ucode_state ret = UCODE_OK;
 
 	while (leftover) {
 		struct microcode_header_intel mc_header;
@@ -903,6 +904,7 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 			new_mc  = mc;
 			new_mc_size = mc_size;
 			mc = NULL;	/* trigger new vmalloc */
+			ret = UCODE_NEW;
 		}
 
 		ucode_ptr += mc_size;
@@ -932,7 +934,7 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, new_rev, uci->cpu_sig.rev);
 
-	return UCODE_OK;
+	return ret;
 }
 
 static int get_ucode_fw(void *to, const void *from, size_t n)
