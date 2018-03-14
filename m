Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbeCNS1U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:27:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932240AbeCNS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:26:57 -0400
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
Subject: [PATCH v3 13/14] s390: vfio-ap: implement VFIO_DEVICE_GET_INFO ioctl
Date: Wed, 14 Mar 2018 14:25:53 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031418-0012-0000-0000-000015E5511B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003025; UDB=6.00510424; IPR=6.00782355;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 18:26:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031418-0013-0000-0000-000051DE9E12
Message-Id: <1521051954-25715-14-git-send-email-akrowiak@linux.vnet.ibm.com>
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

Introduces ioctl access to the VFIO AP Matrix device driver
by implementing the VFIO_DEVICE_GET_INFO ioctl. This ioctl
provides the VFIO AP Matrix device driver information to the
guest machine.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |   43 +++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index c7911da..7223a1c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -101,6 +101,48 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 				 &matrix_mdev->group_notifier);
 }
 
+static int vfio_ap_mdev_get_device_info(unsigned long arg)
+{
+	unsigned long minsz;
+	struct vfio_device_info info;
+
+	minsz = offsetofend(struct vfio_device_info, num_irqs);
+
+	if (copy_from_user(&info, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (info.argsz < minsz) {
+		pr_err("%s: Argument size %u less than min size %li",
+		       VFIO_AP_MATRIX_MODULE_NAME, info.argsz, minsz);
+		return -EINVAL;
+	}
+
+	info.flags = VFIO_DEVICE_FLAGS_AP;
+	info.num_regions = 0;
+	info.num_irqs = 0;
+
+	return copy_to_user((void __user *)arg, &info, minsz);
+}
+
+static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
+				    unsigned int cmd, unsigned long arg)
+{
+	int ret;
+
+	switch (cmd) {
+	case VFIO_DEVICE_GET_INFO:
+		ret = vfio_ap_mdev_get_device_info(arg);
+		break;
+	default:
+		pr_err("%s: ioctl command %d is not a supported command",
+		       VFIO_AP_MATRIX_MODULE_NAME, cmd);
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
 static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
 {
 	return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
@@ -807,6 +849,7 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 	.remove			= vfio_ap_mdev_remove,
 	.open			= vfio_ap_mdev_open,
 	.release		= vfio_ap_mdev_release,
+	.ioctl			= vfio_ap_mdev_ioctl,
 };
 
 int vfio_ap_mdev_register(struct ap_matrix *ap_matrix)
-- 
1.7.1
