Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932095AbeAaROT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:14:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753732AbeAaROR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:14:17 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] x86/hyper-v: detect nested features
Date: Wed, 31 Jan 2018 18:13:40 +0100
Message-Id: <20180131171341.21478-5-vkuznets@redhat.com>
In-Reply-To: <20180131171341.21478-1-vkuznets@redhat.com>
References: <20180131171341.21478-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TLFS 5.0 says: "Support for an enlightened VMCS interface is reported with
CPUID leaf 0x40000004. If an enlightened VMCS interface is supported,
 additional nested enlightenments may be discovered by reading the CPUID
leaf 0x4000000A (see 2.4.11)."

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/mshyperv.h | 2 ++
 arch/x86/kernel/cpu/mshyperv.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ba8dc52a2c9b..4d7d84b8d503 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -26,12 +26,14 @@ enum hv_cpuid_function {
 	HVCPUID_FEATURES			= 0x40000003,
 	HVCPUID_ENLIGHTENMENT_INFO		= 0x40000004,
 	HVCPUID_IMPLEMENTATION_LIMITS		= 0x40000005,
+	HVCPUID_NESTED_FEATURES			= 0x4000000A
 };
 
 struct ms_hyperv_info {
 	u32 features;
 	u32 misc_features;
 	u32 hints;
+	u32 nested_features;
 	u32 max_vp_index;
 	u32 max_lp_index;
 };
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 9340f41ce8d3..7a387f7a28b8 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -207,6 +207,9 @@ static void __init ms_hyperv_init_platform(void)
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
 	}
 
+	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED)
+		ms_hyperv.nested_features = cpuid_eax(HVCPUID_NESTED_FEATURES);
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
-- 
2.14.3
