Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E1ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788EA20858
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788EA20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeGPNQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:16:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727522AbeGPNQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:16:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB7AA77886;
        Mon, 16 Jul 2018 12:49:10 +0000 (UTC)
Received: from redhat.com (ovpn-120-40.rdu2.redhat.com [10.10.120.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85B5F7C4D;
        Mon, 16 Jul 2018 12:49:04 +0000 (UTC)
Date:   Mon, 16 Jul 2018 15:49:04 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com,
        maxime.coquelin@redhat.com
Subject: Re: [PATCH net-next V2 0/8] Packed virtqueue support for vhost
Message-ID: <20180716154102-mutt-send-email-mst@kernel.org>
References: <1531711691-6769-1-git-send-email-jasowang@redhat.com>
 <20180716113720-mutt-send-email-mst@kernel.org>
 <33f4643f-f226-0389-1f4f-607c289db94e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33f4643f-f226-0389-1f4f-607c289db94e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 16 Jul 2018 12:49:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 16 Jul 2018 12:49:10 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 05:46:33PM +0800, Jason Wang wrote:
> 
> 
> On 2018年07月16日 16:39, Michael S. Tsirkin wrote:
> > On Mon, Jul 16, 2018 at 11:28:03AM +0800, Jason Wang wrote:
> > > Hi all:
> > > 
> > > This series implements packed virtqueues. The code were tested with
> > > Tiwei's guest driver series at https://patchwork.ozlabs.org/cover/942297/
> > > 
> > > 
> > > Pktgen test for both RX and TX does not show obvious difference with
> > > split virtqueues. The main bottleneck is the guest Linux driver, since
> > > it can not stress vhost for a 100% CPU utilization. A full TCP
> > > benchmark is ongoing. Will test virtio-net pmd as well when it was
> > > ready.
> > Well the question then is why we should bother merging this
> > if this doesn't give a performance gain.
> 
> We meet bottlenecks at other places. I can only test Linux driver which has
> lots of overheads e.g interrupts. And perf show only a small fraction of
> time were spent on e.g virtqueue manipulation. I hope virtio-net pmd can
> give us different result but we don't have one ready for testing now. (Jen's
> V4 have bugs thus can not work with this series).

Can't linux busy poll? And how about testing loopback with XDP?

> >   Do you see
> > a gain in CPU utilization maybe?
> 
> Unfortunately not.
> 
> > 
> > If not - let's wait for that TCP benchmark result?
> 
> We can, but you know TCP_STREAM result is sometime misleading.
> 
> A brunch of other patches of mine were rebased on this and then blocked on
> this series. Consider we don't meet regression, maybe we can merge this
> first and try optimizations or fixups on top?
> 
> Thanks

I'm not sure I understand this approach. Packed ring is just an optimization.
What value is there in merging it if it does not help speed?

> > 
> > > Notes:
> > > - This version depends on Tiwei's series at https://patchwork.ozlabs.org/cover/942297/
> > > 
> > > This version were tested with:
> > > 
> > > - Zerocopy (Out of Order) support
> > > - vIOMMU support
> > > - mergeable buffer on/off
> > > - busy polling on/off
> > > - vsock (nc-vsock)
> > > 
> > > Changes from V1:
> > > - drop uapi patch and use Tiwei's
> > > - split the enablement of packed virtqueue into a separate patch
> > > 
> > > Changes from RFC V5:
> > > 
> > > - save unnecessary barriers during vhost_add_used_packed_n()
> > > - more compact math for event idx
> > > - fix failure of SET_VRING_BASE when avail_wrap_counter is true
> > > - fix not copy avail_wrap_counter during GET_VRING_BASE
> > > - introduce SET_VRING_USED_BASE/GET_VRING_USED_BASE for syncing last_used_idx
> > > - rename used_wrap_counter to last_used_wrap_counter
> > > - rebase to net-next
> > > 
> > > Changes from RFC V4:
> > > 
> > > - fix signalled_used index recording
> > > - track avail index correctly
> > > - various minor fixes
> > > 
> > > Changes from RFC V3:
> > > 
> > > - Fix math on event idx checking
> > > - Sync last avail wrap counter through GET/SET_VRING_BASE
> > > - remove desc_event prefix in the driver/device structure
> > > 
> > > Changes from RFC V2:
> > > 
> > > - do not use & in checking desc_event_flags
> > > - off should be most significant bit
> > > - remove the workaround of mergeable buffer for dpdk prototype
> > > - id should be in the last descriptor in the chain
> > > - keep _F_WRITE for write descriptor when adding used
> > > - device flags updating should use ADDR_USED type
> > > - return error on unexpected unavail descriptor in a chain
> > > - return false in vhost_ve_avail_empty is descriptor is available
> > > - track last seen avail_wrap_counter
> > > - correctly examine available descriptor in get_indirect_packed()
> > > - vhost_idx_diff should return u16 instead of bool
> > > 
> > > Changes from RFC V1:
> > > 
> > > - Refactor vhost used elem code to avoid open coding on used elem
> > > - Event suppression support (compile test only).
> > > - Indirect descriptor support (compile test only).
> > > - Zerocopy support.
> > > - vIOMMU support.
> > > - SCSI/VSOCK support (compile test only).
> > > - Fix several bugs
> > > 
> > > Jason Wang (8):
> > >    vhost: move get_rx_bufs to vhost.c
> > >    vhost: hide used ring layout from device
> > >    vhost: do not use vring_used_elem
> > >    vhost_net: do not explicitly manipulate vhost_used_elem
> > >    vhost: vhost_put_user() can accept metadata type
> > >    vhost: packed ring support
> > >    vhost: event suppression for packed ring
> > >    vhost: enable packed virtqueues
> > > 
> > >   drivers/vhost/net.c        | 143 ++-----
> > >   drivers/vhost/scsi.c       |  62 +--
> > >   drivers/vhost/vhost.c      | 994 ++++++++++++++++++++++++++++++++++++++++-----
> > >   drivers/vhost/vhost.h      |  55 ++-
> > >   drivers/vhost/vsock.c      |  42 +-
> > >   include/uapi/linux/vhost.h |   7 +
> > >   6 files changed, 1035 insertions(+), 268 deletions(-)
> > > 
> > > -- 
> > > 2.7.4
