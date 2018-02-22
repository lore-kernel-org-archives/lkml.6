Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932479AbeBVMEt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:04:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753649AbeBVMEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:04:46 -0500
Date: Thu, 22 Feb 2018 13:04:39 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
X-X-Sender: sebott@schleppi
To: Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kvm: fix warning for non-x86 builds
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18022212-0040-0000-0000-000004157638
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022212-0041-0000-0000-000026188B6B
Message-Id: <alpine.LFD.2.21.1802221301580.1603@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220155
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning by moving the prototype
of kvm_arch_mmu_notifier_invalidate_range() to linux/kvm_host.h .

  CHECK   arch/s390/kvm/../../../virt/kvm/kvm_main.c
arch/s390/kvm/../../../virt/kvm/kvm_main.c:138:13: warning: symbol 'kvm_arch_mmu_notifier_invalidate_range' was not declared. Should it be static?

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 arch/x86/include/asm/kvm_host.h | 3 ---
 include/linux/kvm_host.h        | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dd6f57a54a26..0a9e330b34f0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1464,7 +1464,4 @@ static inline int kvm_cpu_get_apicid(int mps_cpu)
 #define put_smstate(type, buf, offset, val)                      \
 	*(type *)((buf) + (offset) - 0x7e00) = val
 
-void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
-		unsigned long start, unsigned long end);
-
 #endif /* _ASM_X86_KVM_HOST_H */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ac0062b74aed..ed3d4ddbaff3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1272,4 +1272,7 @@ static inline long kvm_arch_vcpu_async_ioctl(struct file *filp,
 }
 #endif /* CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL */
 
+void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
+		unsigned long start, unsigned long end);
+
 #endif
-- 
2.13.4
