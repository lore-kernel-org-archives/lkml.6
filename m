Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeFDSDI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbeFDSDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:03:07 -0400
From: Jeff Layton <jlayton@kernel.org>
To: viro@ZenIV.linux.org.uk, dhowells@redhat.com
Cc: willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] vfs: track per-sb writeback errors and report them via fsinfo()
Date: Mon,  4 Jun 2018 14:02:59 -0400
Message-Id: <20180604180304.9662-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

This is a reworked (and more modest) version of the syncfs rework that I
posted recently. Given that we have a new fsinfo syscall being
introduced, we may as well use it to report writeback errors on a per
superblock basis. This allows us to provide the info that the PostgreSQL
developers wanted, without needing to change an existing interface.

We may still want to change syncfs to report writeback errors at some
point, but for now, I think this is a safer path to presenting this
info.

This seems to do the right thing when tested by hand, but I don't yet
have an xfstest for it, since the syscall is still quite new. Once that
goes in and we get fsinfo support in xfs_io, it should be rather
trivial to modify the test I wrote for the syncfs rework.

Jeff Layton (5):
  vfs: track per-sb writeback errors
  buffer: record blockdev write errors in super_block that backs them
  errseq: add a new errseq_scrape function
  vfs: allow fsinfo to fetch the current state of s_wb_err
  samples: extend test-fsinfo to access error_state

 fs/buffer.c                 |  2 ++
 fs/statfs.c                 |  9 +++++++++
 include/linux/errseq.h      |  1 +
 include/linux/fs.h          |  3 +++
 include/linux/pagemap.h     |  5 ++++-
 include/uapi/linux/fsinfo.h | 11 +++++++++++
 lib/errseq.c                | 33 +++++++++++++++++++++++++++++++--
 samples/statx/test-fsinfo.c | 13 +++++++++++++
 8 files changed, 74 insertions(+), 3 deletions(-)

-- 
2.17.0
