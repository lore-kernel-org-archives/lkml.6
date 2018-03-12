Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeCLHhY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:37:24 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40759 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeCLHhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:37:23 -0400
X-Google-Smtp-Source: AG47ELtSlBbV473BKR9VrjtdHH7FfG8QuN2E2pKZ9K4pCkv9qvmdb/m2Icd4TYopuCJP86yWsw9L3w==
Date: Mon, 12 Mar 2018 08:37:19 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH 35/35] syscalls: do not call sys_close() within the
 kernel
Message-ID: <20180312073719.ugsbv3nlkbbtac4v@gmail.com>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
 <20180311105557.20807-36-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180311105557.20807-36-linux@dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1200,7 +1200,7 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
>  
>  	return retval;
>  }
> -EXPORT_SYMBOL(sys_close);
> +
>  
>  /*

Nit: this introduces a stray newline.

> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1042,4 +1042,10 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
>  	return do_fchownat(AT_FDCWD, filename, user, group,
>  			     AT_SYMLINK_NOFOLLOW);
>  }
> +
> +extern int __close_fd(struct files_struct *files, unsigned int fd);
> +static inline int ksys_close(unsigned int fd)
> +{
> +	return __close_fd(current->files, fd);
> +}

Would be nice to reuse that stray newline after the __close_fd() prototype for the 
canonical stylistic separation of declarations from definitions.

It would also be very nice to add a short comment before ksys_close() that 
explains how it differs from sys_close(). This should reduce the amount of 
cargo-cult copying of existing ksys_close()/sys_close() patterns.

Thanks,

	Ingo
