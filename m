Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD7DC10F0B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6F420661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957201;
	bh=84Fw57FnMIzJ6hVsnyWXrvOB4ID1IjUlwL7ztUwPIuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wy4wvH+z8v1OkikUO2mD1VsGhOzZhfawDApgnWuNA/ZmrrBLfJ0NPaxdy/olyOPXd
	 XOoGjGZNLgtKs7fjGTZBFMSX50PxQ9+Hqc687HD3CLOwR+R6wv3r1NvsNt6EYmy6TL
	 LvjlEyKJvF2vJZKSt/QaTJ7Vcvnm7/nh1XUJdOd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfBWVH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:07:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbfBWVHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E19B2085A;
        Sat, 23 Feb 2019 21:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956043;
        bh=84Fw57FnMIzJ6hVsnyWXrvOB4ID1IjUlwL7ztUwPIuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oE+a5z6hn0xjpDntDUIBoNUXoxhqY5Lyni0SLMgJEyLCX7C6kXZtOHMIgnRN5CBuc
         akuamW00f7z/vItrr+yW9bCPVcVeAJZghMdrbmSK7VIzzMvOrUBiXdFMt8y46KRokf
         y5tS6bAtULmrlAPr0MCgLuvPIA+aFtECVrHJYVgs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 25/65] iomap: get/put the page in iomap_page_create/release()
Date:   Sat, 23 Feb 2019 16:06:00 -0500
Message-Id: <20190223210640.200911-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piotr Jaroszynski <pjaroszynski@nvidia.com>

[ Upstream commit 8e47a457321ca1a74ad194ab5dcbca764bc70731 ]

migrate_page_move_mapping() expects pages with private data set to have
a page_count elevated by 1.  This is what used to happen for xfs through
the buffer_heads code before the switch to iomap in commit 82cb14175e7d
("xfs: add support for sub-pagesize writeback without buffer_heads").
Not having the count elevated causes move_pages() to fail on memory
mapped files coming from xfs.

Make iomap compatible with the migrate_page_move_mapping() assumption by
elevating the page count as part of iomap_page_create() and lowering it
in iomap_page_release().

It causes the move_pages() syscall to misbehave on memory mapped files
from xfs.  It does not not move any pages, which I suppose is "just" a
perf issue, but it also ends up returning a positive number which is out
of spec for the syscall.  Talking to Michal Hocko, it sounds like
returning positive numbers might be a necessary update to move_pages()
anyway though.

Fixes: 82cb14175e7d ("xfs: add support for sub-pagesize writeback without buffer_heads")
Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>
[hch: actually get/put the page iomap_migrate_page() to make it work
      properly]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/iomap.c b/fs/iomap.c
index e57fb1e534c5a..2e3e64012db7e 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -117,6 +117,12 @@ iomap_page_create(struct inode *inode, struct page *page)
 	atomic_set(&iop->read_count, 0);
 	atomic_set(&iop->write_count, 0);
 	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+
+	/*
+	 * migrate_page_move_mapping() assumes that pages with private data have
+	 * their count elevated by 1.
+	 */
+	get_page(page);
 	set_page_private(page, (unsigned long)iop);
 	SetPagePrivate(page);
 	return iop;
@@ -133,6 +139,7 @@ iomap_page_release(struct page *page)
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
 	ClearPagePrivate(page);
 	set_page_private(page, 0);
+	put_page(page);
 	kfree(iop);
 }
 
@@ -565,8 +572,10 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 
 	if (page_has_private(page)) {
 		ClearPagePrivate(page);
+		get_page(newpage);
 		set_page_private(newpage, page_private(page));
 		set_page_private(page, 0);
+		put_page(page);
 		SetPagePrivate(newpage);
 	}
 
-- 
2.19.1

