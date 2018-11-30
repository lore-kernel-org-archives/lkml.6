Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52625C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB1720863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB1720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeK3TRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:17:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:64152 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbeK3TRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:17:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:09:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="117412120"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 30 Nov 2018 00:09:16 -0800
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.128])
        by linux.intel.com (Postfix) with ESMTP id D7772580213;
        Fri, 30 Nov 2018 00:09:13 -0800 (PST)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     pbonzini@redhat.com, mdontu@bitdefender.com, ncitu@bitdefender.com
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH V2 08/11] KVM: VMX: Introduce ioctls to set/get Sub-Page Write Protection.
Date:   Fri, 30 Nov 2018 16:08:58 +0800
Message-Id: <c53fda52c3599677945c0a2c65debb9f273a5fc0.1543481993.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We introduced 2 ioctls to let user application to set/get subpage write
protection bitmap per gfn, each gfn corresponds to a bitmap.

The user application, qemu, or some other security control daemon. will
set the protection bitmap via this ioctl.

the API defined as:

struct kvm_subpage {
	__u64 base_gfn;
	__u64 npages;
	/* sub-page write-access bitmap array */
	__u32 access_map[SUBPAGE_MAX_BITMAP];
}sp;

kvm_vm_ioctl(s, KVM_SUBPAGES_SET_ACCESS, &sp)
kvm_vm_ioctl(s, KVM_SUBPAGES_GET_ACCESS, &sp)

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: He Chen <he.chen@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |   9 +++
 arch/x86/kvm/mmu.c              |  49 ++++++++++++++++
 arch/x86/kvm/vmx.c              |  20 +++++++
 arch/x86/kvm/x86.c              | 124 +++++++++++++++++++++++++++++++++++++++-
 include/linux/kvm_host.h        |   5 ++
 include/uapi/linux/kvm.h        |  11 ++++
 6 files changed, 217 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 46312b9..3218d91 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -397,6 +397,8 @@ struct kvm_mmu {
 	void (*invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa);
 	void (*update_pte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 			   u64 *spte, const void *pte);
+	int (*get_subpages)(struct kvm *kvm, struct kvm_subpage *spp_info);
+	int (*set_subpages)(struct kvm *kvm, struct kvm_subpage *spp_info);
 	hpa_t root_hpa;
 	hpa_t sppt_root;
 	union kvm_mmu_role mmu_role;
@@ -784,6 +786,7 @@ struct kvm_lpage_info {
 
 struct kvm_arch_memory_slot {
 	struct kvm_rmap_head *rmap[KVM_NR_PAGE_SIZES];
+	u32 *subpage_wp_info;
 	struct kvm_lpage_info *lpage_info[KVM_NR_PAGE_SIZES - 1];
 	unsigned short *gfn_track[KVM_PAGE_TRACK_MAX];
 };
@@ -1187,6 +1190,9 @@ struct kvm_x86_ops {
 
 	int (*nested_enable_evmcs)(struct kvm_vcpu *vcpu,
 				   uint16_t *vmcs_version);
+
+	int (*get_subpages)(struct kvm *kvm, struct kvm_subpage *spp_info);
+	int (*set_subpages)(struct kvm *kvm, struct kvm_subpage *spp_info);
 };
 
 struct kvm_arch_async_pf {
@@ -1400,6 +1406,9 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva);
 void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid);
 void kvm_mmu_new_cr3(struct kvm_vcpu *vcpu, gpa_t new_cr3, bool skip_tlb_flush);
 
+int kvm_mmu_get_subpages(struct kvm *kvm, struct kvm_subpage *spp_info);
+int kvm_mmu_set_subpages(struct kvm *kvm, struct kvm_subpage *spp_info);
+
 void kvm_enable_tdp(void);
 void kvm_disable_tdp(void);
 
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d077693..b1773c6 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1430,6 +1430,15 @@ static u64 *rmap_get_next(struct rmap_iterator *iter)
 	return sptep;
 }
 
+static u32 *gfn_to_subpage_wp_info(struct kvm_memory_slot *slot,
+				   gfn_t gfn)
+{
+	unsigned long idx;
+
+	idx = gfn_to_index(gfn, slot->base_gfn, PT_PAGE_TABLE_LEVEL);
+	return &slot->arch.subpage_wp_info[idx];
+}
+
 #define for_each_rmap_spte(_rmap_head_, _iter_, _spte_)			\
 	for (_spte_ = rmap_get_first(_rmap_head_, _iter_);		\
 	     _spte_; _spte_ = rmap_get_next(_iter_))
@@ -4141,6 +4150,44 @@ static int tdp_page_fault(struct kvm_vcpu *vcpu, gva_t gpa, u32 error_code,
 	return RET_PF_RETRY;
 }
 
