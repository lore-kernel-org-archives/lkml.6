Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BDCC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56F22075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56F22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbeIGRlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:41:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727611AbeIGRlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:41:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 296B2402315B;
        Fri,  7 Sep 2018 13:00:53 +0000 (UTC)
Received: from redhat.com (ovpn-124-199.rdu2.redhat.com [10.10.124.199])
        by smtp.corp.redhat.com (Postfix) with SMTP id C7D9F215670B;
        Fri,  7 Sep 2018 13:00:49 +0000 (UTC)
Date:   Fri, 7 Sep 2018 09:00:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
Message-ID: <20180907084509-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180827170005-mutt-send-email-mst@kernel.org>
 <20180907012225.GA32677@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907012225.GA32677@debian>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 13:00:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 13:00:53 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:22:25AM +0800, Tiwei Bie wrote:
> On Mon, Aug 27, 2018 at 05:00:40PM +0300, Michael S. Tsirkin wrote:
> > Are there still plans to test the performance with vost pmd?
> > vhost doesn't seem to show a performance gain ...
> > 
> 
> I tried some performance tests with vhost PMD. In guest, the
> XDP program will return XDP_DROP directly. And in host, testpmd
> will do txonly fwd.
> 
> When burst size is 1 and packet size is 64 in testpmd and
> testpmd needs to iterate 5 Tx queues (but only the first two
> queues are enabled) to prepare and inject packets, I got ~12%
> performance boost (5.7Mpps -> 6.4Mpps). And if the vhost PMD
> is faster (e.g. just need to iterate the first two queues to
> prepare and inject packets), then I got similar performance
> for both rings (~9.9Mpps) (packed ring's performance can be
> lower, because it's more complicated in driver.)
> 
> I think packed ring makes vhost PMD faster, but it doesn't make
> the driver faster. In packed ring, the ring is simplified, and
> the handling of the ring in vhost (device) is also simplified,
> but things are not simplified in driver, e.g. although there is
> no desc table in the virtqueue anymore, driver still needs to
> maintain a private desc state table (which is still managed as
> a list in this patch set) to support the out-of-order desc
> processing in vhost (device).
> 
> I think this patch set is mainly to make the driver have a full
> functional support for the packed ring, which makes it possible
> to leverage the packed ring feature in vhost (device). But I'm
> not sure whether there is any other better idea, I'd like to
> hear your thoughts. Thanks!

Just this: Jens seems to report a nice gain with virtio and
vhost pmd across the board. Try to compare virtio and
virtio pmd to see what does pmd do better?


> 
> > 
> > On Wed, Jul 11, 2018 at 10:27:06AM +0800, Tiwei Bie wrote:
> > > Hello everyone,
> > > 
> > > This patch set implements packed ring support in virtio driver.
> > > 
> > > Some functional tests have been done with Jason's
> > > packed ring implementation in vhost:
> > > 
> > > https://lkml.org/lkml/2018/7/3/33
> > > 
> > > Both of ping and netperf worked as expected.
> > > 
> > > v1 -> v2:
> > > - Use READ_ONCE() to read event off_wrap and flags together (Jason);
> > > - Add comments related to ccw (Jason);
> > > 
> > > RFC (v6) -> v1:
> > > - Avoid extra virtio_wmb() in virtqueue_enable_cb_delayed_packed()
> > >   when event idx is off (Jason);
> > > - Fix bufs calculation in virtqueue_enable_cb_delayed_packed() (Jason);
> > > - Test the state of the desc at used_idx instead of last_used_idx
> > >   in virtqueue_enable_cb_delayed_packed() (Jason);
> > > - Save wrap counter (as part of queue state) in the return value
> > >   of virtqueue_enable_cb_prepare_packed();
> > > - Refine the packed ring definitions in uapi;
> > > - Rebase on the net-next tree;
> > > 
> > > RFC v5 -> RFC v6:
> > > - Avoid tracking addr/len/flags when DMA API isn't used (MST/Jason);
> > > - Define wrap counter as bool (Jason);
> > > - Use ALIGN() in vring_init_packed() (Jason);
> > > - Avoid using pointer to track `next` in detach_buf_packed() (Jason);
> > > - Add comments for barriers (Jason);
> > > - Don't enable RING_PACKED on ccw for now (noticed by Jason);
> > > - Refine the memory barrier in virtqueue_poll();
> > > - Add a missing memory barrier in virtqueue_enable_cb_delayed_packed();
> > > - Remove the hacks in virtqueue_enable_cb_prepare_packed();
> > > 
> > > RFC v4 -> RFC v5:
> > > - Save DMA addr, etc in desc state (Jason);
> > > - Track used wrap counter;
> > > 
> > > RFC v3 -> RFC v4:
> > > - Make ID allocation support out-of-order (Jason);
> > > - Various fixes for EVENT_IDX support;
> > > 
> > > RFC v2 -> RFC v3:
> > > - Split into small patches (Jason);
> > > - Add helper virtqueue_use_indirect() (Jason);
> > > - Just set id for the last descriptor of a list (Jason);
> > > - Calculate the prev in virtqueue_add_packed() (Jason);
> > > - Fix/improve desc suppression code (Jason/MST);
> > > - Refine the code layout for XXX_split/packed and wrappers (MST);
> > > - Fix the comments and API in uapi (MST);
> > > - Remove the BUG_ON() for indirect (Jason);
> > > - Some other refinements and bug fixes;
> > > 
> > > RFC v1 -> RFC v2:
> > > - Add indirect descriptor support - compile test only;
> > > - Add event suppression supprt - compile test only;
> > > - Move vring_packed_init() out of uapi (Jason, MST);
> > > - Merge two loops into one in virtqueue_add_packed() (Jason);
> > > - Split vring_unmap_one() for packed ring and split ring (Jason);
> > > - Avoid using '%' operator (Jason);
> > > - Rename free_head -> next_avail_idx (Jason);
> > > - Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
> > > - Some other refinements and bug fixes;
> > > 
> > > Thanks!
> > > 
> > > Tiwei Bie (5):
> > >   virtio: add packed ring definitions
> > >   virtio_ring: support creating packed ring
> > >   virtio_ring: add packed ring support
> > >   virtio_ring: add event idx support in packed ring
> > >   virtio_ring: enable packed ring
> > > 
> > >  drivers/s390/virtio/virtio_ccw.c   |   14 +
> > >  drivers/virtio/virtio_ring.c       | 1365 ++++++++++++++++++++++------
> > >  include/linux/virtio_ring.h        |    8 +-
> > >  include/uapi/linux/virtio_config.h |    3 +
> > >  include/uapi/linux/virtio_ring.h   |   43 +
> > >  5 files changed, 1157 insertions(+), 276 deletions(-)
> > > 
> > > -- 
> > > 2.18.0
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 
