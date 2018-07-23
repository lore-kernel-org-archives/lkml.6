Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2CDECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41D320856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41D320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbeGWO3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:29:35 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:52043 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388064AbeGWO3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:29:34 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowAD3_5sl1lVbkm7cEA--.63S5;
        Mon, 23 Jul 2018 21:21:15 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com,
        mingo@redhat.com, hpa@zytor.com, peterz@infradead.org,
        tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 03/17] x86/mtrr: get MTRR number and support TOP_MEM2
Date:   Mon, 23 Jul 2018 21:20:23 +0800
Message-Id: <1532352037-7151-4-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
X-CM-TRANSID: qwCowAD3_5sl1lVbkm7cEA--.63S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43Cw1xCrWrZr1xZw43Jrb_yoW8uFy5pr
        W7XF48tF4UWan5Ja4qyw4kXrW8Zw1qga1fKw4DGF95J3WFvr9rXFs5Zw1Iqw12vr1rGr1r
        KFy09F4ayws5AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE
        c7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI
        1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
        JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7V
        AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
        AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bec_fUUUUU
        =
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hygon CPU have a special magic MSR way to force WB for memory >4GB,
and also support TOP_MEM2. Therefore, it is necessary to add Hygon
support in amd_special_default_mtrr().

The MtrrFixDramModEn bit on Hygon platform should also be set to 1 during
BIOS initialization of the fixed MTRRs, then cleared to 0 for operation.

The number of variable MTRRs for Hygon is 2 as AMD's.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 3 ++-
 arch/x86/kernel/cpu/mtrr/generic.c | 3 ++-
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 765afd5..3668c5d 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -831,7 +831,8 @@ int __init amd_special_default_mtrr(void)
 {
 	u32 l, h;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return 0;
 	if (boot_cpu_data.x86 < 0xf)
 		return 0;
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e12ee86..71f868f 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -49,7 +49,8 @@ static inline void k8_check_syscfg_dram_mod_en(void)
 {
 	u32 lo, hi;
 
-	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
+	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	       boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) &&
 	      (boot_cpu_data.x86 >= 0x0f)))
 		return;
 
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 9a19c80..507039c 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -127,7 +127,7 @@ static void __init set_num_var_ranges(void)
 
 	if (use_intel())
 		rdmsr(MSR_MTRRcap, config, dummy);
-	else if (is_cpu(AMD))
+	else if (is_cpu(AMD) || is_cpu(HYGON))
 		config = 2;
 	else if (is_cpu(CYRIX) || is_cpu(CENTAUR))
 		config = 8;
-- 
2.7.4

