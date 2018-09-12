Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3C5C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A1C2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A1C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeILV1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:27:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbeILV1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:27:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B568940241C8;
        Wed, 12 Sep 2018 16:22:25 +0000 (UTC)
Received: from redhat.com (ovpn-121-244.rdu2.redhat.com [10.10.121.244])
        by smtp.corp.redhat.com (Postfix) with SMTP id 057E62166BA2;
        Wed, 12 Sep 2018 16:22:22 +0000 (UTC)
Date:   Wed, 12 Sep 2018 12:22:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v2 3/5] virtio_ring: add packed ring support
Message-ID: <20180912121650-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-4-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711022711.7090-4-tiwei.bie@intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 12 Sep 2018 16:22:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 12 Sep 2018 16:22:25 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:27:09AM +0800, Tiwei Bie wrote:
> This commit introduces the support (without EVENT_IDX) for
> packed ring.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  drivers/virtio/virtio_ring.c | 495 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 487 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c4f8abc7445a..f317b485ba54 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -55,12 +55,21 @@
>  #define END_USE(vq)
>  #endif
>  
> +#define _VRING_DESC_F_AVAIL(b)	((__u16)(b) << 7)
> +#define _VRING_DESC_F_USED(b)	((__u16)(b) << 15)
> +
>  struct vring_desc_state {
>  	void *data;			/* Data for callback. */
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
>  };
>  
>  struct vring_desc_state_packed {
> +	void *data;			/* Data for callback. */
> +	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> +	int num;			/* Descriptor list length. */
> +	dma_addr_t addr;		/* Buffer DMA addr. */
> +	u32 len;			/* Buffer length. */
> +	u16 flags;			/* Descriptor flags. */
>  	int next;			/* The next desc state. */
>  };
>  

Idea: how about using data to chain these descriptors?
You can validate it's pointing within an array to distinguish
e.g. on detach.

-- 
MST
