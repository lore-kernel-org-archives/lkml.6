Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA24BECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5F220824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdUrJ43R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5F220824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeJ0DFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbeJ0DFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:05:19 -0400
Received: from kernel.org (c-71-202-33-127.hsd1.ca.comcast.net [71.202.33.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92AE220824;
        Fri, 26 Oct 2018 18:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540578434;
        bh=xXKEG+V8+mKxTTt5972/Uv0jmNn6D4WcqzHHZXE5Em4=;
        h=Date:From:To:Cc:Subject:From;
        b=RdUrJ43RZskUz6H56IPIO+BHmOJoKtRUwaTqOLSbSRKkRtUBq5+DvhCt8Hi42sxZi
         PKBX+cGtx2UGmnxLTAPLilm7cQBwQuwGgTdGUyhQ7m7HP3dj7E5/MXipfF0F/lHRB2
         NE8EF1ppstBtreAMjJLSWZI0VqOBzjQC/rJVq/LI=
Date:   Fri, 26 Oct 2018 11:27:13 -0700
From:   Shaohua Li <shli@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [GIT PULL] MD update for 4.20
Message-ID: <20181026182713.GA93048@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please pull MD update for 4.20. This pull mainly improves raid10 cluster and
fixes some bugs.
- raid10 cluster improvements from Guoqing
- Memory leak fixes from Jack and Xiao
- raid10 hang fix from Alex
- raid5 block faulty device fix from Mariusz
- metadata update fix from Neil
- Invalid disk role fix from Me
- Other clearnups

Thanks,
Shaohua

The following changes since commit f151f57bfd97fb8c76bbef9e181ecba5dd750f2a:

  Merge tag 'drm-fixes-2018-09-28' of git://anongit.freedesktop.org/drm/drm (2018-09-28 18:55:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shli/md.git for-next

for you to fetch changes up to af9b926de9c5986ab009e64917de87c9758bab10:

  MD: Memory leak when flush bio size is zero (2018-10-22 09:15:26 -0700)

----------------------------------------------------------------
Alex Wu (1):
      md/raid10: Fix raid10 replace hang when new added disk faulty

Colin Ian King (1):
      md: remove redundant code that is no longer reachable

Guoqing Jiang (8):
      md-cluster/raid10: resize all the bitmaps before start reshape
      md-cluster/raid10: support add disk under grow mode
      md-cluster: introduce resync_info_get interface for sanity check
      md-cluster/raid10: call update_size in md_reap_sync_thread
      md-cluster/raid10: don't call remove_and_add_spares during reshaping stage
      md-cluster/bitmap: don't call md_bitmap_sync_with_cluster during reshaping stage
      md-cluster: send BITMAP_NEEDS_SYNC message if reshaping is interrupted
      md-cluster: remove suspend_info

Jack Wang (2):
      md/bitmap: use mddev_suspend/resume instead of ->quiesce()
      md: fix memleak for mempool

Mariusz Tkaczyk (1):
      raid5: block failing device if raid will be failed

NeilBrown (1):
      md: allow metadata updates while suspending an array - fix

Shaohua Li (2):
      MD: fix invalid stored role for a disk
      MD: fix invalid stored role for a disk - try2

Xiao Ni (1):
      MD: Memory leak when flush bio size is zero

 drivers/md/md-bitmap.c   |   9 +-
 drivers/md/md-cluster.c  | 234 ++++++++++++++++++++++++++++++++---------------
 drivers/md/md-cluster.h  |   2 +
 drivers/md/md.c          | 113 +++++++++++++++++------
 drivers/md/md.h          |   1 +
 drivers/md/raid1.c       |   1 +
 drivers/md/raid10.c      | 109 ++++++++++++++++++----
 drivers/md/raid5-cache.c |   2 -
 drivers/md/raid5.c       |  12 +++
 9 files changed, 356 insertions(+), 127 deletions(-)
