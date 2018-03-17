Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753683AbeCQRXF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:23:05 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35120 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeCQRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:21:11 -0400
Date: Sat, 17 Mar 2018 18:04:38 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 17/36] fs: add ksys_chroot() helper; remove-in kernel
 calls to sys_chroot()
Message-ID: <20180317170438.GA3351@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316084941.GF4151@infradead.org>
 <CAK8P3a2s2YsttKSjZfc8xW+kjv8M1hFDCg1E9nHPjq_KRvik2Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Christoph,

On Thu, Mar 15, 2018 at 09:44:24PM +0100, Arnd Bergmann wrote:
> > diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> > index 4afb04686c8e..5743f04014ca 100644
> > --- a/drivers/base/devtmpfs.c
> > +++ b/drivers/base/devtmpfs.c
> > @@ -387,7 +387,7 @@ static int devtmpfsd(void *p)
> >         if (*err)
> >                 goto out;
> >         sys_chdir("/.."); /* will traverse into overmounted root */
> > -       sys_chroot(".");
> > +       ksys_chroot(".");
> >         complete(&setup_done);
> >         while (1) {
> >                 spin_lock(&req_lock);
> 
> Could this be done using kern_path()/set_fs_root() instead so we
> avoid the __user pointer?
> 
>        Arnd

On Fri, Mar 16, 2018 at 01:49:41AM -0700, Christoph Hellwig wrote:
> Agreed.  Especially as we don't need any of the permission checks here.

Thanks for your input. As re-working this code to use the vfs-internal
helpers would probably mean that the syscall-cleanup code has to wait
for another release cycle, I propose to address this issue with the
following paragraph in the commit message:

	In the near future, the fs-external callers of ksys_chroot() should be
	converted to use kern_path()/set_fs_root() directly. Then ksys_chroot()
	can be moved within sys_chroot() again.

Thanks,
	Dominik
