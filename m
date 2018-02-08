Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbeBHFL6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 00:11:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:9549 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbeBHFL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 00:11:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,476,1511856000";
   d="scan'208";a="16402229"
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org
Cc: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] x86/kvm/vmx: Don't halt vcpu when L1 is injecting events to L2
Date: Thu,  8 Feb 2018 13:13:36 +0800
Message-Id: <1518066816-7197-1-git-send-email-chao.gao@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although L2 is in halt state, it will be in the active state after
VM entry if the VM entry is vectoring. Halting the vcpu here means
the event won't be injected to L2 and this decision isn't reported
to L1. Thus L0 drops an event that should be injected to L2.

Because virtual interrupt delivery may wake L2 vcpu, if VID is enabled,
do the same thing -- don't halt L2.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/kvm/vmx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index bb5b488..e1fe4e4 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10985,8 +10985,14 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (ret)
 		return ret;
 
-	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT)
-		return kvm_vcpu_halt(vcpu);
+	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) {
+		u32 intr_info = vmcs_read32(VM_ENTRY_INTR_INFO_FIELD);
+		u32 exec_control = vmcs_read32(SECONDARY_VM_EXEC_CONTROL);
+
+		if (!(intr_info & VECTORING_INFO_VALID_MASK) &&
+			!(exec_control & SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY))
+			return kvm_vcpu_halt(vcpu);
+	}
 
 	vmx->nested.nested_run_pending = 1;
 
-- 
1.9.1
