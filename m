Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32226C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC2021720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeLZINI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:13:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:64132 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbeLZIMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:12:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 00:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="104759720"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.239.13.104])
  by orsmga008.jf.intel.com with ESMTP; 26 Dec 2018 00:12:47 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: [PATCH v1 6/8] kvm:cpuid  Add CPUID support for CET xsaves component query.
Date:   Wed, 26 Dec 2018 16:15:30 +0800
Message-Id: <20181226081532.30698-7-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181226081532.30698-1-weijiang.yang@intel.com>
References: <20181226081532.30698-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CET xsaves component size is queried through CPUID.(EAX=0xD, ECX=11)
and CPUID.(EAX=0xD, ECX=12).

Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/cpuid.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7bcfa61375c0..5bac31e58955 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -565,6 +565,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 	case 0xd: {
 		int idx, i;
 		u64 supported = kvm_supported_xcr0();
+		u64 sv_supported;
 
 		entry->eax &= supported;
 		entry->ebx = xstate_required_size(supported, false);
@@ -584,18 +585,23 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 				entry[i].eax &= kvm_cpuid_D_1_eax_x86_features;
 				cpuid_mask(&entry[i].eax, CPUID_D_1_EAX);
 				entry[i].ebx = 0;
+				sv_supported = entry[i].ecx +
+					((u64)entry[i].edx << 32);
 				if (entry[i].eax & (F(XSAVES)|F(XSAVEC)))
 					entry[i].ebx =
 						xstate_required_size(supported,
 								     true);
-			} else {
+			} else if (!(entry[i].ecx & 1)) {
 				if (entry[i].eax == 0 || !(supported & mask))
 					continue;
-				if (WARN_ON_ONCE(entry[i].ecx & 1))
+				entry[i].ecx = 0;
+				entry[i].edx = 0;
+			} else {
+				if (entry[i].eax == 0 || !(sv_supported & mask))
 					continue;
+				entry[i].ecx = 1;
+				entry[i].edx = 0;
 			}
-			entry[i].ecx = 0;
-			entry[i].edx = 0;
 			entry[i].flags |=
 			       KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
 			++*nent;
-- 
2.17.1

