Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33342C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA7920880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA7920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeILR5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:57:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbeILR5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:57:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6894B87A7D;
        Wed, 12 Sep 2018 12:53:23 +0000 (UTC)
Received: from redhat.com (ovpn-121-244.rdu2.redhat.com [10.10.121.244])
        by smtp.corp.redhat.com (Postfix) with SMTP id 96DB62027EA4;
        Wed, 12 Sep 2018 12:53:20 +0000 (UTC)
Date:   Wed, 12 Sep 2018 08:53:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v2 1/5] virtio: add packed ring definitions
Message-ID: <20180912084549-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-2-tiwei.bie@intel.com>
 <20180907094922-mutt-send-email-mst@kernel.org>
 <20180910021322.GA10912@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910021322.GA10912@debian>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 12 Sep 2018 12:53:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 12 Sep 2018 12:53:23 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:13:22AM +0800, Tiwei Bie wrote:
> On Fri, Sep 07, 2018 at 09:51:23AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 11, 2018 at 10:27:07AM +0800, Tiwei Bie wrote:
> > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > ---
> > >  include/uapi/linux/virtio_config.h |  3 +++
> > >  include/uapi/linux/virtio_ring.h   | 43 ++++++++++++++++++++++++++++++
> > >  2 files changed, 46 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > > index 449132c76b1c..1196e1c1d4f6 100644
> > > --- a/include/uapi/linux/virtio_config.h
> > > +++ b/include/uapi/linux/virtio_config.h
> > > @@ -75,6 +75,9 @@
> > >   */
> > >  #define VIRTIO_F_IOMMU_PLATFORM		33
> > >  
> > > +/* This feature indicates support for the packed virtqueue layout. */
> > > +#define VIRTIO_F_RING_PACKED		34
> > > +
> > >  /*
> > >   * Does the device support Single Root I/O Virtualization?
> > >   */
> > > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > > index 6d5d5faa989b..0254a2ba29cf 100644
> > > --- a/include/uapi/linux/virtio_ring.h
> > > +++ b/include/uapi/linux/virtio_ring.h
> > > @@ -44,6 +44,10 @@
> > >  /* This means the buffer contains a list of buffer descriptors. */
> > >  #define VRING_DESC_F_INDIRECT	4
> > >  
> > > +/* Mark a descriptor as available or used. */
> > > +#define VRING_DESC_F_AVAIL	(1ul << 7)
> > > +#define VRING_DESC_F_USED	(1ul << 15)
> > > +
> > >  /* The Host uses this in used->flags to advise the Guest: don't kick me when
> > >   * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
> > >   * will still kick if it's out of buffers. */
> > > @@ -53,6 +57,17 @@
> > >   * optimization.  */
> > >  #define VRING_AVAIL_F_NO_INTERRUPT	1
> > >  
> > > +/* Enable events. */
> > > +#define VRING_EVENT_F_ENABLE	0x0
> > > +/* Disable events. */
> > > +#define VRING_EVENT_F_DISABLE	0x1
> > > +/*
> > > + * Enable events for a specific descriptor
> > > + * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> > > + * Only valid if VIRTIO_RING_F_EVENT_IDX has been negotiated.
> > > + */
> > > +#define VRING_EVENT_F_DESC	0x2
> > > +
> > >  /* We support indirect buffer descriptors */
> > >  #define VIRTIO_RING_F_INDIRECT_DESC	28
> > >  
> > 
> > These are for the packed ring, right? Pls prefix accordingly.
> 
> How about something like this:
> 
> #define VRING_PACKED_DESC_F_AVAIL	(1u << 7)
> #define VRING_PACKED_DESC_F_USED	(1u << 15)

_F_ should be a bit number, not a shifted value.
Yes I know current virtio_ring.h is inconsistent in
that respect. changes welcome though we need to
maintain the old names for the sake of old apps.

> 
> #define VRING_PACKED_EVENT_F_ENABLE	0x0
> #define VRING_PACKED_EVENT_F_DISABLE	0x1
> #define VRING_PACKED_EVENT_F_DESC	0x2

These are values, I think they should not have _F_.
Yes I know current virtio_ring.h is inconsistent in
that respect.


> 
> > Also, you likely need macros for the wrap counters.
> 
> How about something like this:
> 
> #define VRING_PACKED_EVENT_WRAP_COUNTER_SHIFT	15

Given it's a single bit, maybe even
VRING_PACKED_EVENT_F_WRAP_CTR

> #define VRING_PACKED_EVENT_WRAP_COUNTER_MASK	\
> 			(1u << VRING_PACKED_WRAP_COUNTER_SHIFT)
> #define VRING_PACKED_EVENT_OFFSET_MASK	\
> 			((1u << VRING_PACKED_WRAP_COUNTER_SHIFT) - 1)

I'm not sure the mask is justified.

> > 
> > > @@ -171,4 +186,32 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
> > >  	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
> > >  }
> > >  
> > > +struct vring_packed_desc_event {
> > > +	/* Descriptor Ring Change Event Offset/Wrap Counter. */
> > > +	__virtio16 off_wrap;
> > > +	/* Descriptor Ring Change Event Flags. */
> > > +	__virtio16 flags;
> > > +};
> > > +
> > > +struct vring_packed_desc {
> > > +	/* Buffer Address. */
> > > +	__virtio64 addr;
> > > +	/* Buffer Length. */
> > > +	__virtio32 len;
> > > +	/* Buffer ID. */
> > > +	__virtio16 id;
> > > +	/* The flags depending on descriptor type. */
> > > +	__virtio16 flags;
> > > +};
> > 
> > Don't use __virtioXX types, just __leXX ones.
> 
> Got it, will do that.
> 
> > 
> > > +
> > > +struct vring_packed {
> > > +	unsigned int num;
> > > +
> > > +	struct vring_packed_desc *desc;
> > > +
> > > +	struct vring_packed_desc_event *driver;
> > > +
> > > +	struct vring_packed_desc_event *device;
> > > +};
> > > +
> > >  #endif /* _UAPI_LINUX_VIRTIO_RING_H */
> > > -- 
> > > 2.18.0
