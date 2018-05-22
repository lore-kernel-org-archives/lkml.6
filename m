Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeEVIRP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:17:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:23522 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbeEVIRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:17:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="51200156"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
Subject: [RFC v5 0/5] virtio: support packed ring
Date: Tue, 22 May 2018 16:16:43 +0800
Message-Id: <20180522081648.14768-1-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This RFC implements packed ring support in virtio driver.

Some simple functional tests have been done with Jason's
packed ring implementation in vhost (RFC v4):

https://lkml.org/lkml/2018/5/16/501

Both of ping and netperf worked as expected w/ EVENT_IDX
disabled. Ping worked as expected w/ EVENT_IDX enabled,
but netperf didn't (A hack has been added in the driver
to make netperf test pass in this case. The hack can be
found by `grep -rw XXX` in the code).

TODO:
- Refinements (for code and commit log);
- More tests;
- Bug fixes;

RFC v4 -> RFC v5:
- Save DMA addr, etc in desc state (Jason);
- Track used wrap counter;

RFC v3 -> RFC v4:
- Make ID allocation support out-of-order (Jason);
- Various fixes for EVENT_IDX support;

RFC v2 -> RFC v3:
- Split into small patches (Jason);
- Add helper virtqueue_use_indirect() (Jason);
- Just set id for the last descriptor of a list (Jason);
- Calculate the prev in virtqueue_add_packed() (Jason);
- Fix/improve desc suppression code (Jason/MST);
- Refine the code layout for XXX_split/packed and wrappers (MST);
- Fix the comments and API in uapi (MST);
- Remove the BUG_ON() for indirect (Jason);
- Some other refinements and bug fixes;

RFC v1 -> RFC v2:
- Add indirect descriptor support - compile test only;
- Add event suppression supprt - compile test only;
- Move vring_packed_init() out of uapi (Jason, MST);
- Merge two loops into one in virtqueue_add_packed() (Jason);
- Split vring_unmap_one() for packed ring and split ring (Jason);
- Avoid using '%' operator (Jason);
- Rename free_head -> next_avail_idx (Jason);
- Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
- Some other refinements and bug fixes;

Thanks!

Tiwei Bie (5):
  virtio: add packed ring definitions
  virtio_ring: support creating packed ring
  virtio_ring: add packed ring support
  virtio_ring: add event idx support in packed ring
  virtio_ring: enable packed ring

 drivers/virtio/virtio_ring.c       | 1354 ++++++++++++++++++++++------
 include/linux/virtio_ring.h        |    8 +-
 include/uapi/linux/virtio_config.h |    5 +-
 include/uapi/linux/virtio_ring.h   |   36 +
 4 files changed, 1125 insertions(+), 278 deletions(-)

-- 
2.17.0
