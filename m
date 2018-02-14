Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966645AbeBNCri (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 21:47:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966497AbeBNCrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 21:47:36 -0500
Date: Wed, 14 Feb 2018 04:47:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com, tiwei.bie@intel.com
Subject: Re: [PATCH RFC 0/2] Packed ring for vhost
Message-ID: <20180214044634-mutt-send-email-mst@kernel.org>
References: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:37:07AM +0800, Jason Wang wrote:
> Hi all:
> 
> This RFC implement a subset of packed ring which was described at
> https://github.com/oasis-tcs/virtio-docs/blob/master/virtio-v1.1-packed-wd07.pdf
> . The code were tested with pmd implement by Jens at
> http://dpdk.org/ml/archives/dev/2018-January/089417.html. Minor
> change was needed for pmd codes to kick virtqueue since it assumes a
> busy polling backend.
> 
> Test were done between localhost and guest. Testpmd (rxonly) in guest
> reports 2.4Mpps. Testpmd (txonly) repots about 2.1Mpps.

How does this compare with the split ring design?

> It's not a complete implemention, here's what were missed:
> 
> - Device Area
> - Driver Area
> - Descriptor indirection
> - Zerocopy may not be functional
> - Migration path is not tested
> - Vhost devices except for net
> - vIOMMU can not work (mainly because the metadata prefetch is not
>   implemented).
> - See FIXME/TODO in the codes for more details
> - No batching or other optimizations were implemented

ioeventfd for PIO/mmio/s390.

> For a quick prototype, this series open code the tracking of warp
> counter and descriptor index at net device. This will be addressed in
> the future by:
> 
> - Move get_rx_bufs() from net.c to vhost.c
> - Let vhost_get_vq_desc() returns vring_used_elem instad of head id
> 
> With the above, we can hide the internal (at least part of) vring
> layout from specific device.
> 
> Please review.
> 
> Thanks
> 
> Jason Wang (2):
>   virtio: introduce packed ring defines
>   vhost: packed ring support
> 
>  drivers/vhost/net.c                |  14 +-
>  drivers/vhost/vhost.c              | 351 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h              |   6 +-
>  include/uapi/linux/virtio_config.h |   9 +
>  include/uapi/linux/virtio_ring.h   |  17 ++
>  5 files changed, 369 insertions(+), 28 deletions(-)
> 
> -- 
> 2.7.4
