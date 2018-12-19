Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D24C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971212080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbeLSTTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:19:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730172AbeLSTSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:18:14 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBJIwfUw133315
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:12 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pfs981gqe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:12 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Wed, 19 Dec 2018 19:18:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Dec 2018 19:18:08 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBJJI6P76226298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 19:18:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3B9352051;
        Wed, 19 Dec 2018 19:18:06 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 58D7E52050;
        Wed, 19 Dec 2018 19:18:06 +0000 (GMT)
From:   Michael Mueller <mimu@linux.ibm.com>
To:     KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v5 05/15] KVM: s390: unify pending_irqs() and pending_irqs_no_gisa()
Date:   Wed, 19 Dec 2018 20:17:46 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18121919-0008-0000-0000-000002A3B18D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121919-0009-0000-0000-0000220E4C0A
Message-Id: <20181219191756.57973-6-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812190150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a single function with parameter irq_flags to differentiate
between cases.

New irq flag:
   IRQ_FLAG_LOCAL: include vcpu local interruptions pending
   IRQ_FLAG_FLOATING: include vcpu floating interruptions pending
   IRQ_FLAG_GISA: include GISA interruptions pending in IPM

New irq masks:
   IRQ_MASK_ALL: include all types
   IRQ_MASK_NO_GISA: include all types but GISA

Examples:
   pending_irqs(vcpu, IRQ_MASK_ALL)
   pending_irqs(vcpu, IRQ_MASK_NO_GISA)

There will be more irq flags with upcoming patches.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 093b568b6356..4ab20d2eb180 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -31,6 +31,13 @@
 #define PFAULT_DONE 0x0680
 #define VIRTIO_PARAM 0x0d00
 
+#define IRQ_FLAG_LOCAL    0x8000 /* include local interruption pending mask */
+#define IRQ_FLAG_FLOATING 0x4000 /* include float interruption pending mask */
+#define IRQ_FLAG_GISA     0x2000 /* include GISA interruption pending mask */
+
+#define IRQ_MASK_ALL      (IRQ_FLAG_LOCAL | IRQ_FLAG_FLOATING | IRQ_FLAG_GISA)
+#define IRQ_MASK_NO_GISA  (IRQ_MASK_ALL & ~IRQ_FLAG_GISA)
+
 /* handle external calls via sigp interpretation facility */
 static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 {
@@ -237,16 +244,18 @@ static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gis
 	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
 }
 
-static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
+static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu, u16 irq_flags)
 {
-	return vcpu->kvm->arch.float_int.pending_irqs |
-		vcpu->arch.local_int.pending_irqs;
-}
+	unsigned long pending_irqs = 0;
 
-static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
-{
-	return pending_irqs_no_gisa(vcpu) |
-		kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
+	if (irq_flags & IRQ_FLAG_LOCAL)
+		pending_irqs |= vcpu->arch.local_int.pending_irqs;
+	if (irq_flags & IRQ_FLAG_FLOATING)
+		pending_irqs |= vcpu->kvm->arch.float_int.pending_irqs;
+	if (irq_flags & IRQ_FLAG_GISA)
+		pending_irqs |= kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) <<
+			IRQ_PEND_IO_ISC_7;
+	return pending_irqs;
 }
 
 static inline int isc_to_irq_type(unsigned long isc)
@@ -275,7 +284,7 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 {
 	unsigned long active_mask;
 
-	active_mask = pending_irqs(vcpu);
+	active_mask = pending_irqs(vcpu, IRQ_MASK_ALL);
 	if (!active_mask)
 		return 0;
 
@@ -343,7 +352,7 @@ static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
 
 static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
 {
-	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_IO_MASK))
+	if (!(pending_irqs(vcpu, IRQ_MASK_NO_GISA) & IRQ_PEND_IO_MASK))
 		return;
 	else if (psw_ioint_disabled(vcpu))
 		kvm_s390_set_cpuflags(vcpu, CPUSTAT_IO_INT);
@@ -353,7 +362,7 @@ static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
 
 static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
 {
-	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_EXT_MASK))
+	if (!(pending_irqs(vcpu, IRQ_MASK_NO_GISA) & IRQ_PEND_EXT_MASK))
 		return;
 	if (psw_extint_disabled(vcpu))
 		kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
@@ -363,7 +372,7 @@ static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
 
 static void set_intercept_indicators_mchk(struct kvm_vcpu *vcpu)
 {
-	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_MCHK_MASK))
+	if (!(pending_irqs(vcpu, IRQ_MASK_NO_GISA) & IRQ_PEND_MCHK_MASK))
 		return;
 	if (psw_mchk_disabled(vcpu))
 		vcpu->arch.sie_block->ictl |= ICTL_LPSW;
-- 
2.13.4

