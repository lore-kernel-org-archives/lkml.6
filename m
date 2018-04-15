Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeDOV0Z (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:26:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753060AbeDOVWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:22:44 -0400
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        akrowiak@linux.vnet.ibm.com
Subject: [PATCH v4 04/15] KVM: s390: CPU model support for AP virtualization
Date: Sun, 15 Apr 2018 17:22:14 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041521-0044-0000-0000-000004043AD5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008862; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018429; UDB=6.00519481; IPR=6.00797666;
 MB=3.00020592; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-15 21:22:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041521-0045-0000-0000-000008363D7C
Message-Id: <1523827345-11600-5-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804150214
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces a new CPU model feature and two CPU model
facilities to support AP virtualization for KVM guests.

CPU model feature:

The KVM_S390_VM_CPU_FEAT_AP feature indicates that
AP instructions are available on the guest. This
feature will be enabled by the kernel only if the AP
instructions are installed on the linux host. This feature
must be specifically turned on for the KVM guest from
userspace to use the VFIO AP device driver for guest
access to AP devices.

CPU model facilities:

1. AP Query Configuration Information (QCI) facility is installed.

   This is indicated by setting facilities bit 12 for
   the guest. The kernel will not enable this facility
   for the guest if it is not set on the host. This facility
   must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
   feature is not installed.

2. AP Facilities Test facility (APFT) is installed.

   This is indicated by setting facilities bit 15 for
   the guest. The kernel will not enable this facility for
   the guest if it is not set on the host. This facility
   must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
   feature is not installed.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/include/uapi/asm/kvm.h |    1 +
 arch/s390/kvm/kvm-s390.c         |    5 +++++
 arch/s390/tools/gen_facilities.c |    2 ++
 4 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c990a1d..3162783 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -186,6 +186,7 @@ struct kvm_s390_sie_block {
 #define ECA_AIV		0x00200000
 #define ECA_VX		0x00020000
 #define ECA_PROTEXCI	0x00002000
+#define ECA_APIE	0x00000008
 #define ECA_SII		0x00000001
 	__u32	eca;			/* 0x004c */
 #define ICPT_INST	0x04
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 4cdaa55..a580dec 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_AP		14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b47ff11..55cd897 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -367,6 +367,11 @@ static void kvm_s390_cpu_feat_init(void)
 
 	if (MACHINE_HAS_ESOP)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
+
+	/* Check if AP instructions installed on host */
+	if (kvm_ap_instructions_installed())
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
+
 	/*
 	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
 	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 90a8c9e..a52290b 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -106,6 +106,8 @@ struct facility_def {
 
 		.name = "FACILITIES_KVM_CPUMODEL",
 		.bits = (int[]){
+			12, /* AP Query Configuration Information */
+			15, /* AP Facilities Test */
 			-1  /* END */
 		}
 	},
-- 
1.7.1
