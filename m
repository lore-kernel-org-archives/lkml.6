Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeERUuQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:50:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40530 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeERUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:50:14 -0400
X-Google-Smtp-Source: AB8JxZqBircl9GuaMZ3dFOyuPCfhkMYze4eyb7McmD+glIcqoJ7kWnglRgxT8AOov5MhleKQD6GBEQ==
Date: Fri, 18 May 2018 23:50:11 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de
Subject: Re: [PATCH -vfs] proc: don't maintain sizeof(struct proc_dir_entry)
Message-ID: <20180518205011.GA9756@avx2>
References: <20180518200213.GA8006@avx2>
 <20180518202315.GU30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518202315.GU30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 09:23:15PM +0100, Al Viro wrote:
> On Fri, May 18, 2018 at 11:02:13PM +0300, Alexey Dobriyan wrote:
> > Automatically cap sizeof(struct proc_dir_entry) at 192/128 bytes or
> > 256/192 bytes if spinlock debugging/lockdep is enabled.
> 
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -61,13 +61,15 @@ struct proc_dir_entry {
> >  	char *name;
> >  	umode_t mode;
> >  	u8 namelen;
> > +	char inline_name[];
> > +} __randomize_layout;
> > +
> 
> Hmm...  proc_root initialization relies upon a gccism after that...

Yeah well.

> Speaking of which, why the hell do we even bother with proc_root.name?

printk("%s/%s", pde->parent->name, pde->name) is nice and doesn't cost
anything (OK, it may cost 5 bytes).
