Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE94C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7915D218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeLZIVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:21:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:19494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbeLZIVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:21:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 00:21:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="103379595"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.239.13.104])
  by orsmga006.jf.intel.com with ESMTP; 26 Dec 2018 00:21:12 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     qemu-devel@nongnu.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel][PATCH 4/4] Report CPUID xsave area support for CET.
Date:   Wed, 26 Dec 2018 16:25:20 +0800
Message-Id: <b3b315a59c56582e2c4fd5f3e262f5d38b4b8985.1545806972.git.weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUID bit definition as below:
CPUID.(EAX=d, ECX=1):ECX.CET_U(bit 11): user mode state
CPUID.(EAX=d, ECX=1):ECX.CET_S(bit 12): kernel mode state

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cf4f2798dc..78994bfa1d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4396,12 +4396,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx = xsave_area_size(env->xcr0);
         } else if (count == 1) {
             *eax = env->features[FEAT_XSAVE];
+            *ecx = env->features[FEAT_XSAVE_SV_LO];
+            *edx = env->features[FEAT_XSAVE_SV_HI];
+            *ebx = xsave_area_size_compat(x86_cpu_xsave_components(cpu) |
+                    x86_cpu_xsave_sv_components(cpu));
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
             if ((x86_cpu_xsave_components(cpu) >> count) & 1) {
                 const ExtSaveArea *esa = &x86_ext_save_areas[count];
                 *eax = esa->size;
                 *ebx = esa->offset;
             }
+            if ((x86_cpu_xsave_sv_components(cpu) >> count) & 1) {
+                const ExtSaveArea *esa_sv = &x86_ext_save_areas[count];
+                *eax = esa_sv->size;
+                *ebx = esa_sv->offset;
+                *ecx = 1;
+            }
         }
         break;
     }
-- 
2.17.1

