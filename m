Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeDOVX6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:23:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753187AbeDOVXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:23:00 -0400
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
Subject: [PATCH v4 12/15] s390: vfio-ap: sysfs interface to view matrix mdev matrix
Date: Sun, 15 Apr 2018 17:22:22 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041521-0052-0000-0000-000002DB5A21
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008862; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018429; UDB=6.00519481; IPR=6.00797666;
 MB=3.00020592; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-15 21:22:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041521-0053-0000-0000-00005C578077
Message-Id: <1523827345-11600-13-git-send-email-akrowiak@linux.vnet.ibm.com>
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
 drivers/s390/crypto/vfio_ap_ops.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 413ecbb..bc2b05e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -701,6 +701,32 @@ static ssize_t control_domains_show(struct device *dev,
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
+	int nchars = 0;
+	int n;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix->apm,
+			     matrix_mdev->matrix->apm_max) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix->aqm,
+				     matrix_mdev->matrix->aqm_max) {
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
@@ -709,6 +735,7 @@ static ssize_t control_domains_show(struct device *dev,
 	&dev_attr_assign_control_domain.attr,
 	&dev_attr_unassign_control_domain.attr,
 	&dev_attr_control_domains.attr,
+	&dev_attr_matrix.attr,
 	NULL,
 };
 
-- 
1.7.1
