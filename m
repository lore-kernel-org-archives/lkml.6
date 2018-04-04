Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeDDPeK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:34:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40293 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752513AbeDDPeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:34:07 -0400
X-Google-Smtp-Source: AIpwx4+hCYA9NXaWlCRj0jFiGdkaYlclf4qWNhVwImlpqcf1D/8OEVlKeShdV/2k8GsOplrA1XPDjg==
Subject: Re: [PATCH] netdevsim: remove incorrect __net_initdata annotations
To: Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180404121347.3089169-1-arnd@arndb.de>
From: David Ahern <dsa@cumulusnetworks.com>
Message-ID: <5181fd00-1943-6e76-ea18-1d3951dd9b58@cumulusnetworks.com>
Date: Wed, 4 Apr 2018 09:33:59 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404121347.3089169-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/18 6:12 AM, Arnd Bergmann wrote:
> The __net_initdata section cannot currently be used for structures that
> get cleaned up in an exitcall using unregister_pernet_operations:
> 
> WARNING: vmlinux.o(.text+0x868c34): Section mismatch in reference from the function nsim_devlink_exit() to the (unknown reference) .init.data:(unknown)
> The function nsim_devlink_exit() references
> the (unknown reference) __initdata (unknown).
> This is often because nsim_devlink_exit lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
> WARNING: vmlinux.o(.text+0x868c64): Section mismatch in reference from the function nsim_devlink_init() to the (unknown reference) .init.data:(unknown)
> WARNING: vmlinux.o(.text+0x8692bc): Section mismatch in reference from the function nsim_fib_exit() to the (unknown reference) .init.data:(unknown)
> WARNING: vmlinux.o(.text+0x869300): Section mismatch in reference from the function nsim_fib_init() to the (unknown reference) .init.data:(unknown)
> 
> As that warning tells us, discarding the structure after a module is
> loaded would lead to a undefined behavior when that module is removed.
> 
> It might be possible to change that annotation so it has no effect for
> loadable modules, but I have not figured out exactly how to do that, and
> we want this to be fixed in -rc1.
> 
> This just removes the annotations, just like we do for all other such
> modules.
> 
> Fixes: 37923ed6b8ce ("netdevsim: Add simple FIB resource controller via devlink")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/netdevsim/devlink.c | 2 +-
>  drivers/net/netdevsim/fib.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/devlink.c b/drivers/net/netdevsim/devlink.c
> index 27ae05c5fdaf..1dba47936456 100644
> --- a/drivers/net/netdevsim/devlink.c
> +++ b/drivers/net/netdevsim/devlink.c
> @@ -267,7 +267,7 @@ static int __net_init nsim_devlink_netns_init(struct net *net)
>  	return 0;
>  }
>  
> -static struct pernet_operations nsim_devlink_net_ops __net_initdata = {
> +static struct pernet_operations nsim_devlink_net_ops = {
>  	.init = nsim_devlink_netns_init,
>  	.id   = &nsim_devlink_id,
>  	.size = sizeof(bool),
> diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
> index 0d105bafa261..9bfe9e151e13 100644
> --- a/drivers/net/netdevsim/fib.c
> +++ b/drivers/net/netdevsim/fib.c
> @@ -230,7 +230,7 @@ static int __net_init nsim_fib_netns_init(struct net *net)
>  	return 0;
>  }
>  
> -static struct pernet_operations nsim_fib_net_ops __net_initdata = {
> +static struct pernet_operations nsim_fib_net_ops = {
>  	.init = nsim_fib_netns_init,
>  	.id   = &nsim_fib_net_id,
>  	.size = sizeof(struct nsim_fib_data),
> 

I am confused ... I do the same thing in the VRF driver and that code
has been there since June 2017.
