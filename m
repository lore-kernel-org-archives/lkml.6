Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8359C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B35265DC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B35265DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeFZHUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:20:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751569AbeFZHU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:20:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4805F808255D;
        Tue, 26 Jun 2018 07:20:26 +0000 (UTC)
Received: from t450s.home (ovpn04.gateway.prod.ext.sin2.redhat.com [10.69.146.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6EF97C33;
        Tue, 26 Jun 2018 07:20:11 +0000 (UTC)
Date:   Tue, 26 Jun 2018 15:20:12 +0800
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        Kirti Wankhede <kwankhede@nvidia.com>,
        kvm@vger.kernel.org (open list:VFIO MEDIATED DEVICE DRIVERS)
Subject: Re: [PATCH 2/2] sample/mdev/mbochs: add mbochs_kunmap_dmabuf
Message-ID: <20180626152012.530d9c16@t450s.home>
In-Reply-To: <20180625064453.19768-2-kraxel@redhat.com>
References: <20180625064453.19768-1-kraxel@redhat.com>
        <20180625064453.19768-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 26 Jun 2018 07:20:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 26 Jun 2018 07:20:26 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'alex.williamson@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 08:44:52 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> There is no default implementation for dma_buf_ops->unmap.
> So add a function unmapping the page, otherwise we'll leak them.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  samples/vfio-mdev/mbochs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> index aa25cda21d..85ac603769 100644
> --- a/samples/vfio-mdev/mbochs.c
> +++ b/samples/vfio-mdev/mbochs.c
> @@ -811,11 +811,18 @@ static void *mbochs_kmap_dmabuf(struct dma_buf *buf, unsigned long page_num)
>  	return kmap(page);
>  }
>  
> +static void mbochs_kunmap_dmabuf(struct dma_buf *buf, unsigned long page_num,
> +				 void *vaddr)
> +{
> +	kunmap(vaddr);
> +}
> +
>  static struct dma_buf_ops mbochs_dmabuf_ops = {
>  	.map_dma_buf	  = mbochs_map_dmabuf,
>  	.unmap_dma_buf	  = mbochs_unmap_dmabuf,
>  	.release	  = mbochs_release_dmabuf,
>  	.map		  = mbochs_kmap_dmabuf,
> +	.unmap		  = mbochs_kunmap_dmabuf,
>  	.mmap		  = mbochs_mmap_dmabuf,
>  };
>  

Is this a fix for v4.18?  AFAICT, the kmap_atomic removal is only in
next, not yet upstream and hopefully includes this sample driver before
hitting mainline.  Should we therefore have a v4.18-rc based patch for
this to include before v4.18 to resolve this?  Thanks,

Alex
