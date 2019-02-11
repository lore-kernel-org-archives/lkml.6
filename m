Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B343C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A88C222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899381;
	bh=dcOVIART2IzLvjZPnq7Tr59A29Nr8oIiJe/yaKrkE6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tv9NX56VFWcAZoxpNyY3kjh1AiPvKWv2wmXRgWae4s90KKbHzstXtygOcAcAR9bcT
	 KAUiJKWvCW6mGREVndu3Kqp3yPHMsLJIroKpxMObYvX3XRi4dpsc2YCMUmZtqqSFCu
	 x/BMwIXqbIyUr5XX+GqEfaJ8fy+Awa8Jsg4e7n/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbfBKPgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:36:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388356AbfBKOwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B864B2081B;
        Mon, 11 Feb 2019 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896722;
        bh=dcOVIART2IzLvjZPnq7Tr59A29Nr8oIiJe/yaKrkE6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2Zu6XRRoeUwaDldwrCqYBnIBlbB8sM/KA6Tg6mEKncP670csPF0O7SdD3H1ioNxC
         NK68PSSHR8ThSFYEPnrnrvExPp2N0OHXJG8ZAwh41/vQduVNv2Tf8mu7jLqJhXwmnb
         2qOl2cUsNFFueTDSDFOZ55k3vmDLsnpa4/1gIe/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 252/313] xfs: fix shared extent data corruption due to missing cow reservation
Date:   Mon, 11 Feb 2019 15:18:52 +0100
Message-Id: <20190211141910.169800156@linuxfoundation.org>
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

commit 59e4293149106fb92530f8e56fa3992d8548c5e6 upstream.

Page writeback indirectly handles shared extents via the existence
of overlapping COW fork blocks. If COW fork blocks exist, writeback
always performs the associated copy-on-write regardless if the
underlying blocks are actually shared. If the blocks are shared,
then overlapping COW fork blocks must always exist.

fstests shared/010 reproduces a case where a buffered write occurs
over a shared block without performing the requisite COW fork
reservation.  This ultimately causes writeback to the shared extent
and data corruption that is detected across md5 checks of the
filesystem across a mount cycle.

The problem occurs when a buffered write lands over a shared extent
that crosses an extent size hint boundary and that also happens to
have a partial COW reservation that doesn't cover the start and end
blocks of the data fork extent.

For example, a buffered write occurs across the file offset (in FSB
units) range of [29, 57]. A shared extent exists at blocks [29, 35]
and COW reservation already exists at blocks [32, 34]. After
accommodating a COW extent size hint of 32 blocks and the existing
reservation at offset 32, xfs_reflink_reserve_cow() allocates 32
blocks of reservation at offset 0 and returns with COW reservation
across the range of [0, 34]. The associated data fork extent is
still [29, 35], however, which isn't fully covered by the COW
reservation.

This leads to a buffered write at file offset 35 over a shared
extent without associated COW reservation. Writeback eventually
kicks in, performs an overwrite of the underlying shared block and
causes the associated data corruption.

Update xfs_reflink_reserve_cow() to accommodate the fact that a
delalloc allocation request may not fully cover the extent in the
data fork. Trim the data fork extent appropriately, just as is done
for shared extent boundaries and/or existing COW reservations that
happen to overlap the start of the data fork extent. This prevents
shared/010 failures due to data corruption on reflink enabled
filesystems.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_reflink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 42ea7bab9144..7088f44c0c59 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -302,6 +302,7 @@ xfs_reflink_reserve_cow(
 	if (error)
 		return error;
 
+	xfs_trim_extent(imap, got.br_startoff, got.br_blockcount);
 	trace_xfs_reflink_cow_alloc(ip, &got);
 	return 0;
 }
-- 
2.19.1



