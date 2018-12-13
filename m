Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EF8C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A7D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A7D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeLMTlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:41:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbeLMTlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:41:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7682A30842AC;
        Thu, 13 Dec 2018 19:41:09 +0000 (UTC)
Received: from redhat.com (ovpn-120-21.rdu2.redhat.com [10.10.120.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id B3CDB6012D;
        Thu, 13 Dec 2018 19:41:08 +0000 (UTC)
Date:   Thu, 13 Dec 2018 14:41:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] vhost: generalize adding used elem
Message-ID: <20181213144027-mutt-send-email-mst@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213101022.12475-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213101022.12475-2-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 13 Dec 2018 19:41:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 06:10:20PM +0800, Jason Wang wrote:
> Use one generic vhost_copy_to_user() instead of two dedicated
> accessor. This will simplify the conversion to fine grain accessors.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


The reason we did it like this is because it was faster.
Want to try benchmarking before we change it?

> ---
>  drivers/vhost/vhost.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5f81a66d34..1c54ec1b82f8 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2164,16 +2164,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
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
