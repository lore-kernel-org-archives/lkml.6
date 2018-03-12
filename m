Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbeCLTy1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:54:27 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:48726 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeCLTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:54:24 -0400
Date: Mon, 12 Mar 2018 20:43:11 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH 35/35] syscalls: do not call sys_close() within the
 kernel
Message-ID: <20180312194311.GE16666@light.dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
 <20180311105557.20807-36-linux@dominikbrodowski.net>
 <20180312073719.ugsbv3nlkbbtac4v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312073719.ugsbv3nlkbbtac4v@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 08:37:19AM +0100, Ingo Molnar wrote:
> 
> * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1200,7 +1200,7 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
> >  
> >  	return retval;
> >  }
> > -EXPORT_SYMBOL(sys_close);
> > +
> >  
> >  /*
> 
> Nit: this introduces a stray newline.
> 
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -1042,4 +1042,10 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
> >  	return do_fchownat(AT_FDCWD, filename, user, group,
> >  			     AT_SYMLINK_NOFOLLOW);
> >  }
> > +
> > +extern int __close_fd(struct files_struct *files, unsigned int fd);
> > +static inline int ksys_close(unsigned int fd)
> > +{
> > +	return __close_fd(current->files, fd);
> > +}
> 
> Would be nice to reuse that stray newline after the __close_fd() prototype for the 
> canonical stylistic separation of declarations from definitions.
> 
> It would also be very nice to add a short comment before ksys_close() that 
> explains how it differs from sys_close(). This should reduce the amount of 
> cargo-cult copying of existing ksys_close()/sys_close() patterns.

Thanks, have done that:

	/*
	 * In contrast to sys_close(), this stub does not check whether the syscall
	 * should or should not be restarted, but returns the raw error codes from
	 * __close_fd().
	 */

Is that ok?

Thanks,
	Dominik
