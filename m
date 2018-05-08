Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933429AbeEHSN3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:13:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40302 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933198AbeEHSN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:13:26 -0400
X-Google-Smtp-Source: AB8JxZp7tDu0pEqiDbOWo34vlGwq1hMEk+tkQdqzjnmofc/CuKg+NBbfAXuvFfMimnrjaCwzPnPn0A==
Date: Tue, 8 May 2018 11:13:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammed Gamal <mgamal@redhat.com>
Cc: netdev@vger.kernel.org, sthemmin@microsoft.com, haiyangz@microsoft.com,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        vkuznets@redhat.com
Subject: Re: [PATCH] hv_netvsc: Fix net device attach on older Windows hosts
Message-ID: <20180508111323.1767fc0c@xeon-e3>
In-Reply-To: <1525801247-27765-1-git-send-email-mgamal@redhat.com>
References: <1525801247-27765-1-git-send-email-mgamal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 May 2018 19:40:47 +0200
Mohammed Gamal <mgamal@redhat.com> wrote:

> On older windows hosts the net_device instance is returned to
> the caller of rndis_filter_device_add() without having the presence
> bit set first. This would cause any subsequent calls to network device
> operations (e.g. MTU change, channel change) to fail after the device
> is detached once, returning -ENODEV.
> 
> Make sure we explicitly call netif_device_attach() before returning
> the net_device instance to make sure the presence bit is set
> 
> Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  drivers/net/hyperv/rndis_filter.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
> index 6b127be..09a3c1d 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -1287,8 +1287,10 @@ struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
>  		   rndis_device->hw_mac_adr,
>  		   rndis_device->link_state ? "down" : "up");
>  
> -	if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_5)
> +	if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_5) {
> +		netif_device_attach(net);
>  		return net_device;
> +	}

Yes, this looks right, but it might be easier to use goto existing exit
path.

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 3b6dbacaf77d..ed941c5a0be9 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1316,7 +1316,7 @@ struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
                   rndis_device->link_state ? "down" : "up");
 
        if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_5)
-               return net_device;
+               goto out;
 
        rndis_filter_query_link_speed(rndis_device, net_device);
