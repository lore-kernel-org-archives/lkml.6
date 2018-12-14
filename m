Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C45AC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A8C2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789926;
	bh=85iGf4P4H3uGcKnolzDy4JEq77iOJBeASDD0Fh9wU1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Rk+MBnO32f5+o/b5l6b1A5v/eIVotfmGpVhc0x1fYf9hd4DiV6bFqmThEfCA8YtM
	 UvSe7qyNvcQDViB5gHSnJjgqqd98UsSuDegv2wO06iwgROegp4uWTGcau/ZGlfjDin
	 bRYO0+YwdprN0LrrHRO9BZeJ0nkvxbe0LwKYBJI8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A8C2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbeLNMQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:16:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732426AbeLNMQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E100214ED;
        Fri, 14 Dec 2018 12:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789770;
        bh=85iGf4P4H3uGcKnolzDy4JEq77iOJBeASDD0Fh9wU1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NmqgOh4Ab14jPNemIapUEZZbvVxGP3oJXPEuU9P7h/PlHAyfZZBvop8ldK3zl1gYq
         CnjhIQ47Ay3UUtf5anueL8eWlyVYzpC1S4su7/5oOeCnMUiFR7OBHAw5+C7Zcw8Rru
         VdJ9Z7Ab1wfNnZjBzC6OyV2V6mwMJJkDsDoTK93Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Rue <dan.rue@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 71/88] hugetlbfs: fix bug in pgoff overflow checking
Date:   Fri, 14 Dec 2018 13:00:45 +0100
Message-Id: <20181214115708.110814029@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Kravetz <mike.kravetz@oracle.com>

commit 5df63c2a149ae65a9ec239e7c2af44efa6f79beb upstream.

This is a fix for a regression in 32 bit kernels caused by an invalid
check for pgoff overflow in hugetlbfs mmap setup.  The check incorrectly
specified that the size of a loff_t was the same as the size of a long.
The regression prevents mapping hugetlbfs files at offsets greater than
4GB on 32 bit kernels.

On 32 bit kernels conversion from a page based unsigned long can not
overflow a loff_t byte offset.  Therefore, skip this check if
sizeof(unsigned long) != sizeof(loff_t).

Link: http://lkml.kernel.org/r/20180330145402.5053-1-mike.kravetz@oracle.com
Fixes: 63489f8e8211 ("hugetlbfs: check for pgoff value overflow")
Reported-by: Dan Rue <dan.rue@linaro.org>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Nic Losby <blurbdust@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/hugetlbfs/inode.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -148,10 +148,14 @@ static int hugetlbfs_file_mmap(struct fi
 
 	/*
 	 * page based offset in vm_pgoff could be sufficiently large to
-	 * overflow a (l)off_t when converted to byte offset.
+	 * overflow a loff_t when converted to byte offset.  This can
+	 * only happen on architectures where sizeof(loff_t) ==
+	 * sizeof(unsigned long).  So, only check in those instances.
 	 */
-	if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
-		return -EINVAL;
+	if (sizeof(unsigned long) == sizeof(loff_t)) {
+		if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
+			return -EINVAL;
+	}
 
 	/* must be huge page aligned */
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))


