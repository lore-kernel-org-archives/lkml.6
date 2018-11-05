Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2969920685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2969920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbeKFESn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:18:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:23400 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387873AbeKFESn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:18:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 10:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="86862411"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2018 10:57:41 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] x86/cpufeatures: Remove get_scattered_cpuid_leaf()
Date:   Mon,  5 Nov 2018 10:57:25 -0800
Message-Id: <20181105185725.18679-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_scattered_cpuid_leaf() was added[1] to help KVM rebuild hardware-
defined leafs that are rearranged by Linux to avoid bloating the
x86_capability array.  Eventually, the last consumer of the function
was removed[2], but the function itself was kept, perhaps even
intentionally as a form of documentation.

Remove get_scattered_cpuid_leaf() as it is currently not used by KVM.
Furthermore, simply rebuilding the "real" leaf does not resolve all of
KVM's woes when it comes to exposing a scattered CPUID feature, i.e.
keeping the function as documentation may be counter-productive in
some scenarios, e.g. when KVM needs to do more than simply expose the
leaf.

[1] 47bdf3378d62 ("x86/cpuid: Provide get_scattered_cpuid_leaf()")
[2] b7b27aa011a1 ("KVM/x86: Update the reverse_cpuid list to include CPUID_7_EDX")

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
---
 arch/x86/kernel/cpu/cpu.h       |  3 ---
 arch/x86/kernel/cpu/scattered.c | 24 ------------------------
 2 files changed, 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index da5446acc241..5eb946b9a9f3 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -49,9 +49,6 @@ extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void get_cpu_address_sizes(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
 extern void init_scattered_cpuid_features(struct cpuinfo_x86 *c);
-extern u32 get_scattered_cpuid_leaf(unsigned int level,
-				    unsigned int sub_leaf,
-				    enum cpuid_regs_idx reg);
 extern void init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_hygon_cacheinfo(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 772c219b6889..0631f5328b7f 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -56,27 +56,3 @@ void init_scattered_cpuid_features(struct cpuinfo_x86 *c)
 			set_cpu_cap(c, cb->feature);
 	}
 }
-
-u32 get_scattered_cpuid_leaf(unsigned int level, unsigned int sub_leaf,
-			     enum cpuid_regs_idx reg)
-{
-	const struct cpuid_bit *cb;
-	u32 cpuid_val = 0;
-
-	for (cb = cpuid_bits; cb->feature; cb++) {
-
-		if (level > cb->level)
-			continue;
-
-		if (level < cb->level)
-			break;
-
-		if (reg == cb->reg && sub_leaf == cb->sub_leaf) {
-			if (cpu_has(&boot_cpu_data, cb->feature))
-				cpuid_val |= BIT(cb->bit);
-		}
-	}
-
-	return cpuid_val;
-}
-EXPORT_SYMBOL_GPL(get_scattered_cpuid_leaf);
-- 
2.19.1

