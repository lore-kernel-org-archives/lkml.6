Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD20C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE9B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896746;
	bh=/dtmye/Z5awe/WIl4nDxrdGY0kr+ao27PddBoWsCais=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zRgNEoyKzECUDMwQQwX0POfm/MhXTNAVHz4gRLjKOozT6pu8Ek3qySvEV3RPirzK/
	 1NVT3ep3eN51Yz/2NSQUxpnjyRSR/rKvEAnI3QgvB2wPJwq2tVH/o/q9FKY5tDpGrD
	 2v3wRbzNHTe0W/P/A7SjegfPdbq4sI1f09c0CIgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388423AbfBKOwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732094AbfBKOwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF4E2081B;
        Mon, 11 Feb 2019 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896740;
        bh=/dtmye/Z5awe/WIl4nDxrdGY0kr+ao27PddBoWsCais=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQX8SKx4B/D9ej57gwit3aGmpq+dEKu5yvya/Uxm6OfpA6msUtYQvlPE1lDR7FZqs
         7xg8NXe9qF38pR6BuFSJ6O/TGws2YKYExje5Mu2dPN092q1Itr5h6qJ6ugNB/dtA6m
         eMHzJspib2HlDQ0G5OHIWWKgLA/vFC/HI+vHB6SM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 254/313] xfs: delalloc -> unwritten COW fork allocation can go wrong
Date:   Mon, 11 Feb 2019 15:18:54 +0100
Message-Id: <20190211141910.303412484@linuxfoundation.org>
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

commit 9230a0b65b47fe6856c4468ec0175c4987e5bede upstream.

Long saga. There have been days spent following this through dead end
after dead end in multi-GB event traces. This morning, after writing
a trace-cmd wrapper that enabled me to be more selective about XFS
trace points, I discovered that I could get just enough essential
tracepoints enabled that there was a 50:50 chance the fsx config
would fail at ~115k ops. If it didn't fail at op 115547, I stopped
fsx at op 115548 anyway.

That gave me two traces - one where the problem manifested, and one
where it didn't. After refining the traces to have the necessary
information, I found that in the failing case there was a real
extent in the COW fork compared to an unwritten extent in the
working case.

Walking back through the two traces to the point where the CWO fork
extents actually diverged, I found that the bad case had an extra
unwritten extent in it. This is likely because the bug it led me to
had triggered multiple times in those 115k ops, leaving stray
COW extents around. What I saw was a COW delalloc conversion to an
unwritten extent (as they should always be through
xfs_iomap_write_allocate()) resulted in a /written extent/:

xfs_writepage:        dev 259:0 ino 0x83 pgoff 0x17000 size 0x79a00 offset 0 length 0
xfs_iext_remove:      dev 259:0 ino 0x83 state RC|LF|RF|COW cur 0xffff888247b899c0/2 offset 32 block 152 count 20 flag 1 caller xfs_bmap_add_extent_delay_real
xfs_bmap_pre_update:  dev 259:0 ino 0x83 state RC|LF|RF|COW cur 0xffff888247b899c0/1 offset 1 block 4503599627239429 count 31 flag 0 caller xfs_bmap_add_extent_delay_real
xfs_bmap_post_update: dev 259:0 ino 0x83 state RC|LF|RF|COW cur 0xffff888247b899c0/1 offset 1 block 121 count 51 flag 0 caller xfs_bmap_add_ex

Basically, Cow fork before:

	0 1            32          52
	+H+DDDDDDDDDDDD+UUUUUUUUUUU+
	   PREV		RIGHT

COW delalloc conversion allocates:

	  1	       32
	  +uuuuuuuuuuuu+
	  NEW

And the result according to the xfs_bmap_post_update trace was:

	0 1            32          52
	+H+wwwwwwwwwwwwwwwwwwwwwwww+
	   PREV

Which is clearly wrong - it should be a merged unwritten extent,
not an unwritten extent.

That lead me to look at the LEFT_FILLING|RIGHT_FILLING|RIGHT_CONTIG
case in xfs_bmap_add_extent_delay_real(), and sure enough, there's
the bug.

It takes the old delalloc extent (PREV) and adds the length of the
RIGHT extent to it, takes the start block from NEW, removes the
RIGHT extent and then updates PREV with the new extent.

What it fails to do is update PREV.br_state. For delalloc, this is
always XFS_EXT_NORM, while in this case we are converting the
delayed allocation to unwritten, so it needs to be updated to
XFS_EXT_UNWRITTEN. This LF|RF|RC case does not do this, and so
the resultant extent is always written.

And that's the bug I've been chasing for a week - a bmap btree bug,
not a reflink/dedupe/copy_file_range bug, but a BMBT bug introduced
with the recent in core extent tree scalability enhancements.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index a47670332326..3a496ffe6551 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -1683,10 +1683,13 @@ xfs_bmap_add_extent_delay_real(
 	case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING | BMAP_RIGHT_CONTIG:
 		/*
 		 * Filling in all of a previously delayed allocation extent.
-		 * The right neighbor is contiguous, the left is not.
+		 * The right neighbor is contiguous, the left is not. Take care
+		 * with delay -> unwritten extent allocation here because the
+		 * delalloc record we are overwriting is always written.
 		 */
 		PREV.br_startblock = new->br_startblock;
 		PREV.br_blockcount += RIGHT.br_blockcount;
+		PREV.br_state = new->br_state;
 
 		xfs_iext_next(ifp, &bma->icur);
 		xfs_iext_remove(bma->ip, &bma->icur, state);
-- 
2.19.1



