Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeEGRZH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:25:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37020 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeEGRZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:25:05 -0400
X-Google-Smtp-Source: AB8JxZrtdccei8MT6dCTjWksK9+CfqOe56nAAbSSCp6qt4WimzTXdX05jzH53g3PMwA70uWWTVUzOA==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Roman Kagan <rkagan@virtuozzo.com>, Thomas Avery <tavery321@gmail.com>
Subject: [PATCH] KVM: hyperv: idr_find needs RCU protection
Date: Mon,  7 May 2018 19:25:00 +0200
Message-Id: <1525713900-26152-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the eventfd is released after the KVM SRCU grace period
elapses, the conn_to_evt data structure itself is not; it uses RCU
internally, instead.  Fix the read-side critical section to happen
under rcu_read_lock/unlock; the result is still protected by
vcpu->kvm->srcu.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 14dd5e5010a2..5708e951a5c6 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1296,8 +1296,10 @@ static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, bool fast, u64 param)
 	if (param & ~KVM_HYPERV_CONN_ID_MASK)
 		return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
-	/* conn_to_evt is protected by vcpu->kvm->srcu */
+	/* the eventfd is protected by vcpu->kvm->srcu, but conn_to_evt isn't */
+	rcu_read_lock();
 	eventfd = idr_find(&vcpu->kvm->arch.hyperv.conn_to_evt, param);
+	rcu_read_unlock();
 	if (!eventfd)
 		return HV_STATUS_INVALID_PORT_ID;
 
-- 
1.8.3.1
