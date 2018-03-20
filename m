Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeCTOCl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:02:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753509AbeCTOC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:02:29 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v6 6/7] x86/hyper-v: detect nested features
Date: Tue, 20 Mar 2018 15:02:10 +0100
Message-Id: <20180320140211.7600-7-vkuznets@redhat.com>
In-Reply-To: <20180320140211.7600-1-vkuznets@redhat.com>
References: <20180320140211.7600-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TLFS 5.0 says: "Support for an enlightened VMCS interface is reported with
CPUID leaf 0x40000004. If an enlightened VMCS interface is supported,
 additional nested enlightenments may be discovered by reading the CPUID
leaf 0x4000000A (see 2.4.11)."

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/hyperv-tlfs.h | 4 ++++
 arch/x86/include/asm/mshyperv.h    | 1 +
 arch/x86/kernel/cpu/mshyperv.c     | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 07e0547ae8b8..99139c8e952b 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -21,6 +21,7 @@
 #define HYPERV_CPUID_FEATURES			0x40000003
 #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
 #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
+#define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
 
 #define HYPERV_HYPERVISOR_PRESENT_BIT		0x80000000
 #define HYPERV_CPUID_MIN			0x40000005
@@ -339,6 +340,9 @@ struct hv_tsc_emulation_status {
 #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
 		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
 
+/* Hyper-V Enlightened VMCS version mask in nested features CPUID */
+#define HV_X64_ENLIGHTENED_VMCS_VERSION		0xff
+
 #define HV_X64_MSR_TSC_REFERENCE_ENABLE		0x00000001
 #define HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT	12
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 3f162353f180..57c65315b60b 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -13,6 +13,7 @@ struct ms_hyperv_info {
 	u32 features;
 	u32 misc_features;
 	u32 hints;
+	u32 nested_features;
 	u32 max_vp_index;
 	u32 max_lp_index;
 };
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 0dfc568c110c..1afc0a453bba 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -208,6 +208,11 @@ static void __init ms_hyperv_init_platform(void)
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
 	}
 
+	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
+		ms_hyperv.nested_features =
+			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
+	}
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
-- 
2.14.3
