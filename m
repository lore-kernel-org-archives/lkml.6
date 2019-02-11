Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3CBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDE821B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896751;
	bh=H+W83pPOWz7JISs4TurBJBvN+grw1a12Ol4WtJxt+0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zkEeirfuiCvbMiSzcUSpFSjBIRwADItSruNgcIJlCZzINIRvqhGTa22A91c8ui0B+
	 mzZWi6nH0iRzx2WfP3BEZBbs9nxL71R3JxvWmg30kR4/6R8eoJfcEEJr8O5FzcNWbb
	 IJ37AmfBs9vij/qwCIJ/Dhwhk32xqijHjRF6cotc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbfBKOwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388433AbfBKOw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFCE42081B;
        Mon, 11 Feb 2019 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896746;
        bh=H+W83pPOWz7JISs4TurBJBvN+grw1a12Ol4WtJxt+0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0ej70ZoatATxd/j0XOAAzAiDdWypk3klm2AN1/+bOMSux2df1x0M4a7xTWRaN0Da
         GtFvIh9BzGfZZyNDmTPoNe2j1beNfSBafwKH0aiyM2hItCLZkSrYEsH23UaEAVukTN
         vHqPolsYuwPx2iRMGjsDPhUESlrD4NaWSfzJB9dc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 256/313] xfs: fix PAGE_MASK usage in xfs_free_file_space
Date:   Mon, 11 Feb 2019 15:18:56 +0100
Message-Id: <20190211141910.419927356@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

commit a579121f94aba4e8bad1a121a0fad050d6925296 upstream.

In commit e53c4b598, I *tried* to teach xfs to force writeback when we
fzero/fpunch right up to EOF so that if EOF is in the middle of a page,
the post-EOF part of the page gets zeroed before we return to userspace.
Unfortunately, I missed the part where PAGE_MASK is ~(PAGE_SIZE - 1),
which means that we totally fail to zero if we're fpunching and EOF is
within the first page.  Worse yet, the same PAGE_MASK thinko plagues the
filemap_write_and_wait_range call, so we'd initiate writeback of the
entire file, which (mostly) masked the thinko.

Drop the tricky PAGE_MASK and replace it with correct usage of PAGE_SIZE
and the proper rounding macros.

Fixes: e53c4b598 ("xfs: ensure post-EOF zeroing happens after zeroing part of a file")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_bmap_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 9d1e5c3a661e..211b06e4702e 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1175,9 +1175,9 @@ xfs_free_file_space(
 	 * page could be mmap'd and iomap_zero_range doesn't do that for us.
 	 * Writeback of the eof page will do this, albeit clumsily.
 	 */
-	if (offset + len >= XFS_ISIZE(ip) && ((offset + len) & PAGE_MASK)) {
+	if (offset + len >= XFS_ISIZE(ip) && offset_in_page(offset + len) > 0) {
 		error = filemap_write_and_wait_range(VFS_I(ip)->i_mapping,
-				(offset + len) & ~PAGE_MASK, LLONG_MAX);
+				round_down(offset + len, PAGE_SIZE), LLONG_MAX);
 	}
 
 	return error;
-- 
2.19.1



