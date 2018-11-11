Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC41C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EF520866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o17/IVEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EF520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbeKLIS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732788AbeKLISZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:25 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8674121508;
        Sun, 11 Nov 2018 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975309;
        bh=IzGQjBeLo7hVTgOMjVSiX5SjNYHBrNS27f9oWCBzYDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o17/IVEkHfSfBSI6nC4IN/iz+Y7bb92MvH+4nEBFSjw6qDJ6/om3Cpp0Xt/yojrsH
         kbCUQCY8BclCY3VvHARNyz4+Z8a2RthG2/x9qqYkpLYtM6GniGCt67sLOQ9zMIorKG
         f3X3HF+BvIOeT/hp8khQ1vntZjMxYVRx0QvhC0zw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Mihcla Hocko <mhocko@suse.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 252/361] hugetlbfs: dirty pages as they are added to pagecache
Date:   Sun, 11 Nov 2018 14:19:59 -0800
Message-Id: <20181111221653.284125624@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/hugetlb.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3690,6 +3690,12 @@ int huge_add_to_page_cache(struct page *
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


