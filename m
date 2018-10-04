Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF4CC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E07F2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E07F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeJDHyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:54:08 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:15683 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbeJDHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:54:04 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 04 Oct 2018 10:33:13 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g7s2q-0001LP-1O; Thu, 04 Oct 2018 11:03:12 +1000
Date:   Thu, 4 Oct 2018 11:03:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     gregkh@linuxfoundation.org
Cc:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net
Subject: [GIT PULL] xfs: fixes for 4.19-rc6
Message-ID: <20181004010311.GU31060@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Can you please pull the XFS from the tag listed below. It's a bit
bigger than that I'd like this late in the cycle, but we've had a
few challenges getting ourselves sorted out this cycle. Details
of the contents are in the pull-req output below. This has been be
run through xfstests over the past week, and merges against 4.19-rc6
cleanly.

FYI, there is likely to be one more XFS fix for this cycle - we've
just tracked down the source of a clone_file_range() data corruption
so I'll send that as a separate pullreq once Darrick's fix is
reviewed and tested.

Cheers,

Dave.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux tags/xfs-fixes-for-4.19-rc6

for you to fetch changes up to e55ec4ddbef9897199c307dfb23167e3801fdaf5:

  xfs: fix error handling in xfs_bmap_extents_to_btree (2018-10-01 08:11:07 +1000)

----------------------------------------------------------------
XFS fixes for 4.19-rc6

Accumlated regression and bug fixes for 4.19-rc6, including:

o make iomap correctly mark dirty pages for sub-page block sizes
o fix regression in handling extent-to-btree format conversion errors
o fix torn log wrap detection for new logs
o various corrupt inode detection fixes
o various delalloc state fixes
o cleanup all the missed transaction cancel cases missed from changes merged
  in 4.19-rc1
o fix lockdep false positive on transaction allocation
o fix locking and reference counting on buffer log items

----------------------------------------------------------------
Brian Foster (6):
      xfs: remove last of unnecessary xfs_defer_cancel() callers
      xfs: don't unlock invalidated buf on aborted tx commit
      xfs: clean up xfs_trans_brelse()
      xfs: refactor xfs_buf_log_item reference count handling
      xfs: remove invalid log recovery first/last cycle check
      iomap: set page dirty after partial delalloc on mkwrite

Christoph Hellwig (2):
      xfs: don't bring in extents in xfs_bmap_punch_delalloc_range
      xfs: skip delalloc COW blocks in xfs_reflink_end_cow

Darrick J. Wong (1):
      xfs: don't crash the vfs on a garbage inline symlink

Dave Chinner (3):
      xfs: avoid lockdep false positives in xfs_trans_alloc
      xfs: fix transaction leak in xfs_reflink_allocate_cow()
      xfs: fix error handling in xfs_bmap_extents_to_btree

Eric Sandeen (2):
      xfs: don't treat unknown di_flags2 as corruption in scrub
      xfs: validate inode di_forkoff

YueHaibing (1):
      xfs: remove duplicated include from alloc.c

 fs/iomap.c                      |   2 +-
 fs/xfs/libxfs/xfs_attr.c        |  28 +++-----
 fs/xfs/libxfs/xfs_attr_remote.c |  10 +--
 fs/xfs/libxfs/xfs_bmap.c        |  24 +++----
 fs/xfs/libxfs/xfs_format.h      |   2 +
 fs/xfs/libxfs/xfs_inode_buf.c   |  30 +++++++++
 fs/xfs/scrub/alloc.c            |   1 -
 fs/xfs/scrub/inode.c            |   4 +-
 fs/xfs/xfs_bmap_util.c          |  20 ++----
 fs/xfs/xfs_buf_item.c           | 119 ++++++++++++++++++----------------
 fs/xfs/xfs_buf_item.h           |   1 +
 fs/xfs/xfs_inode.c              |  10 +--
 fs/xfs/xfs_iops.c               |  12 +++-
 fs/xfs/xfs_log_recover.c        |  10 ---
 fs/xfs/xfs_reflink.c            | 137 ++++++++++++++++++++++++----------------
 fs/xfs/xfs_trace.h              |   1 -
 fs/xfs/xfs_trans.c              |  10 ++-
 fs/xfs/xfs_trans_buf.c          |  99 +++++++----------------------
 18 files changed, 256 insertions(+), 264 deletions(-)
-- 
Dave Chinner
david@fromorbit.com
