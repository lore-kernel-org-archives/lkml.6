Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeBALvU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:51:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48364 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752429AbeBALrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:47:52 -0500
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Jones <drjones@redhat.com>, Hanjun Guo <guohanjun@huawei.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jon Masters <jcm@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [PATCH v3 05/18] arm/arm64: KVM: Add PSCI_VERSION helper
Date: Thu,  1 Feb 2018 11:46:44 +0000
Message-Id: <20180201114657.7323-6-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180201114657.7323-1-marc.zyngier@arm.com>
References: <20180201114657.7323-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're about to trigger a PSCI version explosion, it doesn't
hurt to introduce a PSCI_VERSION helper that is going to be
used everywhere.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_psci.h    | 6 ++++--
 include/uapi/linux/psci.h | 3 +++
 virt/kvm/arm/psci.c       | 4 +---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index 2042bb909474..5659343580a3 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -18,8 +18,10 @@
 #ifndef __KVM_ARM_PSCI_H__
 #define __KVM_ARM_PSCI_H__
 
-#define KVM_ARM_PSCI_0_1	1
-#define KVM_ARM_PSCI_0_2	2
+#include <uapi/linux/psci.h>
+
+#define KVM_ARM_PSCI_0_1	PSCI_VERSION(0, 1)
+#define KVM_ARM_PSCI_0_2	PSCI_VERSION(0, 2)
 
 int kvm_psci_version(struct kvm_vcpu *vcpu);
 int kvm_psci_call(struct kvm_vcpu *vcpu);
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 760e52a9640f..b3bcabe380da 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -88,6 +88,9 @@
 		(((ver) & PSCI_VERSION_MAJOR_MASK) >> PSCI_VERSION_MAJOR_SHIFT)
 #define PSCI_VERSION_MINOR(ver)			\
 		((ver) & PSCI_VERSION_MINOR_MASK)
+#define PSCI_VERSION(maj, min)						\
+	((((maj) << PSCI_VERSION_MAJOR_SHIFT) & PSCI_VERSION_MAJOR_MASK) | \
+	 ((min) & PSCI_VERSION_MINOR_MASK))
 
 /* PSCI features decoding (>=1.0) */
 #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT	1
diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
index b322e46fd142..999f94d6bb98 100644
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -25,8 +25,6 @@
 
 #include <kvm/arm_psci.h>
 
-#include <uapi/linux/psci.h>
-
 /*
  * This is an implementation of the Power State Coordination Interface
  * as described in ARM document number ARM DEN 0022A.
@@ -222,7 +220,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		 * Bits[31:16] = Major Version = 0
 		 * Bits[15:0] = Minor Version = 2
 		 */
-		val = 2;
+		val = KVM_ARM_PSCI_0_2;
 		break;
 	case PSCI_0_2_FN_CPU_SUSPEND:
 	case PSCI_0_2_FN64_CPU_SUSPEND:
-- 
2.14.2