+int kvm_mmu_get_subpages(struct kvm *kvm, struct kvm_subpage *spp_info)
+{
+	u32 *access = spp_info->access_map;
+	gfn_t gfn = spp_info->base_gfn;
+	int npages = spp_info->npages;
+	struct kvm_memory_slot *slot;
+	int i;
+
+	for (i = 0; i < npages; i++, gfn++) {
+		slot = gfn_to_memslot(kvm, gfn);
+		if (!slot)
+			return -EFAULT;
+		access[i] = *gfn_to_subpage_wp_info(slot, gfn);
+	}
+
+	return i;
+}
+
+int kvm_mmu_set_subpages(struct kvm *kvm, struct kvm_subpage *spp_info)
+{
+	u32 access = spp_info->access_map[0];
+	gfn_t gfn = spp_info->base_gfn;
+	int npages = spp_info->npages;
+	struct kvm_memory_slot *slot;
+	u32 *wp_map;
+	int i;
+
+	for (i = 0; i < npages; i++, gfn++) {
+		slot = gfn_to_memslot(kvm, gfn);
+		if (!slot)
+			return -EFAULT;
+		wp_map = gfn_to_subpage_wp_info(slot, gfn);
+		*wp_map = access;
+	}
+
+	return i;
+}
+
 static void nonpaging_init_context(struct kvm_vcpu *vcpu,
 				   struct kvm_mmu *context)
 {
@@ -4835,6 +4882,8 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 	context->get_cr3 = get_cr3;
 	context->get_pdptr = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
+	context->get_subpages = kvm_x86_ops->get_subpages;
+	context->set_subpages = kvm_x86_ops->set_subpages;
 
 	if (!is_paging(vcpu)) {
 		context->nx = false;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6634098..b660812 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8028,6 +8028,11 @@ static __init int hardware_setup(void)
 		kvm_x86_ops->enable_log_dirty_pt_masked = NULL;
 	}
 
+	if (!enable_ept_spp) {
+		kvm_x86_ops->get_subpages = NULL;
+		kvm_x86_ops->set_subpages = NULL;
+	}
+
 	if (!cpu_has_vmx_preemption_timer())
 		kvm_x86_ops->request_immediate_exit = __kvm_request_immediate_exit;
 
@@ -15037,6 +15042,18 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int vmx_get_subpages(struct kvm *kvm,
+			    struct kvm_subpage *spp_info)
+{
+	return kvm_get_subpages(kvm, spp_info);
+}
+
+static int vmx_set_subpages(struct kvm *kvm,
+			    struct kvm_subpage *spp_info)
+{
+	return kvm_set_subpages(kvm, spp_info);
+}
+
 static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -15184,6 +15201,9 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.enable_smi_window = enable_smi_window,
 
 	.nested_enable_evmcs = nested_enable_evmcs,
+
+	.get_subpages = vmx_get_subpages,
+	.set_subpages = vmx_set_subpages,
 };
 
 static void vmx_cleanup_l1d_flush(void)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5cd5647..fa36858 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4507,6 +4507,44 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 	return r;
 }
 
+static int kvm_vm_ioctl_get_subpages(struct kvm *kvm,
+				     struct kvm_subpage *spp_info)
+{
+	return kvm_arch_get_subpages(kvm, spp_info);
+}
+
+static int kvm_vm_ioctl_set_subpages(struct kvm *kvm,
+				     struct kvm_subpage *spp_info)
+{
+	return kvm_arch_set_subpages(kvm, spp_info);
+}
+
+int kvm_get_subpages(struct kvm *kvm,
+		     struct kvm_subpage *spp_info)
+{
+	int ret;
+
+	mutex_lock(&kvm->slots_lock);
+	ret = kvm_mmu_get_subpages(kvm, spp_info);
+	mutex_unlock(&kvm->slots_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvm_get_subpages);
+
+int kvm_set_subpages(struct kvm *kvm,
+		     struct kvm_subpage *spp_info)
+{
+	int ret;
+
+	mutex_lock(&kvm->slots_lock);
+	ret = kvm_mmu_set_subpages(kvm, spp_info);
+	mutex_unlock(&kvm->slots_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvm_set_subpages);
+
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg)
 {
@@ -4811,6 +4849,39 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		if (copy_from_user(&hvevfd, argp, sizeof(hvevfd)))
 			goto out;
 		r = kvm_vm_ioctl_hv_eventfd(kvm, &hvevfd);
+	}
+	case KVM_SUBPAGES_GET_ACCESS: {
+		struct kvm_subpage spp_info;
+
+		r = -EFAULT;
+		if (copy_from_user(&spp_info, argp, sizeof(spp_info)))
+			goto out;
+
+		r = -EINVAL;
+		if (spp_info.npages == 0 ||
+		    spp_info.npages > SUBPAGE_MAX_BITMAP)
+			goto out;
+
+		r = kvm_vm_ioctl_get_subpages(kvm, &spp_info);
+		if (copy_to_user(argp, &spp_info, sizeof(spp_info))) {
+			r = -EFAULT;
+			goto out;
+		}
+		break;
+	}
+	case KVM_SUBPAGES_SET_ACCESS: {
+		struct kvm_subpage spp_info;
+
+		r = -EFAULT;
+		if (copy_from_user(&spp_info, argp, sizeof(spp_info)))
+			goto out;
+
+		r = -EINVAL;
+		if (spp_info.npages == 0 ||
+		    spp_info.npages > SUBPAGE_MAX_BITMAP)
+			goto out;
+
+		r = kvm_vm_ioctl_set_subpages(kvm, &spp_info);
 		break;
 	}
 	default:
@@ -9152,6 +9223,34 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_hv_destroy_vm(kvm);
 }
 
