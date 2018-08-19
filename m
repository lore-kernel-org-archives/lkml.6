Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537DBC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047DE20836
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047DE20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeHSTZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:25:32 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:53623 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbeHSTZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:25:32 -0400
Received: from localhost.localdomain (unknown [110.184.154.248])
        by APP-10 (Coremail) with SMTP id tACowAD3_sYYl3lbBcSwAg--.224S2;
        Mon, 20 Aug 2018 00:13:17 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v4 10/16] x86/mce: enable Hygon support to MCE infrastructure
Date:   Mon, 20 Aug 2018 00:12:52 +0800
Message-Id: <6ca1b4b20f3d580620fa689ad5e16291aeac95b6.1534599097.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534599097.git.puwen@hygon.cn>
References: <cover.1534599097.git.puwen@hygon.cn>
X-CM-TRANSID: tACowAD3_sYYl3lbBcSwAg--.224S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1kXw4DGrWrJw17Zw4fZrb_yoWrZryDpr
        W7tFWvgF48uF97G34Dtr4DZr4rZF1vga1xWry3Cw1rA3Z8AryUXrs0yw1YqryDA393u3Wf
        ta15uw47Ja1kAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAF
        wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUD-B_UUUUU=
X-Originating-IP: [110.184.154.248]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hygon machine check arch is similar to AMD family 17h. To enable the MCE
infrastructure support, add CPU vendor check for Hygon to share the code
path of AMD.

Add hygon mce init function mce_hygon_feature_init() to minimize further
maintenance effort.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/mce.h                |  5 +++++
 arch/x86/kernel/cpu/mcheck/mce-severity.c |  3 ++-
 arch/x86/kernel/cpu/mcheck/mce.c          | 21 +++++++++++++++------
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 8c7b3e5..0af3b0e 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -213,6 +213,11 @@ static inline void mce_amd_feature_init(struct cpuinfo_x86 *c) { }
 static inline int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr) { return -EINVAL; };
 #endif
 
+static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)
+{
+	return mce_amd_feature_init(c);
+}
+
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce-severity.c b/arch/x86/kernel/cpu/mcheck/mce-severity.c
index f34d89c..44396d5 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-severity.c
@@ -336,7 +336,8 @@ int (*mce_severity)(struct mce *m, int tolerant, char **msg, bool is_excp) =
 
 void __init mcheck_vendor_init_severity(void)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		mce_severity = mce_severity_amd;
 }
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 8c50754..65d13f8 100644
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
 
@@ -512,9 +513,9 @@ static int mce_usable_address(struct mce *m)
 
 bool mce_is_memory_error(struct mce *m)
 {
-	if (m->cpuvendor == X86_VENDOR_AMD) {
+	if (m->cpuvendor == X86_VENDOR_AMD ||
+	    m->cpuvendor == X86_VENDOR_HYGON) {
 		return amd_mce_is_memory_error(m);
-
 	} else if (m->cpuvendor == X86_VENDOR_INTEL) {
 		/*
 		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
@@ -540,7 +541,9 @@ EXPORT_SYMBOL_GPL(mce_is_memory_error);
 
 static bool mce_is_correctable(struct mce *m)
 {
-	if (m->cpuvendor == X86_VENDOR_AMD && m->status & MCI_STATUS_DEFERRED)
+	if ((m->cpuvendor == X86_VENDOR_AMD ||
+	     m->cpuvendor == X86_VENDOR_HYGON) &&
+	    (m->status & MCI_STATUS_DEFERRED))
 		return false;
 
 	if (m->status & MCI_STATUS_UC)
@@ -1725,7 +1728,8 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
  */
 static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 {
-	if (c->x86_vendor == X86_VENDOR_AMD) {
+	if (c->x86_vendor == X86_VENDOR_AMD ||
+	    c->x86_vendor == X86_VENDOR_HYGON) {
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
@@ -1766,6 +1770,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_amd_feature_init(c);
 		break;
 		}
+	case X86_VENDOR_HYGON:
+		mce_hygon_feature_init(c);
+		break;
 	case X86_VENDOR_CENTAUR:
 		mce_centaur_feature_init(c);
 		break;
@@ -1991,12 +1998,14 @@ static void mce_disable_error_reporting(void)
 static void vendor_disable_error_reporting(void)
 {
 	/*
-	 * Don't clear on Intel or AMD CPUs. Some of these MSRs are socket-wide.
+	 * Don't clear on Intel or AMD or Hygon CPUs. Some of these MSRs
+	 * are socket-wide.
 	 * Disabling them for just a single offlined CPU is bad, since it will
 	 * inhibit reporting for all shared resources on the socket like the
 	 * last level cache (LLC), the integrated memory controller (iMC), etc.
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		return;
 
-- 
2.7.4

