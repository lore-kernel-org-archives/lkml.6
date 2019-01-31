Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BDAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20FF2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbfAaIzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:55:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729687AbfAaIxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:53:22 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0V8hv8T005525
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:21 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qbw2h2pq4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:21 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 31 Jan 2019 08:53:19 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 08:53:16 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0V8rECO57278706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 08:53:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B10CF42045;
        Thu, 31 Jan 2019 08:53:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5721942049;
        Thu, 31 Jan 2019 08:53:14 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 08:53:14 +0000 (GMT)
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
Subject: [PATCH v7 03/15] KVM: s390: move bitmap idle_mask into arch struct top level
Date:   Thu, 31 Jan 2019 09:52:34 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20190131085247.13826-1-mimu@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19013108-0016-0000-0000-0000024E356C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013108-0017-0000-0000-000032A842D1
Message-Id: <20190131085247.13826-4-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vcpu idle_mask state is used by but not specific
to the emulated floating interruptions. The state is
relevant to gisa related interruptions as well.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/interrupt.c        | 11 +++++------
 arch/s390/kvm/kvm-s390.h         |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 3cba08f73dc6..c259a67c4298 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -591,7 +591,6 @@ struct kvm_s390_float_interrupt {
 	struct kvm_s390_mchk_info mchk;
 	struct kvm_s390_ext_info srv_signal;
 	int next_rr_cpu;
-	DECLARE_BITMAP(idle_mask, KVM_MAX_VCPUS);
 	struct mutex ais_lock;
 	u8 simm;
 	u8 nimm;
@@ -838,6 +837,7 @@ struct kvm_arch{
 	/* subset of available cpu features enabled by user space */
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
 	struct kvm_s390_gisa *gisa;
+	DECLARE_BITMAP(idle_mask, KVM_MAX_VCPUS);
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 167a3068ef84..2a3eb9f076c3 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -318,13 +318,13 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 static void __set_cpu_idle(struct kvm_vcpu *vcpu)
 {
 	kvm_s390_set_cpuflags(vcpu, CPUSTAT_WAIT);
-	set_bit(vcpu->vcpu_id, vcpu->kvm->arch.float_int.idle_mask);
+	set_bit(vcpu->vcpu_id, vcpu->kvm->arch.idle_mask);
 }
 
 static void __unset_cpu_idle(struct kvm_vcpu *vcpu)
 {
 	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_WAIT);
-	clear_bit(vcpu->vcpu_id, vcpu->kvm->arch.float_int.idle_mask);
+	clear_bit(vcpu->vcpu_id, vcpu->kvm->arch.idle_mask);
 }
 
 static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
@@ -1726,7 +1726,6 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
  */
 static void __floating_irq_kick(struct kvm *kvm, u64 type)
 {
-	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_vcpu *dst_vcpu;
 	int sigcpu, online_vcpus, nr_tries = 0;
 
@@ -1735,11 +1734,11 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
 		return;
 
 	/* find idle VCPUs first, then round robin */
-	sigcpu = find_first_bit(fi->idle_mask, online_vcpus);
+	sigcpu = find_first_bit(kvm->arch.idle_mask, online_vcpus);
 	if (sigcpu == online_vcpus) {
 		do {
-			sigcpu = fi->next_rr_cpu;
-			fi->next_rr_cpu = (fi->next_rr_cpu + 1) % online_vcpus;
+			sigcpu = kvm->arch.float_int.next_rr_cpu++;
+			kvm->arch.float_int.next_rr_cpu %= online_vcpus;
 			/* avoid endless loops if all vcpus are stopped */
 			if (nr_tries++ >= online_vcpus)
 				return;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 1f6e36cdce0d..72ef87799593 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -67,7 +67,7 @@ static inline int is_vcpu_stopped(struct kvm_vcpu *vcpu)
 
 static inline int is_vcpu_idle(struct kvm_vcpu *vcpu)
 {
-	return test_bit(vcpu->vcpu_id, vcpu->kvm->arch.float_int.idle_mask);
+	return test_bit(vcpu->vcpu_id, vcpu->kvm->arch.idle_mask);
 }
 
 static inline int kvm_is_ucontrol(struct kvm *kvm)
-- 
2.13.4

