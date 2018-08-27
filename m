Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C02C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC2A208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC2A208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeH0Wod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:44:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:12776 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbeH0Woc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:44:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 11:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,296,1531810800"; 
   d="scan'208";a="69524562"
Received: from nitikasi-mobl.ger.corp.intel.com (HELO localhost) ([10.249.36.186])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2018 11:56:26 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Haim Cohen <haim.cohen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Matt Turner <mattst88@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v13 05/13] x86/msr: Add SGX definitions to msr-index.h
Date:   Mon, 27 Aug 2018 21:53:26 +0300
Message-Id: <20180827185507.17087-6-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

ENCLS and ENCLU are usable if and only if SGX_ENABLE is set and After
SGX is activated the IA32_SGXLEPUBKEYHASHn MSRs are writable if
SGX_LC_WR is set and the feature control is locked.

SGX related bits in IA32_FEATURE_CONTROL cannot be set before SGX is
activated by the pre-boot firmware. SGX activation is triggered by
setting bit 0 in the MSR 0x7a. Until SGX is activated, the LE hash MSRs
are writable to allow pre-boot firmware to lock down the LE root key
with a non-Intel value.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Haim Cohen <haim.cohen@intel.com>
Signed-off-by: Haim Cohen <haim.cohen@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h | 8 ++++++++
 arch/x86/kernel/cpu/common.c     | 8 ++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4731f0cf97c5..44d7b68e7f52 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -486,6 +486,8 @@
 #define FEATURE_CONTROL_LOCKED				(1<<0)
 #define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
 #define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
+#define FEATURE_CONTROL_SGX_ENABLE			(1<<18)
+#define FEATURE_CONTROL_SGX_LE_WR			(1<<17)
 #define FEATURE_CONTROL_LMCE				(1<<20)
 
 #define MSR_IA32_APICBASE		0x0000001b
@@ -552,6 +554,12 @@
 #define PACKAGE_THERM_INT_LOW_ENABLE		(1 << 1)
 #define PACKAGE_THERM_INT_PLN_ENABLE		(1 << 24)
 
+/* Intel SGX MSRs */
+#define MSR_IA32_SGXLEPUBKEYHASH0	0x0000008C
+#define MSR_IA32_SGXLEPUBKEYHASH1	0x0000008D
+#define MSR_IA32_SGXLEPUBKEYHASH2	0x0000008E
+#define MSR_IA32_SGXLEPUBKEYHASH3	0x0000008F
+
 /* Thermal Thresholds Support */
 #define THERM_INT_THRESHOLD0_ENABLE    (1 << 15)
 #define THERM_SHIFT_THRESHOLD0        8
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 211c76322ddf..282ceef992b0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -52,6 +52,7 @@
 #include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
+#include <asm/sgx_arch.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/uv/uv.h>
@@ -866,10 +867,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		}
 	}
 
-	/* Intel SGX features: level 0x00000012 */
-	if (c->cpuid_level >= 0x00000012) {
-		cpuid(0x00000012, &eax, &ebx, &ecx, &edx);
-
+	/* Intel SGX features */
+	if (c->cpuid_level >= SGX_CPUID) {
+		cpuid(SGX_CPUID,  &eax, &ebx, &ecx, &edx);
 		c->x86_capability[CPUID_12_EAX] = eax;
 	}
 
-- 
2.17.1

