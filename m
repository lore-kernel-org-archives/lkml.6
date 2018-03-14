Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932311AbeCNS06 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:26:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752697AbeCNS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:26:53 -0400
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        akrowiak@linux.vnet.ibm.com
Subject: [PATCH v3 12/14] KVM: s390: configure the guest's AP devices
Date: Wed, 14 Mar 2018 14:25:52 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031418-0012-0000-0000-000015E55118
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003025; UDB=6.00510424; IPR=6.00782355;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 18:26:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031418-0013-0000-0000-000051DE9E04
Message-Id: <1521051954-25715-13-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140201
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registers a group notifier during the open of the mediated
matrix device to get information on KVM presence through the
VFIO_GROUP_NOTIFY_SET_KVM event. When notified, the pointer
to the kvm structure is saved inside the mediated matrix
device. Once the VFIO AP device driver has access to KVM,
the AP matrix for the guest can be configured.

Guest access to AP adapters, usage domains and control domains
is controlled by three bit masks referenced from the
Crypto Control Block (CRYCB) referenced from the guest's SIE state
description:

  * The AP Mask (APM) controls access to the AP adapters. Each bit
    in the APM represents an adapter number - from most significant
    to least significant bit - from 0 to 255. The bits in the APM
    are set according to the adapter numbers assigned to the mediated
    matrix device via its 'assign_adapter' sysfs attribute file.

  * The AP Queue (AQM) controls access to the AP queues. Each bit
    in the AQM represents an AP queue index - from most significant
    to least significant bit - from 0 to 255. A queue index references
    a specific domain and is synonymous with the domian number. The
    bits in the AQM are set according to the domain numbers assigned
    to the mediated matrix device via its 'assign_domain' sysfs
    attribute file.

  * The AP Domain Mask (ADM) controls access to the AP control domains.
    Each bit in the ADM represents a control domain - from most
    significant to least significant bit - from 0-255. The
    bits in the ADM are set according to the domain numbers assigned
    to the mediated matrix device via its 'assign_control_domain'
    sysfs attribute file.

The guest will be configured when the file descriptor for the mediated
matrix device is opened. If AP interpretive execution (APIE) is
not turned on for the guest, then the open will fail since the
VFIO AP device driver is dependent upon APIE.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm-ap.h        |    2 +
 arch/s390/kvm/kvm-ap.c                |   14 +++++++++
 drivers/s390/crypto/vfio_ap_ops.c     |   50 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |    2 +
 4 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
index 679e026..e2d45ed 100644
--- a/arch/s390/include/asm/kvm-ap.h
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -48,6 +48,8 @@ struct kvm_ap_matrix {
 
 void kvm_ap_matrix_destroy(struct kvm_ap_matrix *ap_matrix);
 
+int kvm_ap_instructions_interpreted(struct kvm *kvm);
+
 int kvm_ap_configure_matrix(struct kvm *kvm, struct kvm_ap_matrix *matrix);
 
 void kvm_ap_deconfigure_matrix(struct kvm *kvm);
diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
index eb365e2..c331d53 100644
--- a/arch/s390/kvm/kvm-ap.c
+++ b/arch/s390/kvm/kvm-ap.c
@@ -268,6 +268,20 @@ void kvm_ap_matrix_destroy(struct kvm_ap_matrix *ap_matrix)
 EXPORT_SYMBOL(kvm_ap_matrix_destroy);
 
 /**
+ * kvm_ap_instructions_interpreted
+ *
+ * Indicates whether AP instructions are being interpreted on the guest
+ *
+ * Returns 1 if instructions are being interpreted; otherwise, returns 0
+ */
+int kvm_ap_instructions_interpreted(struct kvm *kvm)
+{
+	return test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP) &&
+				 kvm->arch.crypto.apie;
+}
+EXPORT_SYMBOL(kvm_ap_instructions_interpreted);
+
+/**
  * kvm_ap_configure_matrix
  *
  * Configure the AP matrix for a KVM guest.
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 04f7a92..c7911da 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -53,6 +53,54 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 	return 0;
 }
 
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
+static int vfio_ap_mdev_open(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long events;
+	int ret;
+
+	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
+	events = VFIO_GROUP_NOTIFY_SET_KVM;
+
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				     &events, &matrix_mdev->group_notifier);
+	if (ret)
+		return ret;
+
+	if (!kvm_ap_instructions_interpreted(matrix_mdev->kvm))
+		return -EOPNOTSUPP;
+
+	ret = kvm_ap_configure_matrix(matrix_mdev->kvm,
+				      matrix_mdev->matrix);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static void vfio_ap_mdev_release(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	kvm_ap_deconfigure_matrix(matrix_mdev->kvm);
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				 &matrix_mdev->group_notifier);
+}
+
 static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
 {
 	return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
@@ -757,6 +805,8 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 	.mdev_attr_groups	= vfio_ap_mdev_attr_groups,
 	.create			= vfio_ap_mdev_create,
 	.remove			= vfio_ap_mdev_remove,
+	.open			= vfio_ap_mdev_open,
+	.release		= vfio_ap_mdev_release,
 };
 
 int vfio_ap_mdev_register(struct ap_matrix *ap_matrix)
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index f6e7ed1..1133735 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -32,6 +32,8 @@ struct ap_matrix {
 
 struct ap_matrix_mdev {
 	struct kvm_ap_matrix *matrix;
+	struct notifier_block group_notifier;
+	struct kvm *kvm;
 };
 
 static inline struct ap_matrix *to_ap_matrix(struct device *dev)
-- 
1.7.1
