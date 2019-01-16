Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637EDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF7C20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfAPTMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:12:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729879AbfAPTMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:12:40 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GJ3k2B139752
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:12:38 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q29ptj2e0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:12:38 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Wed, 16 Jan 2019 19:12:36 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 19:12:32 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GJCVuf42729642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 19:12:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89D5D52051;
        Wed, 16 Jan 2019 19:12:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 4034052050;
        Wed, 16 Jan 2019 19:12:31 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH] iommu/intel-iommu: fix memory leak in intel_iommu_put_resv_regions()
Date:   Wed, 16 Jan 2019 20:11:44 +0100
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 19011619-0008-0000-0000-000002B1F41F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011619-0009-0000-0000-0000221E0EA9
Message-Id: <20190116191144.15652-1-gerald.schaefer@de.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=889 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9d3a4de4cb8d ("iommu: Disambiguate MSI region types") changed
the reserved region type in intel_iommu_get_resv_regions() from
IOMMU_RESV_RESERVED to IOMMU_RESV_MSI, but it forgot to also change
the type in intel_iommu_put_resv_regions().

This leads to a memory leak, because now the check in
intel_iommu_put_resv_regions() for IOMMU_RESV_RESERVED will never
be true, and no allocated regions will be freed.

Fix this by changing the region type in intel_iommu_put_resv_regions()
to IOMMU_RESV_MSI, matching the type of the allocated regions.

Fixes: 9d3a4de4cb8d ("iommu: Disambiguate MSI region types")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 048b5ab36a02..b83e0f2025bb 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5295,7 +5295,7 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 	struct iommu_resv_region *entry, *next;
 
 	list_for_each_entry_safe(entry, next, head, list) {
-		if (entry->type == IOMMU_RESV_RESERVED)
+		if (entry->type == IOMMU_RESV_MSI)
 			kfree(entry);
 	}
 }
-- 
2.16.4

