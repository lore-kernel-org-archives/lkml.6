Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932924AbeCSJYi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:24:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933040AbeCSJUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:20:37 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com, cdall@kernel.org,
        peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: [RFC 02/12] KVM: arm/arm64: Document KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
Date: Mon, 19 Mar 2018 10:20:10 +0100
Message-Id: <1521451220-27754-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521451220-27754-1-git-send-email-eric.auger@redhat.com>
References: <1521451220-27754-1-git-send-email-eric.auger@redhat.com>
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
---
 Documentation/virtual/kvm/devices/arm-vgic-v3.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
index 9293b45..2c0bedf 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
@@ -27,6 +27,18 @@ Groups:
       VCPU and all of the redistributor pages are contiguous.
       Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
       This address needs to be 64K aligned.
+
+    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION (rw, 64-bit)
+      The attr field of kvm_device_attr encodes 3 values:
+      bits:     | 63   ....  52  |  51   ....   12 |11 - 0
+      values:   |     pfns       |       base      | index
+      - index encodes the unique redistibutor region index
+      - base field encodes bits [51:12] the guest physical base address
+        of the first redistributor in the region. There are two 64K pages
+        for each VCPU and all of the redistributor pages are contiguous
+        within the redistributor region.
+      - pfns encodes the size of the region in 64kB pages.
+      Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
   Errors:
     -E2BIG:  Address outside of addressable IPA range
     -EINVAL: Incorrectly aligned address
-- 
2.5.5
