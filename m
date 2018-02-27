Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbeB0OaR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:30:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753569AbeB0OaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:30:13 -0500
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
Subject: [PATCH v2 11/15] s390: vfio-ap: sysfs interfaces to configure control domains
Date: Tue, 27 Feb 2018 09:28:09 -0500
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022714-0016-0000-0000-00000851C797
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995862; UDB=6.00506230; IPR=6.00775186;
 MB=3.00019761; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-27 14:29:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022714-0017-0000-0000-00003DA3E206
Message-Id: <1519741693-17440-12-git-send-email-akrowiak@linux.vnet.ibm.com>
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
index 191071f..4171f4b 100644
--- a/arch/s390/include/asm/kvm-ap.h
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -17,6 +17,7 @@
 #define KVM_AP_MASK_BYTES(n)(n / BITS_PER_BYTE)
 #define KVM_AP_MAX_APM_INDEX(matrix)(matrix->apm_max - 1)
 #define KVM_AP_MAX_AQM_INDEX(matrix)(matrix->aqm_max - 1)
+#define KVM_AP_MAX_ADM_INDEX(matrix)(matrix->adm_max - 1)
 
 /**
  * The AP matrix is comprised of three bit masks identifying the adapters,
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index c448835..461d450 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -588,11 +588,118 @@ static ssize_t unassign_domain_store(struct device *dev,
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
+		       VFIO_AP_MATRIX_MODULE_NAME, buf, maxid, maxid);
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
+		       VFIO_AP_MATRIX_MODULE_NAME, buf, maxid, maxid);
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
