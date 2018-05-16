Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeEPMcb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:32:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752026AbeEPMc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:32:29 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfreimann@redhat.com, wexu@redhat.com, tiwei.bie@intel.com
Subject: [RFC V4 PATCH 0/8] Packed ring layout for vhost
Date: Wed, 16 May 2018 20:32:13 +0800
Message-Id: <1526473941-16199-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

This RFC implement packed ring layout. The code were tested with
Tiwei's RFC V3 ahttps://lkml.org/lkml/2018/4/25/34. Some fixups and
tweaks were needed on top of Tiwei's code to make it run for event
index.

Pktgen reports about 20% improvement on PPS (event index is off). More
testing is ongoing.

Notes for tester:

- Start from this version, vhost need qemu co-operation to work
  correctly. Or you can comment out the packed specific code for
  GET/SET_VRING_BASE.

Changes from V3:
- Fix math on event idx checking
- Sync last avail wrap counter through GET/SET_VRING_BASE
- remove desc_event prefix in the driver/device structure

Changes from V2:
- do not use & in checking desc_event_flags
- off should be most significant bit
- remove the workaround of mergeable buffer for dpdk prototype
- id should be in the last descriptor in the chain
- keep _F_WRITE for write descriptor when adding used
- device flags updating should use ADDR_USED type
- return error on unexpected unavail descriptor in a chain
- return false in vhost_ve_avail_empty is descriptor is available
- track last seen avail_wrap_counter
- correctly examine available descriptor in get_indirect_packed()
- vhost_idx_diff should return u16 instead of bool

Changes from V1:

- Refactor vhost used elem code to avoid open coding on used elem
- Event suppression support (compile test only).
- Indirect descriptor support (compile test only).
- Zerocopy support.
- vIOMMU support.
- SCSI/VSOCK support (compile test only).
- Fix several bugs

Jason Wang (8):
  vhost: move get_rx_bufs to vhost.c
  vhost: hide used ring layout from device
  vhost: do not use vring_used_elem
  vhost_net: do not explicitly manipulate vhost_used_elem
  vhost: vhost_put_user() can accept metadata type
  virtio: introduce packed ring defines
  vhost: packed ring support
  vhost: event suppression for packed ring

 drivers/vhost/net.c                | 136 ++----
 drivers/vhost/scsi.c               |  62 +--
 drivers/vhost/vhost.c              | 861 ++++++++++++++++++++++++++++++++-----
 drivers/vhost/vhost.h              |  47 +-
 drivers/vhost/vsock.c              |  42 +-
 include/uapi/linux/virtio_config.h |   9 +
 include/uapi/linux/virtio_ring.h   |  32 ++
 7 files changed, 928 insertions(+), 261 deletions(-)

-- 
2.7.4
