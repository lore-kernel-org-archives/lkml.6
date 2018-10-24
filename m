Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B5FC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A112207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kQSYQ8HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A112207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeJXNTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 09:19:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58506 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeJXNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 09:19:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9O4iBX0162936;
        Wed, 24 Oct 2018 04:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=AyUcklR2+ZE2sBdFRyUml0HTUf4myfsqASFPXEU59fM=;
 b=kQSYQ8HLZILUYGeuBe27keoBJCsvaZhQT1sZJ4jngejfGu92yrlSZWTi8qlQ6UzXCFnz
 epnscRlbPpuSib+xTXpHKin5oygBB1yjsi6Akw4lnbt5JeqxCr+np2WworkgaLDDPFx+
 4mjEIDFy2xzn9sTmjmYXSaEoHTgt330zNs93Vk/qlUjMCrAEPxSN3yFpkCUBeHOhQHoQ
 71kxx1HefRwo+Kdkayl6jolNVKpmcgr5vAsE/HJsFZtND9eIX22LZFoXa10JJA/NxMZN
 xS4KkiCoEkUrOKG4ASuAuacqJP+DtNC6fGlDNwbY1PQvs+xyaeogX+f3amm+vpYYsppr WQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0qs1qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 04:51:00 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9O4p0O2002338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 04:51:00 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9O4owdr011897;
        Wed, 24 Oct 2018 04:50:58 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 21:50:57 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC v2 0/1] hugetlbfs: Use i_mmap_rwsem for pmd share and fault/trunc
Date:   Tue, 23 Oct 2018 21:50:52 -0700
Message-Id: <20181024045053.1467-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=283
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses issues with page fault/truncation synchronization.
The first issue was noticed as a negative hugetlb reserved page counts
during DB development testing.  Code inspection revealed that the most
likely cause were races with truncate and page faults.  In fact, I could
write a not too complicated program to cause the races and recreate the
issue.

A more dangerous issue exists when you introduce huge pmd sharing to
page fault/truncate races.  The fist thing that happens in huge page
fault processing is a call to huge_pte_alloc to get a ptep.  Suppose
that ptep points to a shared pmd.  Now, another thread could perform
a truncate and unmap everyone mapping the file.  huge_pmd_unshare can
be called for the mapping on which the first thread is operating.
huge_pmd_unshare can clear pud pointing to the pmd.  After this, the
ptep points to another task's page table or worse.  This leads to bad
things such as incorrect page map/reference counts or invaid memory
references.

Fix this all by modifying the usage of i_mmap_rwsem to cover
fault/truncate races as well as handling of shared pmds

Mike Kravetz (1):
  hugetlbfs: use i_mmap_rwsem for pmd sharing and truncate/fault sync

 fs/hugetlbfs/inode.c | 21 ++++++++++----
 mm/hugetlb.c         | 65 +++++++++++++++++++++++++++++++++-----------
 mm/rmap.c            | 10 +++++++
 mm/userfaultfd.c     | 11 ++++++--
 4 files changed, 84 insertions(+), 23 deletions(-)

-- 
2.17.2

