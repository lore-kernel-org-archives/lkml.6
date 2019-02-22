Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90611C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563812075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfBVPcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:32:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbfBVPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:32:10 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MFVgFQ194952
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:32:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qtjcbwvat-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:31:57 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 22 Feb 2019 15:30:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Feb 2019 15:30:10 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1MFU8F524248570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 15:30:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABC885204E;
        Fri, 22 Feb 2019 15:30:08 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 32F295204F;
        Fri, 22 Feb 2019 15:30:08 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v4 5/7] s390: ap: implement PAPQ AQIC interception in kernel
Date:   Fri, 22 Feb 2019 16:29:58 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19022215-4275-0000-0000-00000312B94D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022215-4276-0000-0000-00003820F14A
Message-Id: <1550849400-27152-6-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We register the AP PQAP instruction hook during the open
of the mediated device. And unregister it on release.

In the AP PQAP instruction hook, if we receive a demand to
enable IRQs,
- we retrieve the vfio_ap_queue based on the APQN we receive
  in REG1,
- we retrieve the page of the guest address, (NIB), from
  register REG2
- we the mediated device to use the VFIO pinning infratrsucture
  to pin the page of the guest address,
- we retrieve the pointer to KVM to register the guest ISC
  and retrieve the host ISC
- finaly we activate GISA

If we receive a demand to disable IRQs,
- we deactivate GISA
- unregister from the GIB
- unping the NIB

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h      |   1 +
 drivers/s390/crypto/ap_bus.h          |   1 +
 drivers/s390/crypto/vfio_ap_ops.c     | 199 +++++++++++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |   1 +
 4 files changed, 199 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 49cc8b0..5f3bb8c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -720,6 +720,7 @@ struct kvm_s390_cpu_model {
 struct kvm_s390_crypto {
 	struct kvm_s390_crypto_cb *crycb;
 	int (*pqap_hook)(struct kvm_vcpu *vcpu);
+	void *vfio_private;
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index bfc66e4..323f2aa 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -43,6 +43,7 @@ static inline int ap_test_bit(unsigned int *ptr, unsigned int nr)
 #define AP_RESPONSE_BUSY		0x05
 #define AP_RESPONSE_INVALID_ADDRESS	0x06
 #define AP_RESPONSE_OTHERWISE_CHANGED	0x07
+#define AP_RESPONSE_INVALID_GISA	0x08
 #define AP_RESPONSE_Q_FULL		0x10
 #define AP_RESPONSE_NO_PENDING_REPLY	0x10
 #define AP_RESPONSE_INDEX_TOO_BIG	0x11
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 1b5130a..0196065 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -43,7 +43,7 @@ struct vfio_ap_queue *vfio_ap_get_queue(int apqn, struct list_head *l)
 	return NULL;
 }
 
-static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
+int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 {
 	struct ap_queue_status status;
 	int retry = 20;
@@ -75,6 +75,27 @@ static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 	return -EBUSY;
 }
 
+/**
+ * vfio_ap_free_irq:
+ * @q: The vfio_ap_queue
+ *
+ * Unpin the guest NIB
+ * Unregister the ISC from the GIB alert
+ * Clear the vfio_ap_queue intern fields
+ */
+static void vfio_ap_free_irq(struct vfio_ap_queue *q)
+{
+	if (!q)
+		return;
+	if (q->g_pfn)
+		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &q->g_pfn, 1);
+	if (q->isc)
+		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->isc);
+	q->nib = 0;
+	q->isc = 0;
+	q->g_pfn = 0;
+}
+
 static void vfio_ap_matrix_init(struct ap_config_info *info,
 				struct ap_matrix *matrix)
 {
@@ -97,6 +118,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 	}
 
 	INIT_LIST_HEAD(&matrix_mdev->qlist);
