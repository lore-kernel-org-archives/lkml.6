Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753398AbeDOVYA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:24:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753196AbeDOVXA (ORCPT
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
Subject: [PATCH v4 11/15] s390: vfio-ap: sysfs interfaces to configure control domains
Date: Sun, 15 Apr 2018 17:22:21 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041521-0036-0000-0000-000002E25DDC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008862; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018429; UDB=6.00519481; IPR=6.00797666;
 MB=3.00020592; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-15 21:22:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041521-0037-0000-0000-000043FEA892
Message-Id: <1523827345-11600-12-git-send-email-akrowiak@linux.vnet.ibm.com>
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

Provides the sysfs interfaces for assigning AP control domains
to and unassigning AP control domains from a mediated matrix device.

The IDs of the AP control domains assigned to the mediated matrix
device are stored in an AP domain mask (ADM). The bits in the ADM,
from most significant to least significant bit, correspond to
AP domain numbers 0 to 255. When a control domain is assigned,
the bit corresponding its domain ID will be set in the ADM.
Likewise, when a domain is unassigned, the bit corresponding
to its domain ID will be cleared in the ADM.

The relevant sysfs structures are:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
...............[$uuid]
.................. assign_control_domain
.................. unassign_control_domain

To assign a control domain to the $uuid mediated matrix device's
ADM, write its domain number to the assign_control_domain file.
To unassign a domain, write its domain number to the
unassign_control_domain file. The domain number is specified
using conventional semantics: If it begins with 0x the number
will be parsed as a hexadecimal (case insensitive) number;
otherwise, it will be parsed as a decimal number.

For example, to assign control domain 173 (0xad) to the mediated
matrix device $uuid:

	echo 173 > assign_control_domain

	or

	echo 0xad > assign_control_domain

To unassign control domain 173 (0xad):

	echo 173 > unassign_control_domain

	or

	echo 0xad > unassign_control_domain

The assignment will be rejected if the APQI exceeds the maximum
value for an AP domain:
  * If the AP Extended Addressing (APXA) facility is installed,
    the max value is 255
  * Else the max value is 15

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm-ap.h    |    1 +
 drivers/s390/crypto/vfio_ap_ops.c |  107 +++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
index 8ee196e..3cc305b 100644
--- a/arch/s390/include/asm/kvm-ap.h
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -19,6 +19,7 @@
 #define KVM_AP_MASK_BYTES(n)	DIV_ROUND_UP(n, BITS_PER_BYTE)
 #define KVM_AP_MAX_APM_INDEX(matrix)	(matrix->apm_max - 1)
 #define KVM_AP_MAX_AQM_INDEX(matrix)	(matrix->aqm_max - 1)
+#define KVM_AP_MAX_ADM_INDEX(matrix)	(matrix->adm_max - 1)
 
 /**
  * The AP matrix is comprised of three bit masks identifying the adapters,
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index d4f9310..413ecbb 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -597,11 +597,118 @@ static ssize_t unassign_domain_store(struct device *dev,
 }
 DEVICE_ATTR_WO(unassign_domain);
 
+
+/**
+ * assign_control_domain_store
+ *
+ * @dev: the matrix device
+ * @attr: a mediated matrix device attribute
+ * @buf: a buffer containing the adapter ID (APID) to be assigned
+ * @count: the number of bytes in @buf
+ *
+ * Parses the domain ID from @buf and assigns it to the mediated matrix device.
+ *
+ * Returns the number of bytes processed if the domain ID is valid; otherwise
+ * returns an error.
+ */
+static ssize_t assign_control_domain_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int ret;
+	unsigned long id;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	int maxid = KVM_AP_MAX_ADM_INDEX(matrix_mdev->matrix);
+
+	ret = kstrtoul(buf, 0, &id);
+	if (ret || (id > maxid)) {
+		pr_err("%s: control domain id '%s' not a value from 0 to %02d(%#04x)",
+		       VFIO_AP_MODULE_NAME, buf, maxid, maxid);
+
+		return ret ? ret : -EINVAL;
+	}
+
+	/* Set the bit in the ADM (bitmask) corresponding to the AP control
+	 * domain number (id). The bits in the mask, from most significant to
+	 * least significant, correspond to IDs 0 up to the one less than the
+	 * number of control domains that can be assigned.
+	 */
+	set_bit_inv(id, matrix_mdev->matrix->adm);
+
+	return count;
+}
+DEVICE_ATTR_WO(assign_control_domain);
+
+/**
+ * unassign_control_domain_store
+ *
+ * @dev: the matrix device
+ * @attr: a mediated matrix device attribute
+ * @buf: a buffer containing the adapter ID (APID) to be assigned
+ * @count: the number of bytes in @buf
+ *
+ * Parses the domain ID from @buf and unassigns it from the mediated matrix
+ * device.
+ *
+ * Returns the number of bytes processed if the domain ID is valid; otherwise
+ * returns an error.
+ */
+static ssize_t unassign_control_domain_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	int ret;
+	unsigned long apqi;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	int maxid = KVM_AP_MAX_ADM_INDEX(matrix_mdev->matrix);
+
+	ret = kstrtoul(buf, 0, &apqi);
+	if (ret || (apqi > maxid)) {
+		pr_err("%s: control domain id '%s' not a value from 0 to %02d(%#04x)",
+		       VFIO_AP_MODULE_NAME, buf, maxid, maxid);
+
+		return ret ? ret : -EINVAL;
+	}
+
+	clear_bit_inv((unsigned long)apqi,
+		      (unsigned long *)matrix_mdev->matrix->adm);
+
+	return count;
+}
+DEVICE_ATTR_WO(unassign_control_domain);
+
+static ssize_t control_domains_show(struct device *dev,
+				    struct device_attribute *dev_attr,
+				    char *buf)
+{
+	unsigned long id;
+	int nchars = 0;
+	int n;
+	char *bufpos = buf;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	for_each_set_bit_inv(id, matrix_mdev->matrix->adm,
+			     matrix_mdev->matrix->adm_max) {
+		n = sprintf(bufpos, "%04lx\n", id);
+		bufpos += n;
+		nchars += n;
+	}
+
+	return nchars;
+}
+DEVICE_ATTR_RO(control_domains);
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
 	&dev_attr_assign_domain.attr,
 	&dev_attr_unassign_domain.attr,
+	&dev_attr_assign_control_domain.attr,
+	&dev_attr_unassign_control_domain.attr,
+	&dev_attr_control_domains.attr,
 	NULL,
 };
 
-- 
1.7.1
