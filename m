Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA71C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD232173C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD232173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeHKQDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:03:38 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:41401 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727304AbeHKQDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:03:37 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowAAXHpKn5G5bnZ5fAA--.574S2;
        Sat, 11 Aug 2018 21:29:15 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kvm@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v3 12/17] x86/kvm: enable Hygon support to KVM infrastructure
Date:   Sat, 11 Aug 2018 21:29:08 +0800
Message-Id: <eacb5892319c76c05efaa9de1011a76c456c9d96.1533989493.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1533989492.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn>
X-CM-TRANSID: swCowAAXHpKn5G5bnZ5fAA--.574S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUCw1Duw13Xr4UJF15twb_yoW5Jr17pF
        ZrGFs7XFsYgrsIk34DJrsrZw1UZFs8Kw18Kry5uw1FvF4YvayxXr4Fkw15Ja17Aa95ua4r
        KFy8W3WkJ3yxZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hygon Dhyana CPU has the SVM feature as AMD family 17h does.
Add Hygon support in the KVM infrastructure.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/kvm_emulate.h |  4 ++++
 arch/x86/include/asm/virtext.h     |  5 +++--
 arch/x86/kvm/emulate.c             | 11 ++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
index 0f82cd9..93c4bf5 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -364,6 +364,10 @@ struct x86_emulate_ctxt {
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
index 4c4f426..1ab7758 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2711,7 +2711,16 @@ static bool em_syscall_is_enabled(struct x86_emulate_ctxt *ctxt)
 	    edx == X86EMUL_CPUID_VENDOR_AMDisbetterI_edx)
 		return true;
 
-	/* default: (not Intel, not AMD), apply Intel's stricter rules... */
+	/* Hygon ("HygonGenuine") */
+	if (ebx == X86EMUL_CPUID_VENDOR_HygonGenuine_ebx &&
+	    ecx == X86EMUL_CPUID_VENDOR_HygonGenuine_ecx &&
+	    edx == X86EMUL_CPUID_VENDOR_HygonGenuine_edx)
+		return true;
+
+	/*
+	 * default: (not Intel, not AMD, not Hygon), apply Intel's
+	 * stricter rules...
+	 */
 	return false;
 }
 
-- 
2.7.4

