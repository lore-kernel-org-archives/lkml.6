Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeBZKP7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:15:59 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:32856 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbeBZKPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:15:55 -0500
X-Google-Smtp-Source: AH8x225TCjWtxZHPu3jhj5fce7349Poxg1E37OhcjiHNjBXZNOq7QQPh2iBR0scDPkxThH4JVXHCjQuaj5vwi6fz+jU=
MIME-Version: 1.0
In-Reply-To: <20180226094159.2519438-1-arnd@arndb.de>
References: <20180226094159.2519438-1-arnd@arndb.de>
From: Matteo Croce <mcroce@redhat.com>
Date: Mon, 26 Feb 2018 11:15:14 +0100
Message-ID: <CAGnkfhwQ1p0aiH89N4Q6fwqLHeYKR8KP6ADhV_dpwCab1Vz61Q@mail.gmail.com>
Subject: Re: [PATCH] [net-next] ipvlan: fix building with modular IPV6
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 10:41 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> We no longer depend on IPV6, but that now causes a link error with
> CONFIG_IPV6=m and CONFIG_IPVLAN=y:
>
> drivers/net/ipvlan/ipvlan_core.o: In function `ipvlan_queue_xmit':
> ipvlan_core.c:(.text+0x1440): undefined reference to `ip6_route_output_flags'
> drivers/net/ipvlan/ipvlan_core.o: In function `ipvlan_l3_rcv':
> ipvlan_core.c:(.text+0x1818): undefined reference to `ip6_route_input_lookup'
>
> This adds back the dependency on IPV6, with the option of building without
> IPV6, but forcing IPVLAN to be a module when IPV6 is a module.
>
> Fixes: 94333fac44d1 ("ipvlan: drop ipv6 dependency")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index d88b78a17440..08b85215c2be 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -149,6 +149,7 @@ config MACVTAP
>  config IPVLAN
>      tristate "IP-VLAN support"
>      depends on INET
> +    depends on IPV6 || !IPV6
>      depends on NETFILTER
>      select NET_L3_MASTER_DEV
>      ---help---
> --
> 2.9.0
>

Sorry  for that, the fix look very reasonable to me.

Thanks,
-- 
Matteo Croce
per aspera ad upstream
