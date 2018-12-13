Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565F9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABEA20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABEA20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeLMTzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:55:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbeLMTzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:55:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FAF93082204;
        Thu, 13 Dec 2018 19:55:19 +0000 (UTC)
Received: from redhat.com (ovpn-120-21.rdu2.redhat.com [10.10.120.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6FB351057FA2;
        Thu, 13 Dec 2018 19:55:18 +0000 (UTC)
Date:   Thu, 13 Dec 2018 14:55:17 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH] vhost: return EINVAL if iovecs size does not match the
 message size
Message-ID: <20181213143426-mutt-send-email-mst@kernel.org>
References: <20181213145350.5454-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213145350.5454-1-ptikhomirov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 13 Dec 2018 19:55:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 05:53:50PM +0300, Pavel Tikhomirov wrote:
> We've failed to copy and process vhost_iotlb_msg so let userspace at
> least know about it. For instance before these patch the code below runs
> without any error:
> 
> int main()
> {
>   struct vhost_msg msg;
>   struct iovec iov;
>   int fd;
> 
>   fd = open("/dev/vhost-net", O_RDWR);
>   if (fd == -1) {
>     perror("open");
>     return 1;
>   }
> 
>   iov.iov_base = &msg;
>   iov.iov_len = sizeof(msg)-4;
> 
>   if (writev(fd, &iov,1) == -1) {
>     perror("writev");
>     return 1;
>   }
> 
>   return 0;
> }
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Thanks for the patch!

> ---
>  drivers/vhost/vhost.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5f81a66d34..03014224ef13 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1024,8 +1024,10 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>  	int type, ret;
>  
>  	ret = copy_from_iter(&type, sizeof(type), from);
> -	if (ret != sizeof(type))
> +	if (ret != sizeof(type)) {
> +		ret = -EINVAL;
>  		goto done;
> +	}
>  
>  	switch (type) {
>  	case VHOST_IOTLB_MSG:

should this be EFAULT rather?

> @@ -1044,8 +1046,10 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>  
>  	iov_iter_advance(from, offset);
>  	ret = copy_from_iter(&msg, sizeof(msg), from);
> -	if (ret != sizeof(msg))
> +	if (ret != sizeof(msg)) {
> +		ret = -EINVAL;
>  		goto done;
> +	}
>  	if (vhost_process_iotlb_msg(dev, &msg)) {
>  		ret = -EFAULT;
>  		goto done;

This too?

> -- 
> 2.17.1
