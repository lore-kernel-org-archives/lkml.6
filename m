Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeETVYf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 17:24:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752638AbeETVXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 17:23:24 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: [PATCH v7 09/13] KVM: arm/arm64: Check vcpu redist base before registering an iodev
Date: Sun, 20 May 2018 23:22:48 +0200
Message-Id: <1526851372-13009-10-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1526851372-13009-1-git-send-email-eric.auger@redhat.com>
References: <1526851372-13009-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are going to register several redist regions,
vgic_register_all_redist_iodevs() may be called several times. We need
to register a redist_iodev for a given vcpu only once. So let's
check if the base address has already been set. Initialize this latter
in kvm_vgic_vcpu_init().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>

---

v4 -> v5:
- added Christoffer's A-b
---
 virt/kvm/arm/vgic/vgic-init.c    | 3 +++
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index f8750d7..4fb5514 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -198,6 +198,9 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	int i, ret;
 
+	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+	vgic_cpu->sgi_iodev.base_addr = VGIC_ADDR_UNDEF;
+
 	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
 	spin_lock_init(&vgic_cpu->ap_list_lock);
 
diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 3dbc057..1c6c535 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -592,6 +592,9 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	gpa_t rd_base, sgi_base;
 	int ret;
 
+	if (!IS_VGIC_ADDR_UNDEF(vgic_cpu->rd_iodev.base_addr))
+		return 0;
+
 	/*
 	 * We may be creating VCPUs before having set the base address for the
 	 * redistributor region, in which case we will come back to this
-- 
2.5.5
