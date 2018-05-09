Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935379AbeEIPHT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:07:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39550 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935065AbeEIPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:07:17 -0400
X-Google-Smtp-Source: AB8JxZp2neGNMNQPrIRmG/MlnEH42gwJn1vWqyZ/i5nozefTWFe3cFFrl64vgeR3lZaTr4fc2mWY9Q==
Date: Wed, 9 May 2018 08:07:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammed Gamal <mgamal@redhat.com>
Cc: netdev@vger.kernel.org, sthemmin@microsoft.com, haiyangz@microsoft.com,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        vkuznets@redhat.com
Subject: Re: [PATCH v2] hv_netvsc: Fix net device attach on older Windows
 hosts
Message-ID: <20180509080714.1c7467b2@xeon-e3>
In-Reply-To: <1525853854-8277-1-git-send-email-mgamal@redhat.com>
References: <1525853854-8277-1-git-send-email-mgamal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 May 2018 10:17:34 +0200
Mohammed Gamal <mgamal@redhat.com> wrote:

> On older windows hosts the net_device instance is returned to
> the caller of rndis_filter_device_add() without having the presence
> bit set first. This would cause any subsequent calls to network device
> operations (e.g. MTU change, channel change) to fail after the device
> is detached once, returning -ENODEV.
> 
> Instead of returning the device instabce, we take the exit path where
> we call netif_device_attach()
> 
> Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>

The standard for patch submission is no blank lines between Fixes
and Signed-off-by to make it easier for bots.

> ---
>  drivers/net/hyperv/rndis_filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
> index 6b127be..e7ca5b5 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -1288,7 +1288,7 @@ struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
>  		   rndis_device->link_state ? "down" : "up");
>  
>  	if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_5)
> -		return net_device;
> +		goto out;
>  
>  	rndis_filter_query_link_speed(rndis_device, net_device);
>  


Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>
