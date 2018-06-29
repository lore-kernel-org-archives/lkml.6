Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C145C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5AA27F4F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5AA27F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966311AbeF2VMR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:12:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754453AbeF2VMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:12:09 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5TL9E65077743
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:12:09 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jwt6pmwb2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:12:09 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Fri, 29 Jun 2018 17:12:07 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Jun 2018 17:12:04 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5TLC2uP9634162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jun 2018 21:12:02 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B2D7124055;
        Fri, 29 Jun 2018 18:13:31 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 669D2124052;
        Fri, 29 Jun 2018 18:13:30 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.157.42])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Jun 2018 18:13:30 -0400 (EDT)
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
Subject: [PATCH v6 16/21] s390: vfio-ap: sysfs interface to view guest matrix
Date:   Fri, 29 Jun 2018 17:11:18 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062921-0068-0000-0000-000003106203
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009278; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01054189; UDB=6.00540581; IPR=6.00832112;
 MB=3.00021933; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-29 21:12:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062921-0069-0000-0000-000044DB0448
Message-Id: <1530306683-7270-17-git-send-email-akrowiak@linux.vnet.ibm.com>
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

From: Tony Krowiak <akrowiak@linux.ibm.com>

Provides a sysfs interface to view the AP matrix configured for the
guest that is using the mdev matrix device.

The relevant sysfs structures are:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
...............[$uuid]
.................. guest_matrix

To view the matrix configured for the guest,
print the guest_matrix file:

cat guest_matrix

If no guest is using the device, then the output will be an emtpy
string.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |   39 +++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 98bd0a1..bc05d40 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -730,6 +730,44 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 }
 DEVICE_ATTR_RO(matrix);
 
+static unsigned long *kvm_ap_get_crycb_apm(struct ap_matrix_mdev *matrix_mdev);
+
+static unsigned long *kvm_ap_get_crycb_aqm(struct ap_matrix_mdev *matrix_mdev);
+
+static ssize_t guest_matrix_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	char *bufpos = buf;
+	unsigned long apid;
+	unsigned long apqi;
+	unsigned long *apm, *aqm;
+	unsigned long napm = matrix_mdev->matrix.apm_max + 1;
+	unsigned long naqm = matrix_mdev->matrix.aqm_max + 1;
+	int nchars = 0;
+	int n;
+
+	if (!matrix_mdev->kvm)
+		return nchars;
+
+	apm = kvm_ap_get_crycb_apm(matrix_mdev);
+	for_each_set_bit_inv(apid, apm, napm) {
+		n = sprintf(bufpos, "%02lx\n", apid);
+		bufpos += n;
+		nchars += n;
+
+		aqm = kvm_ap_get_crycb_aqm(matrix_mdev);
+		for_each_set_bit_inv(apqi, aqm, naqm) {
+			n = sprintf(bufpos, "%02lx.%04lx\n", apid, apqi);
+			bufpos += n;
+			nchars += n;
+		}
+	}
+
+	return nchars;
+}
+DEVICE_ATTR_RO(guest_matrix);
 
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
@@ -740,6 +778,7 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 	&dev_attr_unassign_control_domain.attr,
 	&dev_attr_control_domains.attr,
 	&dev_attr_matrix.attr,
+	&dev_attr_guest_matrix.attr,
 	NULL,
 };
 
-- 
1.7.1

