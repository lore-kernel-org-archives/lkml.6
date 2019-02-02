Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7943C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1C820870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfBBEHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:07:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:12513 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfBBEHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:07:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 20:07:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="143571060"
Received: from unknown (HELO dpdk-tbie) ([10.67.104.173])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2019 20:07:10 -0800
Date:   Sat, 2 Feb 2019 12:04:40 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio: drop internal struct from UAPI
Message-ID: <20190202040440.GA19948@dpdk-tbie>
References: <20190201221553.7210-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190201221553.7210-1-mst@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 05:16:01PM -0500, Michael S. Tsirkin wrote:
> There's no reason to expose struct vring_packed in UAPI - if we do we
> won't be able to change or drop it, and it's not part of any interface.
> 
> Let's move it to virtio_ring.c
> 
> Cc: Tiwei Bie <tiwei.bie@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c     |  7 ++++++-
>  include/uapi/linux/virtio_ring.h | 10 ----------
>  2 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 412e0c431d87..1c85b3423182 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -152,7 +152,12 @@ struct vring_virtqueue {
>  		/* Available for packed ring */
>  		struct {
>  			/* Actual memory layout for this queue. */
> -			struct vring_packed vring;
> +			struct {
> +				unsigned int num;
> +				struct vring_packed_desc *desc;
> +				struct vring_packed_desc_event *driver;
> +				struct vring_packed_desc_event *device;
> +			} vring;
>  
>  			/* Driver ring wrap counter. */
>  			bool avail_wrap_counter;
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 2414f8af26b3..4c4e24c291a5 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -213,14 +213,4 @@ struct vring_packed_desc {
>  	__le16 flags;
>  };
>  
> -struct vring_packed {
> -	unsigned int num;
> -
> -	struct vring_packed_desc *desc;
> -
> -	struct vring_packed_desc_event *driver;
> -
> -	struct vring_packed_desc_event *device;
> -};
> -
>  #endif /* _UAPI_LINUX_VIRTIO_RING_H */
> -- 
> MST

Acked-by: Tiwei Bie <tiwei.bie@intel.com>
