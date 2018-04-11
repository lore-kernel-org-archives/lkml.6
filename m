Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbeDKRXH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 13:23:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751777AbeDKRVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 13:21:36 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] KVM: x86: hyperv: do rep check for each hypercall separately
Date: Wed, 11 Apr 2018 19:21:23 +0200
Message-Id: <20180411172126.16355-4-vkuznets@redhat.com>
In-Reply-To: <20180411172126.16355-1-vkuznets@redhat.com>
References: <20180411172126.16355-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to support TLB flush hypercalls, some of which are REP hypercalls.
Also, return HV_STATUS_INVALID_HYPERCALL_INPUT as it seems more
appropriate.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 3cb3bb68db7e..67788d358200 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1309,7 +1309,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 {
 	u64 param, ingpa, outgpa, ret = HV_STATUS_SUCCESS;
 	uint16_t code, rep_idx, rep_cnt;
-	bool fast, longmode;
+	bool fast, longmode, rep;
 
 	/*
 	 * hypercall generates UD from non zero cpl and real mode
@@ -1342,28 +1342,31 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	fast = !!(param & HV_HYPERCALL_FAST_BIT);
 	rep_cnt = (param >> HV_HYPERCALL_REP_COMP_OFFSET) & 0xfff;
 	rep_idx = (param >> HV_HYPERCALL_REP_START_OFFSET) & 0xfff;
+	rep = !!(rep_cnt || rep_idx);
 
 	trace_kvm_hv_hypercall(code, fast, rep_cnt, rep_idx, ingpa, outgpa);
 
-	/* Hypercall continuation is not supported yet */
-	if (rep_cnt || rep_idx) {
-		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
-		goto set_result;
-	}
-
 	switch (code) {
 	case HVCALL_NOTIFY_LONG_SPIN_WAIT:
+		if (unlikely(rep)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
 		kvm_vcpu_on_spin(vcpu, true);
 		break;
 	case HVCALL_SIGNAL_EVENT:
+		if (unlikely(rep)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
 		ret = kvm_hvcall_signal_event(vcpu, fast, ingpa);
 		if (ret != HV_STATUS_INVALID_PORT_ID)
 			break;
 		/* maybe userspace knows this conn_id: fall through */
 	case HVCALL_POST_MESSAGE:
 		/* don't bother userspace if it has no way to handle it */
-		if (!vcpu_to_synic(vcpu)->active) {
-			ret = HV_STATUS_INVALID_HYPERCALL_CODE;
+		if (unlikely(rep || !vcpu_to_synic(vcpu)->active)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
 		vcpu->run->exit_reason = KVM_EXIT_HYPERV;
-- 
2.14.3
