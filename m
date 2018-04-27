Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935424AbeD0OPW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:15:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935250AbeD0OPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:15:18 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com, cdall@kernel.org,
        peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: [PATCH v4 02/12] KVM: arm/arm64: Document KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
Date: Fri, 27 Apr 2018 16:14:55 +0200
Message-Id: <1524838505-3823-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1524838505-3823-1-git-send-email-eric.auger@redhat.com>
References: <1524838505-3823-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We introduce a new KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION attribute in
KVM_DEV_ARM_VGIC_GRP_ADDR group. It allows userspace to provide the
base address and size of a redistributor region

Compared to KVM_VGIC_V3_ADDR_TYPE_REDIST, this new attribute allows
to declare several separate redistributor regions.

So the whole redist space does not need to be contiguous anymore.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---
v3 -> v4:
- Added Peter's R-b
---
 Documentation/virtual/kvm/devices/arm-vgic-v3.txt | 25 ++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
index 9293b45..cbc4328 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
@@ -27,9 +27,32 @@ Groups:
       VCPU and all of the redistributor pages are contiguous.
       Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
       This address needs to be 64K aligned.
+
+    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION (rw, 64-bit)
+      The attr field of kvm_device_attr encodes 3 values:
+      bits:     | 63   ....  52  |  51   ....   16 | 15 - 12  |11 - 0
+      values:   |     count      |       base      |  flags   | index
+      - index encodes the unique redistributor region index
+      - flags: reserved for future use, currently 0
+      - base field encodes bits [51:16] of the guest physical base address
+        of the first redistributor in the region.
+      - count encodes the number of redistributors in the region. Must be
+        greater than 0.
+      There are two 64K pages for each redistributor in the region and
+      redistributors are laid out contiguously within the region. Regions
+      are filled with redistributors in the index order. The sum of all
+      region count fields must be greater than or equal to the number of
+      VCPUs. Redistributor regions must be registered in the incremental
+      index order, starting from index 0.
+      Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
+
+  It is invalid to mix calls with KVM_VGIC_V3_ADDR_TYPE_REDIST and
+  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION attributes.
+
   Errors:
     -E2BIG:  Address outside of addressable IPA range
-    -EINVAL: Incorrectly aligned address
+    -EINVAL: Incorrectly aligned address, bad redistributor region
+             count/index, mixed redistributor region attribute usage
     -EEXIST: Address already configured
     -ENXIO:  The group or attribute is unknown/unsupported for this device
              or hardware support is missing.
-- 
2.5.5
