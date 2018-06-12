Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CC5D2C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C48208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C48208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933860AbeFLH6o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:58:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933550AbeFLH5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:57:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5C7sYRq137860
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:57:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jj6u891ek-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:57:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 12 Jun 2018 08:56:58 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 08:56:57 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5C7uueN35258460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 07:56:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D78D3AE04D;
        Tue, 12 Jun 2018 08:45:47 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A07AAE055;
        Tue, 12 Jun 2018 08:45:47 +0100 (BST)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 08:45:47 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v3 4/8] vfio: ccw: Only accept SSCH as an IO request
Date:   Tue, 12 Jun 2018 09:56:46 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061207-0016-0000-0000-000001DABEA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061207-0017-0000-0000-0000322DEFD2
Message-Id: <1528790210-19535-5-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=663 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies the IO request handling to handle the only
implemented request: SSCH.
Other requests are invalid and get a return value of -ENOTSUP
as before.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c | 55 ++++++++++++++++-------------------------
 drivers/s390/cio/vfio_ccw_ops.c | 15 ++++++-----
 2 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 94bf151..e672d14 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -122,50 +122,37 @@ static int fsm_io_request(struct vfio_ccw_private *private,
 			   enum vfio_ccw_event event)
 {
 	union orb *orb;
-	union scsw *scsw = &private->scsw;
 	struct ccw_io_region *io_region = &private->io_region;
 	struct mdev_device *mdev = private->mdev;
 
 	private->state = VFIO_CCW_STATE_BOXED;
 
-	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
-
-	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
-		orb = (union orb *)io_region->orb_area;
-
-		/* Don't try to build a cp if transport mode is specified. */
-		if (orb->tm.b) {
-			io_region->ret_code = -EOPNOTSUPP;
-			goto err_out;
-		}
-		io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev),
-					      orb);
-		if (io_region->ret_code)
-			goto err_out;
-
-		io_region->ret_code = cp_prefetch(&private->cp);
-		if (io_region->ret_code) {
-			cp_free(&private->cp);
-			goto err_out;
-		}
-
-		/* Start channel program and wait for I/O interrupt. */
-		io_region->ret_code = fsm_io_helper(private);
-		if (io_region->ret_code) {
-			cp_free(&private->cp);
-			goto err_out;
-		}
-		return private->state;
-	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
-		/* XXX: Handle halt. */
+	orb = (union orb *)io_region->orb_area;
+
+	/* Don't try to build a cp if transport mode is specified. */
+	if (orb->tm.b) {
 		io_region->ret_code = -EOPNOTSUPP;
 		goto err_out;
-	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
-		/* XXX: Handle clear. */
-		io_region->ret_code = -EOPNOTSUPP;
+	}
+	io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev),
+				      orb);
+	if (io_region->ret_code)
+		goto err_out;
+
+	io_region->ret_code = cp_prefetch(&private->cp);
+	if (io_region->ret_code) {
+		cp_free(&private->cp);
 		goto err_out;
 	}
 
+	/* Start channel program and wait for I/O interrupt. */
+	io_region->ret_code = fsm_io_helper(private);
+	if (io_region->ret_code) {
+		cp_free(&private->cp);
+		goto err_out;
+	}
+	return private->state;
+
 err_out:
 	return VFIO_CCW_STATE_IDLE;
 }
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 41eeb57..af05932 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -188,25 +188,24 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 {
 	struct vfio_ccw_private *private;
 	struct ccw_io_region *region;
+	union scsw *scsw;
 
 	if (*ppos + count > sizeof(*region))
 		return -EINVAL;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	if (private->state != VFIO_CCW_STATE_IDLE)
-		return -EACCES;
 
 	region = &private->io_region;
 	if (copy_from_user((void *)region + *ppos, buf, count))
 		return -EFAULT;
 
-	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
-	if (region->ret_code != 0) {
-		private->state = VFIO_CCW_STATE_IDLE;
-		return region->ret_code;
-	}
+	scsw = (union scsw *) &region->scsw_area;
+	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC)
+		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
+	else
+		return -EOPNOTSUPP;
 
-	return count;
+	return region->ret_code ? region->ret_code : count;
 }
 
 static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info)
-- 
2.7.4

