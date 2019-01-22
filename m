Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCD7C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593C521850
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfAWOG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:06:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:53944 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfAWOG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:06:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 06:06:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,511,1539673200"; 
   d="scan'208";a="140622228"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2019 06:06:24 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     weijiang.yang@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: [PATCH v2 1/7] KVM:VMX: Define CET VMCS fields and bits
Date:   Wed, 23 Jan 2019 04:59:03 +0800
Message-Id: <20190122205909.24165-2-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122205909.24165-1-weijiang.yang@intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On processors that support CET, VMX saves/restores
the states of IA32_S_CET, SSP and IA32_INTERRUPT_SSP_TABLE_ADDR MSR
to the VMCS area for Guest/Host unconditionally.

If VM_EXIT_LOAD_HOST_CET_STATE = 1, the host CET MSRs are
restored from VMCS host-state area at VM exit as follows:

- HOST_IA32_S_CET: Host supervisor mode IA32_S_CET MSR is loaded
                   from this field.

- HOST_SSP : Host SSP is loaded from this field.

- HOST_INTR_SSP_TABLE_ADDR : Host IA32_INTERRUPT_SSP_TABLE_ADDR
                             MSR is loaded from this field.

If VM_ENTRY_LOAD_GUEST_CET_STATE = 1, the guest CET MSRs are loaded
from VMCS guest-state area at VM entry as follows:

- GUEST_IA32_S_CET : Guest supervisor mode IA32_S_CET MSR is loaded
                     from this field.

- GUEST_SSP : Guest SSP is loaded from this field.

- GUEST_INTR_SSP_TABL_ADDR : Guest IA32_INTERRUPT_SSP_TABLE_ADDR
                             MSR is loaded from this field.

Additionally, to context switch guest and host CET states, the VMM
uses xsaves/xrstors instructions to save/restore the guest CET states
at VM exit/entry. The CET xsave area is within thread_struct.fpu area.
If OS execution flow changes during task switch/interrupt/exception etc.,
the OS also relies on xsaves/xrstors to switch CET states accordingly.

Note: Although these VMCS fields are 64-bit, they don't have high fields.

Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/include/asm/vmx.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index ade0f153947d..395c1f7e5938 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -98,6 +98,7 @@
 #define VM_EXIT_LOAD_IA32_EFER                  0x00200000
 #define VM_EXIT_SAVE_VMX_PREEMPTION_TIMER       0x00400000
 #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
+#define VM_EXIT_LOAD_HOST_CET_STATE             0x10000000
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
@@ -109,6 +110,7 @@
 #define VM_ENTRY_LOAD_IA32_PAT			0x00004000
 #define VM_ENTRY_LOAD_IA32_EFER                 0x00008000
 #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
+#define VM_ENTRY_LOAD_GUEST_CET_STATE           0x00100000
 
 #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
 
@@ -325,6 +327,9 @@ enum vmcs_field {
 	GUEST_PENDING_DBG_EXCEPTIONS    = 0x00006822,
 	GUEST_SYSENTER_ESP              = 0x00006824,
 	GUEST_SYSENTER_EIP              = 0x00006826,
+	GUEST_IA32_S_CET                = 0x00006828,
+	GUEST_SSP                       = 0x0000682a,
+	GUEST_INTR_SSP_TABL_ADDR        = 0x0000682c,
 	HOST_CR0                        = 0x00006c00,
 	HOST_CR3                        = 0x00006c02,
 	HOST_CR4                        = 0x00006c04,
@@ -337,6 +342,9 @@ enum vmcs_field {
 	HOST_IA32_SYSENTER_EIP          = 0x00006c12,
 	HOST_RSP                        = 0x00006c14,
 	HOST_RIP                        = 0x00006c16,
+	HOST_IA32_S_CET                 = 0x00006c18,
+	HOST_SSP                        = 0x00006c1a,
+	HOST_INTR_SSP_TABL_ADDR         = 0x00006c1c
 };
 
 /*
-- 
2.17.1

