Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBB8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9DB20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9DB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeIDGpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 02:45:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbeIDGpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 02:45:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BB5C87A50;
        Tue,  4 Sep 2018 02:22:38 +0000 (UTC)
Received: from redhat.com (ovpn-123-241.rdu2.redhat.com [10.10.123.241])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0869E2157F45;
        Tue,  4 Sep 2018 02:22:37 +0000 (UTC)
Date:   Mon, 3 Sep 2018 22:22:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: fix VHOST_GET_BACKEND_FEATURES ioctl request
 definition
Message-ID: <20180903222127-mutt-send-email-mst@kernel.org>
References: <20180903175906.GA11529@glebfm.cloud.tilaa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903175906.GA11529@glebfm.cloud.tilaa.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 04 Sep 2018 02:22:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 04 Sep 2018 02:22:38 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 08:59:13PM +0300, Gleb Fotengauer-Malinovskiy wrote:
> The _IOC_READ flag fits this ioctl request more because this request
> actually only writes to, but doesn't read from userspace.
> See NOTEs in include/uapi/asm-generic/ioctl.h for more information.
> 
> Fixes: 429711aec282 ("vhost: switch to use new message format")
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>

Hmm it does make sense, and it's not too late to fix this up.
Jason, what's your take on this? Was _IOW intentional?


> ---
>  include/uapi/linux/vhost.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b1e22c40c4b6..84c3de89696a 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -176,7 +176,7 @@ struct vhost_memory {
>  #define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
>  
>  #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
> -#define VHOST_GET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x26, __u64)
> +#define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
>  
>  /* VHOST_NET specific defines */
>  
> 
> -- 
> glebfm
