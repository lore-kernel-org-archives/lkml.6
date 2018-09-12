Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11860C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92E820882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92E820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeILVVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:21:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbeILVVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:21:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CA4B804B4DB;
        Wed, 12 Sep 2018 16:16:35 +0000 (UTC)
Received: from redhat.com (ovpn-121-244.rdu2.redhat.com [10.10.121.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4C5B2156701;
        Wed, 12 Sep 2018 16:16:32 +0000 (UTC)
Date:   Wed, 12 Sep 2018 12:16:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
Message-ID: <20180912121457-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180827170005-mutt-send-email-mst@kernel.org>
 <20180907012225.GA32677@debian>
 <20180907084509-mutt-send-email-mst@kernel.org>
 <20180910030053.GA15645@debian>
 <f5ef0393-cf02-0795-a51a-8783ee300037@redhat.com>
 <20180911053726.GA7472@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911053726.GA7472@debian>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 16:16:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 16:16:35 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 01:37:26PM +0800, Tiwei Bie wrote:
> On Mon, Sep 10, 2018 at 11:33:17AM +0800, Jason Wang wrote:
> > On 2018年09月10日 11:00, Tiwei Bie wrote:
> > > On Fri, Sep 07, 2018 at 09:00:49AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Sep 07, 2018 at 09:22:25AM +0800, Tiwei Bie wrote:
> > > > > On Mon, Aug 27, 2018 at 05:00:40PM +0300, Michael S. Tsirkin wrote:
> > > > > > Are there still plans to test the performance with vost pmd?
> > > > > > vhost doesn't seem to show a performance gain ...
> > > > > > 
> > > > > I tried some performance tests with vhost PMD. In guest, the
> > > > > XDP program will return XDP_DROP directly. And in host, testpmd
> > > > > will do txonly fwd.
> > > > > 
> > > > > When burst size is 1 and packet size is 64 in testpmd and
> > > > > testpmd needs to iterate 5 Tx queues (but only the first two
> > > > > queues are enabled) to prepare and inject packets, I got ~12%
> > > > > performance boost (5.7Mpps -> 6.4Mpps). And if the vhost PMD
> > > > > is faster (e.g. just need to iterate the first two queues to
> > > > > prepare and inject packets), then I got similar performance
> > > > > for both rings (~9.9Mpps) (packed ring's performance can be
> > > > > lower, because it's more complicated in driver.)
> > > > > 
> > > > > I think packed ring makes vhost PMD faster, but it doesn't make
> > > > > the driver faster. In packed ring, the ring is simplified, and
> > > > > the handling of the ring in vhost (device) is also simplified,
> > > > > but things are not simplified in driver, e.g. although there is
> > > > > no desc table in the virtqueue anymore, driver still needs to
> > > > > maintain a private desc state table (which is still managed as
> > > > > a list in this patch set) to support the out-of-order desc
> > > > > processing in vhost (device).
> > > > > 
> > > > > I think this patch set is mainly to make the driver have a full
> > > > > functional support for the packed ring, which makes it possible
> > > > > to leverage the packed ring feature in vhost (device). But I'm
> > > > > not sure whether there is any other better idea, I'd like to
> > > > > hear your thoughts. Thanks!
> > > > Just this: Jens seems to report a nice gain with virtio and
> > > > vhost pmd across the board. Try to compare virtio and
> > > > virtio pmd to see what does pmd do better?
> > > The virtio PMD (drivers/net/virtio) in DPDK doesn't need to share
> > > the virtio ring operation code with other drivers and is highly
> > > optimized for network. E.g. in Rx, the Rx burst function won't
> > > chain descs. So the ID management for the Rx ring can be quite
> > > simple and straightforward, we just need to initialize these IDs
> > > when initializing the ring and don't need to change these IDs
> > > in data path anymore (the mergable Rx code in that patch set
> > > assumes the descs will be written back in order, which should be
> > > fixed. I.e., the ID in the desc should be used to index vq->descx[]).
> > > The Tx code in that patch set also assumes the descs will be
> > > written back by device in order, which should be fixed.
> > 
> > Yes it is. I think I've pointed it out in some early version of pmd patch.
> > So I suspect part (or all) of the boost may come from in order feature.
> > 
> > > 
> > > But in kernel virtio driver, the virtio_ring.c is very generic.
> > > The enqueue (virtqueue_add()) and dequeue (virtqueue_get_buf_ctx())
> > > functions need to support all the virtio devices and should be
> > > able to handle all the possible cases that may happen. So although
> > > the packed ring can be very efficient in some cases, currently
> > > the room to optimize the performance in kernel's virtio_ring.c
> > > isn't that much. If we want to take the fully advantage of the
> > > packed ring's efficiency, we need some further e.g. API changes
> > > in virtio_ring.c, which shouldn't be part of this patch set.
> > 
> > Could you please share more thoughts on this e.g how to improve the API?
> > Notice since the API is shared by both split ring and packed ring, it may
> > improve the performance of split ring as well. One can easily imagine a
> > batching API, but it does not have many real users now, the only case is the
> > XDP transmission which can accept an array of XDP frames.
> 
> I don't have detailed thoughts on this yet. But kernel's
> virtio_ring.c is quite generic compared with what we did
> in virtio PMD.

In what way? What are some things that aren't implemented there?

If what you say is true then we should take a careful look
and not supporting these generic things with packed layout.
Once we do support them it will be too late and we won't
be able to get performance back.



> > 
> > > So
> > > I still think this patch set is mainly to make the kernel virtio
> > > driver to have a full functional support of the packed ring, and
> > > we can't expect impressive performance boost with it.
> > 
> > We can only gain when virtio ring layout is the bottleneck. If there're
> > bottlenecks elsewhere, we probably won't see any increasing in the numbers.
> > Vhost-net is an example, and lots of optimizations have proved that virtio
> > ring is not the main bottleneck for the current codes. I suspect it also the
> > case of virtio driver. Did perf tell us any interesting things in virtio
> > driver?
> > 
> > Thanks
> > 
> > > 
> > > > 
> > > > > > On Wed, Jul 11, 2018 at 10:27:06AM +0800, Tiwei Bie wrote:
> > > > > > > Hello everyone,
> > > > > > > 
> > > > > > > This patch set implements packed ring support in virtio driver.
> > > > > > > 
> > > > > > > Some functional tests have been done with Jason's
> > > > > > > packed ring implementation in vhost:
> > > > > > > 
> > > > > > > https://lkml.org/lkml/2018/7/3/33
> > > > > > > 
> > > > > > > Both of ping and netperf worked as expected.
> > > > > > > 
> > > > > > > v1 -> v2:
> > > > > > > - Use READ_ONCE() to read event off_wrap and flags together (Jason);
> > > > > > > - Add comments related to ccw (Jason);
> > > > > > > 
> > > > > > > RFC (v6) -> v1:
> > > > > > > - Avoid extra virtio_wmb() in virtqueue_enable_cb_delayed_packed()
> > > > > > >    when event idx is off (Jason);
> > > > > > > - Fix bufs calculation in virtqueue_enable_cb_delayed_packed() (Jason);
> > > > > > > - Test the state of the desc at used_idx instead of last_used_idx
> > > > > > >    in virtqueue_enable_cb_delayed_packed() (Jason);
> > > > > > > - Save wrap counter (as part of queue state) in the return value
> > > > > > >    of virtqueue_enable_cb_prepare_packed();
> > > > > > > - Refine the packed ring definitions in uapi;
> > > > > > > - Rebase on the net-next tree;
> > > > > > > 
> > > > > > > RFC v5 -> RFC v6:
> > > > > > > - Avoid tracking addr/len/flags when DMA API isn't used (MST/Jason);
> > > > > > > - Define wrap counter as bool (Jason);
> > > > > > > - Use ALIGN() in vring_init_packed() (Jason);
> > > > > > > - Avoid using pointer to track `next` in detach_buf_packed() (Jason);
> > > > > > > - Add comments for barriers (Jason);
> > > > > > > - Don't enable RING_PACKED on ccw for now (noticed by Jason);
> > > > > > > - Refine the memory barrier in virtqueue_poll();
> > > > > > > - Add a missing memory barrier in virtqueue_enable_cb_delayed_packed();
> > > > > > > - Remove the hacks in virtqueue_enable_cb_prepare_packed();
> > > > > > > 
> > > > > > > RFC v4 -> RFC v5:
> > > > > > > - Save DMA addr, etc in desc state (Jason);
> > > > > > > - Track used wrap counter;
> > > > > > > 
> > > > > > > RFC v3 -> RFC v4:
> > > > > > > - Make ID allocation support out-of-order (Jason);
> > > > > > > - Various fixes for EVENT_IDX support;
> > > > > > > 
> > > > > > > RFC v2 -> RFC v3:
> > > > > > > - Split into small patches (Jason);
> > > > > > > - Add helper virtqueue_use_indirect() (Jason);
> > > > > > > - Just set id for the last descriptor of a list (Jason);
> > > > > > > - Calculate the prev in virtqueue_add_packed() (Jason);
> > > > > > > - Fix/improve desc suppression code (Jason/MST);
> > > > > > > - Refine the code layout for XXX_split/packed and wrappers (MST);
> > > > > > > - Fix the comments and API in uapi (MST);
> > > > > > > - Remove the BUG_ON() for indirect (Jason);
> > > > > > > - Some other refinements and bug fixes;
> > > > > > > 
> > > > > > > RFC v1 -> RFC v2:
> > > > > > > - Add indirect descriptor support - compile test only;
> > > > > > > - Add event suppression supprt - compile test only;
> > > > > > > - Move vring_packed_init() out of uapi (Jason, MST);
> > > > > > > - Merge two loops into one in virtqueue_add_packed() (Jason);
> > > > > > > - Split vring_unmap_one() for packed ring and split ring (Jason);
> > > > > > > - Avoid using '%' operator (Jason);
> > > > > > > - Rename free_head -> next_avail_idx (Jason);
> > > > > > > - Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
> > > > > > > - Some other refinements and bug fixes;
> > > > > > > 
> > > > > > > Thanks!
> > > > > > > 
> > > > > > > Tiwei Bie (5):
> > > > > > >    virtio: add packed ring definitions
> > > > > > >    virtio_ring: support creating packed ring
> > > > > > >    virtio_ring: add packed ring support
> > > > > > >    virtio_ring: add event idx support in packed ring
> > > > > > >    virtio_ring: enable packed ring
> > > > > > > 
> > > > > > >   drivers/s390/virtio/virtio_ccw.c   |   14 +
> > > > > > >   drivers/virtio/virtio_ring.c       | 1365 ++++++++++++++++++++++------
> > > > > > >   include/linux/virtio_ring.h        |    8 +-
> > > > > > >   include/uapi/linux/virtio_config.h |    3 +
> > > > > > >   include/uapi/linux/virtio_ring.h   |   43 +
> > > > > > >   5 files changed, 1157 insertions(+), 276 deletions(-)
> > > > > > > 
> > > > > > > -- 
> > > > > > > 2.18.0
> > > > > > ---------------------------------------------------------------------
> > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > > > > 
> > 
