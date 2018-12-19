Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B9D2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeLSTS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:18:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730441AbeLSTSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:18:20 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBJIwxdg094792
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:20 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pft326kyv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:18:19 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Wed, 19 Dec 2018 19:18:17 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Dec 2018 19:18:15 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBJJIDlv61276346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 19:18:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92ECA52052;
        Wed, 19 Dec 2018 19:18:13 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3802952050;
        Wed, 19 Dec 2018 19:18:13 +0000 (GMT)
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
Subject: [PATCH v5 10/15] KVM: s390: add functions to (un)register GISC with GISA
Date:   Wed, 19 Dec 2018 20:17:51 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18121919-0016-0000-0000-00000238D575
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121919-0017-0000-0000-000032912D01
Message-Id: <20181219191756.57973-11-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812190150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the IAM (Interruption Alert Mask) to the architecture specific
kvm struct. This mask in the GISA is used to define for which ISC
a GIB alert can be issued.

The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
are used to (un)register a GISC (guest ISC) with a virtual machine and
its GISA.

Upon successful completion, kvm_s390_gisc_register() returns the
ISC to be used for GIB alert interruptions. A negative return code
indicates an error during registration.

Theses functions will be used by other adapter types like AP and PCI to
request pass-through interruption support.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  9 ++++++
 arch/s390/kvm/interrupt.c        | 66 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 0deba3ae8bc7..2c1259da3636 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -782,6 +782,9 @@ struct kvm_s390_gisa {
 			u8  reserved03[11];
 			u32 airq_count;
 		} g1;
+		struct {
+			u64 word[4];
+		} u64;
 	};
 };
 
@@ -849,6 +852,9 @@ struct kvm_arch{
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
 	struct kvm_s390_gisa *gisa;
 	int gib_in_use;
+	u8 iam;
+	u32 iam_ref_count[MAX_ISC + 1];
+	spinlock_t iam_ref_lock;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
@@ -882,6 +888,9 @@ void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
 
+extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
+extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
+
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_check_processor_compat(void *rtn) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 5a54360cecfe..1cc3ad2e6c7e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -229,6 +229,25 @@ static inline u8 int_word_to_isc(u32 int_word)
  */
 #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
 
+static inline int set_iam(struct kvm_s390_gisa *gisa, u8 iam)
+{
+	u64 word0, _word0;
+
+	do {
+		word0 = READ_ONCE(gisa->u64.word[0]);
+		/* If the GISA is in the alert list, do nothing. */
+		if ((u64)gisa != word0 >> 32)
+			return -EBUSY;
+		/*
+		 * Try to set the IAM or loop, if the IPM has changed
+		 * or the GISA has been inserted into the alert list.
+		 */
+		_word0 = (word0 & ~0xffUL) | iam;
+	} while (cmpxchg(&gisa->u64.word[0], word0, _word0) != _word0);
+
+	return 0;
+}
+
 static inline void set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
@@ -2917,6 +2936,8 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 	if (!css_general_characteristics.aiv)
 		return;
 	kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
+	kvm->arch.iam = 0;
+	spin_lock_init(&kvm->arch.iam_ref_lock);
 	nullify_gisa(kvm->arch.gisa);
 	kvm->arch.gib_in_use = !!gib;
 	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
@@ -2929,6 +2950,51 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
 	kvm->arch.gisa = NULL;
 }
 
+int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
+{
+	if (!kvm->arch.gib_in_use)
+		return -ENODEV;
+	if (gisc > MAX_ISC)
+		return -ERANGE;
+
+	spin_lock(&kvm->arch.iam_ref_lock);
+	if (kvm->arch.iam_ref_count[gisc] == 0)
+		kvm->arch.iam |= 0x80 >> gisc;
+	kvm->arch.iam_ref_count[gisc]++;
+	if (kvm->arch.iam_ref_count[gisc] == 1)
+		set_iam(kvm->arch.gisa, kvm->arch.iam);
+	spin_unlock(&kvm->arch.iam_ref_lock);
+
+	return gib->nisc;
+}
+EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
+
+int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
+{
+	int rc = 0;
+
+	if (!kvm->arch.gib_in_use)
+		return -ENODEV;
+	if (gisc > MAX_ISC)
+		return -ERANGE;
+
+	spin_lock(&kvm->arch.iam_ref_lock);
+	if (kvm->arch.iam_ref_count[gisc] == 0) {
+		rc = -EINVAL;
+		goto out;
+	}
+	kvm->arch.iam_ref_count[gisc]--;
+	if (kvm->arch.iam_ref_count[gisc] == 0) {
+		kvm->arch.iam &= ~(0x80 >> gisc);
+		set_iam(kvm->arch.gisa, kvm->arch.iam);
+	}
+out:
+	spin_unlock(&kvm->arch.iam_ref_lock);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
+
 void kvm_s390_gib_destroy(void)
 {
 	if (!gib)
-- 
2.13.4

