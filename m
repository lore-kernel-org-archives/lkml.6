Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB215C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE48B21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfAXNAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:00:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728033AbfAXNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:00:18 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OCt0Rs143539
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:00:17 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q7cm240c7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:00:17 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 24 Jan 2019 13:00:15 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Jan 2019 13:00:11 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0OD09vB44826636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 13:00:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55B2652051;
        Thu, 24 Jan 2019 13:00:09 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 02DBF5205A;
        Thu, 24 Jan 2019 13:00:08 +0000 (GMT)
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
Subject: [PATCH v6 11/13] KVM: s390: add functions to (un)register GISC with GISA
Date:   Thu, 24 Jan 2019 13:59:37 +0100
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20190124125939.130763-1-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012413-0008-0000-0000-000002B565B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012413-0009-0000-0000-000022219A00
Message-Id: <20190124125939.130763-12-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=932 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Interruption Alert Mask (IAM) to the architecture specific
kvm struct. This mask in the GISA is used to define for which ISC
a GIB alert will be issued.

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
 arch/s390/include/asm/kvm_host.h |  13 +++++
 arch/s390/kvm/interrupt.c        | 117 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 7077762ab460..2cfff617cb21 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -781,6 +781,9 @@ struct kvm_s390_gisa {
 			u8  reserved03[11];
 			u32 airq_count;
 		} g1;
+		struct {
+			u64 word[4];
+		} u64;
 	};
 };
 
@@ -813,8 +816,15 @@ struct kvm_s390_vsie {
 	struct page *pages[KVM_MAX_VCPUS];
 };
 
+struct kvm_s390_gisa_iam {
+	u8 mask;
+	spinlock_t ref_lock;
+	u32 ref_count[MAX_ISC + 1];
+};
+
 struct kvm_s390_gisa_interrupt {
 	struct kvm_s390_gisa *origin;
+	struct kvm_s390_gisa_iam alert;
 };
 
 struct kvm_arch{
@@ -885,6 +895,9 @@ void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
 
+extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
+extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
+
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_check_processor_compat(void *rtn) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 5efcd9e2cf8f..6bc9dab6d352 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -222,6 +222,33 @@ static inline u8 int_word_to_isc(u32 int_word)
  */
 #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
 
+/**
+ * gisa_set_iam - change the GISA interruption alert mask
+ *
+ * @gisa: gisa to operate on
+ * @iam: new IAM value to use
+ *
+ * Change the IAM atomically with the next alert address and the IPM
+ * of the GISA if the GISA is not part of the GIB alert list. All three
+ * fields are located in the first long word of the GISA.
+ *
+ * Returns: 0 on success
+ *          -EBUSY in case the gisa is part of the alert list
+ */
+static inline int gisa_set_iam(struct kvm_s390_gisa *gisa, u8 iam)
+{
+	u64 word, _word;
+
+	do {
+		word = READ_ONCE(gisa->u64.word[0]);
+		if ((u64)gisa != word >> 32)
+			return -EBUSY;
+		_word = (word & ~0xffUL) | iam;
+	} while (cmpxchg(&gisa->u64.word[0], word, _word) != word);
+
+	return 0;
+}
+
 static inline void gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
@@ -2911,6 +2938,8 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 	if (!css_general_characteristics.aiv)
 		return;
 	gi->origin = &kvm->arch.sie_page2->gisa;
+	gi->alert.mask = 0;
+	spin_lock_init(&gi->alert.ref_lock);
 	kvm_s390_gisa_clear(kvm);
 	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
 }
@@ -2920,6 +2949,94 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
 	kvm->arch.gisa_int.origin = NULL;
 }
 
+/**
+ * kvm_s390_gisc_register - register a guest ISC
+ *
+ * @kvm:  the kernel vm to work with
+ * @gisc: the guest interruption sub class to register
+ *
+ * The function extends the vm specific alert mask to use.
+ * The effectve IAM mask in the GISA is updated as well
+ * in case the GISA is not part of the GIB alert list.
+ * It will be updated latest when the IAM gets restored
+ * by gisa_get_ipm_or_restore_iam().
+ *
+ * Returns: the nonspecific ISC (NISC) the gib alert mechanism
+ *          has registered with the channel subsystem.
+ *          -ENODEV in case the vm uses no GISA
+ *          -ERANGE in case the guest ISC is invalid
+ */
+int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
+{
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+	u8 alert_mask;
+
+	if (!gi->origin)
+		return -ENODEV;
+	if (gisc > MAX_ISC)
+		return -ERANGE;
+
+	spin_lock(&gi->alert.ref_lock);
+	if (gi->alert.ref_count[gisc] == 0) {
+		alert_mask = gi->alert.mask | 0x80 >> gisc;
+		WRITE_ONCE(gi->alert.mask, alert_mask);
+	}
+	gi->alert.ref_count[gisc]++;
+	if (gi->alert.ref_count[gisc] == 1)
+		gisa_set_iam(gi->origin, alert_mask);
+	spin_unlock(&gi->alert.ref_lock);
+
+	return gib->nisc;
+}
+EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
+
+/**
+ * kvm_s390_gisc_unregister - unregister a guest ISC
+ *
+ * @kvm:  the kernel vm to work with
+ * @gisc: the guest interruption sub class to register
+ *
+ * The function reduces the vm specific alert mask to use.
+ * The effectve IAM mask in the GISA is updated as well
+ * in case the GISA is not part of the GIB alert list.
+ * It will be updated latest when the IAM gets restored
+ * by gisa_get_ipm_or_restore_iam().
+ *
+ * Returns: the nonspecific ISC (NISC) the gib alert mechanism
+ *          has registered with the channel subsystem.
+ *          -ENODEV in case the vm uses no GISA
+ *          -ERANGE in case the guest ISC is invalid
+ *          -EINVAL in case the guest ISC is not registered
+ */
+int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
+{
+	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+	u8 alert_mask;
+	int rc = 0;
+
+	if (!gi->origin)
+		return -ENODEV;
+	if (gisc > MAX_ISC)
+		return -ERANGE;
+
+	spin_lock(&gi->alert.ref_lock);
+	if (gi->alert.ref_count[gisc] == 0) {
+		rc = -EINVAL;
+		goto out;
+	}
+	gi->alert.ref_count[gisc]--;
+	if (gi->alert.ref_count[gisc] == 0) {
+		alert_mask = gi->alert.mask & ~(0x80 >> gisc);
+		WRITE_ONCE(gi->alert.mask, alert_mask);
+		gisa_set_iam(gi->origin, alert_mask);
+	}
+out:
+	spin_unlock(&gi->alert.ref_lock);
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

