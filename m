Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615D3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E565920827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E565920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeJ2KQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:16:04 -0400
Received: from nautica.notk.org ([91.121.71.147]:56429 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbeJ2KQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:16:04 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 9982EC009; Mon, 29 Oct 2018 02:29:39 +0100 (CET)
Date:   Mon, 29 Oct 2018 02:29:24 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [GIT PULL] 9p updates for 4.20
Message-ID: <20181029012924.GA31433@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a 9p update for 4.20.

Highlights this time around are the end of Matthew's work to remove the
custom 9p request cache and use a slab directly for requests, with some
extra patches on my end to not degrade performance, but it's a very good
cleanup.
Tomas and I fixed a few more syzkaller bugs (refcount is the big one),
and I had a go at the coverity bugs and at some of the bugzilla reports
we had open for a while.

I'm a bit disappointed that I couldn't get much reviews for a few of my
own patches, but the big ones got some and it's all been soaking in
linux-next for quite a while so I think it should be OK.

Lastly, as said last time, I'm going to be confusing again as I changed
my PGP key - it's signed by the old one - but should keep this one for
the forseeable future now.

Thanks!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://github.com/martinetd/linux tags/9p-for-4.20

for you to fetch changes up to fb488fc1f2b4c5128540b032892ddec91edaf8d9:

  9p/trans_fd: put worker reqs on destroy (2018-10-10 09:14:34 +0900)

----------------------------------------------------------------
Dan Carpenter (1):
      9p: potential NULL dereference

Dinu-Razvan Chis-Serban (1):
      9p locks: add mount option for lock retry interval

Dominique Martinet (12):
      9p/xen: fix check for xenbus_read error in front_probe
      v9fs_dir_readdir: fix double-free on p9stat_read error
      9p: clear dangling pointers in p9stat_free
      9p: embed fcall in req to round down buffer allocs
      9p: add a per-client fcall kmem_cache
      9p/rdma: do not disconnect on down_interruptible EAGAIN
      9p: acl: fix uninitialized iattr access
      9p/rdma: remove useless check in cm_event_handler
      9p: p9dirent_read: check network-provided name length
      9p locks: fix glock.client_id leak in do_lock
      9p/trans_fd: abort p9_read_work if req status changed
      9p/trans_fd: put worker reqs on destroy

Gertjan Halkes (1):
      9p: do not trust pdu content for stat item size

Gustavo A. R. Silva (1):
      9p: fix spelling mistake in fall-through annotation

Matthew Wilcox (2):
      9p: Use a slab for allocating requests
      9p: Remove p9_idpool

Tomas Bortoli (3):
      9p: rename p9_free_req() function
      9p: Add refcount to p9_req_t
      9p: Rename req to rreq in trans_fd

 fs/9p/acl.c             |   2 +-
 fs/9p/v9fs.c            |  21 +++++
 fs/9p/v9fs.h            |   1 +
 fs/9p/vfs_dir.c         |  19 +---
 fs/9p/vfs_file.c        |  24 +++++-
 include/net/9p/9p.h     |  12 +--
 include/net/9p/client.h |  71 ++++++---------
 net/9p/Makefile         |   1 -
 net/9p/client.c         | 551 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------
 net/9p/mod.c            |   9 +-
 net/9p/protocol.c       |  20 ++++-
 net/9p/trans_fd.c       |  64 +++++++++-----
 net/9p/trans_rdma.c     |  37 ++++----
 net/9p/trans_virtio.c   |  44 +++++++---
 net/9p/trans_xen.c      |  17 ++--
 net/9p/util.c           | 140 ------------------------------
 16 files changed, 482 insertions(+), 551 deletions(-)
 delete mode 100644 net/9p/util.c
