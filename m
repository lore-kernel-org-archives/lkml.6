Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBACC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E173327FF6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E173327FF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936334AbeF2VPw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:15:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753973AbeF2VL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:11:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5TL9Khq055624
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:11:58 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jwry87qb2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:11:57 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Fri, 29 Jun 2018 17:11:56 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Jun 2018 17:11:53 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5TLBpKA10355226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jun 2018 21:11:51 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBA26124052;
        Fri, 29 Jun 2018 18:13:20 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A685D124054;
        Fri, 29 Jun 2018 18:13:19 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.157.42])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Jun 2018 18:13:19 -0400 (EDT)
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
Subject: [PATCH v6 11/21] s390: vfio-ap: sysfs interfaces to configure domains
Date:   Fri, 29 Jun 2018 17:11:13 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062921-0068-0000-0000-0000031061FF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009278; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01054189; UDB=6.00540581; IPR=6.00832112;
 MB=3.00021933; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-29 21:11:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062921-0069-0000-0000-000044DB042D
Message-Id: <1530306683-7270-12-git-send-email-akrowiak@linux.vnet.ibm.com>
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

Provides the sysfs interfaces for assigning AP domains to
and unassigning AP domains from a mediated matrix device.

An AP domain ID corresponds to an AP queue index (APQI). For
each domain assigned to the mediated matrix device, its
corresponging APQI is stored in an AP queue mask (AQM).
The bits in the AQM, from most significant to least
significant bit, correspond to AP domain numbers 0 to 255.
When a domain is assigned, the bit corresponding to its
APQI will be set in the AQM. Likewise, when a domain is
unassigned, the bit corresponding to its APQI will be
cleared from the AQM.

The relevant sysfs structures are:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
...............[$uuid]
.................. assign_domain
.................. unassign_domain

To assign a domain to the $uuid mediated matrix device,
write the domain's ID to the assign_domain file. To
unassign a domain, write the domain's ID to the
unassign_domain file. The ID is specified using
conventional semantics: If it begins with 0x, the number
will be parsed as a hexadecimal (case insensitive) number;
if it begins with 0, it will be parsed as an octal number;
otherwise, it will be parsed as a decimal number.

For example, to assign domain 173 (0xad) to the mediated matrix
device $uuid:

	echo 173 > assign_domain

	or

	echo 0255 > assign_domain

	or

	echo 0xad > assign_domain

To unassign domain 173 (0xad):

	echo 173 > unassign_domain

	or

	echo 0255 > unassign_domain

	or

	echo 0xad > unassign_domain

The assignment will be rejected:

* If the domain ID exceeds the maximum value for an AP domain:

  * If the AP Extended Addressing (APXA) facility is installed,
    the max value is 255

  * Else the max value is 15

* If no AP adapters have yet been assigned and there are
  no AP queues reserved by the VFIO AP driver that have an APQN
  with an APQI matching that of the AP domain number being
  assigned.

* If any of the APQNs that can be derived from the intersection
  of the APQI being assigned and the AP adapter ID (APID) of
  each of the AP adapters previously assigned can not be matched
  with an APQN of an AP queue device reserved by the VFIO AP
  driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |  173 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 172 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a4351bd..a5b06e7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -170,6 +170,27 @@ static int vfio_ap_queue_has_apid(struct device *dev, void *data)
 }
 
 /**
+ * vfio_ap_queue_has_apqi
+ *
+ * @dev: an AP queue device
+ * @data: an AP queue index
+ *
+ * Flags whether any AP queue device has a particular AP queue index
+ *
+ * Returns 0 to indicate the function succeeded
+ */
+static int vfio_ap_queue_has_apqi(struct device *dev, void *data)
+{
+	struct vfio_id_reserved *id_res = data;
+	struct ap_queue *ap_queue = to_ap_queue(dev);
+
+	if (id_res->id == AP_QID_QUEUE(ap_queue->qid))
+		id_res->reserved = true;
+
+	return 0;
+}
+
+/**
  * vfio_ap_verify_qid_reserved
  *
  * @matrix_dev: a mediated matrix device
@@ -236,6 +257,42 @@ static int vfio_ap_verify_apid_reserved(struct ap_matrix_dev *matrix_dev,
 	return -EPERM;
 }
 
+/**
+ * vfio_ap_verify_apqi_reserved
+ *
+ * @matrix_dev: a mediated matrix device
+ * @apqi: an AP queue index
+ *
+ * Verifies that an AP queue with @apqi is reserved by the VFIO AP device
+ * driver.
+ *
+ * Returns 0 if an AP queue with @apqi is reserved; otherwise, returns -ENODEV.
+ */
+static int vfio_ap_verify_apqi_reserved(struct ap_matrix_dev *matrix_dev,
+					const char *mdev_name,
+					unsigned long apqi)
+{
+	int ret;
+	struct vfio_id_reserved id_res;
+
+	id_res.id = apqi;
+	id_res.reserved = false;
+
+	ret = driver_for_each_device(matrix_dev->device.driver, NULL, &id_res,
+				     vfio_ap_queue_has_apqi);
+	if (ret)
+		return ret;
+
+	if (id_res.reserved)
+		return 0;
+
+	pr_err("%s: mdev %s using queue %04lx not reserved by %s driver",
+					VFIO_AP_MODULE_NAME, mdev_name, apqi,
+					VFIO_AP_DRV_NAME);
+
+	return -EPERM;
+}
+
 static int vfio_ap_verify_queues_reserved(struct ap_matrix_dev *matrix_dev,
 					  const char *mdev_name,
 					  struct ap_matrix *matrix)
