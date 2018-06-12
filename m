Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1839DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB6C208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB6C208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933839AbeFLH5q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:57:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933756AbeFLH5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:57:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5C7sj2a122898
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:57:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jj7pnpmpm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:57:07 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 12 Jun 2018 08:57:05 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 08:57:02 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5C7v1Pq23068814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 07:57:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20FC0AE055;
        Tue, 12 Jun 2018 08:45:53 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6598AE051;
        Tue, 12 Jun 2018 08:45:52 +0100 (BST)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 08:45:52 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v3 8/8] vfio: ccw: Suppressing the BOXED state
Date:   Tue, 12 Jun 2018 09:56:50 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061207-0008-0000-0000-00000246BECF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061207-0009-0000-0000-000021ACE6CB
Message-Id: <1528790210-19535-9-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=865 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VFIO_CCW_STATE_BOXED and VFIO_CCW_STATE_BUSY are the same.

Let's only keep one: VFIO_CCW_STATE_BUSY

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 9 +--------
 drivers/s390/cio/vfio_ccw_private.h | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 5f1035c..e588c3c 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -120,7 +120,7 @@ static int fsm_io_request(struct vfio_ccw_private *private)
 	struct ccw_io_region *io_region = &private->io_region;
 	struct mdev_device *mdev = private->mdev;
 
-	private->state = VFIO_CCW_STATE_BOXED;
+	private->state = VFIO_CCW_STATE_BUSY;
 
 	orb = (union orb *)io_region->orb_area;
 
@@ -227,13 +227,6 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
-	[VFIO_CCW_STATE_BOXED] = {
-		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
-		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
-		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
-		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
-		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
-	},
 	[VFIO_CCW_STATE_BUSY] = {
 		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index f9e7570..42cc3b7 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -66,7 +66,6 @@ enum vfio_ccw_state {
 	VFIO_CCW_STATE_NOT_OPER,
 	VFIO_CCW_STATE_STANDBY,
 	VFIO_CCW_STATE_IDLE,
-	VFIO_CCW_STATE_BOXED,
 	VFIO_CCW_STATE_BUSY,
 	/* last element! */
 	NR_VFIO_CCW_STATES
-- 
2.7.4

