Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42421C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DF82089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DF82089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932431AbeGIHXA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:23:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:9390 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932165AbeGIHW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:22:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 00:22:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="71129687"
Received: from debian.sh.intel.com ([10.67.104.228])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2018 00:22:56 -0700
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
Subject: [PATCH net-next v1 0/5] virtio: support packed ring
Date:   Mon,  9 Jul 2018 15:22:36 +0800
Message-Id: <20180709072241.8886-1-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This patch set implements packed ring support in virtio driver.

Some functional tests have been done with Jason's
packed ring implementation in vhost:

https://lkml.org/lkml/2018/7/3/33

Both of ping and netperf worked as expected.

RFC (v6) -> v1:
- Avoid extra virtio_wmb() in virtqueue_enable_cb_delayed_packed()
  when event idx is off (Jason);
- Fix bufs calculation in virtqueue_enable_cb_delayed_packed() (Jason);
- Test the state of the desc at used_idx instead of last_used_idx
  in virtqueue_enable_cb_delayed_packed() (Jason);
- Save wrap counter (as part of queue state) in the return value
  of virtqueue_enable_cb_prepare_packed();
- Refine the packed ring definitions in uapi;
- Rebase on the net-next tree;

RFC v5 -> RFC v6:
- Avoid tracking addr/len/flags when DMA API isn't used (MST/Jason);
- Define wrap counter as bool (Jason);
- Use ALIGN() in vring_init_packed() (Jason);
- Avoid using pointer to track `next` in detach_buf_packed() (Jason);
- Add comments for barriers (Jason);
- Don't enable RING_PACKED on ccw for now (noticed by Jason);
- Refine the memory barrier in virtqueue_poll();
- Add a missing memory barrier in virtqueue_enable_cb_delayed_packed();
- Remove the hacks in virtqueue_enable_cb_prepare_packed();

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

 drivers/s390/virtio/virtio_ccw.c   |    8 +
 drivers/virtio/virtio_ring.c       | 1365 ++++++++++++++++++++++------
 include/linux/virtio_ring.h        |    8 +-
 include/uapi/linux/virtio_config.h |    3 +
 include/uapi/linux/virtio_ring.h   |   43 +
 5 files changed, 1151 insertions(+), 276 deletions(-)

-- 
2.18.0

