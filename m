Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2753DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFFA265CE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFFA265CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeFZHRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:17:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752412AbeFZHRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:17:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECC5D81A4EAD;
        Tue, 26 Jun 2018 07:17:18 +0000 (UTC)
Received: from t450s.home (ovpn04.gateway.prod.ext.sin2.redhat.com [10.69.146.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25584111CA1C;
        Tue, 26 Jun 2018 07:17:07 +0000 (UTC)
Date:   Tue, 26 Jun 2018 15:16:19 +0800
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        Kirti Wankhede <kwankhede@nvidia.com>,
        kvm@vger.kernel.org (open list:VFIO MEDIATED DEVICE DRIVERS)
Subject: Re: [PATCH 1/2] sample/mdev/mbochs: remove
 mbochs_kmap_atomic_dmabuf
Message-ID: <20180626151619.13d4c214@t450s.home>
In-Reply-To: <20180625064453.19768-1-kraxel@redhat.com>
References: <20180625064453.19768-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 26 Jun 2018 07:17:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 26 Jun 2018 07:17:19 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'alex.williamson@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 08:44:51 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Atomic mapping interface for dmabufs will be removed.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Fixes: f664a5269542 ("dma-buf: remove kmap_atomic interface")

Though really the above commit needs to be updated to include this fix
to preserve bisection since the mbochs sample driver is already
upstream, suggests we only compile tested removing kmap_atomic without
looking for other users.  drm folks, please update.  Thanks,

Alex

> ---
>  samples/vfio-mdev/mbochs.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> index 2960e26c6e..aa25cda21d 100644
> --- a/samples/vfio-mdev/mbochs.c
> +++ b/samples/vfio-mdev/mbochs.c
> @@ -803,15 +803,6 @@ static void mbochs_release_dmabuf(struct dma_buf *buf)
>  	mutex_unlock(&mdev_state->ops_lock);
>  }
>  
> -static void *mbochs_kmap_atomic_dmabuf(struct dma_buf *buf,
> -				       unsigned long page_num)
> -{
> -	struct mbochs_dmabuf *dmabuf = buf->priv;
> -	struct page *page = dmabuf->pages[page_num];
> -
> -	return kmap_atomic(page);
> -}
> -
>  static void *mbochs_kmap_dmabuf(struct dma_buf *buf, unsigned long page_num)
>  {
>  	struct mbochs_dmabuf *dmabuf = buf->priv;
> @@ -824,7 +815,6 @@ static struct dma_buf_ops mbochs_dmabuf_ops = {
>  	.map_dma_buf	  = mbochs_map_dmabuf,
>  	.unmap_dma_buf	  = mbochs_unmap_dmabuf,
>  	.release	  = mbochs_release_dmabuf,
> -	.map_atomic	  = mbochs_kmap_atomic_dmabuf,
>  	.map		  = mbochs_kmap_dmabuf,
>  	.mmap		  = mbochs_mmap_dmabuf,
>  };

