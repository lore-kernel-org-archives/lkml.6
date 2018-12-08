Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3D9C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDB52082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDB52082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeLHNfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 08:35:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:41436 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeLHNfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 08:35:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2018 05:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,330,1539673200"; 
   d="scan'208";a="128248266"
Received: from btwcube1.sh.intel.com (HELO dpdk-tbie) ([10.67.104.173])
  by fmsmga001.fm.intel.com with ESMTP; 08 Dec 2018 05:35:30 -0800
Date:   Sat, 8 Dec 2018 21:33:37 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [RFC 2/3] virtio_ring: add VIRTIO_RING_NO_LEGACY
Message-ID: <20181208133337.GB29772@dpdk-tbie>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
 <20181207084842.13133-3-tiwei.bie@intel.com>
 <20181207130336-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207130336-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 01:05:35PM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 04:48:41PM +0800, Tiwei Bie wrote:
> > Introduce VIRTIO_RING_NO_LEGACY to support disabling legacy
> > macros and layout definitions.
> > 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> > VRING_AVAIL_ALIGN_SIZE, VRING_USED_ALIGN_SIZE and VRING_DESC_ALIGN_SIZE
> > are not pre-virtio 1.0, but can also be disabled by VIRTIO_RING_NO_LEGACY
> > in this patch, because their names are not consistent with other names.
> > Not sure whether this is a good idea. If we want this, we may also want
> > to define _SPLIT_ version for them.
> 
> I don't think it's a good idea to have alignment in there - the point of
> NO_LEGACY is to help catch bugs not to sanitize coding style IMHO.
> 
> And spec calls "legacy" the 0.X interfaces, let's not muddy the waters.

Make sense. Thanks!

> 
> > 
> >  include/uapi/linux/virtio_ring.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > index 9b0c0d92ab62..192573827850 100644
> > --- a/include/uapi/linux/virtio_ring.h
> > +++ b/include/uapi/linux/virtio_ring.h
> > @@ -37,6 +37,7 @@
> >  #include <linux/types.h>
> >  #include <linux/virtio_types.h>
> >  
> > +#ifndef VIRTIO_RING_NO_LEGACY
> >  /*
> >   * Notice: unlike other _F_ flags, below flags are defined as shifted
> >   * values instead of shifts for compatibility.
> > @@ -51,6 +52,7 @@
> >  #define VRING_USED_F_NO_NOTIFY	1
> >  /* Same as VRING_SPLIT_AVAIL_F_NO_INTERRUPT. */
> >  #define VRING_AVAIL_F_NO_INTERRUPT	1
> > +#endif /* VIRTIO_RING_NO_LEGACY */
> >  
> >  /* Mark a buffer as continuing via the next field in split ring. */
> >  #define VRING_SPLIT_DESC_F_NEXT		0
> > @@ -151,6 +153,7 @@ struct vring {
> >  	struct vring_used *used;
> >  };
> >  
> > +#ifndef VIRTIO_RING_NO_LEGACY
> >  /* Alignment requirements for vring elements.
> >   * When using pre-virtio 1.0 layout, these fall out naturally.
> >   */
> > @@ -203,6 +206,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
> >  		 + align - 1) & ~(align - 1))
> >  		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
> >  }
> > +#endif /* VIRTIO_RING_NO_LEGACY */
> >  
> >  /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
> >  /* Assuming a given event_idx value from the other side, if
> > -- 
> > 2.17.1
