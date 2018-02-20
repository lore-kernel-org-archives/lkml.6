Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753034AbeBTQpV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:45:21 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41483 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeBTQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:45:19 -0500
X-Google-Smtp-Source: AH8x227vC3TZMiy8DAfrN+5fYeqCKD57zp3aHAXqjGXy3TFFCl/+QlOXWYmVg/6xZuAsQn6u9xxBQQ==
Subject: Re: [PATCH] ARM: make CONFIG_DEBUG_WX depend on MMU
To: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>
Cc: Kees Cook <keescook@chromium.org>, Jinbum Park <jinb.park7@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180220150932.3285766-1-arnd@arndb.de>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <bea07eb7-1763-147c-9da5-e70d2fcf876b@redhat.com>
Date: Tue, 20 Feb 2018 08:45:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180220150932.3285766-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 07:09 AM, Arnd Bergmann wrote:
> Without CONFIG_MMU, this results in a build failure:
> 
> ./arch/arm/include/asm/memory.h:92:23: error: initializer element is not constant
>   #define VECTORS_BASE  vectors_base
> arch/arm/mm/dump.c:32:4: note: in expansion of macro 'VECTORS_BASE'
>    { VECTORS_BASE, "Vectors" },
> 
> arch/arm/mm/dump.c:71:11: error: 'L_PTE_USER' undeclared here (not in a function); did you mean 'VTIME_USER'?
>     .mask = L_PTE_USER,
>             ^~~~~~~~~~
> 
> Obviously the feature only makes sense with an MMU, so let's add the
> dependency here.
> 

Acked-by: Laura Abbott <labbott@redhat.com>

> Fixes: a8e53c151fe7 ("ARM: 8737/1: mm: dump: add checking for writable and executable")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/Kconfig.debug | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 7b3d9c5c73bb..6db106b5b9e9 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -22,6 +22,7 @@ config ARM_PTDUMP_DEBUGFS
>   
>   config DEBUG_WX
>   	bool "Warn on W+X mappings at boot"
> +	depends on MMU
>   	select ARM_PTDUMP_CORE
>   	---help---
>   		Generate a warning if any W+X mappings are found at boot.
> 
