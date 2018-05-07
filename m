Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeEGPO6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:14:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751976AbeEGPMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:12:39 -0400
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
Subject: [PATCH v5 10/13] s390: vfio-ap: sysfs interface to view matrix mdev matrix
Date: Mon,  7 May 2018 11:11:49 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050715-8235-0000-0000-00000D713EBC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008987; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01028859; UDB=6.00525678; IPR=6.00807992;
 MB=3.00020972; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-07 15:12:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050715-8236-0000-0000-000040D4AA68
Message-Id: <1525705912-12815-11-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070154
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides a sysfs interface to view the AP matrix configured for the
mediated matrix device.

The relevant sysfs structures are:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
...............[$uuid]
.................. matrix

To view the matrix configured for the mediated matrix device,
print the matrix file:

	cat matrix

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 755be1d..81e03b8 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -716,6 +716,36 @@ static ssize_t control_domains_show(struct device *dev,
 }
 DEVICE_ATTR_RO(control_domains);
 
+static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	char *bufpos = buf;
+	unsigned long apid;
+	unsigned long apqi;
+	unsigned long napm = matrix_mdev->matrix.apm_max + 1;
+	unsigned long naqm = matrix_mdev->matrix.aqm_max + 1;
+	int nchars = 0;
+	int n;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, napm) {
+		n = sprintf(bufpos, "%02lx\n", apid);
+		bufpos += n;
+		nchars += n;
+
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, naqm) {
+			n = sprintf(bufpos, "%02lx.%04lx\n", apid, apqi);
+			bufpos += n;
+			nchars += n;
+		}
+	}
+
+	return nchars;
+}
+DEVICE_ATTR_RO(matrix);
+
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
@@ -724,6 +754,7 @@ static ssize_t control_domains_show(struct device *dev,
 	&dev_attr_assign_control_domain.attr,
 	&dev_attr_unassign_control_domain.attr,
 	&dev_attr_control_domains.attr,
+	&dev_attr_matrix.attr,
 	NULL,
 };
 
-- 
1.7.1
