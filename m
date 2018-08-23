Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE636C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BF721568
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hZ/tritc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BF721568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeHXAbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:31:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52794 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeHXAbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:31:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7NKwWqO144639;
        Thu, 23 Aug 2018 20:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=WScNzPijogN31b3MQE7ypuetUbwMbjDinmHl8orDy+k=;
 b=hZ/tritcKljTWwRUeXZf6e7ET1BoqSwqECQ79xkfA2C22v1/LBf/qa81OjpKw0NLckaE
 ZLAMo9lC7adTa4s0fT//R80aVo7dPM5cl237mJlwmS28FeKYN84Mhf0nv8SDgcp0j25T
 9bCNbh7G3J1xmG2Qwq8MVqI9elsjJUlj1LjvlAiY5RBf1LUny8RPY5zGgHQOkzujoLT1
 VWherYTRMTuBhwCnOZeRe0aAvuxS+2GwQH4sZsvP/720y+s3efnQSPm4ZQi6g8ARZttD
 dNNlZNDA/S8Wh3IFrQ+TmdMYI6wQus8By83cwyE1RWzEx4Gs0zELab5/uQPGW6iui4IX rA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kxavu3t54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 20:59:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7NKxOCi022579
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 20:59:24 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7NKxNRn015248;
        Thu, 23 Aug 2018 20:59:23 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Aug 2018 13:59:22 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v6 0/2] huge_pmd_unshare migration and flushing
Date:   Thu, 23 Aug 2018 13:59:15 -0700
Message-Id: <20180823205917.16297-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8994 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=656
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808230215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct a data corruption issue caused by improper handling of shared
huge PMDs during page migration.  This issue was observed in a customer
environment and can be recreated fairly easily with a test program.
Patch 0001 addresses this issue only and is copied to stable with the
intention that this will go to stable releases.  It has existed since
the addition of shared huge PMD support.

While considering the issue above, Kirill Shutemov noticed that other
callers of huge_pmd_unshare have potential issues with cache and TLB
flushing.  A separate patch (0002) takes advantage of the new routine
adjust_range_if_pmd_sharing_possible() to adjust flushing ranges in
the cases where huge PMD sharing is possible.  There is no copy to
stable for this patch as it has not been reported as an issue and
discovered only via code inspection.

v5-v6:	Rename and update 'sharing possible' routine as suggested by
	Kirill.
v3-v5:  Address build errors if !CONFIG_HUGETLB_PAGE and
        !CONFIG_ARCH_WANT_HUGE_PMD_SHARE

Mike Kravetz (2):
  mm: migration: fix migration of huge PMD shared pages
  hugetlb: take PMD sharing into account when flushing tlb/caches

 include/linux/hugetlb.h | 14 +++++++
 mm/hugetlb.c            | 93 ++++++++++++++++++++++++++++++++++++-----
 mm/rmap.c               | 42 +++++++++++++++++--
 3 files changed, 135 insertions(+), 14 deletions(-)

-- 
2.17.1

