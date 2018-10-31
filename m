Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D356ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67ED2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67ED2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbeKADMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:12:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730101AbeKADMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:12:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9VIA3AB145311
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:13:06 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nffcddpx3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:13:06 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 31 Oct 2018 18:13:04 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 18:13:02 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9VID0Wd6881694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 18:13:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB54B11C058;
        Wed, 31 Oct 2018 18:13:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 436E811C050;
        Wed, 31 Oct 2018 18:13:00 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.73])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 31 Oct 2018 18:13:00 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v1 2/7] vfio: ap: VFIO AP Queue Interrupt Control
Date:   Wed, 31 Oct 2018 19:12:52 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18103118-0012-0000-0000-000002C13608
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103118-0013-0000-0000-000020F5635B
Message-Id: <1541009577-29656-3-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=876 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We define two VFIO ioctl command to setup and clear
the AP Queues interrupt.

Arguments passed by the guest are:
- the apqn, AP queue number
- the Notification by address
- the identifier of the previously associated adapter

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 include/uapi/linux/vfio.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index f378b9802d8b..f13079bb28af 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -816,6 +816,28 @@ struct vfio_iommu_spapr_tce_remove {
 };
 #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
 
+/**
+ * VFIO_AP_SET_IRQ - _IOWR(VFIO_TYPE, VFIO_BASE + 21, struct vfio_ap_aqic)
+ *
+ * Setup IRQ for an AP Queue
+ * @cmd contains the AP queue number (apqn)
+ * @status receives the resulting status of the command
+ * @nib is the Notification Indicator byte address
+ * @adapter_id allows to retrieve the associated adapter
+ */
+struct vfio_ap_aqic {
+	__u32   argsz;
+	__u32   flags;
+	/* in */
+	__u64 cmd;
+	__u64 status;
+	__u64 nib;
+	__u32 adapter_id;
+};
+#define VFIO_AP_SET_IRQ			_IO(VFIO_TYPE, VFIO_BASE + 21)
+#define VFIO_AP_CLEAR_IRQ		_IO(VFIO_TYPE, VFIO_BASE + 22)
+
 /* ***************************************************************** */
 
+
 #endif /* _UAPIVFIO_H */
-- 
2.17.0

