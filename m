Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeCMFqy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:46:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34331 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeCMFqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:46:53 -0400
X-Google-Smtp-Source: AG47ELsev4L2LnPh7XDiLH/duzT4gY8+V1s3IVmcx490ybSqsqHjxr5ZQFilkE1Z3idkltiLD8o1Tg==
Date: Tue, 13 Mar 2018 06:46:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH 35/35] syscalls: do not call sys_close() within the
 kernel
Message-ID: <20180313054649.q5glf3xm3nfcvg4l@gmail.com>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
 <20180311105557.20807-36-linux@dominikbrodowski.net>
 <20180312073719.ugsbv3nlkbbtac4v@gmail.com>
 <20180312194311.GE16666@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312194311.GE16666@light.dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> On Mon, Mar 12, 2018 at 08:37:19AM +0100, Ingo Molnar wrote:
> > 
> > * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > 
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -1200,7 +1200,7 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
> > >  
> > >  	return retval;
> > >  }
> > > -EXPORT_SYMBOL(sys_close);
> > > +
> > >  
> > >  /*
> > 
> > Nit: this introduces a stray newline.
> > 
> > > --- a/include/linux/syscalls.h
> > > +++ b/include/linux/syscalls.h
> > > @@ -1042,4 +1042,10 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
> > >  	return do_fchownat(AT_FDCWD, filename, user, group,
> > >  			     AT_SYMLINK_NOFOLLOW);
> > >  }
> > > +
> > > +extern int __close_fd(struct files_struct *files, unsigned int fd);
> > > +static inline int ksys_close(unsigned int fd)
> > > +{
> > > +	return __close_fd(current->files, fd);
> > > +}
> > 
> > Would be nice to reuse that stray newline after the __close_fd() prototype for the 
> > canonical stylistic separation of declarations from definitions.
> > 
> > It would also be very nice to add a short comment before ksys_close() that 
> > explains how it differs from sys_close(). This should reduce the amount of 
> > cargo-cult copying of existing ksys_close()/sys_close() patterns.
> 
> Thanks, have done that:
> 
> 	/*
> 	 * In contrast to sys_close(), this stub does not check whether the syscall
> 	 * should or should not be restarted, but returns the raw error codes from
> 	 * __close_fd().
> 	 */
> 
> Is that ok?

Yeah, looks good to me!

Thanks,

	Ingo
