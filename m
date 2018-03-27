Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeC0OE2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:04:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750914AbeC0OE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:04:26 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com, cdall@kernel.org,
        peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: [RFC v2 01/12] KVM: arm/arm64: Set dist->spis to NULL after kfree
Date: Tue, 27 Mar 2018 16:04:05 +0200
Message-Id: <1522159456-10419-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1522159456-10419-1-git-send-email-eric.auger@redhat.com>
References: <1522159456-10419-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in case kvm_vgic_map_resources() fails, typically if the vgic
distributor is not defined, __kvm_vgic_destroy will be called
several times. Indeed kvm_vgic_map_resources() is called on
first vcpu run. As a result dist->spis is freeed more than once
and on the second time it causes a "kernel BUG at mm/slub.c:3912!"

Set dist->spis to NULL to avoid the crash.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 virt/kvm/arm/vgic/vgic-init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 743ca5c..3349f2b 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -325,6 +325,7 @@ static void kvm_vgic_dist_destroy(struct kvm *kvm)
 	dist->initialized = false;
 
 	kfree(dist->spis);
+	dist->spis = NULL;
 	dist->nr_spis = 0;
 
 	if (vgic_supports_direct_msis(kvm))
-- 
2.5.5
