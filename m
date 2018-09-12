Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6084C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BBB2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BBB2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeIMAuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:50:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728500AbeIMAuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:50:32 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CJYaPW052544
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:44:29 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf60388tn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:44:28 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Wed, 12 Sep 2018 13:44:28 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 13:44:23 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CJiKKe20054152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 12:44:20 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 880D16A057;
        Wed, 12 Sep 2018 13:44:20 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8AE36A04D;
        Wed, 12 Sep 2018 13:44:17 -0600 (MDT)
Received: from localhost.localdomain (unknown [9.80.213.181])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Sep 2018 13:44:17 -0600 (MDT)
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
Subject: [PATCH v10 14/26] s390: vfio-ap: implement VFIO_DEVICE_RESET ioctl
Date:   Wed, 12 Sep 2018 15:43:04 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091219-0020-0000-0000-00000E640D69
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009709; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01087371; UDB=6.00561489; IPR=6.00867383;
 MB=3.00023256; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-12 19:44:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091219-0021-0000-0000-000063013550
Message-Id: <1536781396-13601-15-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=995 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Krowiak <akrowiak@linux.ibm.com>

Implements the VFIO_DEVICE_RESET ioctl. This ioctl zeroizes
all of the AP queues assigned to the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 48b1b78..d1b326b 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -922,7 +922,7 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 	if (info.argsz < minsz)
 		return -EINVAL;
 
-	info.flags = VFIO_DEVICE_FLAGS_AP;
+	info.flags = VFIO_DEVICE_FLAGS_AP | VFIO_DEVICE_FLAGS_RESET;
 	info.num_regions = 0;
 	info.num_irqs = 0;
 
@@ -938,6 +938,9 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
 	case VFIO_DEVICE_GET_INFO:
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
+	case VFIO_DEVICE_RESET:
+		ret = vfio_ap_mdev_reset_queues(mdev);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
1.7.1

