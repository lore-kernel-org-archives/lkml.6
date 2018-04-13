Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754099AbeDMI0K (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:26:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752512AbeDMIVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:21:05 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com, cdall@kernel.org,
        peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: [PATCH v3 01/12] KVM: arm/arm64: Set dist->spis to NULL after kfree
Date: Fri, 13 Apr 2018 10:20:47 +0200
Message-Id: <1523607658-9166-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1523607658-9166-1-git-send-email-eric.auger@redhat.com>
References: <1523607658-9166-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in case kvm_vgic_map_resources() fails, typically if the vgic
distributor is not defined, __kvm_vgic_destroy will be called
several times. Indeed kvm_vgic_map_resources() is called on
first vcpu run. As a result dist->spis is freeed more than once
and on the second time it causes a "kernel BUG at mm/slub.c:3912!"

Set dist->spis to NULL to avoid the crash.

Fixes: ad275b8bb1e6 ("KVM: arm/arm64: vgic-new: vgic_init: implement
vgic_init")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

---

v2 -> v3:
- added Marc's R-b and Fixed commit
---
 virt/kvm/arm/vgic/vgic-init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 68378fe..c52f03d 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -308,6 +308,7 @@ static void kvm_vgic_dist_destroy(struct kvm *kvm)
 	dist->initialized = false;
 
 	kfree(dist->spis);
+	dist->spis = NULL;
 	dist->nr_spis = 0;
 
 	if (vgic_supports_direct_msis(kvm))
-- 
2.5.5
