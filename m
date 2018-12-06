Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5A7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819F021527
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819F021527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeLFQ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:58:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbeLFQ6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:58:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E02E3082130;
        Thu,  6 Dec 2018 16:58:41 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B1A919C7D;
        Thu,  6 Dec 2018 16:58:39 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 4/6] x86/kvm/hyper-v: Introduce KVM_GET_SUPPORTED_HV_CPUID
Date:   Thu,  6 Dec 2018 17:58:23 +0100
Message-Id: <20181206165825.1832-5-vkuznets@redhat.com>
In-Reply-To: <20181206165825.1832-1-vkuznets@redhat.com>
References: <20181206165825.1832-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 06 Dec 2018 16:58:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With every new Hyper-V Enlightenment we implement we're forced to add a
KVM_CAP_HYPERV_* capability. While this approach works it is fairly
inconvenient: the majority of the enlightenments we do have corresponding
CPUID feature bit(s) and userspace has to know this anyways to be able to
expose the feature to the guest.

Add KVM_GET_SUPPORTED_HV_CPUID ioctl (backed by KVM_CAP_HYPERV_CPUID, "one
cap to rule them all!") returning all Hyper-V CPUID feature leaves.

Using the existing KVM_GET_SUPPORTED_CPUID doesn't seem to be possible:
Hyper-V CPUID feature leaves intersect with KVM's (e.g. 0x40000000,
0x40000001) and we would probably confuse userspace in case we decide to
return these twice.

KVM_CAP_HYPERV_CPUID's number is interim: we're intended to drop
KVM_CAP_HYPERV_STIMER_DIRECT and use its number instead.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c    | 127 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/hyperv.h    |   2 +
 arch/x86/kvm/x86.c       |  20 ++++++
 include/uapi/linux/kvm.h |   4 ++
 4 files changed, 153 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index cecf907e4c49..c62f16b3d7c9 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1804,3 +1804,130 @@ int kvm_vm_ioctl_hv_eventfd(struct kvm *kvm, struct kvm_hyperv_eventfd *args)
 		return kvm_hv_eventfd_deassign(kvm, args->conn_id);
 	return kvm_hv_eventfd_assign(kvm, args->conn_id, args->fd);
 }
