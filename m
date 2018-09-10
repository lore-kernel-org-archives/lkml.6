Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EFAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7792204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7792204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeIJHzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:55:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:49200 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbeIJHzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:55:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2018 20:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,354,1531810800"; 
   d="scan'208";a="72917995"
Received: from btwcube1.sh.intel.com (HELO debian) ([10.67.104.194])
  by orsmga006.jf.intel.com with ESMTP; 09 Sep 2018 20:01:51 -0700
Date:   Mon, 10 Sep 2018 11:00:53 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
Message-ID: <20180910030053.GA15645@debian>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180827170005-mutt-send-email-mst@kernel.org>
 <20180907012225.GA32677@debian>
 <20180907084509-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180907084509-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:00:49AM -0400, Michael S. Tsirkin wrote:
> On Fri, Sep 07, 2018 at 09:22:25AM +0800, Tiwei Bie wrote:
> > On Mon, Aug 27, 2018 at 05:00:40PM +0300, Michael S. Tsirkin wrote:
> > > Are there still plans to test the performance with vost pmd?
> > > vhost doesn't seem to show a performance gain ...
> > > 
> > 
> > I tried some performance tests with vhost PMD. In guest, the
> > XDP program will return XDP_DROP directly. And in host, testpmd
> > will do txonly fwd.
> > 
> > When burst size is 1 and packet size is 64 in testpmd and
> > testpmd needs to iterate 5 Tx queues (but only the first two
> > queues are enabled) to prepare and inject packets, I got ~12%
> > performance boost (5.7Mpps -> 6.4Mpps). And if the vhost PMD
> > is faster (e.g. just need to iterate the first two queues to
> > prepare and inject packets), then I got similar performance
> > for both rings (~9.9Mpps) (packed ring's performance can be
> > lower, because it's more complicated in driver.)
> > 
> > I think packed ring makes vhost PMD faster, but it doesn't make
> > the driver faster. In packed ring, the ring is simplified, and
> > the handling of the ring in vhost (device) is also simplified,
> > but things are not simplified in driver, e.g. although there is
> > no desc table in the virtqueue anymore, driver still needs to
> > maintain a private desc state table (which is still managed as
> > a list in this patch set) to support the out-of-order desc
> > processing in vhost (device).
> > 
> > I think this patch set is mainly to make the driver have a full
> > functional support for the packed ring, which makes it possible
> > to leverage the packed ring feature in vhost (device). But I'm
> > not sure whether there is any other better idea, I'd like to
> > hear your thoughts. Thanks!
> 
> Just this: Jens seems to report a nice gain with virtio and
> vhost pmd across the board. Try to compare virtio and
> virtio pmd to see what does pmd do better?

The virtio PMD (drivers/net/virtio) in DPDK doesn't need to share
the virtio ring operation code with other drivers and is highly
optimized for network. E.g. in Rx, the Rx burst function won't
chain descs. So the ID management for the Rx ring can be quite
simple and straightforward, we just need to initialize these IDs
when initializing the ring and don't need to change these IDs
in data path anymore (the mergable Rx code in that patch set
assumes the descs will be written back in order, which should be
fixed. I.e., the ID in the desc should be used to index vq->descx[]).
The Tx code in that patch set also assumes the descs will be
written back by device in order, which should be fixed.

But in kernel virtio driver, the virtio_ring.c is very generic.
The enqueue (virtqueue_add()) and dequeue (virtqueue_get_buf_ctx())
functions need to support all the virtio devices and should be
able to handle all the possible cases that may happen. So although
the packed ring can be very efficient in some cases, currently
the room to optimize the performance in kernel's virtio_ring.c
isn't that much. If we want to take the fully advantage of the
packed ring's efficiency, we need some further e.g. API changes
in virtio_ring.c, which shouldn't be part of this patch set. So
I still think this patch set is mainly to make the kernel virtio
driver to have a full functional support of the packed ring, and
we can't expect impressive performance boost with it.

> 
> 
> > 
> > > 
> > > On Wed, Jul 11, 2018 at 10:27:06AM +0800, Tiwei Bie wrote:
> > > > Hello everyone,
> > > > 
> > > > This patch set implements packed ring support in virtio driver.
> > > > 
> > > > Some functional tests have been done with Jason's
> > > > packed ring implementation in vhost:
> > > > 
> > > > https://lkml.org/lkml/2018/7/3/33
> > > > 
> > > > Both of ping and netperf worked as expected.
> > > > 
> > > > v1 -> v2:
> > > > - Use READ_ONCE() to read event off_wrap and flags together (Jason);
> > > > - Add comments related to ccw (Jason);
> > > > 
> > > > RFC (v6) -> v1:
> > > > - Avoid extra virtio_wmb() in virtqueue_enable_cb_delayed_packed()
> > > >   when event idx is off (Jason);
> > > > - Fix bufs calculation in virtqueue_enable_cb_delayed_packed() (Jason);
> > > > - Test the state of the desc at used_idx instead of last_used_idx
> > > >   in virtqueue_enable_cb_delayed_packed() (Jason);
> > > > - Save wrap counter (as part of queue state) in the return value
> > > >   of virtqueue_enable_cb_prepare_packed();
> > > > - Refine the packed ring definitions in uapi;
> > > > - Rebase on the net-next tree;
> > > > 
> > > > RFC v5 -> RFC v6:
> > > > - Avoid tracking addr/len/flags when DMA API isn't used (MST/Jason);
> > > > - Define wrap counter as bool (Jason);
> > > > - Use ALIGN() in vring_init_packed() (Jason);
> > > > - Avoid using pointer to track `next` in detach_buf_packed() (Jason);
> > > > - Add comments for barriers (Jason);
> > > > - Don't enable RING_PACKED on ccw for now (noticed by Jason);
> > > > - Refine the memory barrier in virtqueue_poll();
> > > > - Add a missing memory barrier in virtqueue_enable_cb_delayed_packed();
> > > > - Remove the hacks in virtqueue_enable_cb_prepare_packed();
> > > > 
> > > > RFC v4 -> RFC v5:
> > > > - Save DMA addr, etc in desc state (Jason);
> > > > - Track used wrap counter;
> > > > 
> > > > RFC v3 -> RFC v4:
> > > > - Make ID allocation support out-of-order (Jason);
> > > > - Various fixes for EVENT_IDX support;
> > > > 
> > > > RFC v2 -> RFC v3:
> > > > - Split into small patches (Jason);
> > > > - Add helper virtqueue_use_indirect() (Jason);
> > > > - Just set id for the last descriptor of a list (Jason);
> > > > - Calculate the prev in virtqueue_add_packed() (Jason);
> > > > - Fix/improve desc suppression code (Jason/MST);
> > > > - Refine the code layout for XXX_split/packed and wrappers (MST);
> > > > - Fix the comments and API in uapi (MST);
> > > > - Remove the BUG_ON() for indirect (Jason);
> > > > - Some other refinements and bug fixes;
> > > > 
> > > > RFC v1 -> RFC v2:
> > > > - Add indirect descriptor support - compile test only;
> > > > - Add event suppression supprt - compile test only;
> > > > - Move vring_packed_init() out of uapi (Jason, MST);
> > > > - Merge two loops into one in virtqueue_add_packed() (Jason);
> > > > - Split vring_unmap_one() for packed ring and split ring (Jason);
> > > > - Avoid using '%' operator (Jason);
> > > > - Rename free_head -> next_avail_idx (Jason);
> > > > - Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
> > > > - Some other refinements and bug fixes;
> > > > 
> > > > Thanks!
> > > > 
> > > > Tiwei Bie (5):
> > > >   virtio: add packed ring definitions
> > > >   virtio_ring: support creating packed ring
> > > >   virtio_ring: add packed ring support
> > > >   virtio_ring: add event idx support in packed ring
> > > >   virtio_ring: enable packed ring
> > > > 
> > > >  drivers/s390/virtio/virtio_ccw.c   |   14 +
> > > >  drivers/virtio/virtio_ring.c       | 1365 ++++++++++++++++++++++------
> > > >  include/linux/virtio_ring.h        |    8 +-
> > > >  include/uapi/linux/virtio_config.h |    3 +
> > > >  include/uapi/linux/virtio_ring.h   |   43 +
> > > >  5 files changed, 1157 insertions(+), 276 deletions(-)
> > > > 
> > > > -- 
> > > > 2.18.0
> > > 
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > 
