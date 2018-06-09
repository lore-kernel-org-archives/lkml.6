Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id od7oMXPWG1v2HwAAmS7hNA
	; Sat, 09 Jun 2018 13:30:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6DFBD608B8; Sat,  9 Jun 2018 13:30:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DA31B600D0;
	Sat,  9 Jun 2018 13:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA31B600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbeFINaf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 09:30:35 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:44116 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753247AbeFINaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 09:30:21 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowACX2bvC1BtbQUtEBA--.1042S2;
        Sat, 09 Jun 2018 21:23:19 +0800 (CST)
From: Pu Wen <puwen@hygon.cn>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, tony.luck@intel.com, bp@alien8.de,
        zhangpanyong@hygon.cn
Cc: thomas.lendacky@amd.com, peterz@infradead.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org,
        mchehab@kernel.org, trenn@suse.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH 05/11] x86/mce: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:23:03 +0800
Message-Id: <1528550583-28307-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowACX2bvC1BtbQUtEBA--.1042S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1xCw15tF48ArWUtF4xZwb_yoW5Zw45pr
        W7tFWvg3W8AasrWw1qyFWDZr4UZF1vqayxW3sxAw1fAF15AFyUXrs0yw1aqryjv3s3Cw4f
        t3W5Wa17Ja1kAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUva14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
        xVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE
        14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
        uYvjfUw18BUUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the X86 MCE infrastructure support to Hygon
Family 18h CPU:
- It enable Hygon check in __mcheck_cpu_init_early(), print_mce()
  and mce_usable_address() etc.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/mcheck/mce-severity.c |  3 ++-
 arch/x86/kernel/cpu/mcheck/mce.c          | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-severity.c b/arch/x86/kernel/cpu/mcheck/mce-severity.c
index 5bbd06f..610b5ff 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-severity.c
@@ -331,7 +331,8 @@ int (*mce_severity)(struct mce *m, int tolerant, char **msg, bool is_excp) =
 
 void __init mcheck_vendor_init_severity(void)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		mce_severity = mce_severity_amd;
 }
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 42cf288..4711225 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -274,7 +274,8 @@ static void print_mce(struct mce *m)
 {
 	__print_mce(m);
 
-	if (m->cpuvendor != X86_VENDOR_AMD)
+	if (m->cpuvendor != X86_VENDOR_AMD &&
+	    m->cpuvendor != X86_VENDOR_HYGON)
 		pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
 }
 
@@ -512,7 +513,8 @@ static int mce_usable_address(struct mce *m)
 
 bool mce_is_memory_error(struct mce *m)
 {
-	if (m->cpuvendor == X86_VENDOR_AMD) {
+	if (m->cpuvendor == X86_VENDOR_AMD ||
+	    m->cpuvendor == X86_VENDOR_HYGON) {
 		return amd_mce_is_memory_error(m);
 
 	} else if (m->cpuvendor == X86_VENDOR_INTEL) {
@@ -543,6 +545,9 @@ static bool mce_is_correctable(struct mce *m)
 	if (m->cpuvendor == X86_VENDOR_AMD && m->status & MCI_STATUS_DEFERRED)
 		return false;
 
+	if (m->cpuvendor == X86_VENDOR_HYGON && m->status & MCI_STATUS_DEFERRED)
+		return false;
+
 	if (m->status & MCI_STATUS_UC)
 		return false;
 
@@ -1713,7 +1718,8 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
  */
 static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 {
-	if (c->x86_vendor == X86_VENDOR_AMD) {
+	if (c->x86_vendor == X86_VENDOR_AMD ||
+	    c->x86_vendor == X86_VENDOR_HYGON) {
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
@@ -1735,6 +1741,7 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_adjust_timer = cmci_intel_adjust_timer;
 		break;
 
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD: {
 		mce_amd_feature_init(c);
 		break;
@@ -1967,7 +1974,8 @@ static void vendor_disable_error_reporting(void)
 	 * last level cache (LLC), the integrated memory controller (iMC), etc.
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return;
 
 	mce_disable_error_reporting();
-- 
2.7.4
