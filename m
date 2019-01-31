Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D4DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB9E2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfAaIxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:53:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728701AbfAaIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:53:30 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0V8hs9H129220
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:28 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbw8f1w0r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:28 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 31 Jan 2019 08:53:26 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 08:53:23 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0V8rL1a60817622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 08:53:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92AE242049;
        Thu, 31 Jan 2019 08:53:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36F5B4204B;
        Thu, 31 Jan 2019 08:53:20 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 08:53:20 +0000 (GMT)
From:   Michael Mueller <mimu@linux.ibm.com>
To:     KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v7 07/15] KVM: s390: introduce struct kvm_s390_gisa_interrupt
Date:   Thu, 31 Jan 2019 09:52:38 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20190131085247.13826-1-mimu@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19013108-0012-0000-0000-000002EF561C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013108-0013-0000-0000-00002126A054
Message-Id: <20190131085247.13826-8-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=930 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use this struct analog to the kvm interruption structs
for kvm emulated floating and local interruptions.

GIB handling will add further fields to this structure as
required.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  6 ++++-
 arch/s390/kvm/interrupt.c        | 52 +++++++++++++++++++++++-----------------
 arch/s390/kvm/kvm-s390.c         |  2 +-
 3 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c259a67c4298..0941571d34eb 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -803,6 +803,10 @@ struct kvm_s390_vsie {
 	struct page *pages[KVM_MAX_VCPUS];
 };
 
