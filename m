Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753969AbeB0Oeq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:34:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753618AbeB0Oao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:30:44 -0500
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v2 12/15] s390: vfio-ap: sysfs interface to view matrix mdev matrix
Date: Tue, 27 Feb 2018 09:28:10 -0500
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022714-0012-0000-0000-000015CFC906
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995862; UDB=6.00506230; IPR=6.00775186;
 MB=3.00019761; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-27 14:29:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022714-0013-0000-0000-000051A8E797
Message-Id: <1519741693-17440-13-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270183
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
 drivers/s390/crypto/vfio_ap_ops.c |   39 +++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 461d450..04f7a92 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -692,6 +692,44 @@ static ssize_t control_domains_show(struct device *dev,
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
+	n = sprintf(bufpos, "ADAPTER.DOMAIN\n");
+	bufpos += n;
+	nchars += n;
+
+	n = sprintf(bufpos, "--------------\n");
+	bufpos += n;
+	nchars += n;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix->apm,
+			     matrix_mdev->matrix->apm_max) {
+		n = sprintf(bufpos, "%02lx\n", apid);
+		bufpos += n;
+		nchars += n;
+
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
@@ -700,6 +738,7 @@ static ssize_t control_domains_show(struct device *dev,
 	&dev_attr_assign_control_domain.attr,
 	&dev_attr_unassign_control_domain.attr,
 	&dev_attr_control_domains.attr,
+	&dev_attr_matrix.attr,
 	NULL,
 };
 
-- 
1.7.1
