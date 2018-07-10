Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDCAC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D386208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGc3i8Jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D386208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933476AbeGJOBc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933248AbeGJOBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:01:30 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FCBC2089B;
        Tue, 10 Jul 2018 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531231290;
        bh=r0QAqStp1Yng6IgG+avYs16dpR6ywluhcNY+b6IgL5g=;
        h=From:To:Cc:Subject:Date:From;
        b=SGc3i8JvxL0++yCjfABC21zmesELFj/rconDws4rf3vZkS0wTImNVBMDawfkzwpSD
         4phetudV2ipFzLTzcurGrmrXgeQDsulY1RGcCPjl4qYZgsYqzdHQztxq9tDTL6PR0g
         JpDoSdmEUXwmgmCgMHADZYDvx+QlQZKA/U38UgRs=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@ZenIV.linux.org.uk, dhowells@redhat.com
Cc:     willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/4] vfs: track per-sb writeback errors and report them via fsinfo()
Date:   Tue, 10 Jul 2018 10:01:23 -0400
Message-Id: <20180710140127.20739-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: drop buffer.c patch to record wb errors when underlying blockdev
flush fails. We may eventually want that, but at this point I don't have
a clear way to test it to determine its efficacy.

At LSF/MM this year, the PostgreSQL developers mentioned that they'd
like to have some mechanism to check whether there have been any
writeback errors on a filesystem, without necessarily flushing any of
the cached data first.

Given that we have a new fsinfo syscall being introduced, we may as well
use it to report writeback errors on a per superblock basis. This allows
us to provide the info that the PostgreSQL developers wanted, without
needing to change an existing interface.

This seems to do the right thing when tested by hand, but I don't yet
have an xfstest for it, since the syscall is still quite new. Once that
goes in and we get fsinfo support in xfs_io, it should be rather
trivial to roll a testcase for this.

Al, if this looks ok, could you pull this into the branch where you
have David's fsinfo patches queued up?

Thanks,
Jeff

Jeff Layton (4):
  vfs: track per-sb writeback errors
  errseq: add a new errseq_scrape function
  vfs: allow fsinfo to fetch the current state of s_wb_err
  samples: extend test-fsinfo to access error_state

 fs/statfs.c                 |  9 +++++++++
 include/linux/errseq.h      |  1 +
 include/linux/fs.h          |  3 +++
 include/linux/pagemap.h     |  5 ++++-
 include/uapi/linux/fsinfo.h | 11 +++++++++++
 lib/errseq.c                | 33 +++++++++++++++++++++++++++++++--
 samples/statx/test-fsinfo.c | 13 +++++++++++++
 7 files changed, 72 insertions(+), 3 deletions(-)

-- 
2.17.1