+	matrix_mdev->mdev = mdev;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	mutex_lock(&matrix_dev->lock);
@@ -109,10 +131,16 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct vfio_ap_queue *q, *qtmp;
 
 	if (matrix_mdev->kvm)
 		return -EBUSY;
 
+	list_for_each_entry_safe(q, qtmp, &matrix_mdev->qlist, list) {
+		q->matrix_mdev = NULL;
+		vfio_ap_mdev_reset_queue(q);
+		list_move(&q->list, &matrix_dev->free_list);
+	}
 	mutex_lock(&matrix_dev->lock);
 	list_del(&matrix_mdev->node);
 	mutex_unlock(&matrix_dev->lock);
@@ -748,6 +776,161 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 };
 
 /**
+ * vfio_ap_clrirq: Disable Interruption for a APQN
+ *
+ * @dev: the device associated with the ap_queue
+ * @q:   the vfio_ap_queue holding AQIC parameters
+ *
+ * Issue the host side PQAP/AQIC
+ * On success: unpin the NIB saved in *q and unregister from GIB
+ * interface
+ *
+ * Return the ap_queue_status returned by the ap_aqic()
+ */
+static struct ap_queue_status vfio_ap_clrirq(struct vfio_ap_queue *q)
+{
+	struct ap_qirq_ctrl aqic_gisa = {};
+	struct ap_queue_status status;
+
+	status = ap_aqic(q->apqn, aqic_gisa, NULL);
+	if (!status.response_code)
+		vfio_ap_free_irq(q);
+
+	return status;
+}
+
+/**
+ * vfio_ap_setirq: Enable Interruption for a APQN
+ *
+ * @dev: the device associated with the ap_queue
+ * @q:   the vfio_ap_queue holding AQIC parameters
+ *
+ * Pin the NIB saved in *q
+ * Register the guest ISC to GIB interface and retrieve the
+ * host ISC to issue the host side PQAP/AQIC
+ *
+ * Response.status may be set to following Response Code in case of error:
+ * - AP_RESPONSE_INVALID_ADDRESS: vfio_pin_pages failed
+ * - AP_RESPONSE_OTHERWISE_CHANGED: Hypervizor GISA internal error
+ *
+ * Otherwise return the ap_queue_status returned by the ap_aqic()
+ */
+static struct ap_queue_status vfio_ap_setirq(struct vfio_ap_queue *q)
+{
+	struct ap_qirq_ctrl aqic_gisa = {};
+	struct ap_queue_status status = {};
+	struct kvm_s390_gisa *gisa;
+	struct kvm *kvm;
+	unsigned long g_pfn, h_nib, h_pfn;
+	int ret;
+
+	kvm = q->matrix_mdev->kvm;
+	gisa = kvm->arch.gisa_int.origin;
+
+	g_pfn = q->nib >> PAGE_SHIFT;
+	ret = vfio_pin_pages(mdev_dev(q->matrix_mdev->mdev), &g_pfn, 1,
+			     IOMMU_READ | IOMMU_WRITE, &h_pfn);
+	switch (ret) {
+	case 1:
+		break;
+	case -EINVAL:
+	case -E2BIG:
+		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
+		/* Fallthrough */
+	default:
+		return status;
+	}
+
+	h_nib = (h_pfn << PAGE_SHIFT) | (q->nib & ~PAGE_MASK);
+	aqic_gisa.gisc = q->isc;
+	aqic_gisa.isc = kvm_s390_gisc_register(kvm, q->isc);
+	aqic_gisa.ir = 1;
+	aqic_gisa.gisa = gisa->next_alert >> 4;
+
+	status = ap_aqic(q->apqn, aqic_gisa, (void *)h_nib);
+	switch (status.response_code) {
+	case AP_RESPONSE_NORMAL:
+		if (q->g_pfn)
+			vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
+					 &q->g_pfn, 1);
+		q->g_pfn = g_pfn;
+		break;
+	case AP_RESPONSE_OTHERWISE_CHANGED:
+		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &g_pfn, 1);
+		break;
+	case AP_RESPONSE_INVALID_GISA:
+		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
+	default:	/* Fall Through */
+		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
+			status.response_code);
+		vfio_ap_free_irq(q);
+		break;
+	}
+
+	return status;
+}
+
+/**
+ * handle_pqap: PQAP instruction callback
+ *
+ * @vcpu: The vcpu on which we received the PQAP instruction
+ *
+ * Get the general register contents to initialize internal variables.
+ * REG[0]: APQN
+ * REG[1]: IR and ISC
+ * REG[2]: NIB
+ *
+ * Response.status may be set to following Response Code:
+ * - AP_RESPONSE_Q_NOT_AVAIL: if the queue is not available
+ * - AP_RESPONSE_DECONFIGURED: if the queue is not configured
+ * - AP_RESPONSE_NORMAL (0) : in case of successs
+ *   Check vfio_ap_setirq() and vfio_ap_clrirq() for other possible RC.
+ *
+ * Return 0 if we could handle the request inside KVM.
+ * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
+ */
+static int handle_pqap(struct kvm_vcpu *vcpu)
+{
+	uint64_t status;
+	uint16_t apqn;
+	struct vfio_ap_queue *q;
+	struct ap_queue_status qstatus = {};
+	struct ap_matrix_mdev *matrix_mdev;
+
+	/* If we do not use the AIV facility just go to userland */
+	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
+		return -EOPNOTSUPP;
+
+	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
+	matrix_mdev = vcpu->kvm->arch.crypto.vfio_private;
+	if (!matrix_mdev)
+		return -EOPNOTSUPP;
+	q = vfio_ap_get_queue(apqn, &matrix_mdev->qlist);
+	if (!q) {
+		qstatus.response_code = AP_RESPONSE_Q_NOT_AVAIL;
+		goto out;
+	}
+
+	status = vcpu->run->s.regs.gprs[1];
+
+	/* If IR bit(16) is set we enable the interrupt */
+	if ((status >> (63 - 16)) & 0x01) {
+		q->isc = status & 0x07;
+		q->nib = vcpu->run->s.regs.gprs[2];
+		qstatus = vfio_ap_setirq(q);
+		if (qstatus.response_code) {
+			q->nib = 0;
+			q->isc = 0;
+		}
+	} else
+		qstatus = vfio_ap_clrirq(q);
+
+out:
+	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
+	return 0;
+}
+
+ /*
  * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
  *
  * @nb: The notifier block
@@ -767,9 +950,10 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
 
 	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
 		struct vfio_iommu_type1_dma_unmap *unmap = data;
-		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
+		unsigned long pfn = unmap->iova >> PAGE_SHIFT;
 
-		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
+		if (matrix_mdev->mdev)
+			vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &pfn, 1);
 		return NOTIFY_OK;
 	}
 
@@ -879,6 +1063,11 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
 	if (ret)
 		goto err_group;
 
+	if (!matrix_mdev->kvm) {
+		ret = -ENODEV;
+		goto err_iommu;
+	}
+
 	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
 	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
 
@@ -887,6 +1076,8 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
 	if (ret)
 		goto err_iommu;
 
+	matrix_mdev->kvm->arch.crypto.pqap_hook = handle_pqap;
+	matrix_mdev->kvm->arch.crypto.vfio_private = matrix_mdev;
 	return 0;
 
 err_iommu:
@@ -905,6 +1096,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
 
 	vfio_ap_mdev_reset_queues(mdev);
+	matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
+	matrix_mdev->kvm->arch.crypto.vfio_private = NULL;
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index e535735..e2fd2c0 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -94,6 +94,7 @@ struct vfio_ap_queue {
 	struct list_head list;
 	struct ap_matrix_mdev *matrix_mdev;
 	unsigned long nib;
+	unsigned long g_pfn;
 	int	apqn;
 	unsigned char isc;
 };
-- 
2.7.4

