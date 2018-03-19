Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933223AbeCSJUx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:20:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932973AbeCSJUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:20:44 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com, cdall@kernel.org,
        peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: [RFC 05/12] KVM: arm/arm64: Helper to locate free rdist space
Date: Mon, 19 Mar 2018 10:20:13 +0100
Message-Id: <1521451220-27754-6-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521451220-27754-1-git-send-email-eric.auger@redhat.com>
References: <1521451220-27754-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We introduce vgic_v3_rdist_free_slot to help identifying
where we can place a new 2x64KB redistributor.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 virt/kvm/arm/vgic/vgic-mmio-v3.c |  4 ++--
 virt/kvm/arm/vgic/vgic-v3.c      | 21 +++++++++++++++++++++
 virt/kvm/arm/vgic/vgic.h         | 12 ++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index c9dc08f..227b8b6 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -586,6 +586,7 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	struct vgic_io_device *sgi_dev = &vcpu->arch.vgic_cpu.sgi_iodev;
 	struct vgic_redist_region *rdreg;
 	gpa_t rd_base, sgi_base;
+	uint32_t free_pfn_offset;
 	int ret;
 
 	/*
@@ -594,8 +595,7 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	 * function for all VCPUs when the base address is set.  Just return
 	 * without doing any work for now.
 	 */
-	rdreg = list_first_entry(&vgic->rd_regions,
-				 struct vgic_redist_region, list);
+	rdreg = vgic_v3_rdist_free_slot(&vgic->rd_regions, &free_pfn_offset);
 	if (!rdreg)
 		return 0;
 
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 14dabda..68cae0e 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -431,6 +431,27 @@ bool vgic_v3_check_base(struct kvm *kvm)
 	return false;
 }
 
+/**
+ * vgic_v3_rdist_free_slot - Lookup registered rdist regions and identify one
+ * which has free space to put a new rdist regions
+ *
+ * If any, return this redist region handle and the pfn offset to the free slot.
+ * Otherwise, returns NULL.
+ */
+struct vgic_redist_region *vgic_v3_rdist_free_slot(struct list_head *rd_regions,
+						   uint32_t *free_pfn_offset)
+{
+	struct vgic_redist_region *rdreg;
+
+	list_for_each_entry(rdreg, rd_regions, list) {
+		if (!vgic_v3_redist_region_full(rdreg)) {
+			*free_pfn_offset = rdreg->free_pfn_offset;
+			return rdreg;
+		}
+	}
+	return NULL;
+}
+
 int vgic_v3_map_resources(struct kvm *kvm)
 {
 	int ret = 0;
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index 12c37b8..38b2406 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -245,6 +245,18 @@ static inline int vgic_v3_max_apr_idx(struct kvm_vcpu *vcpu)
 	}
 }
 
+static inline bool
+vgic_v3_redist_region_full(struct vgic_redist_region *region)
+{
+	if (!region->pfns)
+		return false;
+
+	return (region->free_pfn_offset > region->pfns - 2);
+}
+
+struct vgic_redist_region *vgic_v3_rdist_free_slot(struct list_head *rd_regions,
+						   uint32_t *free_pfn_offset);
+
 int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
 			 u32 devid, u32 eventid, struct vgic_irq **irq);
 struct vgic_its *vgic_msi_to_its(struct kvm *kvm, struct kvm_msi *msi);
-- 
2.5.5
