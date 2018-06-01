Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750919AbeFABgA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:36:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56587 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750830AbeFABf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:35:59 -0400
X-ME-Proxy: <xmx:_qIQW_YV-HojmwIaDO5sx9FOqaJx7_edHpy0UVyy0NB-TTP8Vh-pyA>
X-ME-Proxy: <xmx:_qIQWyGflckJoPabRRS3FKw6DKWCxAH-SzgWUUbnqfTkE-3CpWSL5w>
X-ME-Proxy: <xmx:_qIQW7zB29rAnGMTQbtf_Blx4hO8zKNkOdoNw2CZ7lMlYgNxcd4jiQ>
X-ME-Proxy: <xmx:_qIQW8nU3SS5A0wCZl8pu5UydcI_n76Kzb-cCrBgynv9UdGWXx7qvw>
X-ME-Proxy: <xmx:_qIQW8n-Yd3--Tj5giCQiLWi3ymSsZS5PtTEIBQ8KQaOVD9Pb_X7-w>
X-ME-Proxy: <xmx:_qIQW5oc9KFqPppIlVND9YRfMxpktWSfutlUjwzLC3b47CsH7DoYRw>
X-ME-Sender: <xms:_qIQW5orrZV2r5SlsUrcoVs1bB1if8AG1F-liYrnG5OuqUFbEp-bzQ>
Message-ID: <1527816954.2807.19.camel@themaw.net>
Subject: Re: [PATCH] autofs: make autofs4 and autofs mutually exclusive
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 01 Jun 2018 09:35:54 +0800
In-Reply-To: <20180531171335.6e8272916501f8b9505bc9f2@linux-foundation.org>
References: <20180529094702.4092022-1-arnd@arndb.de>
         <1527641284.2735.12.camel@themaw.net>
         <CAK8P3a3wMJoquq+3MN69Wd1EaDBgzPnzbD1a_e4cgLHq5j0b9g@mail.gmail.com>
         <1527671935.2939.15.camel@themaw.net>
         <20180531171335.6e8272916501f8b9505bc9f2@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-31 at 17:13 -0700, Andrew Morton wrote:
> On Wed, 30 May 2018 17:18:55 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > > I actually had an alternative approach that I tried out successfully
> > > but discarded as being too different from the original code. Just for
> > > reference, this one would work as well, and allow both to be
> > > compiled together. The version you posted is probably better.
> > 
> > It's an attractive option but the problem is both implement the
> > autofs file system.
> > 
> > I've always thought you can't register the same file system at the
> > same time from two distinct sources.
> > 
> > If you're careful and compile each only as a module you could do it.
> > 
> > But many configurations have autofs compiled built-in because of the
> > auto-loading problems that arose back when there was an autofs fs
> > module as well as an autofs fs module present in the autofs4 directory.
> > 
> > Maybe it would actually work with one winning over the other but
> > I'd prefer not to go that way.
> > 
> > It will be gone in two subsequent releases if it gets merged and no
> > changes to the retained code will be needed with this approach.
> 
> I'm losing the plot here.  Can you please confirm that this is the
> patch we want?

Understandable.

This wasn't quite what I did and at the risk of confusing matters
further I'll try and explain what I did and why.

I folded the change into the patch which created fs/autofs/Kconfig
(autofs-create-autofs-kconfig-and-makefile.patch).

However doing what you're doing here should have the same effect as
long as Kbuild is smart enough to work out that
"depends on AUTOFS_FS = n" doesn't apply when fs/autofs/Kconfig hasn't
yet been created (by autofs-create-autofs-kconfig-and-makefile.patch).

The problem is that AUTOFS_FS=y might be still be present in .config
(surviving after many years) causing the bisection problem.

That's why I thought it best to add the depends in fs/autofs4/Kconfig
at the time fs/autofs/Kconfig is created rather than before that in
autofs-update-fs-autofs4-makefile.patch, as is done here.

Let me check if Kbuild will do the right thing and get back to you.

> 
> 
> From: Ian Kent <raven@themaw.net>
> Subject: autofs: update fs/autofs4/Kconfig
> 
> Update Kconfig and add a depricated warning.
> 
> [raven@themaw.net: make autofs4 Kconfig depend on AUTOFS_FS]
>   Link: http://lkml.kernel.org/r/152687649097.8263.7046086367407522029.stgit@p
> luto.themaw.net
> Link: http://lkml.kernel.org/r/152626706133.28589.11994171621899212952.stgit@p
> luto.themaw.net
> Signed-off-by: Ian Kent <raven@themaw.net>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  fs/autofs4/Kconfig |   42 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff -puN fs/autofs4/Kconfig~autofs-update-fs-autofs4-kconfig
> fs/autofs4/Kconfig
> --- a/fs/autofs4/Kconfig~autofs-update-fs-autofs4-kconfig
> +++ a/fs/autofs4/Kconfig
> @@ -1,5 +1,7 @@
>  config AUTOFS4_FS
> -	tristate "Kernel automounter version 4 support (also supports v3)"
> +	tristate "Kernel automounter version 4 support (also supports v3 and
> v5)"
> +	default n
> +	depends on AUTOFS_FS = n
>  	help
>  	  The automounter is a tool to automatically mount remote file
> systems
>  	  on demand. This implementation is partially kernel-based to reduce
> @@ -7,14 +9,32 @@ config AUTOFS4_FS
>  	  automounter (amd), which is a pure user space daemon.
>  
>  	  To use the automounter you need the user-space tools from
> -	  <https://www.kernel.org/pub/linux/daemons/autofs/v4/>; you also
> -	  want to answer Y to "NFS file system support", below.
> +	  <https://www.kernel.org/pub/linux/daemons/autofs/>; you also want
> +	  to answer Y to "NFS file system support", below.
>  
> -	  To compile this support as a module, choose M here: the module will
> be
> -	  called autofs4.  You will need to add "alias autofs autofs4" to
> your
> -	  modules configuration file.
> -
> -	  If you are not a part of a fairly large, distributed network or
> -	  don't have a laptop which needs to dynamically reconfigure to the
> -	  local network, you probably do not need an automounter, and can say
> -	  N here.
> +	  This module is in the process of being renamed from autofs4 to
> +	  autofs. Since autofs is now the only module that provides the
> +	  autofs file system the module is not version 4 specific.
> +
> +	  The autofs4 module is now built from the source located in
> +	  fs/autofs. The autofs4 directory and its configuration entry
> +	  will be removed two kernel versions from the inclusion of this
> +	  change.
> +
> +	  Changes that will need to be made should be limited to:
> +	  - source include statments should be changed from autofs_fs4.h to
> +	    autofs_fs.h since these two header files have been merged.
> +	  - user space scripts that manually load autofs4.ko should be
> +	    changed to load autofs.ko. But since the module directory name
> +	    and the module name are the same as the file system name there
> +	    is no need to manually load module.
> +	  - any "alias autofs autofs4" will need to be removed.
> +
> +	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
> +
> +	  NOTE: Since the modules autofs and autofs4 use the same file system
> +		type name of "autofs" only one can be built. The "depends"
> +		above will result in AUTOFS4_FS not appearing in .config for
> +		any setting of AUTOFS_FS other than n and AUTOFS4_FS will
> +		appear under the AUTOFS_FS entry otherwise which is intended
> +		to draw attention to the module rename change.
> _
> 
