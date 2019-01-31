Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33956C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95AE20989
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfAaDap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:30:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:14660 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfAaDao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:30:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 19:30:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="271331192"
Received: from zhangyu-optiplex-9020.bj.intel.com ([10.238.135.159])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2019 19:30:42 -0800
From:   Yu Zhang <yu.c.zhang@linux.intel.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] kvm: vmx: Fix typos in vmentry/vmexit control setting
Date:   Thu, 31 Jan 2019 11:26:39 +0800
Message-Id: <1548905199-15752-1-git-send-email-yu.c.zhang@linux.intel.com>
X-Mailer: git-send-email 1.9.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, 'commit f99e3daf94ff ("KVM: x86: Add Intel PT
virtualization work mode")' work mode' offered framework
to support Intel PT virtualization. However, the patch has
some typos in vmx_vmentry_ctrl() and vmx_vmexit_ctrl(), e.g.
used wrong flags and wrong variable, which will cause the
VM entry failure later.

Fixes: 'commit f99e3daf94ff ("KVM: x86: Add Intel PT virtualization work mode")'
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kvm/vmx/vmx.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9932895..267de48 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -445,7 +445,8 @@ static inline u32 vmx_vmentry_ctrl(void)
 {
 	u32 vmentry_ctrl = vmcs_config.vmentry_ctrl;
 	if (pt_mode == PT_MODE_SYSTEM)
-		vmentry_ctrl &= ~(VM_EXIT_PT_CONCEAL_PIP | VM_EXIT_CLEAR_IA32_RTIT_CTL);
+		vmentry_ctrl &= ~(VM_ENTRY_PT_CONCEAL_PIP |
+				  VM_ENTRY_LOAD_IA32_RTIT_CTL);
 	/* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
 	return vmentry_ctrl &
 		~(VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VM_ENTRY_LOAD_IA32_EFER);
@@ -455,9 +456,10 @@ static inline u32 vmx_vmexit_ctrl(void)
 {
 	u32 vmexit_ctrl = vmcs_config.vmexit_ctrl;
 	if (pt_mode == PT_MODE_SYSTEM)
-		vmexit_ctrl &= ~(VM_ENTRY_PT_CONCEAL_PIP | VM_ENTRY_LOAD_IA32_RTIT_CTL);
+		vmexit_ctrl &= ~(VM_EXIT_PT_CONCEAL_PIP |
+				 VM_EXIT_CLEAR_IA32_RTIT_CTL);
 	/* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
-	return vmcs_config.vmexit_ctrl &
+	return vmexit_ctrl &
 		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
 }
 
-- 
1.9.1

