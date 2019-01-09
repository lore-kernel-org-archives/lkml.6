Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778B5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E2F206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbfAIMmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:42:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730917AbfAIMmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:42:07 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09CXns5045734
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 07:42:06 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwepfq7wu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:42:05 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 9 Jan 2019 12:42:03 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 12:41:59 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09CfwiF3211624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 12:41:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1786DA4055;
        Wed,  9 Jan 2019 12:41:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7D68A4040;
        Wed,  9 Jan 2019 12:41:57 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 12:41:57 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        walling@linux.ibm.com, cohuck@redhat.com, david@redhat.com,
        pasic@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v1 2/2] vfio:iommu: Get DMA information from real IOMMU
Date:   Wed,  9 Jan 2019 13:41:54 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547037714-21592-1-git-send-email-pmorel@linux.ibm.com>
References: <1547037714-21592-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010912-0012-0000-0000-000002E55324
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010912-0013-0000-0000-0000211C54FF
Message-Id: <1547037714-21592-3-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report the real IOMMU geometry through the VFIO_IOMMU_GET_INFO
ioctl call when the vfio_iommu_type1_info support capabilities.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/vfio/vfio_iommu_type1.c | 43 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index d9fd318..0a7746c 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1673,6 +1673,23 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
 	return ret;
 }
 
+static int vfio_iommu_type1_caps(struct vfio_iommu *iommu,
+				 struct vfio_info_cap *caps)
+{
+	struct vfio_domain *d;
+	struct vfio_iommu_cap_dma info = { .header.id = VFIO_IOMMU_INFO_CAP_DMA,
+					   .header.version = 1 };
+	int ret;
+
+	d = list_first_entry(&iommu->domain_list, struct vfio_domain, next);
+	if (!d || !d->domain)
+		return -ENODEV;
+	info.dma_start = d->domain->geometry.aperture_start;
+	info.dma_end = d->domain->geometry.aperture_end;
+	ret = vfio_info_add_capability(caps, &info.header, sizeof(info));
+	return ret;
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -1694,6 +1711,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		}
 	} else if (cmd == VFIO_IOMMU_GET_INFO) {
 		struct vfio_iommu_type1_info info;
+		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
+		int ret;
 
 		minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
 
@@ -1703,7 +1722,29 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		info.flags = VFIO_IOMMU_INFO_PGSIZES;
+		if (info.flags & VFIO_IOMMU_INFO_CAPABILITIES) {
+			ret = vfio_iommu_type1_caps(iommu, &caps);
+			if (ret)
+				return ret;
+		}
+		if (caps.size) {
+			if (info.argsz < sizeof(info) + caps.size) {
+				info.argsz = sizeof(info) + caps.size;
+				info.cap_offset = 0;
+			} else {
+				vfio_info_cap_shift(&caps, sizeof(info));
+				if (copy_to_user((void __user *)arg +
+					sizeof(info), caps.buf,
+					caps.size)) {
+					kfree(caps.buf);
+					return -EFAULT;
+				}
+				info.cap_offset = sizeof(info);
+			}
+			kfree(caps.buf);
+		}
+
+		info.flags |= VFIO_IOMMU_INFO_PGSIZES;
 
 		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
 
-- 
2.7.4

