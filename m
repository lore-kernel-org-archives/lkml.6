Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8574BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5706921917
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k8ik7g5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392841AbeLVWau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 17:30:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44924 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389556AbeLVWat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 17:30:49 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBMMU5Q3066644;
        Sat, 22 Dec 2018 22:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=wtu1GGFNK6G+0CF7J2nlgfjqVzVI2PTKDBbjhKnw6oY=;
 b=k8ik7g5Io0VeLExmOQv0fDZY4rlGpnAx9NvDzkj97EdmGQyS8ubFekzR52OsgNUPIMWb
 uZwvMoYqqWD2x6Gr2hY66sq01PJqKhlrKftw9N0br5lMoTBT+v/U5OGYHWXyBkGqcjcg
 rZSp0A5Ek5OVpZkh1G3wAauyKNWkDN6Pw9OmLlTxV5KSwfKZmW6+GxaosSaQX2urGmtk
 k+Tb+kVxQkPYbY5Yn4Zpn96Roq7nSGS5TuRT4iCilhBQDiKHWkXcUMDLvHq/cYlucQD6
 aZlrx7/GSapP/XhSiFQ+l7PP9wYyWh72B6LdRcGqWFv6QkPedaBESBgxHKfZ5ORW1SAs PA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2phasdhh0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Dec 2018 22:30:34 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBMMUWA3014577
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Dec 2018 22:30:33 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBMMUVBC019715;
        Sat, 22 Dec 2018 22:30:31 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 22 Dec 2018 14:30:31 -0800
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
Subject: [PATCH v3 0/2] hugetlbfs: use i_mmap_rwsem for better synchronization
Date:   Sat, 22 Dec 2018 14:30:11 -0800
Message-Id: <20181222223013.22193-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9115 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=363
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812220204
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

v2 -> v3
  Incorporated suggestions from Kirill.  Code change to hold i_mmap_rwsem
  for duration of copy in copy_hugetlb_page_range.  Took i_mmap_rwsem in
  hugetlbfs_evict_inode to be consistent with other callers.  Other changes
  were to documentation/comments.
v1 -> v2
  Combined patches 2 and 3 of v1 series as suggested by Aneesh.  No other
  changes were made.
Patches are a follow up to the RFC,
  http://lkml.kernel.org/r/20181024045053.1467-1-mike.kravetz@oracle.com
  Comments made by Naoya were addressed.

Mike Kravetz (2):
  hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization
  hugetlbfs: Use i_mmap_rwsem to fix page fault/truncate race

 fs/hugetlbfs/inode.c | 61 +++++++++++++++-----------------
 mm/hugetlb.c         | 84 +++++++++++++++++++++++++++++++-------------
 mm/memory-failure.c  | 14 +++++++-
 mm/migrate.c         | 13 ++++++-
 mm/rmap.c            |  4 +++
 mm/userfaultfd.c     | 11 ++++--
 6 files changed, 125 insertions(+), 62 deletions(-)

-- 
2.17.2

