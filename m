Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA4FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BD420684
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BD420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbeKUUjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:39:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:14789 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbeKUUjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:39:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 02:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="275726999"
Received: from btwcube1.sh.intel.com ([10.67.104.173])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2018 02:05:21 -0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com
Subject: [PATCH net-next v3 00/13] virtio: support packed ring
Date:   Wed, 21 Nov 2018 18:03:17 +0800
Message-Id: <20181121100330.24846-1-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set implements packed ring support in virtio driver.

A performance test between pktgen (pktgen_sample03_burst_single_flow.sh)
and DPDK vhost (testpmd/rxonly/vhost-PMD) has been done, I saw
~30% performance gain in packed ring in this case.

To make this patch set work with below patch set for vhost,
some hacks are needed to set the _F_NEXT flag in indirect
descriptors (this should be fixed in vhost):

https://lkml.org/lkml/2018/7/3/33

v2 -> v3:
- Use leXX instead of virtioXX (MST);
- Refactor split ring first (MST);
- Add debug helpers (MST);
- Put split/packed ring specific fields in sub structures (MST);
- Handle normal descriptors and indirect descriptors differently (MST);
- Track the DMA addr/len related info in a separate structure (MST);
- Calculate AVAIL/USED flags only when wrap counter wraps (MST);
- Define a struct/union to read event structure (MST);
- Define a macro for wrap counter bit in uapi (MST);
- Define the AVAIL/USED bits as shifts instead of values (MST);
- s/_F_/_FLAG_/ in VRING_PACKED_EVENT_* as they are values (MST);
- Drop the notify workaround for QEMU's tx-timer in packed ring (MST);

v1 -> v2:
- Use READ_ONCE() to read event off_wrap and flags together (Jason);
- Add comments related to ccw (Jason);

RFC v6 -> v1:
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


Tiwei Bie (13):
  virtio: add packed ring types and macros
  virtio_ring: add _split suffix for split ring functions
  virtio_ring: put split ring functions together
  virtio_ring: put split ring fields in a sub struct
  virtio_ring: introduce debug helpers
  virtio_ring: introduce helper for indirect feature
  virtio_ring: allocate desc state for split ring separately
  virtio_ring: extract split ring handling from ring creation
  virtio_ring: cache whether we will use DMA API
  virtio_ring: introduce packed ring support
  virtio_ring: leverage event idx in packed ring
  virtio_ring: disable packed ring on unsupported transports
  virtio_ring: advertize packed ring layout

 drivers/misc/mic/vop/vop_main.c        |   13 +
 drivers/remoteproc/remoteproc_virtio.c |   13 +
 drivers/s390/virtio/virtio_ccw.c       |   14 +
 drivers/virtio/virtio_ring.c           | 1811 +++++++++++++++++++++++++-------
 include/uapi/linux/virtio_config.h     |    3 +
 include/uapi/linux/virtio_ring.h       |   52 +
 6 files changed, 1530 insertions(+), 376 deletions(-)

-- 
2.14.5

