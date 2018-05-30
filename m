Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968481AbeE3AsN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 20:48:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43947 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S968452AbeE3AsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 20:48:09 -0400
X-ME-Proxy: <xmx:yPQNWwk7DG7p4xhVCOgA0C_2PWU7vh-m8r2fNhzxUdNojXM7Pl-iyA>
X-ME-Proxy: <xmx:yPQNW5ZcsYiK8zslTOEmIQnAqqpihfmTPTIWujTw77fG6lP-dm7LXg>
X-ME-Proxy: <xmx:yPQNW5aJOtJxGVSkGxl9AwEjb4rg-_tcvPYU_iEvH-70RUVsPlG0pg>
X-ME-Proxy: <xmx:yPQNW_Gy8gvyt_-Wm86iStZHstwfMAuz5E-NZC_cs9yOXgHhkDhU1Q>
X-ME-Proxy: <xmx:yPQNWyyv0H6KU4wfDZEEjh9WHyb8Vk7hT20SgWvQobn5bCYTJjwd1A>
X-ME-Proxy: <xmx:yPQNW00_K9sCPHrFDuGrdbz5mNlep0KczKzLhNasCtrctbxPUxYMeg>
X-ME-Sender: <xms:yPQNW-4DQ-30uNLxcVTbzH4R1zkz7xwcbdaCFo6ofWNwco_Kyc_KuQ>
Message-ID: <1527641284.2735.12.camel@themaw.net>
Subject: Re: [PATCH] autofs: make autofs4 and autofs mutually exclusive
From: Ian Kent <raven@themaw.net>
To: Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Date: Wed, 30 May 2018 08:48:04 +0800
In-Reply-To: <20180529094702.4092022-1-arnd@arndb.de>
References: <20180529094702.4092022-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-29 at 11:46 +0200, Arnd Bergmann wrote:
> The autofs4 implementation is just a redirect to autofs now, but that
> also means we can't have both built into the same kernel:
> 
> fs/autofs/inode.o: In function `autofs_new_ino':
> inode.c:(.text+0x1b8): multiple definition of `autofs_new_ino'
> fs/autofs/inode.o:inode.c:(.text+0x1b8): first defined here
> fs/autofs/inode.o: In function `autofs_clean_ino':
> inode.c:(.text+0x288): multiple definition of `autofs_clean_ino'
> 
> There is also a problem with trying to build both in parallel, which
> leads to two 'make' processes writing to the same fs/autofs/.*.o.cmd
> file, causing corruption that manifests like
> 
> fs/autofs4/../autofs/.expire.o.cmd:679: *** missing separator.  Stop.
> 
> Making AUTOFS4_FS depend on AUTOFS_FS being disabled should avoid all
> configurations that run into either issue.

Thanks Arnd and this adds support that my analysis of build
problems is accurate.

I posted a similar patch on May 21 which also added a NOTE to
fs/autofs4/Kconfig saying pretty much what you've said.
https://patchwork.kernel.org/patch/10413823/

I recommend using my patch so that anyone that's surprised by the
.config change has a chance of finding an explanation somewhere, ;)

Not only is the change needed, but to preserve bisection it needs
to be folded into the original patch titled:
autofs: create autofs Kconfig and Makefile

otherwise build test robots will still see this problem between
build testing after "autofs: create autofs Kconfig and Makefile"
and before this change is applied.

Folding in the change is my current recommendation to Andrew.
Hopefully that will fix the problem.

Any further thoughts are of course welcome.

> 
> Fixes: mmotm ("autofs: update fs/autofs4/Makefile")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/autofs4/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
> index 53bc592a250d..eccf673c6c8c 100644
> --- a/fs/autofs4/Kconfig
> +++ b/fs/autofs4/Kconfig
> @@ -1,5 +1,6 @@
>  config AUTOFS4_FS
>  	tristate "Kernel automounter version 4 support (also supports v3 and
> v5)"
> +	depends on AUTOFS_FS=n
>  	default n
>  	help
>  	  The automounter is a tool to automatically mount remote file
> systems