@@ -417,10 +474,124 @@ static ssize_t unassign_adapter_store(struct device *dev,
 }
 DEVICE_ATTR_WO(unassign_adapter);
 
+/**
+ * vfio_ap_validate_apqi
+ *
+ * @matrix_mdev: the mediated matrix device
+ * @apqi: the APQI (domain ID) to validate
+ *
+ * Validates the value of @apqi:
+ *	* If there are no AP adapters assigned, then there must be at least
+ *	  one AP queue device reserved by the VFIO AP device driver with an
+ *	  APQN containing @apqi.
+ *
+ *	* Else each APQN that can be derived from the cross product of @apqi and
+ *	  the IDs of the AP adapters already assigned must identify an AP queue
+ *	  that has been reserved by the VFIO AP device driver.
+ *
+ * Returns 0 if the value of @apqi is valid; otherwise, returns an error.
+ */
+static int vfio_ap_validate_apqi(struct mdev_device *mdev,
+				 struct ap_matrix_mdev *matrix_mdev,
+				 unsigned long apqi)
+{
+	int ret;
+	unsigned long apmsz = matrix_mdev->matrix.apm_max + 1;
+	struct device *dev = mdev_parent_dev(mdev);
+	struct ap_matrix_dev *matrix_dev = to_ap_matrix_dev(dev);
+	struct ap_matrix matrix = matrix_mdev->matrix;
+
+	/* If there are any adapters assigned to the mediated device */
+	if (find_first_bit_inv(matrix.apm, apmsz) < apmsz) {
+		matrix.apm_max = matrix_mdev->matrix.apm_max;
+		memcpy(matrix.apm, matrix_mdev->matrix.apm,
+		       ARRAY_SIZE(matrix.apm) * sizeof(matrix.apm[0]));
+		matrix.aqm_max = matrix_mdev->matrix.aqm_max;
+		memset(matrix.aqm, 0,
+		       ARRAY_SIZE(matrix.aqm) * sizeof(matrix.aqm[0]));
+		set_bit_inv(apqi, matrix.aqm);
+		ret = vfio_ap_verify_queues_reserved(matrix_dev,
+						     matrix_mdev->name,
+						     &matrix);
+	} else {
+		ret = vfio_ap_verify_apqi_reserved(matrix_dev,
+						   matrix_mdev->name, apqi);
+	}
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static ssize_t assign_domain_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int ret;
+	unsigned long apqi;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
+
+	ret = kstrtoul(buf, 0, &apqi);
+	if (ret || (apqi > max_apqi)) {
+		pr_err("%s: %s: domain id '%s' not a value from 0 to %02lu(%#04lx)",
+		       VFIO_AP_MODULE_NAME, __func__, buf, max_apqi, max_apqi);
+
+		return ret ? ret : -EINVAL;
+	}
+
+	ret = vfio_ap_validate_apqi(mdev, matrix_mdev, apqi);
+	if (ret)
+		return ret;
+
+	/* Set the bit in the AQM (bitmask) corresponding to the AP domain
+	 * number (APQI). The bits in the mask, from most significant to least
+	 * significant, correspond to numbers 0-255.
+	 */
+	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
+
+	return count;
+}
+DEVICE_ATTR_WO(assign_domain);
+
+static ssize_t unassign_domain_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int ret;
+	unsigned long apqi;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
+
+	ret = kstrtoul(buf, 0, &apqi);
+	if (ret || (apqi > max_apqi)) {
+		pr_err("%s: %s: domain id '%s' not a value from 0 to %02lu(%#04lx)",
+		       VFIO_AP_MODULE_NAME, __func__, buf, max_apqi, max_apqi);
+
+		return ret ? ret : -EINVAL;
+	}
+
+	if (!test_bit_inv(apqi, matrix_mdev->matrix.aqm)) {
+		pr_err("%s: %s: domain %02lu(%#04lx) not assigned",
+		       VFIO_AP_MODULE_NAME, __func__, apqi, apqi);
+		return -ENODEV;
+	}
+
+	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
+
+	return count;
+}
+DEVICE_ATTR_WO(unassign_domain);
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
-	NULL
+	&dev_attr_assign_domain.attr,
+	&dev_attr_unassign_domain.attr,
+	NULL,
 };
 
 static struct attribute_group vfio_ap_mdev_attr_group = {
-- 
1.7.1

