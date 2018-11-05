Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A6AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52C82081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52C82081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeKFFkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:40:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42101 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFFkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:40:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA5KIp8o473751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 12:18:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA5KIpgS473748;
        Mon, 5 Nov 2018 12:18:51 -0800
Date:   Mon, 5 Nov 2018 12:18:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sean Christopherson <tipbot@zytor.com>
Message-ID: <tip-43500e6f294d175602606c77bfb0d8cd4ea88b4f@git.kernel.org>
Cc:     bp@suse.de, hpa@zytor.com, tglx@linutronix.de, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        x86@kernel.org, sean.j.christopherson@intel.com, rkrcmar@redhat.com
Reply-To: rkrcmar@redhat.com, sean.j.christopherson@intel.com,
          x86@kernel.org, mingo@kernel.org, mingo@redhat.com,
          linux-kernel@vger.kernel.org, pbonzini@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, bp@suse.de
In-Reply-To: <20181105185725.18679-1-sean.j.christopherson@intel.com>
References: <20181105185725.18679-1-sean.j.christopherson@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpufeatures: Remove get_scattered_cpuid_leaf()
Git-Commit-ID: 43500e6f294d175602606c77bfb0d8cd4ea88b4f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  43500e6f294d175602606c77bfb0d8cd4ea88b4f
Gitweb:     https://git.kernel.org/tip/43500e6f294d175602606c77bfb0d8cd4ea88b4f
Author:     Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate: Mon, 5 Nov 2018 10:57:25 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 5 Nov 2018 20:54:20 +0100

x86/cpufeatures: Remove get_scattered_cpuid_leaf()

get_scattered_cpuid_leaf() was added[1] to help KVM rebuild hardware-
defined leafs that are rearranged by Linux to avoid bloating the
x86_capability array. Eventually, the last consumer of the function was
removed[2], but the function itself was kept, perhaps even intentionally
as a form of documentation.

Remove get_scattered_cpuid_leaf() as it is currently not used by KVM.
Furthermore, simply rebuilding the "real" leaf does not resolve all of
KVM's woes when it comes to exposing a scattered CPUID feature, i.e.
keeping the function as documentation may be counter-productive in some
scenarios, e.g. when KVM needs to do more than simply expose the leaf.

[1] 47bdf3378d62 ("x86/cpuid: Provide get_scattered_cpuid_leaf()")
[2] b7b27aa011a1 ("KVM/x86: Update the reverse_cpuid list to include CPUID_7_EDX")

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20181105185725.18679-1-sean.j.christopherson@intel.com
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
