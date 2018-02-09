Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeBIFHk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 00:07:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:9300 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbeBIFHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 00:07:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,482,1511856000";
   d="scan'208";a="25973512"
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org
Cc: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v2] x86/kvm/vmx: Don't halt vcpu when L1 is injecting events to L2
Date: Fri,  9 Feb 2018 13:09:12 +0800
Message-Id: <1518152952-12633-1-git-send-email-chao.gao@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although L2 is in halt state, it will be in the active state after
VM entry if the VM entry is vectoring according to SDM 26.6.2 Activity
State. Halting the vcpu here means the event won't be injected to L2
and this decision isn't reported to L1. Thus L0 drops an event that
should be injected to L2.

Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
Changes in v2:
 - Remove VID stuff. Only handle event injection in this patch.
---
 arch/x86/kvm/vmx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index bb5b488..42f39d9 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10985,7 +10985,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (ret)
 		return ret;
 
-	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT)
+	/*
+	 * If we're entering a halted L2 vcpu and the L2 vcpu won't be woken
+	 * by event injection, halt vcpu for optimization.
+	 */
+	if ((vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) &&
+	    !(vmcs12->vm_entry_intr_info_field & VECTORING_INFO_VALID_MASK))
 		return kvm_vcpu_halt(vcpu);
 
 	vmx->nested.nested_run_pending = 1;
-- 
1.9.1
