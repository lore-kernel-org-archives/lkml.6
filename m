Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2310C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66182184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XmGvtUJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeLRWgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:36:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51446 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeLRWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:36:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBIMY49G194290;
        Tue, 18 Dec 2018 22:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ZEyi/mJaQCtnsfh/MuvJPVrz32g9rgqB4m3iXTu6uXo=;
 b=XmGvtUJG6WHgkEdyvGm2qRovE+L/Llr2whf9j6f2QMBrX8llq+V23XCL0ZBkE76LKcaN
 iBoxw+/MgZqtS7zY20UVvhEj7+OvYmMgBfIsouBNwpKmzkIrRLnChSFzxXny9EtpED3r
 eStWa1/9Sg7YKemyUE7gPP0VB/l/mbq9V6LBgigoLzJ45ZdvlP0qmJwCpOliF/KHnlEG
 l1grgSNoX/UrXcSFjUy14Re/o16IrHZfW3/ICu7ov5zEiVDxvNIwTwfDORgIxYLBTone
 1MWEWZNM6cmQzcLk9lHyA8qRAUy/70rjm0lut/jLwnuOt3/kPOyMu+yXHvLdVmVFtA1L Xg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2pct8qx3w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 22:36:05 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBIMa5mH012213
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 22:36:05 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBIMa4bP029999;
        Tue, 18 Dec 2018 22:36:04 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 14:36:04 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 0/2] hugetlbfs: use i_mmap_rwsem for better synchronization
Date:   Tue, 18 Dec 2018 14:35:55 -0800
Message-Id: <20181218223557.5202-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9111 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=424
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two primary issues addressed here:
1) For shared pmds, huge PTE pointers returned by huge_pte_alloc can become
   invalid via a call to huge_pmd_unshare by another thread.
2) hugetlbfs page faults can race with truncation causing invalid global
   reserve counts and state.
Both issues are addressed by expanding the use of i_mmap_rwsem.

These issues have existed for a long time.  They can be recreated with a
test program that causes page fault/truncation races.  For simple mappings,
this results in a negative HugePages_Rsvd count.  If racing with mappings
that contain shared pmds, we can hit "BUG at fs/hugetlbfs/inode.c:444!" or
Oops! as the result of an invalid memory reference.

v1 -> v2
  Combined patches 2 and 3 of v1 series as suggested by Aneesh.  No other
  changes were made.
Patches are a follow up to the RFC,
  http://lkml.kernel.org/r/20181024045053.1467-1-mike.kravetz@oracle.com
  Comments made by Naoya were addressed.

Mike Kravetz (2):
  hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization
  hugetlbfs: Use i_mmap_rwsem to fix page fault/truncate race

 fs/hugetlbfs/inode.c | 50 +++++++++----------------
 mm/hugetlb.c         | 87 +++++++++++++++++++++++++++++++-------------
 mm/memory-failure.c  | 14 ++++++-
 mm/migrate.c         | 13 ++++++-
 mm/rmap.c            |  3 ++
 mm/userfaultfd.c     | 11 +++++-
 6 files changed, 116 insertions(+), 62 deletions(-)

-- 
2.17.2

