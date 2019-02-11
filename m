Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2324C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823C02081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895858;
	bh=rp6SeT7cAw2aFGUMNNoH7aaBxC7cm9kDAI+OYoaCCdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RE9UAlLPagpvLbyb9UsWxymF9DmL7Yt5azaQODjQJ2Lg1pc+alXctKvbilirgYiXx
	 pTm1ITbKYpeXUj4eFOkR/D8LAkkvYDn8GXDCNr3lvUla2gOAv0oQdWmnLmEI48RhM6
	 VvIdOoDr8I0kkkPTI/upKjfFFU9qjy5t+As3hwXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfBKOhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:37:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730864AbfBKOhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:37:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF0B920700;
        Mon, 11 Feb 2019 14:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895852;
        bh=rp6SeT7cAw2aFGUMNNoH7aaBxC7cm9kDAI+OYoaCCdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wNXMknxgy4azwNjx6cLoLGhlryM5++DIh0F6NXrXDTsYusIC61dsWOQXuZZVjsq1R
         5JBXdcltdRygp0d1I46VSLmKb1DcPeipuuBUMG8OuIFjbiMX/CtT5FKMyhOmcamIs1
         63tTw9YJaw8xpFf/vP0VgT4V/3aS9ifbqXcF3Meo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 4.20 313/352] xfs: eof trim writeback mapping as soon as it is cached
Date:   Mon, 11 Feb 2019 15:19:00 +0100
Message-Id: <20190211141906.755066751@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Foster <bfoster@redhat.com>

commit aa6ee4ab69293969867ab09b57546d226ace3d7a upstream.

The cached writeback mapping is EOF trimmed to try and avoid races
between post-eof block management and writeback that result in
sending cached data to a stale location. The cached mapping is
currently trimmed on the validation check, which leaves a race
window between the time the mapping is cached and when it is trimmed
against the current inode size.

For example, if a new mapping is cached by delalloc conversion on a
blocksize == page size fs, we could cycle various locks, perform
memory allocations, etc.  in the writeback codepath before the
associated mapping is eventually trimmed to i_size. This leaves
enough time for a post-eof truncate and file append before the
cached mapping is trimmed. The former event essentially invalidates
a range of the cached mapping and the latter bumps the inode size
such the trim on the next writepage event won't trim all of the
invalid blocks. fstest generic/464 reproduces this scenario
occasionally and causes a lost writeback and stale delalloc blocks
warning on inode inactivation.

To work around this problem, trim the cached writeback mapping as
soon as it is cached in addition to on subsequent validation checks.
This is a minor tweak to tighten the race window as much as possible
until a proper invalidation mechanism is available.

Fixes: 40214d128e07 ("xfs: trim writepage mapping to within eof")
Cc: <stable@vger.kernel.org> # v4.14+
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_aops.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -449,6 +449,7 @@ xfs_map_blocks(
 	}
 
 	wpc->imap = imap;
+	xfs_trim_extent_eof(&wpc->imap, ip);
 	trace_xfs_map_blocks_found(ip, offset, count, wpc->io_type, &imap);
 	return 0;
 allocate_blocks:
@@ -459,6 +460,7 @@ allocate_blocks:
 	ASSERT(whichfork == XFS_COW_FORK || cow_fsb == NULLFILEOFF ||
 	       imap.br_startoff + imap.br_blockcount <= cow_fsb);
 	wpc->imap = imap;
+	xfs_trim_extent_eof(&wpc->imap, ip);
 	trace_xfs_map_blocks_alloc(ip, offset, count, wpc->io_type, &imap);
 	return 0;
 }


