Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FDFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3ED208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3ED208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeJEOai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:30:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728229AbeJEOah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:30:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w957V5g5123384
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 03:33:09 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mx2kfjtwu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 03:33:09 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 5 Oct 2018 08:33:07 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 08:33:03 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w957X2HI50790548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Oct 2018 07:33:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CAB94C050;
        Fri,  5 Oct 2018 10:32:41 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 437014C046;
        Fri,  5 Oct 2018 10:32:41 +0100 (BST)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.35])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 10:32:41 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     david@redhat.com, linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH] s390: vfio-ap: trace the update of APCB masks
Date:   Fri,  5 Oct 2018 09:33:01 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18100507-4275-0000-0000-000002C54FFD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100507-4276-0000-0000-000037D06B12
Message-Id: <1538724781-31852-1-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a tracing function to trace in the KVM trace buffer
and trace the changes of the APCB masks.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 22 ++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a8a9984..00e632a 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -753,6 +753,28 @@ static void vfio_ap_mdev_copy_masks(struct ap_matrix_mdev *matrix_mdev)
 	memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
 	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.adm_max + 1, BITS_PER_BYTE);
 	memcpy(adm, matrix_mdev->matrix.adm, nbytes);
+
+	switch (matrix_mdev->kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT2:
+		VM_AP_EVENT(matrix_mdev->kvm, 3,
+			    "SET CRYCB: apm %016lx %016lx %016lx %016lx",
+			    apm[0], apm[1], apm[2], apm[3]);
+		VM_AP_EVENT(matrix_mdev->kvm, 3,
+			    "SET CRYCB: aqm %016lx %016lx %016lx %016lx",
+			    aqm[0], aqm[1], aqm[2], aqm[3]);
+		VM_AP_EVENT(matrix_mdev->kvm, 3,
+			    "SET CRYCB: adm %016lx %016lx %016lx %016lx",
+			    adm[0], adm[1], adm[2], adm[3]);
+		break;
+	case CRYCB_FORMAT1:
+	case CRYCB_FORMAT0: /* Both CRYCB format uses APCB format 0 */
+	default: /* Can not happen */
+		VM_AP_EVENT(matrix_mdev->kvm, 3,
+			    "SET CRYCB: apm %016lx aqm %04x adm %04x", apm[0],
+			    *((unsigned short *)aqm), *((unsigned short *)adm));
+		break;
+	}
+
 }
 
 /**
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 5675492..4cd779d 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -19,6 +19,10 @@
 
 #include "ap_bus.h"
 
+#define VM_AP_EVENT(d_kvm, d_loglevel, d_string, d_args...)\
+	debug_sprintf_event(d_kvm->arch.dbf, d_loglevel, d_string "\n", \
+			    d_args)
+
 #define VFIO_AP_MODULE_NAME "vfio_ap"
 #define VFIO_AP_DRV_NAME "vfio_ap"
 
-- 
2.7.4

