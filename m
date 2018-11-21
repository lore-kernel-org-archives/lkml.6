Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA27C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F060A20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F060A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeKUT4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:56:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726001AbeKUT4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:56:53 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAL9J9F2079858
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 04:23:10 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nw1d90wn0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 04:23:10 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 21 Nov 2018 09:23:09 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Nov 2018 09:23:06 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAL9N5sG27328582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 09:23:05 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 985BA124053;
        Wed, 21 Nov 2018 09:23:05 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D5F3124055;
        Wed, 21 Nov 2018 09:23:03 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.179])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Nov 2018 09:23:02 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, mpe@ellerman.id.au,
        paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V4 0/3] * mm/kvm/vfio/ppc64: Migrate compound pages out of CMA region
Date:   Wed, 21 Nov 2018 14:52:56 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 18112109-0060-0000-0000-000002D6575A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010092; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01120588; UDB=6.00581487; IPR=6.00900709;
 MB=3.00024261; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-21 09:23:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112109-0061-0000-0000-0000474465E8
Message-Id: <20181121092259.16482-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=611 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811210085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppc64 use CMA area for the allocation of guest page table (hash page table). We won't
be able to start guest if we fail to allocate hash page table. We have observed
hash table allocation failure because we failed to migrate pages out of CMA region
because they were pinned. This happen when we are using VFIO. VFIO on ppc64 pins
the entire guest RAM. If the guest RAM pages get allocated out of CMA region, we
won't be able to migrate those pages. The pages are also pinned for the lifetime of the
guest.

Currently we support migration of non-compound pages. With THP and with the addition of
 hugetlb migration we can end up allocating compound pages from CMA region. This
patch series add support for migrating compound pages. The first path adds the helper
get_user_pages_cma_migrate() which pin the page making sure we migrate them out of
CMA region before incrementing the reference count. 

Changes from V3:
* Move the hugetlb check before transhuge check
* Use compound head page when isolating hugetlb page

Aneesh Kumar K.V (3):
  mm: Add get_user_pages_cma_migrate
  powerpc/mm/iommu: Allow migration of cma allocated pages during
    mm_iommu_get
  powerpc/mm/iommu: Allow large IOMMU page size only for hugetlb backing

 arch/powerpc/mm/mmu_context_iommu.c | 140 ++++++++--------------------
 include/linux/hugetlb.h             |   2 +
 include/linux/migrate.h             |   3 +
 mm/hugetlb.c                        |   4 +-
 mm/migrate.c                        | 132 ++++++++++++++++++++++++++
 5 files changed, 179 insertions(+), 102 deletions(-)

-- 
2.17.2

