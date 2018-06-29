Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94EBC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CE627FC6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CE627FC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935726AbeF2VO7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:14:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S937547AbeF2VME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:12:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5TLA32Y073219
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:12:03 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jwst5wm5u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:12:03 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Fri, 29 Jun 2018 17:12:03 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Jun 2018 17:12:00 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5TLBwww6750678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jun 2018 21:11:58 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34E81124054;
        Fri, 29 Jun 2018 18:13:27 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 218AE124052;
        Fri, 29 Jun 2018 18:13:26 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.157.42])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Jun 2018 18:13:26 -0400 (EDT)
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
        akrowiak@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v6 14/21] s390: vfio-ap: implement mediated device open callback
Date:   Fri, 29 Jun 2018 17:11:16 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062921-0072-0000-0000-00000377598E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009278; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01054189; UDB=6.00540581; IPR=6.00832111;
 MB=3.00021933; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-29 21:12:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062921-0073-0000-0000-00004888EAE1
Message-Id: <1530306683-7270-15-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806290224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements the open callback on the mediated matrix device.
The function registers a group notifier to receive notification
of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
the vfio_ap device driver will get access to the guest's
kvm structure. The open callback must ensure that only one
mediated device shall be opened per guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     |  128 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |    2 +
 2 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index bc7398d..58be495 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -11,6 +11,10 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/ctype.h>
+#include <linux/bitops.h>
+#include <linux/kvm_host.h>
+#include <linux/module.h>
+#include <asm/kvm.h>
 
 #include "vfio_ap_private.h"
 
@@ -748,12 +752,136 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 	NULL
 };
 
+/**
+ * Verify that the AP instructions are available on the guest and are to be
+ * interpreted by the firmware. The former is indicated via the
+ * KVM_S390_VM_CPU_FEAT_AP CPU model feature and the latter by apie crypto
+ * flag.
+ */
+static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
+{
+	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat) &&
+	    kvm->arch.crypto.apie)
+		return 0;
+
+	pr_err("%s: interpretation of AP instructions not available",
+	       VFIO_AP_MODULE_NAME);
+
+	return -EOPNOTSUPP;
+}
+
+static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
+		matrix_mdev = container_of(nb, struct ap_matrix_mdev,
+					   group_notifier);
+		matrix_mdev->kvm = data;
+	}
+
+	return NOTIFY_OK;
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
+static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev)
+{
+	int ret = 0;
+	struct ap_matrix_mdev *lstdev;
+
+	spin_lock_bh(&mdev_list_lock);
+
+	list_for_each_entry(lstdev, &mdev_list, list) {
+		if ((lstdev->kvm == matrix_mdev->kvm) &&
+		    (lstdev != matrix_mdev)) {
+			ret = -EPERM;
+			break;
+		}
+	}
+
+	if (ret) {
+		pr_err("%s: mdev %s open failed for guest %s",
+		       VFIO_AP_MODULE_NAME, matrix_mdev->name,
+		       matrix_mdev->kvm->arch.dbf->name);
+		pr_err("%s: mdev %s already opened for guest %s",
+		       VFIO_AP_MODULE_NAME, lstdev->name,
+		       lstdev->kvm->arch.dbf->name);
+	}
+
+	spin_unlock_bh(&mdev_list_lock);
+	return ret;
+}
+
+static int vfio_ap_mdev_open(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_dev *matrix_dev =
+		to_ap_matrix_dev(mdev_parent_dev(mdev));
+	unsigned long events;
+	int ret;
+
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	ret = vfio_ap_verify_queues_reserved(matrix_dev, matrix_mdev->name,
+					     &matrix_mdev->matrix);
+	if (ret)
+		goto out_err;
+
+	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
+	events = VFIO_GROUP_NOTIFY_SET_KVM;
+
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				     &events, &matrix_mdev->group_notifier);
+	if (ret)
+		goto out_err;
+
+	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
+	if (ret)
+		goto out_kvm_err;
+
+	ret = vfio_ap_mdev_open_once(matrix_mdev);
+	if (ret)
+		goto out_kvm_err;
+
+	return 0;
+
+out_kvm_err:
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				 &matrix_mdev->group_notifier);
+	matrix_mdev->kvm = NULL;
+out_err:
+	module_put(THIS_MODULE);
+
+	return ret;
+}
+
+static void vfio_ap_mdev_release(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
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
 
 int vfio_ap_mdev_register(struct ap_matrix_dev *matrix_dev)
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index ae771f5..7792b45 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -56,6 +56,8 @@ struct ap_matrix_mdev {
 	const char *name;
 	struct list_head list;
 	struct ap_matrix matrix;
+	struct notifier_block group_notifier;
+	struct kvm *kvm;
 };
 
 static struct ap_matrix_dev *to_ap_matrix_dev(struct device *dev)
-- 
1.7.1

