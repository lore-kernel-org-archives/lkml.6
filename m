Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbeB0O2d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:28:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752573AbeB0O2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:28:31 -0500
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v2 01/15] KVM: s390: refactor crypto initialization
Date: Tue, 27 Feb 2018 09:27:59 -0500
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022714-0016-0000-0000-00000851C78E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995861; UDB=6.00506230; IPR=6.00775186;
 MB=3.00019761; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-27 14:28:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022714-0017-0000-0000-00003DA3E1EA
Message-Id: <1519741693-17440-2-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270181
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crypto control block designation (CRYCBD) is a 32-bit
field in the KVM guest's SIE state description. The
contents of bits 1-28 of this field, with three zero bits
appended on the right, designate the host real 31-bit
address of a crypto control block (CRYCB). Bits 30-31
specify the format of the CRYCB. In the current
implementation, the address of the CRYCB is stored in
the CRYCBD only if the Message-Security-Assist extension
3 (MSA3) facility is installed. Virtualization of AP
facilities, however, requires that a CRYCB of the
appropriate format be made available to SIE regardless
of whether MSA3 is installed or not.

This patch introduces a new compilation unit to provide
all interfaces related to configuration of AP facilities.
Let's start by moving the function for setting the CRYCB
format from arch/s390/kvm/kvm-s390 to this new AP
configuration interface.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 MAINTAINERS                      |   10 ++++++
 arch/s390/include/asm/kvm-ap.h   |   16 ++++++++++
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/kvm/Makefile           |    2 +-
 arch/s390/kvm/kvm-ap.c           |   47 ++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c         |   62 +++++---------------------------------
 6 files changed, 83 insertions(+), 55 deletions(-)
 create mode 100644 arch/s390/include/asm/kvm-ap.h
 create mode 100644 arch/s390/kvm/kvm-ap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ec5881..4acf7c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11875,6 +11875,16 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	drivers/s390/crypto/
 
+S390 VFIO AP DRIVER
+M:	Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+M:	Christian BornTraeger <borntraeger@de.ibm.com>
+M:	Martin Schwidefsky <schwidefsky@de.ibm.com>
+L:	linux-s390@vger.kernel.org
+W:	http://www.ibm.com/developerworks/linux/linux390/
+S:	Supported
+F:	arch/s390/include/asm/kvm/kvm-ap.h
+F:	arch/s390/kvm/kvm-ap.c
+
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.vnet.ibm.com>
 M:	Benjamin Block <bblock@linux.vnet.ibm.com>
diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
new file mode 100644
index 0000000..4e43117
--- /dev/null
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -0,0 +1,16 @@
+/*
+ * Adjunct Processor (AP) configuration management for KVM guests
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
+ */
+
+#ifndef _ASM_KVM_AP
+#define _ASM_KVM_AP
+#include <linux/types.h>
+#include <linux/kvm_host.h>
+
+void kvm_ap_set_crycb_format(struct kvm *kvm, __u32 *crycbd);
+
+#endif /* _ASM_KVM_AP */
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 27918b1..a4c77d3 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -257,6 +257,7 @@ struct kvm_s390_sie_block {
 	__u8	reservedf0[12];		/* 0x00f0 */
 #define CRYCB_FORMAT1 0x00000001
 #define CRYCB_FORMAT2 0x00000003
+#define CRYCB_FORMAT_MASK 0x00000003
 	__u32	crycbd;			/* 0x00fc */
 	__u64	gcr[16];		/* 0x0100 */
 	__u64	gbea;			/* 0x0180 */
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 05ee90a..1876bfe 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -9,6 +9,6 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqch
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
 kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o
-kvm-objs += diag.o gaccess.o guestdbg.o vsie.o
+kvm-objs += diag.o gaccess.o guestdbg.o vsie.o kvm-ap.o
 
 obj-$(CONFIG_KVM) += kvm.o
diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
new file mode 100644
index 0000000..5305f4c
--- /dev/null
+++ b/arch/s390/kvm/kvm-ap.c
@@ -0,0 +1,47 @@
+/*
+ * Adjunct Processor (AP) configuration management for KVM guests
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
+ */
+
+#include <asm/kvm-ap.h>
+#include <asm/ap.h>
+
+#include "kvm-s390.h"
+
+static int kvm_ap_apxa_installed(void)
+{
+	int ret;
+	struct ap_config_info config;
+
+	ret = ap_query_configuration(&config);
+	if (ret)
+		return 0;
+
+	return (config.apxa == 1);
+}
+
+/**
+ * kvm_ap_set_crycb_format
+ *
+ * Set the CRYCB format in the CRYCBD for the KVM guest.
+ *
+ * @kvm:	the KVM guest
+ * @crycbd:	the CRYCB descriptor
+ */
+void kvm_ap_set_crycb_format(struct kvm *kvm, __u32 *crycbd)
+{
+	*crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
+
+	*crycbd &= ~(CRYCB_FORMAT_MASK);
+
+	/* If the MSAX3 is installed */
+	if (test_kvm_facility(kvm, 76)) {
+		if (kvm_ap_apxa_installed())
+			*crycbd |= CRYCB_FORMAT2;
+		else
+			*crycbd |= CRYCB_FORMAT1;
+	}
+}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5f5a4cb..de1e299 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -40,6 +40,8 @@
 #include <asm/sclp.h>
 #include <asm/cpacf.h>
 #include <asm/timex.h>
+#include <asm/ap.h>
+#include <asm/kvm-ap.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 
@@ -1853,55 +1855,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	return r;
 }
 
-static int kvm_s390_query_ap_config(u8 *config)
-{
-	u32 fcn_code = 0x04000000UL;
-	u32 cc = 0;
-
-	memset(config, 0, 128);
-	asm volatile(
-		"lgr 0,%1\n"
-		"lgr 2,%2\n"
-		".long 0xb2af0000\n"		/* PQAP(QCI) */
-		"0: ipm %0\n"
-		"srl %0,28\n"
-		"1:\n"
-		EX_TABLE(0b, 1b)
-		: "+r" (cc)
-		: "r" (fcn_code), "r" (config)
-		: "cc", "0", "2", "memory"
-	);
-
-	return cc;
-}
-
-static int kvm_s390_apxa_installed(void)
-{
-	u8 config[128];
-	int cc;
-
-	if (test_facility(12)) {
-		cc = kvm_s390_query_ap_config(config);
-
-		if (cc)
-			pr_err("PQAP(QCI) failed with cc=%d", cc);
-		else
-			return config[0] & 0x40;
-	}
-
-	return 0;
-}
-
-static void kvm_s390_set_crycb_format(struct kvm *kvm)
-{
-	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
-
-	if (kvm_s390_apxa_installed())
-		kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
-	else
-		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
-}
-
 static u64 kvm_s390_get_initial_cpuid(void)
 {
 	struct cpuid cpuid;
@@ -1913,12 +1866,13 @@ static u64 kvm_s390_get_initial_cpuid(void)
 
 static void kvm_s390_crypto_init(struct kvm *kvm)
 {
+	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
+	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
+	kvm_ap_set_crycb_format(kvm, &kvm->arch.crypto.crycbd);
+
 	if (!test_kvm_facility(kvm, 76))
 		return;
 
-	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
-	kvm_s390_set_crycb_format(kvm);
-
 	/* Enable AES/DEA protected key functions by default */
 	kvm->arch.crypto.aes_kw = 1;
 	kvm->arch.crypto.dea_kw = 1;
@@ -2446,6 +2400,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
+
 	if (!test_kvm_facility(vcpu->kvm, 76))
 		return;
 
@@ -2455,8 +2411,6 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->ecb3 |= ECB3_AES;
 	if (vcpu->kvm->arch.crypto.dea_kw)
 		vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
-
-	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 }
 
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
-- 
1.7.1
