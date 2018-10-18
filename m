Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C274C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0A021477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ip7EG25U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0A021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeJRMJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:09:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36800 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeJRMJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:09:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9I49T9c191320;
        Thu, 18 Oct 2018 04:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=WpKJOt13oO9GdKIzUCUIf6uwwSO11fcDUAucu7TQbn8=;
 b=ip7EG25U+bema+gMV9ouIM33PZYbRf8ug/q37zPByT8HoChr5e2HOqbJfYC4Ts7s88HP
 50OjY6FQdpiGxphJuy3KcmEznWRO4i++xAN6/k7ECgPYJ6ECYkhSDJGLIslysmdLlEI1
 ZuE62PS9/DducgK9HkVQ+oT+4RFyoh+Klk7IYjLAKCvJiAe/AQhfrknv7BqVWtP+6hqS
 UwJzlDS+B9/FuhU5tSAdMDqvQJSvDCAZ9X7+aSo1mY8MDdlbGekCe0mDZJhXev1CRd2m
 IZKYXZXOZT1nbT28j2s0IkdcSyDJ78GCx24ZtIW/p6BHjHZAVE462OFWWxImMDk06Cc+ oA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2n384ucava-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 04:10:45 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9I4AhEW026865
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 04:10:44 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9I4Ag0l028441;
        Thu, 18 Oct 2018 04:10:42 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 21:10:42 -0700
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
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH] hugetlbfs: dirty pages as they are added to pagecache
Date:   Wed, 17 Oct 2018 21:10:22 -0700
Message-Id: <20181018041022.4529-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=909
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some test systems were experiencing negative huge page reserve
counts and incorrect file block counts.  This was traced to
/proc/sys/vm/drop_caches removing clean pages from hugetlbfs
file pagecaches.  When non-hugetlbfs explicit code removes the
pages, the appropriate accounting is not performed.

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

To address this issue, dirty pages as they are added to pagecache.
This can easily be reproduced with fallocate as shown above. Read
faulted pages will eventually end up being marked dirty.  But there
is a window where they are clean and could be impacted by code such
as drop_caches.  So, just dirty them all as they are added to the
pagecache.

In addition, it makes little sense to even try to drop hugetlbfs
pagecache pages, so disable calls to these filesystems in drop_caches
code.

Fixes: 70c3547e36f5 ("hugetlbfs: add hugetlbfs_fallocate()")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/drop_caches.c | 7 +++++++
 mm/hugetlb.c     | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 82377017130f..b72c5bc502a8 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -9,6 +9,7 @@
 #include <linux/writeback.h>
 #include <linux/sysctl.h>
 #include <linux/gfp.h>
+#include <linux/magic.h>
 #include "internal.h"
 
 /* A global variable is a bit ugly, but it keeps the code simple */
@@ -18,6 +19,12 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
 	struct inode *inode, *toput_inode = NULL;
 
+	/*
+	 * It makes no sense to try and drop hugetlbfs page cache pages.
+	 */
+	if (sb->s_magic == HUGETLBFS_MAGIC)
+		return;
+
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5c390f5a5207..7b5c0ad9a6bd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3690,6 +3690,12 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 		return err;
 	ClearPagePrivate(page);
 
+	/*
+	 * set page dirty so that it will not be removed from cache/file
+	 * by non-hugetlbfs specific code paths.
+	 */
+	set_page_dirty(page);
+
 	spin_lock(&inode->i_lock);
 	inode->i_blocks += blocks_per_huge_page(h);
 	spin_unlock(&inode->i_lock);
-- 
2.17.2

