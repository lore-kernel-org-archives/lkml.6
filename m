Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C0C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8381427FBD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8381427FBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754947AbeF2VON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:14:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S937550AbeF2VMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:12:12 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5TL9Ckh022226
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:12:12 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jwset6gu5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:12:11 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Fri, 29 Jun 2018 17:12:11 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Jun 2018 17:12:08 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5TLC7XJ9634178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jun 2018 21:12:07 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD572124055;
        Fri, 29 Jun 2018 18:13:35 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4C9E124052;
        Fri, 29 Jun 2018 18:13:34 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.157.42])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Jun 2018 18:13:34 -0400 (EDT)
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
Subject: [PATCH v6 18/21] s390: vfio-ap: zeroize the AP queues.
Date:   Fri, 29 Jun 2018 17:11:20 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062921-0040-0000-0000-000004474D55
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009278; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01054190; UDB=6.00540581; IPR=6.00832112;
 MB=3.00021933; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-29 21:12:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062921-0041-0000-0000-0000084D66DB
Message-Id: <1530306683-7270-19-git-send-email-akrowiak@linux.vnet.ibm.com>
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

Let's call PAPQ(ZAPQ) to zeroize a queue:

* For each queue configured for a mediated matrix device
  when it is released.

* When an AP queue is unbound from the VFIO AP device driver.

Zeroizing a queue resets the queue, clears all pending
messages for the queue entries and disables adapter interruptions
associated with the queue.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     |   12 +++++++++++-
 drivers/s390/crypto/vfio_ap_ops.c     |   33 ++++++++++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |   26 ++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index b6ff7a4..d09ffdc 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -53,7 +53,17 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 
 static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 {
-	/* Nothing to do yet */
+	struct ap_queue *ap_queue = to_ap_queue(&apdev->device);
+
+	vfio_ap_reset_queue(AP_QID_CARD(ap_queue->qid),
+			    AP_QID_QUEUE(ap_queue->qid));
+
+	/*
+	 * TODO: Ensure that no guest is using the queue and handle it
+	 * accordingly. The domain or possibly the adapter may have to
+	 * be removed from the guest's configuration which would require
+	 * hot unplug support which is forthcoming.
+	 */
 }
 
 static void vfio_ap_matrix_dev_release(struct device *dev)
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 79ac0d4..e247491 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1054,6 +1054,37 @@ static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev)
 	return ret;
 }
 
+static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev, bool force)
+{
+	int ret;
+	int rc = 0;
+	unsigned long apid, apqi;
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct ap_matrix_dev *matrix_dev =
+		to_ap_matrix_dev(mdev_parent_dev(mdev));
+
+	ret = vfio_ap_verify_queues_reserved(matrix_dev, matrix_mdev->name,
+					     &matrix_mdev->matrix);
+	if (ret)
+		return ret;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
+			     matrix_mdev->matrix.apm_max + 1) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1) {
+			ret = vfio_ap_reset_queue(apid, apqi);
+			if (ret) {
+				if (force)
+					rc = ret;
+				else
+					return ret;
+			}
+		}
+	}
+
+	return rc;
+}
+
 static int vfio_ap_mdev_open(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
@@ -1107,7 +1138,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
 	kvm_ap_deconfigure_matrix(matrix_mdev);
-
+	vfio_ap_mdev_reset_queues(mdev, true);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
 	matrix_mdev->kvm = NULL;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 7792b45..97d80f3 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/mdev.h>
+#include <linux/delay.h>
 
 #include "ap_bus.h"
 
@@ -68,4 +69,29 @@ struct ap_matrix_mdev {
 extern int vfio_ap_mdev_register(struct ap_matrix_dev *matrix_dev);
 extern void vfio_ap_mdev_unregister(struct ap_matrix_dev *matrix_dev);
 
+static inline int vfio_ap_reset_queue(unsigned long apid, unsigned long apqi)
+{
+	int count = 50;
+	struct ap_queue_status status;
+
+	while (count--) {
+		status = ap_zapq(AP_MKQID(apid, apqi));
+		switch (status.response_code) {
+		case AP_RESPONSE_NORMAL:
+			return 0;
+		case AP_RESPONSE_RESET_IN_PROGRESS:
+		case AP_RESPONSE_BUSY:
+			msleep(20);
+			break;
+		default:
+			pr_err("%s: error zeroizing %02lx.%04lx: response code %d ",
+			       VFIO_AP_MODULE_NAME, apid, apqi,
+			       status.response_code);
+			return -EIO;
+		}
+	};
+
+	return -EBUSY;
+}
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
1.7.1

