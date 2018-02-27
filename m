Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeB0U2V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:28:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751628AbeB0U2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:28:19 -0500
Date: Tue, 27 Feb 2018 22:28:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jasowang@redhat.com, wexu@redhat.com
Subject: Re: [PATCH RFC 1/2] virtio: introduce packed ring defines
Message-ID: <20180227222806-mutt-send-email-mst@kernel.org>
References: <20180223111801.15240-1-tiwei.bie@intel.com>
 <20180223111801.15240-2-tiwei.bie@intel.com>
 <20180227085458.h5dytkwaeczrrijr@dhcp-192-241.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227085458.h5dytkwaeczrrijr@dhcp-192-241.str.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 09:54:58AM +0100, Jens Freimann wrote:
> On Fri, Feb 23, 2018 at 07:18:00PM +0800, Tiwei Bie wrote:
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> > include/uapi/linux/virtio_config.h | 18 +++++++++-
> > include/uapi/linux/virtio_ring.h   | 68 ++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 85 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index 308e2096291f..e3d077ef5207 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -49,7 +49,7 @@
> >  * transport being used (eg. virtio_ring), the rest are per-device feature
> >  * bits. */
> > #define VIRTIO_TRANSPORT_F_START	28
> > -#define VIRTIO_TRANSPORT_F_END		34
> > +#define VIRTIO_TRANSPORT_F_END		37
> > 
> > #ifndef VIRTIO_CONFIG_NO_LEGACY
> > /* Do we get callbacks when the ring is completely used, even if we've
> > @@ -71,4 +71,20 @@
> >  * this is for compatibility with legacy systems.
> >  */
> > #define VIRTIO_F_IOMMU_PLATFORM		33
> > +
> > +/* This feature indicates support for the packed virtqueue layout. */
> > +#define VIRTIO_F_RING_PACKED		34
> 
> Spec says VIRTIO_F_PACKED_RING not RING_PACKED

I changed that now :)

> > +
> > +/*
> > + * This feature indicates that all buffers are used by the device
> > + * in the same order in which they have been made available.
> > + */
> > +#define VIRTIO_F_IN_ORDER		35
> > +
> > +/*
> > + * This feature indicates that drivers pass extra data (besides
> > + * identifying the Virtqueue) in their device notifications.
> > + */
> > +#define VIRTIO_F_NOTIFICATION_DATA	36
> > +
> > #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > index 6d5d5faa989b..77b1d4aeef72 100644
> > --- a/include/uapi/linux/virtio_ring.h
> > +++ b/include/uapi/linux/virtio_ring.h
> > @@ -44,6 +44,9 @@
> > /* This means the buffer contains a list of buffer descriptors. */
> > #define VRING_DESC_F_INDIRECT	4
> > 
> > +#define VRING_DESC_F_AVAIL(b)	((b) << 7)
> > +#define VRING_DESC_F_USED(b)	((b) << 15)
> > +
> > /* The Host uses this in used->flags to advise the Guest: don't kick me when
> >  * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
> >  * will still kick if it's out of buffers. */
> > @@ -104,6 +107,36 @@ struct vring {
> > 	struct vring_used *used;
> > };
> > 
> > +struct vring_packed_desc_event {
> > +	/* Descriptor Event Offset */
> > +	__virtio16 desc_event_off   : 15,
> > +	/* Descriptor Event Wrap Counter */
> > +		   desc_event_wrap  : 1;
> > +	/* Descriptor Event Flags */
> > +	__virtio16 desc_event_flags : 2;
> > +};
> 
> Where would the virtqueue number go in driver notifications?
> 
> regards,
> Jens
