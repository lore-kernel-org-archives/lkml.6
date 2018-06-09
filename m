Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RJ1jLnHWG1vJHwAAmS7hNA
	; Sat, 09 Jun 2018 13:31:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 27A52608C8; Sat,  9 Jun 2018 13:31:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9C0386032D;
	Sat,  9 Jun 2018 13:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C0386032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbeFINac (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 09:30:32 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:44125 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753225AbeFINaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 09:30:21 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowAAXTbnQ1Btb701EBA--.1155S2;
        Sat, 09 Jun 2018 21:23:32 +0800 (CST)
From: Pu Wen <puwen@hygon.cn>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        zhangpanyong@hygon.cn
Cc: thomas.lendacky@amd.com, peterz@infradead.org, tony.luck@intel.com,
        bp@alien8.de, boris.ostrovsky@oracle.com, jgross@suse.com,
        rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org,
        mchehab@kernel.org, trenn@suse.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH 06/11] x86/kvm: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:23:23 +0800
Message-Id: <1528550603-28351-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowAAXTbnQ1Btb701EBA--.1155S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF48Jw17ury5AF45Kr4UJwb_yoW5JF4fpF
        ZrGFs2qFsYgrsIk34DJrnrZF1Uuws8Kw10gryUu3savF4jvayxXr4Fkw15Ja17Aa95ua4r
        KFy8ua1kJayfXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

This patch enables the x86 KVM support to Hygon Family 18h CPU:
- Add Hygon CPU VENDOR ID macro for KVM.
- Add SVM support in cpu_has_svm().
- Add support in em_syscall_is_enabled().

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/kvm_emulate.h | 4 ++++
 arch/x86/include/asm/virtext.h     | 5 +++--
 arch/x86/kvm/emulate.c             | 8 +++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
index b24b1c8..a4907e5 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -362,6 +362,10 @@ struct x86_emulate_ctxt {
 #define X86EMUL_CPUID_VENDOR_AMDisbetterI_ecx 0x21726574
 #define X86EMUL_CPUID_VENDOR_AMDisbetterI_edx 0x74656273
 
+#define X86EMUL_CPUID_VENDOR_HygonGenuine_ebx 0x6f677948
+#define X86EMUL_CPUID_VENDOR_HygonGenuine_ecx 0x656e6975
+#define X86EMUL_CPUID_VENDOR_HygonGenuine_edx 0x6e65476e
+
 #define X86EMUL_CPUID_VENDOR_GenuineIntel_ebx 0x756e6547
 #define X86EMUL_CPUID_VENDOR_GenuineIntel_ecx 0x6c65746e
 #define X86EMUL_CPUID_VENDOR_GenuineIntel_edx 0x49656e69
diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 0116b2e..e05e0d3 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -83,9 +83,10 @@ static inline void cpu_emergency_vmxoff(void)
  */
 static inline int cpu_has_svm(const char **msg)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
 		if (msg)
-			*msg = "not amd";
+			*msg = "not amd or hygon";
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b3705ae..fbba814 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2702,7 +2702,13 @@ static bool em_syscall_is_enabled(struct x86_emulate_ctxt *ctxt)
 	    edx == X86EMUL_CPUID_VENDOR_AMDisbetterI_edx)
 		return true;
 
-	/* default: (not Intel, not AMD), apply Intel's stricter rules... */
+	/* Hygon ("HygonGenuine") */
+	if (ebx == X86EMUL_CPUID_VENDOR_HygonGenuine_ebx &&
+	    ecx == X86EMUL_CPUID_VENDOR_HygonGenuine_ecx &&
+	    edx == X86EMUL_CPUID_VENDOR_HygonGenuine_edx)
+		return true;
+
+	/* default: (not Intel, not AMD or Hygon), apply Intel's stricter rules... */
 	return false;
 }
 
-- 
2.7.4
