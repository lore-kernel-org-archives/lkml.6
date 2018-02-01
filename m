Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeBAL3G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:29:06 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54382 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeBAL3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:29:02 -0500
X-Google-Smtp-Source: AH8x2252/VRnp/WMR9XAyXFlMzpaOGdERdtT3Q1w3lVooQ2tNs9R+ZDt80Lm4CMdkDMr9twvBioOhQ==
Subject: Re: [PATCH] net: bridge: Fix uninitialized error in
 br_fdb_sync_static()
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc: Arnd Bergmann <arnd@arndb.de>, bridge@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1517480728-5580-1-git-send-email-geert@linux-m68k.org>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <657a050a-444d-2ad3-17fb-e855f5c54ea9@cumulusnetworks.com>
Date: Thu, 1 Feb 2018 13:28:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517480728-5580-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/18 12:25, Geert Uytterhoeven wrote:
> With gcc-4.1.2.:
> 
>     net/bridge/br_fdb.c: In function ‘br_fdb_sync_static’:
>     net/bridge/br_fdb.c:996: warning: ‘err’ may be used uninitialized in this function
> 
> Indeed, if the list is empty, err will be uninitialized, and will be
> propagated up as the function return value.
> 
> Fix this by preinitializing err to zero.
> 
> Fixes: eb7935830d00b9e0 ("net: bridge: use rhashtable for fdbs")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  net/bridge/br_fdb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index dc87fbc9a23b04e6..d9e69e4514beb20d 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -993,7 +993,7 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
>  int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p)
>  {
>  	struct net_bridge_fdb_entry *f, *tmp;
> -	int err;
> +	int err = 0;
>  
>  	ASSERT_RTNL();
>  
> 

Thanks,
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
