Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F4EC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E64E20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E64E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeLGSK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:10:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeLGSK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:10:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43927C049D5B;
        Fri,  7 Dec 2018 18:10:56 +0000 (UTC)
Received: from redhat.com (ovpn-124-251.rdu2.redhat.com [10.10.124.251])
        by smtp.corp.redhat.com (Postfix) with SMTP id 864F019C7F;
        Fri,  7 Dec 2018 18:10:49 +0000 (UTC)
Date:   Fri, 7 Dec 2018 13:10:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [RFC 3/3] virtio_ring: use new vring flags
Message-ID: <20181207130822-mutt-send-email-mst@kernel.org>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
 <20181207084842.13133-4-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207084842.13133-4-tiwei.bie@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 07 Dec 2018 18:10:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 04:48:42PM +0800, Tiwei Bie wrote:
> Switch to using the _SPLIT_ and _PACKED_ variants of vring flags
> in split ring and packed ring respectively.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
> @@ -502,7 +505,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  		}
>  	}
>  	/* Last one doesn't continue. */
> -	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> +	desc[prev].flags &= cpu_to_virtio16(_vq->vdev,
> +				(u16)~BIT(VRING_SPLIT_DESC_F_NEXT));
>  
>  	if (indirect) {
>  		/* Now that the indirect table is filled in, map it. */

I kind of dislike it that this forces use of a cast here.
Kind of makes it more fragile. Let's use a temporary instead?

> -- 
> 2.17.1
