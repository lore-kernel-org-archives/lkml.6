Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84387C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2953C20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cWULhBVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2953C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeKJJ3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:29:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32999 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeKJJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:29:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id w22-v6so1623337plk.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/V73fWpvPwBtZ0J74Rje2LRbYmSA3wE3tXBHscYlKyM=;
        b=cWULhBVayighgnAbfptejzLfKqBzQa0oI2Xy17MypLNoSvlzm7jpkDUBrMAGpqf2bH
         FY767bZhrBFPLZkhXSOWzd0NnGzpNWur03HbJr6RYhTEZpTj2LoJKpZNXcjSH32sW8g6
         S5eoy0P+mpyqyxoyHc1rdcrUaECIqwuOBRE9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/V73fWpvPwBtZ0J74Rje2LRbYmSA3wE3tXBHscYlKyM=;
        b=rIok7IDk4qSYrB5NKSXt0UJxEidJzRX913TIlq47fMTTL0rlYfEjGpPMC1vfTJSVkl
         4ZDXzH6vv0KyXIyqGeYc8thmQuCs8BcgdFAELuwE3KI1LFguWuqMZUHUcYdlIMBtl1Q5
         rnAE0XMHrfE9C7PyVvpm4NTswFMBi1MGGpUqj65sWf8y9oox6snuWCnt/hlPJ0bAAhDs
         gdTo/zKzx+r6NVexoRshmV7GBUdXWk51Od2rrYsfmPDMpmIRlanJ0p32ZwsNqtguZOiu
         zho+jDs1LamDhVdvWqK0p2sWZwq9DsRXrfgkCm1r0ussHGY3kgAKQhMGIA6TkxbieIC3
         xZUQ==
X-Gm-Message-State: AGRZ1gIdbQqLtU8ujtrip2joidCLFshGSjwGBSfuzOLtAQCb7w0PF7jp
        c0qdsKjwxA5yO5FlwgkXsufbhw==
X-Google-Smtp-Source: AJdET5eVpNIPDTKav6fuQIgkb8e+9g9uoQAqkWBeFKs+ti2DQHMCJdJ9gMBvTlK4F8qF7ad2BCtubA==
X-Received: by 2002:a17:902:c03:: with SMTP id 3-v6mr5356929pls.141.1541807198676;
        Fri, 09 Nov 2018 15:46:38 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id b69-v6sm8691173pfc.150.2018.11.09.15.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 15:46:37 -0800 (PST)
Date:   Fri, 9 Nov 2018 15:46:36 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>, jreck@google.com,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Bruce Fields <bfields@fieldses.org>, jlayton@kernel.org,
        Khalid Aziz <khalid.aziz@oracle.com>, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, minchan@kernel.org,
        shuah@kernel.org, valdis.kletnieks@vt.edu,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to
 memfd
Message-ID: <20181109234636.GA136491@google.com>
References: <20181108041537.39694-1-joel@joelfernandes.org>
 <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:06:31PM +0100, Jann Horn wrote:
> +linux-api for API addition
> +hughd as FYI since this is somewhat related to mm/shmem
> 
> On Fri, Nov 9, 2018 at 9:46 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> > Android uses ashmem for sharing memory regions. We are looking forward
> > to migrating all usecases of ashmem to memfd so that we can possibly
> > remove the ashmem driver in the future from staging while also
> > benefiting from using memfd and contributing to it. Note staging drivers
> > are also not ABI and generally can be removed at anytime.
> >
> > One of the main usecases Android has is the ability to create a region
> > and mmap it as writeable, then add protection against making any
> > "future" writes while keeping the existing already mmap'ed
> > writeable-region active.  This allows us to implement a usecase where
> > receivers of the shared memory buffer can get a read-only view, while
> > the sender continues to write to the buffer.
> > See CursorWindow documentation in Android for more details:
> > https://developer.android.com/reference/android/database/CursorWindow
> >
> > This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> > To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
> > which prevents any future mmap and write syscalls from succeeding while
> > keeping the existing mmap active.
> 
> Please CC linux-api@ on patches like this. If you had done that, I
> might have criticized your v1 patch instead of your v3 patch...

Ok, will do from next time.

> > The following program shows the seal
> > working in action:
> [...]
> > Cc: jreck@google.com
> > Cc: john.stultz@linaro.org
> > Cc: tkjos@google.com
> > Cc: gregkh@linuxfoundation.org
> > Cc: hch@infradead.org
> > Reviewed-by: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> [...]
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 2bb5e257080e..5ba9804e9515 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> [...]
> > @@ -219,6 +220,25 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
> >                 }
> >         }
> >
> > +       if ((seals & F_SEAL_FUTURE_WRITE) &&
> > +           !(*file_seals & F_SEAL_FUTURE_WRITE)) {
> > +               /*
> > +                * The FUTURE_WRITE seal also prevents growing and shrinking
> > +                * so we need them to be already set, or requested now.
> > +                */
> > +               int test_seals = (seals | *file_seals) &
> > +                                (F_SEAL_GROW | F_SEAL_SHRINK);
> > +
> > +               if (test_seals != (F_SEAL_GROW | F_SEAL_SHRINK)) {
> > +                       error = -EINVAL;
> > +                       goto unlock;
> > +               }
> > +
> > +               spin_lock(&file->f_lock);
> > +               file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
> > +               spin_unlock(&file->f_lock);
> > +       }
> 
> So you're fiddling around with the file, but not the inode? How are
> you preventing code like the following from re-opening the file as
> writable?
> 
> $ cat memfd.c
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <sys/syscall.h>
> #include <printf.h>
> #include <fcntl.h>
> #include <err.h>
> #include <stdio.h>
> 
> int main(void) {
>   int fd = syscall(__NR_memfd_create, "testfd", 0);
>   if (fd == -1) err(1, "memfd");
>   char path[100];
>   sprintf(path, "/proc/self/fd/%d", fd);
>   int fd2 = open(path, O_RDWR);
>   if (fd2 == -1) err(1, "reopen");
>   printf("reopen successful: %d\n", fd2);
> }
> $ gcc -o memfd memfd.c
> $ ./memfd
> reopen successful: 4

Great catch and this is indeed an issue :-(. I verified it too.

> That aside: I wonder whether a better API would be something that
> allows you to create a new readonly file descriptor, instead of
> fiddling with the writability of an existing fd.

Android usecases cannot deal with a new fd number because it breaks the
continuity of having the same old fd, as Dan also pointed out.

Also such API will have the same issues you brought up?

thanks,

 - Joel

