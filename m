Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DF1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C26C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C26C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeK1Xm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:42:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728373AbeK1Xmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:42:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASCd7DE030535
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 07:41:21 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p1sfqmr3c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 07:41:21 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 28 Nov 2018 12:41:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 12:41:16 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASCfFuF61276324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 12:41:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43AA74C050;
        Wed, 28 Nov 2018 12:41:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0933C4C040;
        Wed, 28 Nov 2018 12:41:15 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 12:41:14 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com
Cc:     cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH v3 6/6] vfio: ccw: serialize the write system calls
Date:   Wed, 28 Nov 2018 13:41:07 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112812-0012-0000-0000-000002D17965
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112812-0013-0000-0000-00002106BE21
Message-Id: <1543408867-16465-7-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=762 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the user program is QEMU we rely on the QEMU lock to serialize
the calls to the driver.

In the general case we need to make sure that two data transfer are
not started at the same time.
It would in the current implementation resul in a overwriting of the
IO region.

We also need to make sure a clear or a halt started after a data
transfer do not win the race agains the data transfer.
Which would result in the data transfer being started after the
halt/clear.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index eb5b49d..b316966 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -267,22 +267,31 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 {
 	unsigned int index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
 	struct vfio_ccw_private *private;
+	static atomic_t serialize  = ATOMIC_INIT(0);
+	int ret = -EINVAL;
+
+	if (!atomic_add_unless(&serialize, 1, 1))
+		return -EBUSY;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
 
 	if (index >= VFIO_CCW_NUM_REGIONS + private->num_regions)
-		return -EINVAL;
+		goto end;
 
 	switch (index) {
 	case VFIO_CCW_CONFIG_REGION_INDEX:
-		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
+		ret = vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
+		break;
 	default:
 		index -= VFIO_CCW_NUM_REGIONS;
-		return private->region[index].ops->write(private, buf, count,
+		ret = private->region[index].ops->write(private, buf, count,
 							 ppos);
+		break;
 	}
 
-	return -EINVAL;
+end:
+	atomic_dec(&serialize);
+	return ret;
 }
 
 static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info,
-- 
2.7.4

