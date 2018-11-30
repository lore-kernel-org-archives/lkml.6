Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E733AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AE120868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AE120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeK3VEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:04:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:50130 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbeK3VEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:04:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 01:55:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,298,1539673200"; 
   d="scan'208";a="114152244"
Received: from btwcube1.sh.intel.com (HELO debian) ([10.67.104.173])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2018 01:55:29 -0800
Date:   Fri, 30 Nov 2018 17:53:40 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [PATCH net-next v3 01/13] virtio: add packed ring types and
 macros
Message-ID: <20181130095339.GA11984@debian>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
 <20181121100330.24846-2-tiwei.bie@intel.com>
 <1928ac96-3684-45c4-1e8c-09dff03bf308@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1928ac96-3684-45c4-1e8c-09dff03bf308@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 04:10:55PM +0800, Jason Wang wrote:
> 
> On 2018/11/21 下午6:03, Tiwei Bie wrote:
> > Add types and macros for packed ring.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> >   include/uapi/linux/virtio_config.h |  3 +++
> >   include/uapi/linux/virtio_ring.h   | 52 ++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 55 insertions(+)
> > 
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index 449132c76b1c..1196e1c1d4f6 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -75,6 +75,9 @@
> >    */
> >   #define VIRTIO_F_IOMMU_PLATFORM		33
> > +/* This feature indicates support for the packed virtqueue layout. */
> > +#define VIRTIO_F_RING_PACKED		34
> > +
> >   /*
> >    * Does the device support Single Root I/O Virtualization?
> >    */
> > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > index 6d5d5faa989b..2414f8af26b3 100644
> > --- a/include/uapi/linux/virtio_ring.h
> > +++ b/include/uapi/linux/virtio_ring.h
> > @@ -44,6 +44,13 @@
> >   /* This means the buffer contains a list of buffer descriptors. */
> >   #define VRING_DESC_F_INDIRECT	4
> > +/*
> > + * Mark a descriptor as available or used in packed ring.
> > + * Notice: they are defined as shifts instead of shifted values.
> 
> 
> This looks inconsistent to previous flags, any reason for using shifts?

Yeah, it was suggested to use shifts, as _F_ should be a bit
number, not a shifted value:

https://patchwork.ozlabs.org/patch/942296/#1989390

> 
> 
> > + */
> > +#define VRING_PACKED_DESC_F_AVAIL	7
> > +#define VRING_PACKED_DESC_F_USED	15
> > +
> >   /* The Host uses this in used->flags to advise the Guest: don't kick me when
> >    * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
> >    * will still kick if it's out of buffers. */
> > @@ -53,6 +60,23 @@
> >    * optimization.  */
> >   #define VRING_AVAIL_F_NO_INTERRUPT	1
> > +/* Enable events in packed ring. */
> > +#define VRING_PACKED_EVENT_FLAG_ENABLE	0x0
> > +/* Disable events in packed ring. */
> > +#define VRING_PACKED_EVENT_FLAG_DISABLE	0x1
> > +/*
> > + * Enable events for a specific descriptor in packed ring.
> > + * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> > + * Only valid if VIRTIO_RING_F_EVENT_IDX has been negotiated.
> > + */
> > +#define VRING_PACKED_EVENT_FLAG_DESC	0x2
> 
> 
> Any reason for using _FLAG_ instead of _F_?

Yeah, it was suggested to not use _F_, as these are values,
should not have _F_:

https://patchwork.ozlabs.org/patch/942296/#1989390

Regards,
Tiwei

> 
> Thanks
> 
> 
> > +
> > +/*
> > + * Wrap counter bit shift in event suppression structure
> > + * of packed ring.
> > + */
> > +#define VRING_PACKED_EVENT_F_WRAP_CTR	15
> > +
> >   /* We support indirect buffer descriptors */
> >   #define VIRTIO_RING_F_INDIRECT_DESC	28
> > @@ -171,4 +195,32 @@ static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
> >   	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
> >   }
> > +struct vring_packed_desc_event {
> > +	/* Descriptor Ring Change Event Offset/Wrap Counter. */
> > +	__le16 off_wrap;
> > +	/* Descriptor Ring Change Event Flags. */
> > +	__le16 flags;
> > +};
> > +
> > +struct vring_packed_desc {
> > +	/* Buffer Address. */
> > +	__le64 addr;
> > +	/* Buffer Length. */
> > +	__le32 len;
> > +	/* Buffer ID. */
> > +	__le16 id;
> > +	/* The flags depending on descriptor type. */
> > +	__le16 flags;
> > +};
> > +
> > +struct vring_packed {
> > +	unsigned int num;
> > +
> > +	struct vring_packed_desc *desc;
> > +
> > +	struct vring_packed_desc_event *driver;
> > +
> > +	struct vring_packed_desc_event *device;
> > +};
> > +
> >   #endif /* _UAPI_LINUX_VIRTIO_RING_H */
