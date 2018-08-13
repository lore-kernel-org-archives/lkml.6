Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53852C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036CF214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036CF214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbeHNAdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:33:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731312AbeHNAdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:33:00 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7DLcdel115315
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:48:55 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kuh1bte5f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:48:55 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Mon, 13 Aug 2018 17:48:54 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Aug 2018 17:48:50 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7DLmm6Y14156118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Aug 2018 21:48:48 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A122124054;
        Mon, 13 Aug 2018 18:49:46 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86D60124052;
        Mon, 13 Aug 2018 18:49:45 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.141.105])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Aug 2018 18:49:45 -0400 (EDT)
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
Subject: [PATCH v9 11/22] s390: vfio-ap: sysfs interfaces to configure domains
Date:   Mon, 13 Aug 2018 17:48:08 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081321-0052-0000-0000-0000031E7539
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009538; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073087; UDB=6.00552882; IPR=6.00853043;
 MB=3.00022698; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-13 21:48:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081321-0053-0000-0000-00005DB7376F
Message-Id: <1534196899-16987-12-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808130218
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
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |   88 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index dfb434c..c4d7504 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -363,10 +363,96 @@ static ssize_t unassign_adapter_store(struct device *dev,
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
+		return -EINVAL;
+
+	mutex_lock(&matrix_dev.lock);
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
+	mutex_unlock(&matrix_dev.lock);
+
+	return ret;
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
+
+	ret = kstrtoul(buf, 0, &apqi);
+	if (ret)
+		return ret;
+
+	if (apqi > matrix_mdev->matrix.aqm_max)
+		return -EINVAL;
+
+	mutex_lock(&matrix_dev.lock);
+	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
+	mutex_unlock(&matrix_dev.lock);
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

