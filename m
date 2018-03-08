Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755597AbeCHJ0v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:26:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46475 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755406AbeCHJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:26:49 -0500
Date: Thu, 8 Mar 2018 01:26:40 -0800
From: tip-bot for Ashok Raj <tipbot@zytor.com>
Message-ID: <tip-30ec26da9967d0d785abc24073129a34c3211777@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        thomas.lendacky@amd.com, tglx@linutronix.de, hpa@zytor.com,
        arjan.van.de.ven@intel.com, ashok.raj@intel.com, bp@suse.de
Reply-To: bp@suse.de, ashok.raj@intel.com, arjan.van.de.ven@intel.com,
        hpa@zytor.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180228102846.13447-5-bp@alien8.de>
References: <1519352533-15992-4-git-send-email-ashok.raj@intel.com>
        <20180228102846.13447-5-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/microcode: Do not upload microcode if CPUs are
 offline
Git-Commit-ID: 30ec26da9967d0d785abc24073129a34c3211777
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

Commit-ID:  30ec26da9967d0d785abc24073129a34c3211777
Gitweb:     https://git.kernel.org/tip/30ec26da9967d0d785abc24073129a34c3211777
Author:     Ashok Raj <ashok.raj@intel.com>
AuthorDate: Wed, 28 Feb 2018 11:28:43 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 10:19:26 +0100

x86/microcode: Do not upload microcode if CPUs are offline

Avoid loading microcode if any of the CPUs are offline, and issue a
warning. Having different microcode revisions on the system at any time
is outright dangerous.

[ Borislav: Massage changelog. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: http://lkml.kernel.org/r/1519352533-15992-4-git-send-email-ashok.raj@intel.com
Link: https://lkml.kernel.org/r/20180228102846.13447-5-bp@alien8.de

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
