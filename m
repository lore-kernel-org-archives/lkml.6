Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8558C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDD220862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDD220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeHAT4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:56:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405752AbeHATIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61E6613B4;
        Wed,  1 Aug 2018 17:15:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ethan Lien <ethanlien@synology.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 071/246] btrfs: balance dirty metadata pages in btrfs_finish_ordered_io
Date:   Wed,  1 Aug 2018 18:49:41 +0200
Message-Id: <20180801165015.110800376@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Lien <ethanlien@synology.com>

[ Upstream commit e73e81b6d0114d4a303205a952ab2e87c44bd279 ]

[Problem description and how we fix it]
We should balance dirty metadata pages at the end of
btrfs_finish_ordered_io, since a small, unmergeable random write can
potentially produce dirty metadata which is multiple times larger than
the data itself. For example, a small, unmergeable 4KiB write may
produce:

    16KiB dirty leaf (and possibly 16KiB dirty node) in subvolume tree
    16KiB dirty leaf (and possibly 16KiB dirty node) in checksum tree
    16KiB dirty leaf (and possibly 16KiB dirty node) in extent tree

Although we do call balance dirty pages in write side, but in the
buffered write path, most metadata are dirtied only after we reach the
dirty background limit (which by far only counts dirty data pages) and
wakeup the flusher thread. If there are many small, unmergeable random
writes spread in a large btree, we'll find a burst of dirty pages
exceeds the dirty_bytes limit after we wakeup the flusher thread - which
is not what we expect. In our machine, it caused out-of-memory problem
since a page cannot be dropped if it is marked dirty.

Someone may worry about we may sleep in btrfs_btree_balance_dirty_nodelay,
but since we do btrfs_finish_ordered_io in a separate worker, it will not
stop the flusher consuming dirty pages. Also, we use different worker for
metadata writeback endio, sleep in btrfs_finish_ordered_io help us throttle
the size of dirty metadata pages.

[Reproduce steps]
To reproduce the problem, we need to do 4KiB write randomly spread in a
large btree. In our 2GiB RAM machine:

1) Create 4 subvolumes.
2) Run fio on each subvolume:

   [global]
   direct=0
   rw=randwrite
   ioengine=libaio
   bs=4k
   iodepth=16
   numjobs=1
   group_reporting
   size=128G
   runtime=1800
   norandommap
   time_based
   randrepeat=0

3) Take snapshot on each subvolume and repeat fio on existing files.
4) Repeat step (3) until we get large btrees.
   In our case, by observing btrfs_root_item->bytes_used, we have 2GiB of
   metadata in each subvolume tree and 12GiB of metadata in extent tree.
5) Stop all fio, take snapshot again, and wait until all delayed work is
   completed.
6) Start all fio. Few seconds later we hit OOM when the flusher starts
   to work.

It can be reproduced even when using nocow write.

Signed-off-by: Ethan Lien <ethanlien@synology.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add comment ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3162,6 +3162,9 @@ out:
 	/* once for the tree */
 	btrfs_put_ordered_extent(ordered_extent);
 
+	/* Try to release some metadata so we don't get an OOM but don't wait */
+	btrfs_btree_balance_dirty_nodelay(fs_info);
+
 	return ret;
 }
 


