Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeEGPPB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:15:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752524AbeEGPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:12:35 -0400
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
Subject: [PATCH v5 09/13] s390: vfio-ap: sysfs interfaces to configure control domains
Date: Mon,  7 May 2018 11:11:48 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050715-0028-0000-0000-000009913E93
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008987; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01028858; UDB=6.00525678; IPR=6.00807992;
 MB=3.00020972; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-07 15:12:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050715-0029-0000-0000-00003AB3EB5D
Message-Id: <1525705912-12815-10-git-send-email-akrowiak@linux.vnet.ibm.com>
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
if it begins with 0, it is parsed as an octal number;
otherwise, it will be parsed as a decimal number.

For example, to assign control domain 173 (0xad) to the mediated
matrix device $uuid:

	echo 173 > assign_control_domain

	or

	echo 0255 > assign_control_domain

	or

	echo 0xad > assign_control_domain

To unassign control domain 173 (0xad):

	echo 173 > unassign_control_domain

	or

	echo 0255 > unassign_control_domain

	or

	echo 0xad > unassign_control_domain

The assignment will be rejected if the APQI exceeds the maximum
value for an AP domain:
  * If the AP Extended Addressing (APXA) facility is installed,
    the max value is 255
  * Else the max value is 15

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |  114 +++++++++++++++++++++++++++++++++++++
 1 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 5c232de..755be1d 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -605,11 +605,125 @@ static ssize_t unassign_domain_store(struct device *dev,
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
+	unsigned long maxid = vfio_ap_max_domain_id();
+
+	ret = kstrtoul(buf, 0, &id);
+	if (ret || (id > maxid)) {
+		pr_err("%s: %s: control domain id '%s' not a value from 0 to %02lu(%#04lx)",
+		       VFIO_AP_MODULE_NAME, __func__, buf, maxid, maxid);
+
+		return ret ? ret : -EINVAL;
+	}
+
+	/* Set the bit in the ADM (bitmask) corresponding to the AP control
+	 * domain number (id). The bits in the mask, from most significant to
+	 * least significant, correspond to IDs 0 up to the one less than the
+	 * number of control domains that can be assigned.
+	 */
+	set_bit_inv(id, matrix_mdev->matrix.adm);
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
+	unsigned long domid;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
+
+	ret = kstrtoul(buf, 0, &domid);
+	if (ret || (domid > max_domid)) {
+		pr_err("%s: %s: control domain id '%s' not a value from 0 to %02lu(%#04lx)",
+		       VFIO_AP_MODULE_NAME, __func__, buf,
+		       max_domid, max_domid);
+
+		return ret ? ret : -EINVAL;
+	}
+
+	if (!test_bit_inv(domid, matrix_mdev->matrix.adm)) {
+		pr_err("%s: %s: control domain id %02lu(%#04lx) is not assigned",
+		       VFIO_AP_MODULE_NAME, __func__, domid, domid);
+
+		return -ENODEV;
+	}
+
+	clear_bit_inv(domid, matrix_mdev->matrix.adm);
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
+	unsigned long max_apqi = matrix_mdev->matrix.apm_max;
+
+	for_each_set_bit_inv(id, matrix_mdev->matrix.adm, max_apqi + 1) {
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
