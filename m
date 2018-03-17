Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753701AbeCQRVf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:21:35 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35202 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753402AbeCQRVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:21:13 -0400
Date: Sat, 17 Mar 2018 18:11:29 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 30/36] fs: add do_linkat() helper and ksys_link()
 wrapper; remove in-kernel calls to syscall
Message-ID: <20180317171129.GD3351@light.dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-31-linux@dominikbrodowski.net>
 <CAK8P3a0zyzZkH43oW5mMEX5QDm1RdRWMgtjPprFK9iRrNpy5qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0zyzZkH43oW5mMEX5QDm1RdRWMgtjPprFK9iRrNpy5qQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 09:30:58PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 8:05 PM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> >   */
> > -SYSCALL_DEFINE5(linkat, int, olddfd, const char __user *, oldname,
> > -               int, newdfd, const char __user *, newname, int, flags)
> > +int do_linkat(int olddfd, const char __user *oldname, int newdfd,
> > +             const char __user *newname, int flags)
> >  {
> >         struct dentry *new_dentry;
> >         struct path old_path, new_path;
> 
> For consistency with other do_*() functions, I think it would be nice
> to make this one not take a __user pointer either. However, I
> have no idea how to do that without making the common case worse.
> 
> > --- a/init/initramfs.c
> > +++ b/init/initramfs.c
> > @@ -306,7 +306,7 @@ static int __init maybe_link(void)
> >         if (nlink >= 2) {
> >                 char *old = find_link(major, minor, ino, mode, collected);
> >                 if (old)
> > -                       return (sys_link(old, collected) < 0) ? -1 : 1;
> > +                       return (ksys_link(old, collected) < 0) ? -1 : 1;
> >         }
> >         return 0;
> >  }
> 
> Since this is the only caller outside of fs/namei.c, maybe it can be
> changed to use vfs_link() instead? That might still be a larger rework
> than you want to do.

In line with what I propose generally for this series, I have added the
following paragraph to the commit message:

	In the near future, the only fs-external user of ksys_link() should be
	converted to use vfs_link() instead.

Thanks,
	Dominik
