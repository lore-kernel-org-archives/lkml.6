Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CCFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53CB2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfAWOGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:06:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:53944 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfAWOGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:06:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 06:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,511,1539673200"; 
   d="scan'208";a="140622255"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2019 06:06:30 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     weijiang.yang@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: [PATCH v2 4/7] KVM:CPUID: Fix xsaves area size calculation for CPUID.(EAX=0xD,ECX=1).
Date:   Wed, 23 Jan 2019 04:59:06 +0800
Message-Id: <20190122205909.24165-5-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122205909.24165-1-weijiang.yang@intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to latest Software Development Manual vol.2/3.2,
for CPUID.(EAX=0xD,ECX=1), it should report xsaves area size
containing all states enabled  by XCR0|IA32_MSR_XSS.

Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/cpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index dbeb4e7904eb..67b464d1d749 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -136,7 +136,8 @@ int kvm_update_cpuid(struct kvm_vcpu *vcpu)
 
 	best = kvm_find_cpuid_entry(vcpu, 0xD, 1);
 	if (best && (best->eax & (F(XSAVES) | F(XSAVEC))))
-		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
+		best->ebx = xstate_required_size(vcpu->arch.xcr0 |
+			    kvm_supported_xss(), true);
 
 	/*
 	 * The existing code assumes virtual address is 48-bit or 57-bit in the
-- 
2.17.1

