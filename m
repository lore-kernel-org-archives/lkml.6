Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C9AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8632145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2yP37D10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8632145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeLCUKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:10:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57368 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeLCUKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:10:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3Jwl0a086283;
        Mon, 3 Dec 2018 20:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=OlWM2kIS3Z19L+4h3PRXLv5xgaZsAIbrRBC+3bhtAHM=;
 b=2yP37D10zf6yzKz+Jz9KKzevG4xdMaGEKEGLTIxtftWW+nQ9K3UdVfgUGgun3F1tEzQO
 fP0WCBdzXeUqKVHSV8kUG6UV3rjbzHILqICQWp1e9mlwu2ALHb/mfzfjXLP5ZyKKgPKg
 8XrS0Cbcu6VgkfF3lT7Lz3y+AcXizMjEbwoTLPZK56YhL+/L997ynwLAyWrsXtzL84EM
 /NZxllxboONKBSJVIRISxuVHAuKJ6ZKeI2pgstpQEWWTguleno45faFQWB0Rlc1l9tl+
 0DUiJJq+E3u/dMoRCZgbbPiJ4uAac7szaNYhKIteXXEDV4NaAiQVV7ndENjNcCILws0/ pw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2p3j8q8kpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Dec 2018 20:08:58 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB3K8weu017915
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Dec 2018 20:08:58 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB3K8v1Y017153;
        Mon, 3 Dec 2018 20:08:57 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 12:08:56 -0800
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
Subject: [PATCH 0/3] hugetlbfs: use i_mmap_rwsem for better synchronization
Date:   Mon,  3 Dec 2018 12:08:47 -0800
Message-Id: <20181203200850.6460-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=454
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are a follow up to the RFC,
http://lkml.kernel.org/r/20181024045053.1467-1-mike.kravetz@oracle.com
Comments made by Naoya were addressed.

There are two primary issues addressed here:
1) For shared pmds, huge PE pointers returned by huge_pte_alloc can become
   invalid via a call to huge_pmd_unshare by another thread.
2) hugetlbfs page faults can race with truncation causing invalid global
   reserve counts and state.
Both issues are addressed by expanding the use of i_mmap_rwsem.

These issues have existed for a long time.  They can be recreated with a
test program that causes page fault/truncation races.  For simple mappings,
this results in a negative HugePages_Rsvd count.  If racing with mappings
that contain shared pmds, we can hit "BUG at fs/hugetlbfs/inode.c:444!" or
Oops! as the result of an invalid memory reference.

I broke up the larger RFC into separate patches addressing each issue.
Hopefully, this is easier to understand/review.

Mike Kravetz (3):
  hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization
  hugetlbfs: Use i_mmap_rwsem to fix page fault/truncate race
  hugetlbfs: remove unnecessary code after i_mmap_rwsem synchronization

 fs/hugetlbfs/inode.c | 50 +++++++++----------------
 mm/hugetlb.c         | 87 +++++++++++++++++++++++++++++++-------------
 mm/memory-failure.c  | 14 ++++++-
 mm/migrate.c         | 13 ++++++-
 mm/rmap.c            |  3 ++
 mm/userfaultfd.c     | 11 +++++-
 6 files changed, 116 insertions(+), 62 deletions(-)

-- 
2.17.2

