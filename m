Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB33C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5E220834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5E220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeLANQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:16:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:64190 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeLANQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:16:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 18:05:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,300,1539673200"; 
   d="scan'208";a="279578153"
Received: from btwcube1.sh.intel.com (HELO debian) ([10.67.104.173])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2018 18:05:08 -0800
Date:   Sat, 1 Dec 2018 10:03:19 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v3 01/13] virtio: add packed ring types and
 macros
Message-ID: <20181201020318.GA28554@debian>
References: <20181121100330.24846-2-tiwei.bie@intel.com>
 <1928ac96-3684-45c4-1e8c-09dff03bf308@redhat.com>
 <20181130095339.GA11984@debian>
 <20181130074720-mutt-send-email-mst@kernel.org>
 <13593b5c-c1dc-3ab3-a843-d62908e0c7e0@redhat.com>
 <20181130084722-mutt-send-email-mst@kernel.org>
 <20181130153737.GA15105@debian>
 <20181130104957-mutt-send-email-mst@kernel.org>
 <20181130162416.GA19234@debian>
 <20181130114501-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181130114501-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:46:57AM -0500, Michael S. Tsirkin wrote:
> On Sat, Dec 01, 2018 at 12:24:16AM +0800, Tiwei Bie wrote:
> > On Fri, Nov 30, 2018 at 10:53:07AM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Nov 30, 2018 at 11:37:37PM +0800, Tiwei Bie wrote:
> > > > On Fri, Nov 30, 2018 at 08:52:42AM -0500, Michael S. Tsirkin wrote:
> > > > > On Fri, Nov 30, 2018 at 02:01:06PM +0100, Maxime Coquelin wrote:
> > > > > > On 11/30/18 1:47 PM, Michael S. Tsirkin wrote:
> > > > > > > On Fri, Nov 30, 2018 at 05:53:40PM +0800, Tiwei Bie wrote:
> > > > > > > > On Fri, Nov 30, 2018 at 04:10:55PM +0800, Jason Wang wrote:
> > > > > > > > > 
> > > > > > > > > On 2018/11/21 下午6:03, Tiwei Bie wrote:
> > > > > > > > > > Add types and macros for packed ring.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > > > > > > > ---
> > > > > > > > > >    include/uapi/linux/virtio_config.h |  3 +++
> > > > > > > > > >    include/uapi/linux/virtio_ring.h   | 52 ++++++++++++++++++++++++++++++++++++++
> > > > > > > > > >    2 files changed, 55 insertions(+)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > > > > > > > > > index 449132c76b1c..1196e1c1d4f6 100644
> > > > > > > > > > --- a/include/uapi/linux/virtio_config.h
> > > > > > > > > > +++ b/include/uapi/linux/virtio_config.h
> > > > > > > > > > @@ -75,6 +75,9 @@
> > > > > > > > > >     */
> > > > > > > > > >    #define VIRTIO_F_IOMMU_PLATFORM		33
> > > > > > > > > > +/* This feature indicates support for the packed virtqueue layout. */
> > > > > > > > > > +#define VIRTIO_F_RING_PACKED		34
> > > > > > > > > > +
> > > > > > > > > >    /*
> > > > > > > > > >     * Does the device support Single Root I/O Virtualization?
> > > > > > > > > >     */
> > > > > > > > > > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > > > > > > > > > index 6d5d5faa989b..2414f8af26b3 100644
> > > > > > > > > > --- a/include/uapi/linux/virtio_ring.h
> > > > > > > > > > +++ b/include/uapi/linux/virtio_ring.h
> > > > > > > > > > @@ -44,6 +44,13 @@
> > > > > > > > > >    /* This means the buffer contains a list of buffer descriptors. */
> > > > > > > > > >    #define VRING_DESC_F_INDIRECT	4
> > > > > > > > > > +/*
> > > > > > > > > > + * Mark a descriptor as available or used in packed ring.
> > > > > > > > > > + * Notice: they are defined as shifts instead of shifted values.
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > This looks inconsistent to previous flags, any reason for using shifts?
> > > > > > > > 
> > > > > > > > Yeah, it was suggested to use shifts, as _F_ should be a bit
> > > > > > > > number, not a shifted value:
> > > > > > > > 
> > > > > > > > https://patchwork.ozlabs.org/patch/942296/#1989390
> > > > > > > 
> > > > > > > But let's add a _SPLIT_ variant that uses shifts consistently.
> > > > > > 
> > > > > > Maybe we could avoid adding SPLIT and PACKED, but define as follow:
> > > > > > 
> > > > > > #define VRING_DESC_F_INDIRECT_SHIFT 2
> > > > > > #define VRING_DESC_F_INDIRECT (1ull <<  VRING_DESC_F_INDIRECT_SHIFT)
> > > > > > 
> > > > > > #define VRING_DESC_F_AVAIL_SHIFT 7
> > > > > > #define VRING_DESC_F_AVAIL (1ull << VRING_DESC_F_AVAIL_SHIFT)
> > > > > > 
> > > > > > I think it would be better for consistency.
> > > > > 
> > > > > I don't think that will help. the problem is that
> > > > > most of the existing virtio code consistently uses _F_ as shifts.
> > > > > So we just need to do something about these 5 being inconsistent:
> > > > > 
> > > > > include/uapi/linux/virtio_ring.h:#define VRING_DESC_F_NEXT      1
> > > > > include/uapi/linux/virtio_ring.h:#define VRING_DESC_F_WRITE     2
> > > > > include/uapi/linux/virtio_ring.h:#define VRING_DESC_F_INDIRECT  4
> > > > > include/uapi/linux/virtio_ring.h:#define VRING_USED_F_NO_NOTIFY 1
> > > > > include/uapi/linux/virtio_ring.h:#define VRING_AVAIL_F_NO_INTERRUPT     1
> > > > > 
> > > > > I do not want all of virtio to become verbose with _SHIFT, ergo
> > > > > we need to change the above 5 to have names which are with _F_ and
> > > > > have the bit number.
> > > > 
> > > > How about something like this:
> > > > 
> > > > #define VRING_COMM_DESC_F_NEXT			0
> > > > #define VRING_COMM_DESC_F_WRITE			1
> > > > #define VRING_COMM_DESC_F_INDIRECT		2
> > > > 
> > > > #define VRING_SPLIT_USED_F_NO_NOTIFY		0
> > > > #define VRING_SPLIT_AVAIL_F_NO_INTERRUPT	0
> > > > 
> > > > or
> > > > 
> > > > #define VRING_SPLIT_DESC_F_NEXT			0
> > > > #define VRING_SPLIT_DESC_F_WRITE		1
> > > > #define VRING_SPLIT_DESC_F_INDIRECT		2
> > > > 
> > > > #define VRING_SPLIT_USED_F_NO_NOTIFY		0
> > > > #define VRING_SPLIT_AVAIL_F_NO_INTERRUPT	0
> > > > 
> > > > #define VRING_PACKED_DESC_F_NEXT		0
> > > > #define VRING_PACKED_DESC_F_WRITE		1
> > > > #define VRING_PACKED_DESC_F_INDIRECT		2
> > > 
> > > As we aren't sharing code I think I prefer the second form.
> > > Maybe add VRING_NO_LEGACY so people can audit their code
> > > for assumptions?
> > 
> > Maybe it's better to name it as VIRTIO_RING_NO_LEGACY
> > which is more consistent with the names in other files.
> 
> OK
> 
> > > 
> > > We also want to guard layout definitions at the end of that file
> > > I think.
> > 
> > Do you mean guard the definitions of `struct vring` and
> > `struct vring_packed` with _NO_LEGACY?
> 
> I really mean vring_size/vring_init/vring_used_event/vring_avail_event
> these are pre- virtio 1 and should be disabled when
> building with no legacy.
> 
> But yes I would say let's make sure people can set a flag and
> find all dependencies of the split layout in their code easily.

I see. Thanks!

> 
> > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > + */
> > > > > > > > > > +#define VRING_PACKED_DESC_F_AVAIL	7
> > > > > > > > > > +#define VRING_PACKED_DESC_F_USED	15
> > > > > > > > > > +
> > > > > > > > > >    /* The Host uses this in used->flags to advise the Guest: don't kick me when
> > > > > > > > > >     * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
> > > > > > > > > >     * will still kick if it's out of buffers. */
> > > > > > > > > > @@ -53,6 +60,23 @@
> > > > > > > > > >     * optimization.  */
> > > > > > > > > >    #define VRING_AVAIL_F_NO_INTERRUPT	1
> > > > > > > > > > +/* Enable events in packed ring. */
> > > > > > > > > > +#define VRING_PACKED_EVENT_FLAG_ENABLE	0x0
> > > > > > > > > > +/* Disable events in packed ring. */
> > > > > > > > > > +#define VRING_PACKED_EVENT_FLAG_DISABLE	0x1
> > > > > > > > > > +/*
> > > > > > > > > > + * Enable events for a specific descriptor in packed ring.
> > > > > > > > > > + * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> > > > > > > > > > + * Only valid if VIRTIO_RING_F_EVENT_IDX has been negotiated.
> > > > > > > > > > + */
> > > > > > > > > > +#define VRING_PACKED_EVENT_FLAG_DESC	0x2
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Any reason for using _FLAG_ instead of _F_?
> > > > > > > > 
> > > > > > > > Yeah, it was suggested to not use _F_, as these are values,
> > > > > > > > should not have _F_:
> > > > > > > > 
> > > > > > > > https://patchwork.ozlabs.org/patch/942296/#1989390
> > > > > > > > 
> > > > > > > > Regards,
> > > > > > > > Tiwei
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Thanks
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > +
> > > > > > > > > > +/*
> > > > > > > > > > + * Wrap counter bit shift in event suppression structure
> > > > > > > > > > + * of packed ring.
> > > > > > > > > > + */
> > > > > > > > > > +#define VRING_PACKED_EVENT_F_WRAP_CTR	15
> > > > > > > > > > +
> > > > > > > > > >    /* We support indirect buffer descriptors */
> > > > > > > > > >    #define VIRTIO_RING_F_INDIRECT_DESC	28
> > > > > > > > > > @@ -171,4 +195,32 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
> > > > > > > > > >    	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
> > > > > > > > > >    }
> > > > > > > > > > +struct vring_packed_desc_event {
> > > > > > > > > > +	/* Descriptor Ring Change Event Offset/Wrap Counter. */
> > > > > > > > > > +	__le16 off_wrap;
> > > > > > > > > > +	/* Descriptor Ring Change Event Flags. */
> > > > > > > > > > +	__le16 flags;
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > > +struct vring_packed_desc {
> > > > > > > > > > +	/* Buffer Address. */
> > > > > > > > > > +	__le64 addr;
> > > > > > > > > > +	/* Buffer Length. */
> > > > > > > > > > +	__le32 len;
> > > > > > > > > > +	/* Buffer ID. */
> > > > > > > > > > +	__le16 id;
> > > > > > > > > > +	/* The flags depending on descriptor type. */
> > > > > > > > > > +	__le16 flags;
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > > +struct vring_packed {
> > > > > > > > > > +	unsigned int num;
> > > > > > > > > > +
> > > > > > > > > > +	struct vring_packed_desc *desc;
> > > > > > > > > > +
> > > > > > > > > > +	struct vring_packed_desc_event *driver;
> > > > > > > > > > +
> > > > > > > > > > +	struct vring_packed_desc_event *device;
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > >    #endif /* _UAPI_LINUX_VIRTIO_RING_H */
