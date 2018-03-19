Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbeCSJUt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:20:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933093AbeCSJUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:20:39 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com, cdall@kernel.org,
        peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: [RFC 03/12] KVM: arm/arm64: Record RDIST Last bit at registration
Date: Mon, 19 Mar 2018 10:20:11 +0100
Message-Id: <1521451220-27754-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521451220-27754-1-git-send-email-eric.auger@redhat.com>
References: <1521451220-27754-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for multiple RDIST regions, let's record the RDIST
Last bit field when registering the IO device.

As a reminder the Last bit indicates whether the redistributor
is the highest one in a series of contiguous redistributor pages.

Since at the moment KVM only supports a single redist region,
the RDIST tagged with the last bit set to true corresponds to the
highest vCPU one.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/kvm/arm_vgic.h           | 1 +
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index cdbd142..1c8c0ff 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -312,6 +312,7 @@ struct vgic_cpu {
 	 */
 	struct vgic_io_device	rd_iodev;
 	struct vgic_io_device	sgi_iodev;
+	bool rdist_last; /* Is the RDIST the last one of the RDIST region? */
 
 	/* Contains the attributes and gpa of the LPI pending tables. */
 	u64 pendbaser;
diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 671fe81..75fe689 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -184,12 +184,13 @@ static unsigned long vgic_mmio_read_v3r_typer(struct kvm_vcpu *vcpu,
 					      gpa_t addr, unsigned int len)
 {
 	unsigned long mpidr = kvm_vcpu_get_mpidr_aff(vcpu);
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	int target_vcpu_id = vcpu->vcpu_id;
 	u64 value;
 
 	value = (u64)(mpidr & GENMASK(23, 0)) << 32;
 	value |= ((target_vcpu_id & 0xffff) << 8);
-	if (target_vcpu_id == atomic_read(&vcpu->kvm->online_vcpus) - 1)
+	if (vgic_cpu->rdist_last)
 		value |= GICR_TYPER_LAST;
 	if (vgic_has_its(vcpu->kvm))
 		value |= GICR_TYPER_PLPIS;
@@ -580,6 +581,7 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
 	struct vgic_dist *vgic = &kvm->arch.vgic;
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_io_device *rd_dev = &vcpu->arch.vgic_cpu.rd_iodev;
 	struct vgic_io_device *sgi_dev = &vcpu->arch.vgic_cpu.sgi_iodev;
 	gpa_t rd_base, sgi_base;
@@ -632,6 +634,8 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	}
 
 	vgic->vgic_redist_free_offset += 2 * SZ_64K;
+	vgic_cpu->rdist_last =
+		(vcpu->vcpu_id == atomic_read(&vcpu->kvm->online_vcpus) - 1);
 out:
 	mutex_unlock(&kvm->slots_lock);
 	return ret;
-- 
2.5.5
