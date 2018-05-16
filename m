Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeEPPXw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:23:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752038AbeEPPVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:21:45 -0400
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
Subject: [PATCH v4 5/8] KVM: introduce kvm_make_vcpus_request_mask() API
Date: Wed, 16 May 2018 17:21:28 +0200
Message-Id: <20180516152131.30689-6-vkuznets@redhat.com>
In-Reply-To: <20180516152131.30689-1-vkuznets@redhat.com>
References: <20180516152131.30689-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V style PV TLB flush hypercalls inmplementation will use this API.
To avoid memory allocation in CONFIG_CPUMASK_OFFSTACK case add
cpumask_var_t argument.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 include/linux/kvm_host.h |  3 +++
 virt/kvm/kvm_main.c      | 34 ++++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6d6e79c59e68..14e710d639c7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -730,6 +730,9 @@ void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
 
 void kvm_flush_remote_tlbs(struct kvm *kvm);
 void kvm_reload_remote_mmus(struct kvm *kvm);
+
+bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
+				 unsigned long *vcpu_bitmap, cpumask_var_t tmp);
 bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req);
 
 long kvm_arch_dev_ioctl(struct file *filp,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c7b2e927f699..b125d94307d2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -203,29 +203,47 @@ static inline bool kvm_kick_many_cpus(const struct cpumask *cpus, bool wait)
 	return true;
 }
 
-bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
+bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
+				 unsigned long *vcpu_bitmap, cpumask_var_t tmp)
 {
 	int i, cpu, me;
-	cpumask_var_t cpus;
-	bool called;
 	struct kvm_vcpu *vcpu;
-
-	zalloc_cpumask_var(&cpus, GFP_ATOMIC);
+	bool called;
 
 	me = get_cpu();
+
 	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!test_bit(i, vcpu_bitmap))
+			continue;
+
 		kvm_make_request(req, vcpu);
 		cpu = vcpu->cpu;
 
 		if (!(req & KVM_REQUEST_NO_WAKEUP) && kvm_vcpu_wake_up(vcpu))
 			continue;
 
-		if (cpus != NULL && cpu != -1 && cpu != me &&
+		if (tmp != NULL && cpu != -1 && cpu != me &&
 		    kvm_request_needs_ipi(vcpu, req))
-			__cpumask_set_cpu(cpu, cpus);
+			__cpumask_set_cpu(cpu, tmp);
 	}
-	called = kvm_kick_many_cpus(cpus, !!(req & KVM_REQUEST_WAIT));
+
+	called = kvm_kick_many_cpus(tmp, !!(req & KVM_REQUEST_WAIT));
 	put_cpu();
+
+	return called;
+}
+
+bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
+{
+	cpumask_var_t cpus;
+	bool called;
+	static unsigned long vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)]
+		= {[0 ... BITS_TO_LONGS(KVM_MAX_VCPUS)-1] = ULONG_MAX};
+
+	zalloc_cpumask_var(&cpus, GFP_ATOMIC);
+
+	called = kvm_make_vcpus_request_mask(kvm, req, vcpu_bitmap, cpus);
+
 	free_cpumask_var(cpus);
 	return called;
 }
-- 
2.14.3