+
+int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
+				struct kvm_cpuid_entry2 __user *entries)
+{
+	int r = -E2BIG, i;
+	struct kvm_cpuid_entry2 cpuid_entries[] = {
+		{ .function = HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS },
+		{ .function = HYPERV_CPUID_INTERFACE },
+		{ .function = HYPERV_CPUID_VERSION },
+		{ .function = HYPERV_CPUID_FEATURES },
+		{ .function = HYPERV_CPUID_ENLIGHTMENT_INFO },
+		{ .function = HYPERV_CPUID_IMPLEMENT_LIMITS },
+		{ .function = HYPERV_CPUID_NESTED_FEATURES },
+	};
+	int nent = ARRAY_SIZE(cpuid_entries);
+	uint16_t evmcs_ver = kvm_x86_ops->nested_get_evmcs_version(vcpu);
+
+	/* Skip NESTED_FEATURES if eVMCS is not supported */
+	if (!evmcs_ver)
+		--nent;
+
+	if (cpuid->nent < 1)
+		goto out;
+	if (cpuid->nent > nent)
+		cpuid->nent = nent;
+
+	for (i = 0; i < nent; i++) {
+		struct kvm_cpuid_entry2 *ent = &cpuid_entries[i];
+		u32 signature[3];
+
+		switch (ent->function) {
+		case HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS:
+			memcpy(signature, "Linux KVM Hv", 12);
+
+			ent->eax = HYPERV_CPUID_NESTED_FEATURES;
+			ent->ebx = signature[0];
+			ent->ecx = signature[1];
+			ent->edx = signature[2];
+			break;
+
+		case HYPERV_CPUID_INTERFACE:
+			memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
+			ent->eax = signature[0];
+			break;
+
+		case HYPERV_CPUID_VERSION:
+			/*
+			 * We implement some Hyper-V 2016 functions so let's use
+			 * this version.
+			 */
+			ent->eax = 0x00003839;
+			ent->ebx = 0x000A0000;
+			break;
+
+		case HYPERV_CPUID_FEATURES:
+			ent->eax |= HV_X64_MSR_VP_RUNTIME_AVAILABLE;
+			ent->eax |= HV_MSR_TIME_REF_COUNT_AVAILABLE;
+			ent->eax |= HV_X64_MSR_SYNIC_AVAILABLE;
+			ent->eax |= HV_MSR_SYNTIMER_AVAILABLE;
+			ent->eax |= HV_X64_MSR_APIC_ACCESS_AVAILABLE;
+			ent->eax |= HV_X64_MSR_HYPERCALL_AVAILABLE;
+			ent->eax |= HV_X64_MSR_VP_INDEX_AVAILABLE;
+			ent->eax |= HV_X64_MSR_RESET_AVAILABLE;
+			ent->eax |= HV_MSR_REFERENCE_TSC_AVAILABLE;
+			ent->eax |= HV_X64_MSR_GUEST_IDLE_AVAILABLE;
+			ent->eax |= HV_X64_ACCESS_FREQUENCY_MSRS;
+			ent->eax |= HV_X64_ACCESS_REENLIGHTENMENT;
+
+			ent->ebx |= HV_X64_POST_MESSAGES;
+			ent->ebx |= HV_X64_SIGNAL_EVENTS;
+
+			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
+			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
+			ent->edx |= HV_STIMER_DIRECT_MODE_AVAILABLE;
+
+			break;
+
+		case HYPERV_CPUID_ENLIGHTMENT_INFO:
+			ent->eax |= HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
+			ent->eax |= HV_X64_APIC_ACCESS_RECOMMENDED;
+			ent->eax |= HV_X64_SYSTEM_RESET_RECOMMENDED;
+			ent->eax |= HV_X64_RELAXED_TIMING_RECOMMENDED;
+			ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
+			ent->eax |= HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED;
+			ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
+
+			/*
+			 * Default number of spinlock retry attempts, matches
+			 * HyperV 2016.
+			 */
+			ent->ebx = 0x00000FFF;
+
+			break;
+
+		case HYPERV_CPUID_IMPLEMENT_LIMITS:
+			/* Maximum number of virtual processors */
+			ent->eax = KVM_MAX_VCPUS;
+			/*
+			 * Maximum number of logical processors, matches
+			 * HyperV 2016.
+			 */
+			ent->ebx = 64;
+
+			break;
+
+		case HYPERV_CPUID_NESTED_FEATURES:
+			ent->eax = evmcs_ver;
+
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	r = -EFAULT;
+	if (copy_to_user(entries, cpuid_entries,
+			 nent * sizeof(struct kvm_cpuid_entry2)))
+		goto out_free;
+	cpuid->nent = nent;
+	r = 0;
+
+out_free:
+	vfree(cpuid_entries);
+out:
+	return r;
+}
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 0e66c12ed2c3..25428f5966e6 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -95,5 +95,7 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 void kvm_hv_init_vm(struct kvm *kvm);
 void kvm_hv_destroy_vm(struct kvm *kvm);
 int kvm_vm_ioctl_hv_eventfd(struct kvm *kvm, struct kvm_hyperv_eventfd *args);
+int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
+				struct kvm_cpuid_entry2 __user *entries);
 
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b21b5ceb8d26..142776435166 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2998,6 +2998,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_SEND_IPI:
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
 	case KVM_CAP_HYPERV_STIMER_DIRECT:
+	case KVM_CAP_HYPERV_CPUID:
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
 	case KVM_CAP_X86_ROBUST_SINGLESTEP:
@@ -4191,6 +4192,25 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state, &kvm_state);
 		break;
 	}
+	case KVM_GET_SUPPORTED_HV_CPUID: {
+		struct kvm_cpuid2 __user *cpuid_arg = argp;
+		struct kvm_cpuid2 cpuid;
+
+		r = -EFAULT;
+		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
+			goto out;
+
+		r = kvm_vcpu_ioctl_get_hv_cpuid(vcpu, &cpuid,
+						cpuid_arg->entries);
+		if (r)
+			goto out;
+
+		r = -EFAULT;
+		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
+			goto out;
+		r = 0;
+		break;
+	}
 	default:
 		r = -EINVAL;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b8da14cee8e5..9d0038eae002 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -976,6 +976,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
 #define KVM_CAP_HYPERV_STIMER_DIRECT 166
+#define KVM_CAP_HYPERV_CPUID 167
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1422,6 +1423,9 @@ struct kvm_enc_region {
 #define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
 #define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
+/* Available with KVM_CAP_HYPERV_CPUID */
+#define KVM_GET_SUPPORTED_HV_CPUID _IOWR(KVMIO, 0xc0, struct kvm_cpuid2)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
-- 
2.19.2

