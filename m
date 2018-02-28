Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeB1KbS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:31:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752472AbeB1K3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:29:18 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] x86/microcode: Do not upload microcode if CPUs are offline
Date: Wed, 28 Feb 2018 11:28:43 +0100
Message-Id: <20180228102846.13447-5-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180228102846.13447-1-bp@alien8.de>
References: <20180228102846.13447-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

Avoid loading microcode if any of the CPUs are offline, and issue a
warning. Having different microcode revisions on the system at any time
is outright dangerous.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/1519352533-15992-4-git-send-email-ashok.raj@intel.com
[ Massage it. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 63370651e376..fa32cb3dcca5 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -486,6 +486,16 @@ static void __exit microcode_dev_exit(void)
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
+static int check_online_cpus(void)
+{
+	if (num_online_cpus() == num_present_cpus())
+		return 0;
+
+	pr_err("Not all CPUs online, aborting microcode update.\n");
+
+	return -EINVAL;
+}
+
 static enum ucode_state reload_for_cpu(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -519,7 +529,13 @@ static ssize_t reload_store(struct device *dev,
 		return size;
 
 	get_online_cpus();
+
+	ret = check_online_cpus();
+	if (ret)
+		goto put;
+
 	mutex_lock(&microcode_mutex);
+
 	for_each_online_cpu(cpu) {
 		tmp_ret = reload_for_cpu(cpu);
 		if (tmp_ret > UCODE_NFOUND) {
@@ -538,6 +554,8 @@ static ssize_t reload_store(struct device *dev,
 		microcode_check();
 
 	mutex_unlock(&microcode_mutex);
+
+put:
 	put_online_cpus();
 
 	if (!ret)
-- 
2.13.0