+struct kvm_s390_gisa_interrupt {
+	struct kvm_s390_gisa *origin;
+};
+
 struct kvm_arch{
 	void *sca;
 	int use_esca;
@@ -836,8 +840,8 @@ struct kvm_arch{
 	atomic64_t cmma_dirty_pages;
 	/* subset of available cpu features enabled by user space */
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
-	struct kvm_s390_gisa *gisa;
 	DECLARE_BITMAP(idle_mask, KVM_MAX_VCPUS);
+	struct kvm_s390_gisa_interrupt gisa_int;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 942cc7d33766..ee91d1de0036 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -246,7 +246,8 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
 static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
 {
 	return pending_irqs_no_gisa(vcpu) |
-		gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
+		gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<
+			IRQ_PEND_IO_ISC_7;
 }
 
 static inline int isc_to_irq_type(unsigned long isc)
@@ -956,6 +957,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 {
 	struct list_head *isc_list;
 	struct kvm_s390_float_interrupt *fi;
+	struct kvm_s390_gisa_interrupt *gi = &vcpu->kvm->arch.gisa_int;
 	struct kvm_s390_interrupt_info *inti = NULL;
 	struct kvm_s390_io_info io;
 	u32 isc;
@@ -998,8 +1000,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 		goto out;
 	}
 
-	if (vcpu->kvm->arch.gisa &&
-	    gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
+	if (gi->origin && gisa_tac_ipm_gisc(gi->origin, isc)) {
 		/*
 		 * in case an adapter interrupt was not delivered
 		 * in SIE context KVM will handle the delivery
@@ -1533,18 +1534,19 @@ static struct kvm_s390_interrupt_info *get_top_io_int(struct kvm *kvm,
 
 static int get_top_gisa_isc(struct kvm *kvm, u64 isc_mask, u32 schid)
 {
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
 	unsigned long active_mask;
 	int isc;
 
 	if (schid)
 		goto out;
-	if (!kvm->arch.gisa)
+	if (!gi->origin)
 		goto out;
 
-	active_mask = (isc_mask & gisa_get_ipm(kvm->arch.gisa) << 24) << 32;
+	active_mask = (isc_mask & gisa_get_ipm(gi->origin) << 24) << 32;
 	while (active_mask) {
 		isc = __fls(active_mask) ^ (BITS_PER_LONG - 1);
-		if (gisa_tac_ipm_gisc(kvm->arch.gisa, isc))
+		if (gisa_tac_ipm_gisc(gi->origin, isc))
 			return isc;
 		clear_bit_inv(isc, &active_mask);
 	}
@@ -1567,6 +1569,7 @@ static int get_top_gisa_isc(struct kvm *kvm, u64 isc_mask, u32 schid)
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 						    u64 isc_mask, u32 schid)
 {
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
 	struct kvm_s390_interrupt_info *inti, *tmp_inti;
 	int isc;
 
@@ -1584,7 +1587,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 	/* both types of interrupts present */
 	if (int_word_to_isc(inti->io.io_int_word) <= isc) {
 		/* classical IO int with higher priority */
-		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(gi->origin, isc);
 		goto out;
 	}
 gisa_out:
@@ -1596,7 +1599,7 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 			kvm_s390_reinject_io_int(kvm, inti);
 		inti = tmp_inti;
 	} else
-		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(gi->origin, isc);
 out:
 	return inti;
 }
@@ -1685,6 +1688,7 @@ static int __inject_float_mchk(struct kvm *kvm,
 
 static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 {
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
 	struct kvm_s390_float_interrupt *fi;
 	struct list_head *list;
 	int isc;
@@ -1692,9 +1696,9 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	kvm->stat.inject_io++;
 	isc = int_word_to_isc(inti->io.io_int_word);
 
-	if (kvm->arch.gisa && inti->type & KVM_S390_INT_IO_AI_MASK) {
+	if (gi->origin && inti->type & KVM_S390_INT_IO_AI_MASK) {
 		VM_EVENT(kvm, 4, "%s isc %1u", "inject: I/O (AI/gisa)", isc);
-		gisa_set_ipm_gisc(kvm->arch.gisa, isc);
+		gisa_set_ipm_gisc(gi->origin, isc);
 		kfree(inti);
 		return 0;
 	}
@@ -1752,7 +1756,8 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
 		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_STOP_INT);
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		if (!(type & KVM_S390_INT_IO_AI_MASK && kvm->arch.gisa))
+		if (!(type & KVM_S390_INT_IO_AI_MASK &&
+		      kvm->arch.gisa_int.origin))
 			kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_IO_INT);
 		break;
 	default:
@@ -2002,6 +2007,7 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 
 static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 {
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
 	struct kvm_s390_interrupt_info *inti;
 	struct kvm_s390_float_interrupt *fi;
 	struct kvm_s390_irq *buf;
@@ -2025,14 +2031,14 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 
 	max_irqs = len / sizeof(struct kvm_s390_irq);
 
-	if (kvm->arch.gisa && gisa_get_ipm(kvm->arch.gisa)) {
+	if (gi->origin && gisa_get_ipm(gi->origin)) {
 		for (i = 0; i <= MAX_ISC; i++) {
 			if (n == max_irqs) {
 				/* signal userspace to try again */
 				ret = -ENOMEM;
 				goto out_nolock;
 			}
-			if (gisa_tac_ipm_gisc(kvm->arch.gisa, i)) {
+			if (gisa_tac_ipm_gisc(gi->origin, i)) {
 				irq = (struct kvm_s390_irq *) &buf[n];
 				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
 				irq->u.io.io_int_word = isc_to_int_word(i);
@@ -2884,25 +2890,27 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 
 void kvm_s390_gisa_clear(struct kvm *kvm)
 {
-	if (!kvm->arch.gisa)
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+
+	if (!gi->origin)
 		return;
-	memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
-	kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
-	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
+	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
+	gi->origin->next_alert = (u32)(u64)gi->origin;
+	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", gi->origin);
 }
 
 void kvm_s390_gisa_init(struct kvm *kvm)
 {
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+
 	if (!css_general_characteristics.aiv)
 		return;
-	kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
+	gi->origin = &kvm->arch.sie_page2->gisa;
 	kvm_s390_gisa_clear(kvm);
-	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
+	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
 }
 
 void kvm_s390_gisa_destroy(struct kvm *kvm)
 {
-	if (!kvm->arch.gisa)
-		return;
-	kvm->arch.gisa = NULL;
+	kvm->arch.gisa_int.origin = NULL;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7f4bc58a53b9..4c855cb67699 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2812,7 +2812,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 
 	vcpu->arch.sie_block->icpua = id;
 	spin_lock_init(&vcpu->arch.local_int.lock);
-	vcpu->arch.sie_block->gd = (u32)(u64)kvm->arch.gisa;
+	vcpu->arch.sie_block->gd = (u32)(u64)kvm->arch.gisa_int.origin;
 	if (vcpu->arch.sie_block->gd && sclp.has_gisaf)
 		vcpu->arch.sie_block->gd |= GISA_FORMAT1;
 	seqcount_init(&vcpu->arch.cputm_seqcount);
-- 
2.13.4

