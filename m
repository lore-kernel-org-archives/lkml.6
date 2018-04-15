Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeDOVXc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:23:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753231AbeDOVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:23:04 -0400
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
Subject: [PATCH v4 14/15] s390: vfio-ap: implement VFIO_DEVICE_GET_INFO ioctl
Date: Sun, 15 Apr 2018 17:22:24 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041521-0036-0000-0000-000002E25DDD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008862; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018429; UDB=6.00519481; IPR=6.00797666;
 MB=3.00020592; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-15 21:23:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041521-0037-0000-0000-000043FEA899
Message-Id: <1523827345-11600-15-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804150214
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
index e3ff5ab..00179cd 100644
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
+		       VFIO_AP_MODULE_NAME, info.argsz, minsz);
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
+		       VFIO_AP_MODULE_NAME, cmd);
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
@@ -804,6 +846,7 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 	.remove			= vfio_ap_mdev_remove,
 	.open			= vfio_ap_mdev_open,
 	.release		= vfio_ap_mdev_release,
+	.ioctl			= vfio_ap_mdev_ioctl,
 };
 
 int vfio_ap_mdev_register(struct ap_matrix *ap_matrix)
-- 
1.7.1
