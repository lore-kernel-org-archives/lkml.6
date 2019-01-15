Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471CFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E90920656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbfAORhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:37:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730674AbfAORhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:37:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0FHZQtQ094084
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 12:37:38 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q1hww8d45-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 12:37:38 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 15 Jan 2019 17:37:35 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 15 Jan 2019 17:37:33 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0FHbW8x62849104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 17:37:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08B3DAE04D;
        Tue, 15 Jan 2019 17:37:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B88F0AE045;
        Tue, 15 Jan 2019 17:37:31 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Jan 2019 17:37:31 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     gerald.schaefer@de.ibm.com
Cc:     joro@8bytes.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        walling@linux.ibm.com
Subject: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
Date:   Tue, 15 Jan 2019 18:37:30 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011517-4275-0000-0000-000002FF9A96
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011517-4276-0000-0000-0000380DB8FF
Message-Id: <1547573850-9459-2-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=733 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901150145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The s390 iommu can only allow DMA transactions between the zPCI device
entries start_dma and end_dma.

Let's declare the regions before start_dma and after end_dma as
reserved regions using the appropriate callback in iommu_ops.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 22d4db3..5ca91a1 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -363,6 +363,33 @@ void zpci_destroy_iommu(struct zpci_dev *zdev)
 	iommu_device_sysfs_remove(&zdev->iommu_dev);
 }
 
+static void s390_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	struct iommu_resv_region *region;
+	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
+
+	region = iommu_alloc_resv_region(0, zdev->start_dma,
+					 0, IOMMU_RESV_RESERVED);
+	if (!region)
+		return;
+	list_add_tail(&region->list, head);
+
+	region = iommu_alloc_resv_region(zdev->end_dma + 1,
+					 ~0UL - zdev->end_dma,
+					 0, IOMMU_RESV_RESERVED);
+	if (!region)
+		return;
+	list_add_tail(&region->list, head);
+}
+
+static void s390_put_resv_regions(struct device *dev, struct list_head *head)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, head, list)
+		kfree(entry);
+}
+
 static const struct iommu_ops s390_iommu_ops = {
 	.capable = s390_iommu_capable,
 	.domain_alloc = s390_domain_alloc,
@@ -376,6 +403,8 @@ static const struct iommu_ops s390_iommu_ops = {
 	.remove_device = s390_iommu_remove_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+	.get_resv_regions = s390_get_resv_regions,
+	.put_resv_regions = s390_put_resv_regions,
 };
 
 static int __init s390_iommu_init(void)
-- 
2.7.4

