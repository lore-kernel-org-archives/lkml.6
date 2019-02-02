Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33ACC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7132086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfBBDSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 22:18:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfBBDSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 22:18:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50FECC05D419;
        Sat,  2 Feb 2019 03:18:42 +0000 (UTC)
Received: from [10.72.12.58] (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B977600C4;
        Sat,  2 Feb 2019 03:18:38 +0000 (UTC)
Subject: Re: [PATCH] virtio: drop internal struct from UAPI
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Tiwei Bie <tiwei.bie@intel.com>,
        virtualization@lists.linux-foundation.org
References: <20190201221553.7210-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <423ece1f-5eb9-8023-81f0-90fc57e19e24@redhat.com>
Date:   Sat, 2 Feb 2019 11:18:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201221553.7210-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 02 Feb 2019 03:18:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/2/2 上午6:16, Michael S. Tsirkin wrote:
> There's no reason to expose struct vring_packed in UAPI - if we do we
> won't be able to change or drop it, and it's not part of any interface.
>
> Let's move it to virtio_ring.c
>
> Cc: Tiwei Bie <tiwei.bie@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_ring.c     |  7 ++++++-
>   include/uapi/linux/virtio_ring.h | 10 ----------
>   2 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 412e0c431d87..1c85b3423182 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -152,7 +152,12 @@ struct vring_virtqueue {
>   		/* Available for packed ring */
>   		struct {
>   			/* Actual memory layout for this queue. */
> -			struct vring_packed vring;
> +			struct {
> +				unsigned int num;
> +				struct vring_packed_desc *desc;
> +				struct vring_packed_desc_event *driver;
> +				struct vring_packed_desc_event *device;
> +			} vring;
>   
>   			/* Driver ring wrap counter. */
>   			bool avail_wrap_counter;
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 2414f8af26b3..4c4e24c291a5 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -213,14 +213,4 @@ struct vring_packed_desc {
>   	__le16 flags;
>   };
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
>   #endif /* _UAPI_LINUX_VIRTIO_RING_H */


Acked-by: Jason Wang <jasowang@redhat.com>


