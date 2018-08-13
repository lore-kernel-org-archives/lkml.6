Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C57C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DFA21470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DFA21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbeHNAdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:33:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731223AbeHNAdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:33:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7DLn7E9081885
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:49:09 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kuekh0esx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:49:08 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Mon, 13 Aug 2018 17:49:02 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Aug 2018 17:48:58 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7DLmuL352494380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Aug 2018 21:48:56 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C619124053;
        Mon, 13 Aug 2018 18:49:55 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36CBF124054;
        Mon, 13 Aug 2018 18:49:54 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.141.105])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Aug 2018 18:49:54 -0400 (EDT)
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
Subject: [PATCH v9 15/22] s390: vfio-ap: implement mediated device open callback
Date:   Mon, 13 Aug 2018 17:48:12 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081321-0040-0000-0000-0000045E55BF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009538; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073087; UDB=6.00552882; IPR=6.00853043;
 MB=3.00022698; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-13 21:49:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081321-0041-0000-0000-000008655D8D
Message-Id: <1534196899-16987-16-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808130219
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
 drivers/s390/crypto/vfio_ap_ops.c     |  174 ++++++++++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |    2 +
 2 files changed, 175 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index af3b55f..280bd17 100644
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
 
 #include "vfio_ap_private.h"
 
@@ -55,6 +59,9 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	mutex_lock(&matrix_dev.lock);
 	list_del(&matrix_mdev->list);
 	mutex_unlock(&matrix_dev.lock);
@@ -291,6 +298,10 @@ static ssize_t assign_adapter_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_apid = matrix_mdev->matrix.apm_max;
 
+	/* If the guest is running, disallow assignment of adapter */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -348,6 +359,10 @@ static ssize_t unassign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	/* If the guest is running, disallow un-assignment of adapter */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -393,6 +408,10 @@ static ssize_t assign_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
 
+	/* If the guest is running, disallow assignment of domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -432,6 +451,10 @@ static ssize_t unassign_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	/* If the guest is running, disallow un-assignment of domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -470,6 +493,10 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long maxid = matrix_mdev->matrix.adm_max;
 
+	/* If the guest is running, disallow assignment of control domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &id);
 	if (ret)
 		return ret;
@@ -514,6 +541,10 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
 
+	/* If the guest is running, disallow un-assignment of control domain */
+	if (matrix_mdev->kvm)
+		return -EBUSY;
+
 	ret = kstrtoul(buf, 0, &domid);
 	if (ret)
 		return ret;
@@ -602,7 +633,6 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 }
 DEVICE_ATTR_RO(matrix);
 
-
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
@@ -624,12 +654,154 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
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
+static void kvm_ap_merge_bitmasks(unsigned long *dst, unsigned long *mask1,
+				  unsigned long *mask2, unsigned long nbits)
+{
+	int i;
+
+	for (i = 0; i < BITS_TO_LONGS(nbits); i++)
+		dst[i] = mask1[i] | mask2[i];
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
+	kvm_ap_merge_bitmasks(adm, aqm, adm, matrix_mdev->matrix.adm_max + 1);
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
+	mutex_lock(&matrix_dev.lock);
+
+	list_for_each_entry(m, &matrix_dev.mdev_list, list) {
+		if ((m != matrix_mdev) && (m->kvm == matrix_mdev->kvm)) {
+			mutex_unlock(&matrix_dev.lock);
+			return -EPERM;
+		}
+	}
+
+	mutex_unlock(&matrix_dev.lock);
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
+	matrix_mdev->kvm = data;
+	if (data == NULL)
+		return NOTIFY_OK;
+
+	ret = vfio_ap_mdev_open_once(matrix_mdev, data);
+	if (ret)
+		return ret;
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
index aa0d195..3e8534b 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -67,6 +67,8 @@ struct ap_matrix_mdev {
 	const char *name;
 	struct list_head list;
 	struct ap_matrix matrix;
+	struct notifier_block group_notifier;
+	struct kvm *kvm;
 };
 
 extern int vfio_ap_mdev_register(void);
-- 
1.7.1

