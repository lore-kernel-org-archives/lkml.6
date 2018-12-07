Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B3C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165A82082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165A82082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLGSFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:05:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLGSFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:05:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E56E93164667;
        Fri,  7 Dec 2018 18:05:44 +0000 (UTC)
Received: from redhat.com (ovpn-124-251.rdu2.redhat.com [10.10.124.251])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0916F5C228;
        Fri,  7 Dec 2018 18:05:35 +0000 (UTC)
Date:   Fri, 7 Dec 2018 13:05:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [RFC 2/3] virtio_ring: add VIRTIO_RING_NO_LEGACY
Message-ID: <20181207130336-mutt-send-email-mst@kernel.org>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
 <20181207084842.13133-3-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207084842.13133-3-tiwei.bie@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 07 Dec 2018 18:05:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 04:48:41PM +0800, Tiwei Bie wrote:
> Introduce VIRTIO_RING_NO_LEGACY to support disabling legacy
> macros and layout definitions.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
> VRING_AVAIL_ALIGN_SIZE, VRING_USED_ALIGN_SIZE and VRING_DESC_ALIGN_SIZE
> are not pre-virtio 1.0, but can also be disabled by VIRTIO_RING_NO_LEGACY
> in this patch, because their names are not consistent with other names.
> Not sure whether this is a good idea. If we want this, we may also want
> to define _SPLIT_ version for them.

I don't think it's a good idea to have alignment in there - the point of
NO_LEGACY is to help catch bugs not to sanitize coding style IMHO.

And spec calls "legacy" the 0.X interfaces, let's not muddy the waters.

> 
>  include/uapi/linux/virtio_ring.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 9b0c0d92ab62..192573827850 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -37,6 +37,7 @@
>  #include <linux/types.h>
>  #include <linux/virtio_types.h>
>  
> +#ifndef VIRTIO_RING_NO_LEGACY
>  /*
>   * Notice: unlike other _F_ flags, below flags are defined as shifted
>   * values instead of shifts for compatibility.
> @@ -51,6 +52,7 @@
>  #define VRING_USED_F_NO_NOTIFY	1
>  /* Same as VRING_SPLIT_AVAIL_F_NO_INTERRUPT. */
>  #define VRING_AVAIL_F_NO_INTERRUPT	1
> +#endif /* VIRTIO_RING_NO_LEGACY */
>  
>  /* Mark a buffer as continuing via the next field in split ring. */
>  #define VRING_SPLIT_DESC_F_NEXT		0
> @@ -151,6 +153,7 @@ struct vring {
>  	struct vring_used *used;
>  };
>  
> +#ifndef VIRTIO_RING_NO_LEGACY
>  /* Alignment requirements for vring elements.
>   * When using pre-virtio 1.0 layout, these fall out naturally.
>   */
> @@ -203,6 +206,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
>  		 + align - 1) & ~(align - 1))
>  		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
>  }
> +#endif /* VIRTIO_RING_NO_LEGACY */
>  
>  /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
>  /* Assuming a given event_idx value from the other side, if
> -- 
> 2.17.1
