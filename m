Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163229AbeE1KrU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034269AbeE1KrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:47:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Chao Gao <chao.gao@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 135/496] KVM: nVMX: Dont halt vcpu when L1 is injecting events to L2
Date: Mon, 28 May 2018 11:58:40 +0200
Message-Id: <20180528100325.629323892@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Gao <chao.gao@intel.com>

[ Upstream commit 135a06c3a515bbd17729eb04f4f26316d48363d7 ]

Although L2 is in halt state, it will be in the active state after
VM entry if the VM entry is vectoring according to SDM 26.6.2 Activity
State. Halting the vcpu here means the event won't be injected to L2
and this decision isn't reported to L1. Thus L0 drops an event that
should be injected to L2.

Cc: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11174,7 +11174,12 @@ static int nested_vmx_run(struct kvm_vcp
 	if (ret)
 		return ret;
 
-	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT)
+	/*
+	 * If we're entering a halted L2 vcpu and the L2 vcpu won't be woken
+	 * by event injection, halt vcpu.
+	 */
+	if ((vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) &&
+	    !(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK))
 		return kvm_vcpu_halt(vcpu);
 
 	vmx->nested.nested_run_pending = 1;
