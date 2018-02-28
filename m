Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeB1KaX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:30:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37172 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752500AbeB1K3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:29:19 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] x86/microcode: Request microcode on the BSP
Date: Wed, 28 Feb 2018 11:28:45 +0100
Message-Id: <20180228102846.13447-7-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180228102846.13447-1-bp@alien8.de>
References: <20180228102846.13447-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... so that any newer version can land in the cache and can later be
fished out by the application functions. Do that before grabbing the
hotplug lock.

Signed-off-by: Borislav Petkov <bp@suse.de>
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
-- 
2.13.0
