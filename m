Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E2C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF56217D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SxfmEFda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF56217D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeHVAVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:21:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33922 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeHVAVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:21:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7LKvZsV032795;
        Tue, 21 Aug 2018 20:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=isJ9Jkdx665BY4ACGU8+ribFSSa0UcyNFfLuHxoM4Cs=;
 b=SxfmEFdaPTtJBJrRAP8x7bnHqxL68JCqIBXJMKQ/JKO+VLugpt5XzZhBZC9W03NfyjJ8
 OcAxkMdnzhnxwtaPx+rfK5B6ZhpPhHt72/wPIBTd8ezFv2vUAVJsBMYABMIGYtuCJK14
 aQZGOx0nlrX5om9OvEWSEE1jKLQ7ZPdxwb+lE9JNJdPnsZriJ88j3mrbNVaMhG5aH6Rz
 NTE/r4tGVbYtkMUFDEEe8Hdf6fMuPCOYv8/x0uNlxloSz67dGqXm9zVSJcF8KzXfU4wD
 adwR5x/Ebq6mDnWUzJLI/r8wvGYoPIJb3ZZr29jL5l2ICQoZCjnWx9OI4e6TDV639Qk0 vA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kxavtq5u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 20:59:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7LKx8U9032266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 20:59:08 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7LKx5TL015248;
        Tue, 21 Aug 2018 20:59:05 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Aug 2018 13:59:05 -0700
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
Subject: [PATCH v3 0/2] huge_pmd_unshare migration and flushing
Date:   Tue, 21 Aug 2018 13:59:00 -0700
Message-Id: <20180821205902.21223-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8992 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=645
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808210212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 of a patch to correct a data corruption issue caused by improper
handling of shared huge PMDs during page migration.  This issue was
observed in a customer environment and can be recreated fairly easily
with a test program.  Patch 0001 addresses this issue only and is
copied to stable with the intention that this will go to stable
releases.  It has existed since the addition of shared huge PMD support.

While considering the issue above, Kirill Shutemov noticed that other
callers of huge_pmd_unshare have potential issues with cache and TLB
flushing.  A separate patch (0002) takes advantage of the new routine
huge_pmd_sharing_possible() to adjust flushing ranges in the cases
where huge PMD sharing is possible.  There is no copy to stable for this
patch as it has not been reported as an issue and discovered only via
code inspection.

Mike Kravetz (2):
  mm: migration: fix migration of huge PMD shared pages
  hugetlb: take PMD sharing into account when flushing tlb/caches

 include/linux/hugetlb.h | 14 +++++++
 mm/hugetlb.c            | 93 +++++++++++++++++++++++++++++++++++++----
 mm/rmap.c               | 42 +++++++++++++++++--
 3 files changed, 137 insertions(+), 12 deletions(-)

-- 
2.17.1

