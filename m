Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeEVIAX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:00:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751393AbeEVHzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:55:42 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: [PATCH v8 05/13] KVM: arm/arm64: Revisit Redistributor TYPER last bit computation
Date: Tue, 22 May 2018 09:55:10 +0200
Message-Id: <1526975718-18567-6-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1526975718-18567-1-git-send-email-eric.auger@redhat.com>
References: <1526975718-18567-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TYPER of an redistributor reflects whether the rdist is
the last one of the redistributor region. Let's compare the TYPER
GPA against the address of the last occupied slot within the
redistributor region.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>

---

v3 -> v4:
- added Christoffer's R-b
---
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 49ca176..ce5c927 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -184,12 +184,17 @@ static unsigned long vgic_mmio_read_v3r_typer(struct kvm_vcpu *vcpu,
 					      gpa_t addr, unsigned int len)
 {
 	unsigned long mpidr = kvm_vcpu_get_mpidr_aff(vcpu);
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_redist_region *rdreg = vgic_cpu->rdreg;
 	int target_vcpu_id = vcpu->vcpu_id;
+	gpa_t last_rdist_typer = rdreg->base + GICR_TYPER +
+			(rdreg->free_index - 1) * KVM_VGIC_V3_REDIST_SIZE;
 	u64 value;
 
 	value = (u64)(mpidr & GENMASK(23, 0)) << 32;
 	value |= ((target_vcpu_id & 0xffff) << 8);
-	if (target_vcpu_id == atomic_read(&vcpu->kvm->online_vcpus) - 1)
+
+	if (addr == last_rdist_typer)
 		value |= GICR_TYPER_LAST;
 	if (vgic_has_its(vcpu->kvm))
 		value |= GICR_TYPER_PLPIS;
-- 
2.5.5
