Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965103AbeCHJ1q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:27:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60825 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964807AbeCHJ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:27:44 -0500
Date: Thu, 8 Mar 2018 01:27:33 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-cfb52a5a09c8ae3a1dafb44ce549fde5b69e8117@git.kernel.org>
Cc: hpa@zytor.com, thomas.lendacky@amd.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com, tglx@linutronix.de,
        arjan.van.de.ven@intel.com, bp@suse.de
Reply-To: hpa@zytor.com, thomas.lendacky@amd.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, ashok.raj@intel.com,
        arjan.van.de.ven@intel.com, bp@suse.de
In-Reply-To: <20180228102846.13447-7-bp@alien8.de>
References: <20180228102846.13447-7-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/microcode: Request microcode on the BSP
Git-Commit-ID: cfb52a5a09c8ae3a1dafb44ce549fde5b69e8117
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

Commit-ID:  cfb52a5a09c8ae3a1dafb44ce549fde5b69e8117
Gitweb:     https://git.kernel.org/tip/cfb52a5a09c8ae3a1dafb44ce549fde5b69e8117
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 28 Feb 2018 11:28:45 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 10:19:26 +0100

x86/microcode: Request microcode on the BSP

... so that any newer version can land in the cache and can later be
fished out by the application functions. Do that before grabbing the
hotplug lock.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: https://lkml.kernel.org/r/20180228102846.13447-7-bp@alien8.de

---
 arch/x86/kernel/cpu/microcode/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index fa32cb3dcca5..5dd157d48606 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -499,15 +499,10 @@ static int check_online_cpus(void)
 static enum ucode_state reload_for_cpu(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	enum ucode_state ustate;
 
 	if (!uci->valid)
 		return UCODE_OK;
 
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, true);
-	if (ustate != UCODE_OK)
-		return ustate;
-
 	return apply_microcode_on_target(cpu);
 }
 
@@ -515,11 +510,11 @@ static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
+	int cpu, bsp = boot_cpu_data.cpu_index;
 	enum ucode_state tmp_ret = UCODE_OK;
 	bool do_callback = false;
 	unsigned long val;
 	ssize_t ret = 0;
-	int cpu;
 
 	ret = kstrtoul(buf, 0, &val);
 	if (ret)
@@ -528,6 +523,10 @@ static ssize_t reload_store(struct device *dev,
 	if (val != 1)
 		return size;
 
+	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
+	if (tmp_ret != UCODE_OK)
+		return size;
+
 	get_online_cpus();
 
 	ret = check_online_cpus();
