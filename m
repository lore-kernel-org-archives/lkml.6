Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F260AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A282F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A282F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeIZF1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:27:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbeIZF1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:27:37 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PNET9r078567
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:17:43 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mqv8bcx5x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:17:43 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 17:17:42 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 17:17:39 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PNHagj22478860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 16:17:36 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0218136051;
        Tue, 25 Sep 2018 17:17:35 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE19213604F;
        Tue, 25 Sep 2018 17:17:32 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.192.224])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Sep 2018 17:17:32 -0600 (MDT)
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
Subject: [PATCH v11 11/26] s390: vfio-ap: implement mediated device open callback
Date:   Tue, 25 Sep 2018 19:16:26 -0400
X-Mailer: git-send-email 2.19.0.221.g150f307
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092523-0036-0000-0000-00000A3EBF10
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009771; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093642; UDB=6.00565266; IPR=6.00873680;
 MB=3.00023503; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 23:17:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092523-0037-0000-0000-000049117EFA
Message-Id: <20180925231641.4954-12-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250227
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
---
 arch/s390/include/asm/kvm_host.h      |   1 +
 drivers/s390/crypto/vfio_ap_ops.c     | 159 ++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   5 +
 3 files changed, 165 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 0a78036a802b..36d35313e840 100644
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
index 61a5fa7ad40d..89fbcde8dc98 100644
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
@@ -305,6 +312,10 @@ static ssize_t assign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	/* If the guest is running, disallow assignment of adapter */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -366,6 +377,10 @@ static ssize_t unassign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	/* If the guest is running, disallow un-assignment of adapter */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -443,6 +458,10 @@ static ssize_t assign_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
 
+	/* If the guest is running, disallow assignment of domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -500,6 +519,10 @@ static ssize_t unassign_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	/* If the guest is running, disallow un-assignment of domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -540,6 +563,10 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	/* If the guest is running, disallow assignment of control domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &id);
 	if (ret)
 		return ret;
@@ -586,6 +613,10 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
 
+	/* If the guest is running, disallow un-assignment of control domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &domid);
 	if (ret)
 		return ret;
@@ -695,12 +726,140 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 	NULL
 };
 
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
+ * vfio_ap_mdev_set_kvm
+ *
+ * @matrix_mdev: a mediated matrix device
+ * @kvm: reference to KVM instance
+ *
+ * Verifies no other mediated matrix device has @kvm and sets a reference to
+ * it in @matrix_mdev->kvm.
+ *
+ * Return 0 if no other mediated matrix device has a reference to @kvm;
+ * otherwise, returns an -EPERM.
+ */
+static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
+				struct kvm *kvm)
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
+	matrix_mdev->kvm = kvm;
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
+	ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
+	if (ret)
+		return NOTIFY_DONE;
+
+	/* If there is no CRYCB pointer, then we can't copy the masks */
+	if (!matrix_mdev->kvm->arch.crypto.crycbd)
+		return NOTIFY_DONE;
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
index 9f197ffab7ad..5675492233c7 100644
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
2.19.0.221.g150f307