+int kvm_subpage_create_memslot(struct kvm_memory_slot *slot,
+			       unsigned long npages)
+{
+	int lpages;
+
+	lpages = gfn_to_index(slot->base_gfn + npages - 1,
+			      slot->base_gfn, 1) + 1;
+
+	slot->arch.subpage_wp_info =
+	      kvzalloc(lpages * sizeof(*slot->arch.subpage_wp_info),
+		       GFP_KERNEL);
+
+	if (!slot->arch.subpage_wp_info)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void kvm_subpage_free_memslot(struct kvm_memory_slot *free,
+			      struct kvm_memory_slot *dont)
+{
+	if (!dont || free->arch.subpage_wp_info !=
+		dont->arch.subpage_wp_info) {
+		kvfree(free->arch.subpage_wp_info);
+		free->arch.subpage_wp_info = NULL;
+	}
+}
+
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont)
 {
@@ -9173,6 +9272,7 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 	}
 
 	kvm_page_track_free_memslot(free, dont);
+	kvm_subpage_free_memslot(free, dont);
 }
 
 int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
@@ -9225,8 +9325,12 @@ int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (kvm_page_track_create_memslot(slot, npages))
 		goto out_free;
 
-	return 0;
+	if (kvm_subpage_create_memslot(slot, npages))
+		goto out_free_page_track;
 
+	return 0;
+out_free_page_track:
+	kvm_page_track_free_memslot(slot, NULL);
 out_free:
 	for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
 		kvfree(slot->arch.rmap[i]);
@@ -9713,6 +9817,24 @@ int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
 	return kvm_x86_ops->update_pi_irte(kvm, host_irq, guest_irq, set);
 }
 
+int kvm_arch_get_subpages(struct kvm *kvm,
+			  struct kvm_subpage *spp_info)
+{
+	if (!kvm_x86_ops->get_subpages)
+		return -EINVAL;
+
+	return kvm_x86_ops->get_subpages(kvm, spp_info);
+}
+
+int kvm_arch_set_subpages(struct kvm *kvm,
+			  struct kvm_subpage *spp_info)
+{
+	if (!kvm_x86_ops->set_subpages)
+		return -EINVAL;
+
+	return kvm_x86_ops->set_subpages(kvm, spp_info);
+}
+
 bool kvm_vector_hashing_enabled(void)
 {
 	return vector_hashing;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c926698..7f29f97 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -816,6 +816,11 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
 
+int kvm_get_subpages(struct kvm *kvm, struct kvm_subpage *spp_info);
+int kvm_set_subpages(struct kvm *kvm, struct kvm_subpage *spp_info);
+int kvm_arch_get_subpages(struct kvm *kvm, struct kvm_subpage *spp_info);
+int kvm_arch_set_subpages(struct kvm *kvm, struct kvm_subpage *spp_info);
+
 #ifndef __KVM_HAVE_ARCH_VM_ALLOC
 /*
  * All architectures that want to use vzalloc currently also
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 01174f8..3fd6d14 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -102,6 +102,15 @@ struct kvm_userspace_memory_region {
 	__u64 userspace_addr; /* start of the userspace allocated memory */
 };
 
+/* for KVM_SUBPAGES_GET_ACCESS and KVM_SUBPAGES_SET_ACCESS */
+#define SUBPAGE_MAX_BITMAP 128
+struct kvm_subpage {
+	__u64 base_gfn;
+	__u64 npages;
+	 /* sub-page write-access bitmap array */
+	__u32 access_map[SUBPAGE_MAX_BITMAP];
+};
+
 /*
  * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
  * other bits are reserved for kvm internal use which are defined in
@@ -1229,6 +1238,8 @@ struct kvm_vfio_spapr_tce {
 					struct kvm_userspace_memory_region)
 #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
 #define KVM_SET_IDENTITY_MAP_ADDR _IOW(KVMIO,  0x48, __u64)
+#define KVM_SUBPAGES_GET_ACCESS   _IOR(KVMIO,  0x49, __u64)
+#define KVM_SUBPAGES_SET_ACCESS   _IOW(KVMIO,  0x4a, __u64)
 
 /* enable ucontrol for s390 */
 struct kvm_s390_ucas_mapping {
-- 
2.7.4

