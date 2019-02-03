Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B492082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfBCOUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55506 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729962AbfBCOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:41 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdT-0006LF-LZ; Sun, 03 Feb 2019 14:20:39 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Z-00070J-Cl; Sun, 03 Feb 2019 14:49:45 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Mihcla Hocko" <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "Khalid Aziz" <khalid.aziz@oracle.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.778284758@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 119/305] hugetlbfs: dirty pages as they are added to
 pagecache
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Kravetz <mike.kravetz@oracle.com>

commit 22146c3ce98962436e401f7b7016a6f664c9ffb5 upstream.

Some test systems were experiencing negative huge page reserve counts and
incorrect file block counts.  This was traced to /proc/sys/vm/drop_caches
removing clean pages from hugetlbfs file pagecaches.  When non-hugetlbfs
explicit code removes the pages, the appropriate accounting is not
performed.

This can be recreated as follows:
 fallocate -l 2M /dev/hugepages/foo
 echo 1 > /proc/sys/vm/drop_caches
 fallocate -l 2M /dev/hugepages/foo
 grep -i huge /proc/meminfo
   AnonHugePages:         0 kB
   ShmemHugePages:        0 kB
   HugePages_Total:    2048
   HugePages_Free:     2047
   HugePages_Rsvd:    18446744073709551615
   HugePages_Surp:        0
   Hugepagesize:       2048 kB
   Hugetlb:         4194304 kB
 ls -lsh /dev/hugepages/foo
   4.0M -rw-r--r--. 1 root root 2.0M Oct 17 20:05 /dev/hugepages/foo

To address this issue, dirty pages as they are added to pagecache.  This
can easily be reproduced with fallocate as shown above.  Read faulted
pages will eventually end up being marked dirty.  But there is a window
where they are clean and could be impacted by code such as drop_caches.
So, just dirty them all as they are added to the pagecache.

Link: http://lkml.kernel.org/r/b5be45b8-5afe-56cd-9482-28384699a049@oracle.com
Fixes: 6bda666a03f0 ("hugepages: fold find_or_alloc_pages into huge_no_page()")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Mihcla Hocko <mhocko@suse.com>
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/hugetlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3085,6 +3085,12 @@ retry:
 			}
 			ClearPagePrivate(page);
 
+			/*
+			 * set page dirty so that it will not be removed from
+			 * cache/file by non-hugetlbfs specific code paths.
+			 */
+			set_page_dirty(page);
+
 			spin_lock(&inode->i_lock);
 			inode->i_blocks += blocks_per_huge_page(h);
 			spin_unlock(&inode->i_lock);

