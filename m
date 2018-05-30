Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965233AbeE3JTG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:19:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39295 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964904AbeE3JTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:19:00 -0400
X-ME-Proxy: <xmx:g2wOWwdXNADJ6YIYOhM_4Dw6FWKqxrRbsdMvNLPxYuAytlOkuLzdMA>
X-ME-Proxy: <xmx:g2wOW19TTwuGCUfnELq4GZmVCXP1RnRjOZiI0xKDsEOwKBlXpitSZg>
X-ME-Proxy: <xmx:g2wOWwp42qK3Vi1yzbEBYLsDEYMYgLL486NJxsVSYSQUSoO3fXrpGw>
X-ME-Proxy: <xmx:g2wOW-l9filFFw6zchSfevmu1tFawalzBqGTzCclNH4dUaxUgZn4mw>
X-ME-Proxy: <xmx:g2wOW7g5IS4PcaET0UW5-tJ_sC92QjloeRbdc7_iKwVAIL5WvoGUmA>
X-ME-Proxy: <xmx:g2wOW5so7rx3XwXwO9xDQNSMWKy6uw_dKjxxmUtI2i2r99VL70Rj3g>
X-ME-Sender: <xms:g2wOW911rQt6bmAfCGt03EGf9N1FC_hYB4oQnJA8GO2jS62IpS1c_Q>
Message-ID: <1527671935.2939.15.camel@themaw.net>
Subject: Re: [PATCH] autofs: make autofs4 and autofs mutually exclusive
From: Ian Kent <raven@themaw.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 30 May 2018 17:18:55 +0800
In-Reply-To: <CAK8P3a3wMJoquq+3MN69Wd1EaDBgzPnzbD1a_e4cgLHq5j0b9g@mail.gmail.com>
References: <20180529094702.4092022-1-arnd@arndb.de>
         <1527641284.2735.12.camel@themaw.net>
         <CAK8P3a3wMJoquq+3MN69Wd1EaDBgzPnzbD1a_e4cgLHq5j0b9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-30 at 10:41 +0200, Arnd Bergmann wrote:
> On Wed, May 30, 2018 at 2:48 AM, Ian Kent <raven@themaw.net> wrote:
> > On Tue, 2018-05-29 at 11:46 +0200, Arnd Bergmann wrote:
> > > The autofs4 implementation is just a redirect to autofs now, but that
> > > also means we can't have both built into the same kernel:
> > > 
> > > fs/autofs/inode.o: In function `autofs_new_ino':
> > > inode.c:(.text+0x1b8): multiple definition of `autofs_new_ino'
> > > fs/autofs/inode.o:inode.c:(.text+0x1b8): first defined here
> > > fs/autofs/inode.o: In function `autofs_clean_ino':
> > > inode.c:(.text+0x288): multiple definition of `autofs_clean_ino'
> > > 
> > > There is also a problem with trying to build both in parallel, which
> > > leads to two 'make' processes writing to the same fs/autofs/.*.o.cmd
> > > file, causing corruption that manifests like
> > > 
> > > fs/autofs4/../autofs/.expire.o.cmd:679: *** missing separator.  Stop.
> > > 
> > > Making AUTOFS4_FS depend on AUTOFS_FS being disabled should avoid all
> > > configurations that run into either issue.
> > 
> > Thanks Arnd and this adds support that my analysis of build
> > problems is accurate.
> > 
> > I posted a similar patch on May 21 which also added a NOTE to
> > fs/autofs4/Kconfig saying pretty much what you've said.
> > https://patchwork.kernel.org/patch/10413823/
> > 
> > I recommend using my patch so that anyone that's surprised by the
> > .config change has a chance of finding an explanation somewhere, ;)
> > 
> > Not only is the change needed, but to preserve bisection it needs
> > to be folded into the original patch titled:
> > autofs: create autofs Kconfig and Makefile
> > 
> > otherwise build test robots will still see this problem between
> > build testing after "autofs: create autofs Kconfig and Makefile"
> > and before this change is applied.
> > 
> > Folding in the change is my current recommendation to Andrew.
> > Hopefully that will fix the problem.
> 
> Yes, looks good.
> 
> > Any further thoughts are of course welcome.
> 
> I actually had an alternative approach that I tried out successfully
> but discarded as being too different from the original code. Just for
> reference, this one would work as well, and allow both to be
> compiled together. The version you posted is probably better.

It's an attractive option but the problem is both implement the
autofs file system.

I've always thought you can't register the same file system at the
same time from two distinct sources.

If you're careful and compile each only as a module you could do it.

But many configurations have autofs compiled built-in because of the
auto-loading problems that arose back when there was an autofs fs
module as well as an autofs fs module present in the autofs4 directory.

Maybe it would actually work with one winning over the other but
I'd prefer not to go that way.

It will be gone in two subsequent releases if it gets merged and no
changes to the retained code will be needed with this approach.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
> index 9400a9f6318a..5a361f5273a1 100644
> --- a/fs/autofs/autofs_i.h
> +++ b/fs/autofs/autofs_i.h
> @@ -6,6 +6,8 @@
>   * the terms of the GNU General Public License, version 2, or at your
>   * option, any later version, incorporated herein by reference.
>   */
> +#ifndef __AUTOFS_H
> +#define __AUTOFS_H
> 
>  /* Internal header file for autofs */
> 
> @@ -271,3 +273,5 @@ static inline void autofs_del_expiring(struct
> dentry *dentry)
>  }
> 
>  void autofs_kill_sb(struct super_block *);
> +
> +#endif /* __AUTOFS_H */
> diff --git a/fs/autofs4/Makefile b/fs/autofs4/Makefile
> index 417dd726d9ef..5fc0a28d656d 100644
> --- a/fs/autofs4/Makefile
> +++ b/fs/autofs4/Makefile
> @@ -3,7 +3,3 @@
>  #
> 
>  obj-$(CONFIG_AUTOFS4_FS) += autofs4.o
> -
> -autofs4-objs := ../autofs/init.o ../autofs/inode.o ../autofs/root.o \
> -       ../autofs/symlink.o ../autofs/waitq.o ../autofs/expire.o \
> -       ../autofs/dev-ioctl.o
> diff --git a/fs/autofs4/autofs4.c b/fs/autofs4/autofs4.c
> new file mode 100644
> index 000000000000..a76066aa9f27
> --- /dev/null
> +++ b/fs/autofs4/autofs4.c
> @@ -0,0 +1,7 @@
> +#include "../autofs/init.c"
> +#include "../autofs/inode.c"
> +#include "../autofs/root.c"
> +#include "../autofs/symlink.c"
> +#include "../autofs/waitq.c"
> +#include "../autofs/expire.c"
> +#include "../autofs/dev-ioctl.c"
