Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF485C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670582133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670582133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeIMAuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:50:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728450AbeIMAuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:50:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CJY32n057903
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:44:17 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mf68jfewf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:44:17 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Wed, 12 Sep 2018 13:44:15 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 13:44:11 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CJi8Wr42336396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 12:44:08 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE53B6A051;
        Wed, 12 Sep 2018 13:44:08 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEBDD6A04D;
        Wed, 12 Sep 2018 13:44:05 -0600 (MDT)
Received: from localhost.localdomain (unknown [9.80.213.181])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Sep 2018 13:44:05 -0600 (MDT)
From:   Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v10 11/26] s390: vfio-ap: implement mediated device open callback
Date:   Wed, 12 Sep 2018 15:43:01 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091219-0004-0000-0000-00001488C6B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009709; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01087371; UDB=6.00561489; IPR=6.00867384;
 MB=3.00023256; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-12 19:44:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091219-0005-0000-0000-000088C9F03F
Message-Id: <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Krowiak <akrowiak@linux.ibm.com>

Implements the open callback on the mediated matrix device.
The function registers a group notifier to receive notification
of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
the vfio_ap device driver will get access to the guest's
kvm structure. The open callback must ensure that only one
mediated device shall be opened per guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Acked-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h      |    1 +
 drivers/s390/crypto/vfio_ap_ops.c     |  168 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |    5 +
 3 files changed, 174 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 1e758fe..b32bd1b 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -258,6 +258,7 @@ struct kvm_s390_sie_block {
 	__u64	tecmc;			/* 0x00e8 */
 	__u8	reservedf0[12];		/* 0x00f0 */
 #define CRYCB_FORMAT_MASK 0x00000003
+#define CRYCB_FORMAT0 0x00000000
 #define CRYCB_FORMAT1 0x00000001
 #define CRYCB_FORMAT2 0x00000003
 	__u32	crycbd;			/* 0x00fc */
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2a2dcf7..8bc0cdd 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -13,6 +13,10 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/ctype.h>
+#include <linux/bitops.h>
+#include <linux/kvm_host.h>
+#include <linux/module.h>
+#include <asm/kvm.h>
 #include <asm/zcrypt.h>
 
 #include "vfio_ap_private.h"
@@ -54,6 +58,9 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	mutex_lock(&matrix_dev->lock);
 	list_del(&matrix_mdev->node);
 	mutex_unlock(&matrix_dev->lock);
@@ -309,6 +316,10 @@ static ssize_t assign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	/* If the guest is running, disallow assignment of adapter */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -370,6 +381,10 @@ static ssize_t unassign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	/* If the guest is running, disallow un-assignment of adapter */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -447,6 +462,10 @@ static ssize_t assign_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
 
+	/* If the guest is running, disallow assignment of domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -504,6 +523,10 @@ static ssize_t unassign_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	/* If the guest is running, disallow un-assignment of domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -544,6 +567,10 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	/* If the guest is running, disallow assignment of control domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &id);
 	if (ret)
 		return ret;
@@ -590,6 +617,10 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
 
+	/* If the guest is running, disallow un-assignment of control domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &domid);
 	if (ret)
 		return ret;
@@ -699,12 +730,149 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 	NULL
 };
 
+/**
+ * Verify that the AP instructions are available on the guest. This is indicated
+ * via the  KVM_S390_VM_CPU_FEAT_AP CPU model feature.
+ */
+static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
+{
+	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat))
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
+static void vfio_ap_mdev_copy_masks(struct ap_matrix_mdev *matrix_mdev)
+{
+	int nbytes;
+	unsigned long *apm, *aqm, *adm;
+	struct kvm_s390_crypto_cb *crycb = matrix_mdev->kvm->arch.crypto.crycb;
+
+	switch (matrix_mdev->kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT2:
+		apm = (unsigned long *)crycb->apcb1.apm;
+		aqm = (unsigned long *)crycb->apcb1.aqm;
+		adm = (unsigned long *)crycb->apcb1.adm;
+		break;
+	case CRYCB_FORMAT1:
+	case CRYCB_FORMAT0:
+	default:
+		apm = (unsigned long *)crycb->apcb0.apm;
+		aqm = (unsigned long *)crycb->apcb0.aqm;
+		adm = (unsigned long *)crycb->apcb0.adm;
+		break;
+	}
+
+	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.apm_max + 1, BITS_PER_BYTE);
+	memcpy(apm, matrix_mdev->matrix.apm, nbytes);
+	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.aqm_max + 1, BITS_PER_BYTE);
+	memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
+	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.adm_max + 1, BITS_PER_BYTE);
+	memcpy(adm, matrix_mdev->matrix.adm, nbytes);
+}
+
+/**
+ * vfio_ap_mdev_open_once
+ *
+ * @matrix_mdev: a mediated matrix device
+ *
+ * Return 0 if no other mediated matrix device has been opened for the
+ * KVM guest assigned to @matrix_mdev; otherwise, returns an error.
+ */
+static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev,
+				  struct kvm *kvm)
+{
+	struct ap_matrix_mdev *m;
+
+	mutex_lock(&matrix_dev->lock);
+
+	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
+		if ((m != matrix_mdev) && (m->kvm == kvm)) {
+			mutex_unlock(&matrix_dev->lock);
+			return -EPERM;
+		}
+	}
+
+	mutex_unlock(&matrix_dev->lock);
+
+	return 0;
+}
+
+static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	int ret;
+	struct ap_matrix_mdev *matrix_mdev;
+
+	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
+		return NOTIFY_OK;
+
+	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
+
+	if (!data) {
+		matrix_mdev->kvm = NULL;
+		return NOTIFY_OK;
+	}
+
+	ret = vfio_ap_mdev_open_once(matrix_mdev, data);
+	if (ret)
+		return NOTIFY_DONE;
+
+	matrix_mdev->kvm = data;
+
+	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
+	if (ret)
+		return ret;
+
+	vfio_ap_mdev_copy_masks(matrix_mdev);
+
+	return NOTIFY_OK;
+}
+
+static int vfio_ap_mdev_open(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long events;
+	int ret;
+
+
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
+	events = VFIO_GROUP_NOTIFY_SET_KVM;
+
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				     &events, &matrix_mdev->group_notifier);
+	if (ret) {
+		module_put(THIS_MODULE);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void vfio_ap_mdev_release(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	if (matrix_mdev->kvm)
+		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
+
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				 &matrix_mdev->group_notifier);
+	matrix_mdev->kvm = NULL;
+	module_put(THIS_MODULE);
+}
+
 static const struct mdev_parent_ops vfio_ap_matrix_ops = {
 	.owner			= THIS_MODULE,
 	.supported_type_groups	= vfio_ap_mdev_type_groups,
 	.mdev_attr_groups	= vfio_ap_mdev_attr_groups,
 	.create			= vfio_ap_mdev_create,
 	.remove			= vfio_ap_mdev_remove,
+	.open			= vfio_ap_mdev_open,
+	.release		= vfio_ap_mdev_release,
 };
 
 int vfio_ap_mdev_register(void)
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index a2eab78..ebad5db 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -71,10 +71,15 @@ struct ap_matrix {
  * @list:	allows the ap_matrix_mdev struct to be added to a list
  * @matrix:	the adapters, usage domains and control domains assigned to the
  *		mediated matrix device.
+ * @group_notifier: notifier block used for specifying callback function for
+ *		    handling the VFIO_GROUP_NOTIFY_SET_KVM event
+ * @kvm:	the struct holding guest's state
  */
 struct ap_matrix_mdev {
 	struct list_head node;
 	struct ap_matrix matrix;
+	struct notifier_block group_notifier;
+	struct kvm *kvm;
 };
 
 extern int vfio_ap_mdev_register(void);
-- 
1.7.1

