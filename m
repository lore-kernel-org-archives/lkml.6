Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A990CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7647621872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfADV3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:29:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbfADV3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:29:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8D8BCD4CA;
        Fri,  4 Jan 2019 21:29:35 +0000 (UTC)
Received: from redhat.com (ovpn-124-210.rdu2.redhat.com [10.10.124.210])
        by smtp.corp.redhat.com (Postfix) with SMTP id BB7A660BE7;
        Fri,  4 Jan 2019 21:29:34 +0000 (UTC)
Date:   Fri, 4 Jan 2019 16:29:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [RFC PATCH V3 1/5] vhost: generalize adding used elem
Message-ID: <20190104162857-mutt-send-email-mst@kernel.org>
References: <20181229124656.3900-1-jasowang@redhat.com>
 <20181229124656.3900-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229124656.3900-2-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 04 Jan 2019 21:29:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 08:46:52PM +0800, Jason Wang wrote:
> Use one generic vhost_copy_to_user() instead of two dedicated
> accessor. This will simplify the conversion to fine grain
> accessors. About 2% improvement of PPS were seen during vitio-user
> txonly test.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I don't hve a problem with this patch but do you have
any idea how come removing what's supposed to be
an optimization speeds things up?

> ---
>  drivers/vhost/vhost.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 55e5aa662ad5..f179b5ee14c4 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2174,16 +2174,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
>  
>  	start = vq->last_used_idx & (vq->num - 1);
>  	used = vq->used->ring + start;
> -	if (count == 1) {
> -		if (vhost_put_user(vq, heads[0].id, &used->id)) {
> -			vq_err(vq, "Failed to write used id");
> -			return -EFAULT;
> -		}
> -		if (vhost_put_user(vq, heads[0].len, &used->len)) {
> -			vq_err(vq, "Failed to write used len");
> -			return -EFAULT;
> -		}
> -	} else if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
> +	if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
>  		vq_err(vq, "Failed to write used");
>  		return -EFAULT;
>  	}
> -- 
> 2.17.1
