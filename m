Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbeEYCzZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:55:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:22224 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbeEYCzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:55:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,438,1520924400";
   d="scan'208";a="42054613"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH 0/7] Fix DM DAX handling
Date: Thu, 24 May 2018 20:55:11 -0600
Message-Id: <20180525025518.11405-1-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a few issues that I found with DM's handling of DAX
devices.  Here are some of the issues I found:

 * We can create a dm-stripe or dm-linear device which is made up of an
   fsdax PMEM namespace and a raw PMEM namespace but which can hold a
   filesystem mounted with the -o dax mount option.  DAX operations to
   the raw PMEM namespace part lack struct page and can fail in
   interesting/unexpected ways when doing things like fork(), examining
   memory with gdb, etc.

 * We can create a dm-stripe or dm-linear device which is made up of an
   fsdax PMEM namespace and a BRD ramdisk which can hold a filesystem
   mounted with the -o dax mount option.  All I/O to this filesystem
   will fail.

 * In DM you can't transition a dm target which could possibly support
   DAX (mode DM_TYPE_DAX_BIO_BASED) to one which can't support DAX
   (mode DM_TYPE_BIO_BASED), even if you never use DAX.

The first 2 patches in this series are prep work from Darrick and Dave
which improve bdev_dax_supported().  The last 5 problems fix the above
mentioned problems in DM.  I feel that this series simplifies the
handling of DAX devices in DM, and the last 5 DM-related patches have a
net code reduction of 50 lines.


Darrick J. Wong (1):
  fs: allow per-device dax status checking for filesystems

Dave Jiang (1):
  dax: change bdev_dax_supported() to support boolean returns

Ross Zwisler (5):
  dm: fix test for DAX device support
  dm: prevent DAX mounts if not supported
  dm: remove DM_TYPE_DAX_BIO_BASED dm_queue_mode
  dm-snap: remove unnecessary direct_access() stub
  dm-error: remove unnecessary direct_access() stub

 drivers/dax/super.c           | 44 +++++++++++++++++++++----------------------
 drivers/md/dm-ioctl.c         | 16 ++++++----------
 drivers/md/dm-snap.c          |  8 --------
 drivers/md/dm-table.c         | 29 +++++++++++-----------------
 drivers/md/dm-target.c        |  7 -------
 drivers/md/dm.c               |  7 ++-----
 fs/ext2/super.c               |  3 +--
 fs/ext4/super.c               |  3 +--
 fs/xfs/xfs_ioctl.c            |  3 ++-
 fs/xfs/xfs_iops.c             | 30 ++++++++++++++++++++++++-----
 fs/xfs/xfs_super.c            | 10 ++++++++--
 include/linux/dax.h           | 12 ++++--------
 include/linux/device-mapper.h |  8 ++++++--
 13 files changed, 88 insertions(+), 92 deletions(-)

-- 
2.14.3
