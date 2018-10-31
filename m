Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAC4ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A7F2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A7F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbeKADM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:12:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730137AbeKADMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:12:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9VIA3AF145311
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:13:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nffcddq33-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:13:12 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 31 Oct 2018 18:13:09 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 18:13:08 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9VID6PN4981004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 18:13:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70FA011C058;
        Wed, 31 Oct 2018 18:13:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AA7B11C04C;
        Wed, 31 Oct 2018 18:13:06 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.73])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 31 Oct 2018 18:13:06 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v1 6/7] vfio: ap: register guest ISC with GISA and GIB
Date:   Wed, 31 Oct 2018 19:12:56 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18103118-0028-0000-0000-00000310C4D5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103118-0029-0000-0000-000023CCF65A
Message-Id: <1541009577-29656-7-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=880 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register to the GIB Alert list and retrieve the GAL_ISC
to pass to the GISA registration.

Unregister on error and when clearing the interrupt.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index f68102163bf4..232168797fb8 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -903,16 +903,20 @@ static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
 	struct ap_status ap_status = reg2status(0);
 	unsigned long p;
 	int ret = -1;
-	int apqn;
+	int apqn, gal_isc;
 	uint32_t gd;
 
+	gal_isc = kvm_s390_gisc_register(matrix_mdev->kvm, matrix_mdev->gisc);
+	if (gal_isc < 0)
+		return -EIO;
+
 	apqn = (int)(parm->cmd & 0xffff);
 
 	gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
 	if (gd & 0x01)
 		aqic_gisa.f = 1;
 	aqic_gisa.gisc = matrix_mdev->gisc;
-	aqic_gisa.isc = GAL_ISC;
+	aqic_gisa.isc = gal_isc;
 	aqic_gisa.ir = 1;
 	aqic_gisa.gisao = gisa->next_alert >> 4;
 
@@ -923,7 +927,11 @@ static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
 	parm->status = ret;
 
 	ap_status = reg2status(ret);
-	return (ap_status.rc) ? -EIO : 0;
+	if (ap_status.rc) {
+		kvm_s390_gisc_unregister(matrix_mdev->kvm, matrix_mdev->gisc);
+		return -EIO;
+	}
+	return 0;
 }
 
 static int ap_ioctl_clrirq(struct ap_matrix_mdev *matrix_mdev,
@@ -946,6 +954,8 @@ static int ap_ioctl_clrirq(struct ap_matrix_mdev *matrix_mdev,
 	parm->status = retval;
 
 	ap_status = reg2status(retval);
+	/* unregister the IAM from the GIB anyway! */
+	kvm_s390_gisc_unregister(matrix_mdev->kvm, matrix_mdev->gisc);
 	return (ap_status.rc) ? -EIO : 0;
 }
 
-- 
2.17.0

