Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C960C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FD021720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeLZIVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:21:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:19494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbeLZIVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:21:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 00:21:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="103379586"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.239.13.104])
  by orsmga006.jf.intel.com with ESMTP; 26 Dec 2018 00:21:10 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     qemu-devel@nongnu.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel][PATCH 3/4] Add hepler functions for CPUID xsave area size calculation.
Date:   Wed, 26 Dec 2018 16:25:19 +0800
Message-Id: <7a6de6a8c37161fc207f7003fc0e762045fb4028.1545806972.git.weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are called when return CPUID xsave area
size information.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3630c688d6..cf4f2798dc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1281,12 +1281,34 @@ static inline bool accel_uses_host_cpuid(void)
     return kvm_enabled() || hvf_enabled();
 }
 
+static uint32_t xsave_area_size_compat(uint64_t mask)
+{
+    int i;
+    uint64_t ret = 0;
+    uint32_t offset;
+
+    for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
+        const ExtSaveArea *esa = &x86_ext_save_areas[i];
+        offset = i > 1 ? ret : esa->offset;
+        if ((mask >> i) & 1) {
+            ret = MAX(ret, offset + esa->size);
+        }
+    }
+    return ret;
+}
+
 static inline uint64_t x86_cpu_xsave_components(X86CPU *cpu)
 {
     return ((uint64_t)cpu->env.features[FEAT_XSAVE_COMP_HI]) << 32 |
            cpu->env.features[FEAT_XSAVE_COMP_LO];
 }
 
+static inline uint64_t x86_cpu_xsave_sv_components(X86CPU *cpu)
+{
+    return ((uint64_t)cpu->env.features[FEAT_XSAVE_SV_HI]) << 32 |
+           cpu->env.features[FEAT_XSAVE_SV_LO];
+}
+
 const char *get_register_name_32(unsigned int reg)
 {
     if (reg >= CPU_NB_REGS32) {
@@ -4913,8 +4935,10 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
         }
     }
 
-    env->features[FEAT_XSAVE_COMP_LO] = mask;
+    env->features[FEAT_XSAVE_COMP_LO] = mask & CPUID_XSTATE_USER_MASK;
     env->features[FEAT_XSAVE_COMP_HI] = mask >> 32;
+    env->features[FEAT_XSAVE_SV_LO] = mask & CPUID_XSTATE_KERNEL_MASK;
+    env->features[FEAT_XSAVE_SV_HI] = mask >> 32;
 }
 
 /***** Steps involved on loading and filtering CPUID data
-- 
2.17.1

