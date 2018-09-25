Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D1BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95CA20896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95CA20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeIZF1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:27:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbeIZF1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:27:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PNEVhx060574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:17:27 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mqvmhm0qs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:17:27 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 17:17:26 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 17:17:22 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PNHJxL42336492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 16:17:19 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFA92136051;
        Tue, 25 Sep 2018 17:17:18 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEE56136065;
        Tue, 25 Sep 2018 17:17:15 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.192.224])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Sep 2018 17:17:15 -0600 (MDT)
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
        akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v11 07/26] s390: vfio-ap: sysfs interfaces to configure domains
Date:   Tue, 25 Sep 2018 19:16:22 -0400
X-Mailer: git-send-email 2.19.0.221.g150f307
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092523-0036-0000-0000-00000A3EBF06
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009771; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093642; UDB=6.00565266; IPR=6.00873680;
 MB=3.00023503; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 23:17:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092523-0037-0000-0000-000049117ECD
Message-Id: <20180925231641.4954-8-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Krowiak <akrowiak@linux.ibm.com>

Introduces two new sysfs attributes for the VFIO mediated
matrix device for assigning AP domains to and unassigning
AP domains from a mediated matrix device. The IDs of the
AP domains assigned to the mediated matrix device will be
stored in an AP queue mask (AQM).

The bits in the AQM, from most significant to least
significant bit, correspond to AP queue index (APQI) 0 to
255 (note that an APQI is synonymous with with a domain ID).
On some systems, the maximum allowable domain number may be
less than 255 - depending upon the host's AP configuration -
and assignment may be rejected if the input domain ID exceeds
the limit.

When a domain is assigned, the bit corresponding to the APQI
will be set in the AQM. Likewise, when a domain is unassigned,
the bit corresponding to the APQI will be cleared from the AQM.

In order to successfully assign a domain, the APQNs derived from
the domain ID being assigned and the adapter numbers of all
adapters previously assigned:

1. Must be bound to the vfio_ap device driver.

2. Must not be assigned to any other mediated matrix device.

If there are no adapters assigned to the mdev, then there must
be an AP queue bound to the vfio_ap device driver with an
APQN containing the domain ID (i.e., APQI), otherwise all
adapters subsequently assigned will fail because there will be no
AP queues bound with an APQN containing the APQI.

Assigning or un-assigning an AP domain will also be rejected if
a guest using the mediated matrix device is running.

The relevant sysfs structures are:

/sys/devices/vfio_ap/matrix/
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

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 138 +++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 15c5bc02c389..6f658836fb05 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -381,10 +381,146 @@ static ssize_t unassign_adapter_store(struct device *dev,
 }
 DEVICE_ATTR_WO(unassign_adapter);
 
+static int
+vfio_ap_mdev_verify_queues_reserved_for_apqi(struct ap_matrix_mdev *matrix_mdev,
+					     unsigned long apqi)
+{
+	int ret;
+	unsigned long apid;
+	unsigned long nbits = matrix_mdev->matrix.apm_max + 1;
+
+	if (find_first_bit_inv(matrix_mdev->matrix.apm, nbits) >= nbits)
+		return vfio_ap_verify_queue_reserved(NULL, &apqi);
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, nbits) {
+		ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * assign_domain_store
+ *
+ * @dev:	the matrix device
+ * @attr:	the mediated matrix device's assign_domain attribute
+ * @buf:	a buffer containing the AP queue index (APQI) of the domain to
+ *		be assigned
+ * @count:	the number of bytes in @buf
+ *
+ * Parses the APQI from @buf and sets the corresponding bit in the mediated
+ * matrix device's AQM.
+ *
+ * Returns the number of bytes processed if the APQI is valid; otherwise returns
+ * one of the following errors:
+ *
+ *	1. -EINVAL
+ *	   The APQI is not a valid number
+ *
+ *	2. -ENODEV
+ *	   The APQI exceeds the maximum value configured for the system
+ *
+ *	3. -EADDRNOTAVAIL
+ *	   An APQN derived from the cross product of the APQI being assigned
+ *	   and the APIDs previously assigned is not bound to the vfio_ap device
+ *	   driver; or, if no APIDs have yet been assigned, the APQI is not
+ *	   contained in an APQN bound to the vfio_ap device driver.
+ *
+ *	4. -EADDRINUSE
+ *	   An APQN derived from the cross product of the APQI being assigned
+ *	   and the APIDs previously assigned is being used by another mediated
+ *	   matrix device
+ */
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
+	if (ret)
+		return ret;
+	if (apqi > max_apqi)
+		return -ENODEV;
+
+	mutex_lock(&matrix_dev->lock);
+
+	ret = vfio_ap_mdev_verify_queues_reserved_for_apqi(matrix_mdev, apqi);
+	if (ret)
+		goto done;
+
+	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
+
+	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
+	if (ret)
+		goto share_err;
+
+	ret = count;
+	goto done;
+
+share_err:
+	clear_bit_inv(apqi, matrix_mdev->matrix.aqm);
+done:
+	mutex_unlock(&matrix_dev->lock);
+
+	return ret;
+}
+DEVICE_ATTR_WO(assign_domain);
+
+
+/**
+ * unassign_domain_store
+ *
+ * @dev:	the matrix device
+ * @attr:	the mediated matrix device's unassign_domain attribute
+ * @buf:	a buffer containing the AP queue index (APQI) of the domain to
+ *		be unassigned
+ * @count:	the number of bytes in @buf
+ *
+ * Parses the APQI from @buf and clears the corresponding bit in the
+ * mediated matrix device's AQM.
+ *
+ * Returns the number of bytes processed if the APQI is valid; otherwise,
+ * returns one of the following errors:
+ *	-EINVAL if the APQI is not a number
+ *	-ENODEV if the APQI exceeds the maximum value configured for the system
+ */
+static ssize_t unassign_domain_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int ret;
+	unsigned long apqi;
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	ret = kstrtoul(buf, 0, &apqi);
+	if (ret)
+		return ret;
+
+	if (apqi > matrix_mdev->matrix.aqm_max)
+		return -ENODEV;
+
+	mutex_lock(&matrix_dev->lock);
+	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
+	mutex_unlock(&matrix_dev->lock);
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
2.19.0.221.g150f307

