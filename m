Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbeFDVtY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:49:24 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52616 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeFDVtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:49:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Jun 2018 23:49:18 +0200
From: Stefan Agner <stefan@agner.ch>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kbuild-owner@vger.kernel.org
Subject: Re: [PATCH v5 24/31] kconfig: add CC_IS_GCC and GCC_VERSION
In-Reply-To: <1527499328-13213-25-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
 <1527499328-13213-25-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <dbd4d0dc92ba45dcae81cbab8ab8ba29@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 28.05.2018 11:22, Masahiro Yamada wrote:
> This will be useful to specify the required compiler version,
> like this:
> 
> config FOO
>         bool "Use Foo"
>         depends on GCC_VERSION >= 40800
>         help
>           This feature requires GCC 4.8 or newer.
> 

I tried using CC_IS_GCC today while using clang. It seems that it is set
to y despite I am using CC=clang.

.config looks like this after config:

...
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=40201
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=60000
...


I am using clang 6.0.0 on Arch Linux, which seems to return a version
when using gcc-version.sh:
./scripts/gcc-version.sh clang | sed 's/^0*//'
402

I guess that should not be the case?

--
Stefan

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  init/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index f1b0cfb..2e33d93 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -8,6 +8,14 @@ config DEFCONFIG_LIST
>  	default ARCH_DEFCONFIG
>  	default "arch/$(ARCH)/defconfig"
>  
> +config CC_IS_GCC
> +	def_bool $(success,$(CC) --version | grep -q gcc)
> +
> +config GCC_VERSION
> +	int
> +	default $(shell,$(srctree)/scripts/gcc-version.sh -p $(CC) | sed
> 's/^0*//') if CC_IS_GCC
> +	default 0
> +
>  config CONSTRUCTORS
>  	bool
>  	depends on !UML
