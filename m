Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbeE3PRu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:17:50 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34769 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753666AbeE3PRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:17:43 -0400
X-Google-Smtp-Source: ADUXVKLCUnYptFhyzSxRaqeBgP8j++ZxsAgz6ZOZPP4SXTlIWfcQQd/eWl7Io1XhlkojyE1jDPxCOg==
Date: Wed, 30 May 2018 11:17:38 -0400
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next, wrong] make BPFILTER_UMH depend on X86
Message-ID: <20180530151736.nzpde2bgzn4koi7f@ast-mbp>
References: <20180528153222.2037158-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528153222.2037158-1-arnd@arndb.de>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 05:31:01PM +0200, Arnd Bergmann wrote:
> When build testing across architectures, I run into a build error on
> all targets other than X86:
> 
> gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objdump: net/bpfilter/bpfilter_umh: File format not recognized
> gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objcopy:net/bpfilter/bpfilter_umh.o: Invalid bfd target
> 
> The problem is that 'hostprogs' get built with 'gcc' rather than
> '$(CROSS_COMPILE)gcc', and my default gcc (as most people's) targets x86.
> 
> To work around it, adding an X86 dependency gets randconfigs building
> again on my box.
> 
> Clearly, this is not a good solution, since it should actually work fine
> when building native kernels on other architectures but that is now
> disabled, while cross building an x86 kernel on another host is still
> broken after my patch.
> 
> What we probably want here is to try out if the compiler is able to build
> executables for the target architecture and not build the helper otherwise,
> at least when compile-testing. No idea how to do that though.
> 
> Link: http://www.kernel.org/pub/tools/crosstool/
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/bpfilter/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
> index 60725c5f79db..61cc4fcbb4d0 100644
> --- a/net/bpfilter/Kconfig
> +++ b/net/bpfilter/Kconfig
> @@ -9,6 +9,7 @@ menuconfig BPFILTER
>  if BPFILTER
>  config BPFILTER_UMH
>  	tristate "bpfilter kernel module with user mode helper"
> +	depends on X86 # actually depends on native builds

depends on X86 will break it on arm.
I think the better short term fix would be to test that HOSTCC == CC
It doesn't have to be the same compiler. HOSTCC's arch == kernel ARCH
Not sure how to hack makefile to do that.
Long term we need to get rid of HOSTCC dependency.
