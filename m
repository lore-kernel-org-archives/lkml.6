Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC86C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA27220840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IcOr60Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA27220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeKKC4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:56:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44268 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeKKC4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:56:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id b81-v6so1835905pfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 09:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RAOSk752rvaDPZ/vfFvRhPrKNX9UBnZooEKSicvOERM=;
        b=IcOr60LcicOWMcAp4EEaUfjsJ60DRVfrKdBRc5IK+p+UpWfV+hFZhdjTTxx1Z0wRou
         5LtGsKA/Xh8ZbCucMU/56zhXQdmad+9yKgb5VZlDTb2G0er8927/G8Fat9bAa9ctLSFL
         jZFtM/FYYO6mu+bmO2J3nN2REH9V3g96xRc5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RAOSk752rvaDPZ/vfFvRhPrKNX9UBnZooEKSicvOERM=;
        b=kvtBkmtrPgkF0RDvxPe+EZW461QglpVZPRYI/6hkZnOKa4Ey46piifXnLhwCMNkVjC
         exm7CUKpBuVnz6knFiwYs82E26Ed8InGp1FMkkvho4YEzTVctyZj0GJCbVYGPG4swP9s
         CkqD14tdT4bDHu8KZcOoVZf0xlINtRmpPO5+YKXvLK7eocRDYRWRx3KFl+p6cPrKNfaS
         WtdYWVPRSK4/fwFR3f3QkoiZtysyoBhuHRE1+UniwK3LE74vzfrHfD648YP6atVDJqao
         87UHl6O1iR1WampWE+O/sTEwzCJ6e+gPwQV3okxbJW6xfCyRe4YP1/dcQyz8w3GAgBP6
         7PeQ==
X-Gm-Message-State: AGRZ1gI9AHSb4VnG7Zvh4VXGKPlLLRCbzlLomQr5qMc7h1C2SPW6KvGq
        mUPWSKdQOOEYCxyfnfUy/VeFaw==
X-Google-Smtp-Source: AJdET5dzv8rKL5XgeMJoBDeq3zP3Ju3riuFS4UybM8hR/ZyzlCvwLqJaOZtFDPwAnhwkkEKt5mrfvA==
X-Received: by 2002:a63:c0f:: with SMTP id b15mr11711275pgl.314.1541869860763;
        Sat, 10 Nov 2018 09:11:00 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 34sm10635910pgp.90.2018.11.10.09.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 09:10:59 -0800 (PST)
Date:   Sat, 10 Nov 2018 09:10:58 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "jreck@google.com" <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "Lei.Yang@windriver.com" <Lei.Yang@windriver.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to
 memfd
Message-ID: <20181110171058.GA242356@google.com>
References: <20181108041537.39694-1-joel@joelfernandes.org>
 <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
 <CAG48ez0kQ4d566bXTFOYANDgii-stL-Qj-oyaBzvfxdV=PU-7g@mail.gmail.com>
 <20181110032005.GA22238@google.com>
 <CAKOZuethC7+YrRyyGciUCfhSSa9cCcAFJ8g_qEw9uh3TBbyOcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuethC7+YrRyyGciUCfhSSa9cCcAFJ8g_qEw9uh3TBbyOcg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 04:26:46AM -0800, Daniel Colascione wrote:
> On Friday, November 9, 2018, Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Fri, Nov 09, 2018 at 10:19:03PM +0100, Jann Horn wrote:
> > > On Fri, Nov 9, 2018 at 10:06 PM Jann Horn <jannh@google.com> wrote:
> > > > On Fri, Nov 9, 2018 at 9:46 PM Joel Fernandes (Google)
> > > > <joel@joelfernandes.org> wrote:
> > > > > Android uses ashmem for sharing memory regions. We are looking
> > forward
> > > > > to migrating all usecases of ashmem to memfd so that we can possibly
> > > > > remove the ashmem driver in the future from staging while also
> > > > > benefiting from using memfd and contributing to it. Note staging
> > drivers
> > > > > are also not ABI and generally can be removed at anytime.
> > > > >
> > > > > One of the main usecases Android has is the ability to create a
> > region
> > > > > and mmap it as writeable, then add protection against making any
> > > > > "future" writes while keeping the existing already mmap'ed
> > > > > writeable-region active.  This allows us to implement a usecase where
> > > > > receivers of the shared memory buffer can get a read-only view, while
> > > > > the sender continues to write to the buffer.
> > > > > See CursorWindow documentation in Android for more details:
> > > > > https://developer.android.com/reference/android/database/
> > CursorWindow
> > > > >
> > > > > This usecase cannot be implemented with the existing F_SEAL_WRITE
> > seal.
> > > > > To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE
> > seal
> > > > > which prevents any future mmap and write syscalls from succeeding
> > while
> > > > > keeping the existing mmap active.
> > > >
> > > > Please CC linux-api@ on patches like this. If you had done that, I
> > > > might have criticized your v1 patch instead of your v3 patch...
> > > >
> > > > > The following program shows the seal
> > > > > working in action:
> > > > [...]
> > > > > Cc: jreck@google.com
> > > > > Cc: john.stultz@linaro.org
> > > > > Cc: tkjos@google.com
> > > > > Cc: gregkh@linuxfoundation.org
> > > > > Cc: hch@infradead.org
> > > > > Reviewed-by: John Stultz <john.stultz@linaro.org>
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > ---
> > > > [...]
> > > > > diff --git a/mm/memfd.c b/mm/memfd.c
> > > > > index 2bb5e257080e..5ba9804e9515 100644
> > > > > --- a/mm/memfd.c
> > > > > +++ b/mm/memfd.c
> > > > [...]
> > > > > @@ -219,6 +220,25 @@ static int memfd_add_seals(struct file *file,
> > unsigned int seals)
> > > > >                 }
> > > > >         }
> > > > >
> > > > > +       if ((seals & F_SEAL_FUTURE_WRITE) &&
> > > > > +           !(*file_seals & F_SEAL_FUTURE_WRITE)) {
> > > > > +               /*
> > > > > +                * The FUTURE_WRITE seal also prevents growing and
> > shrinking
> > > > > +                * so we need them to be already set, or requested
> > now.
> > > > > +                */
> > > > > +               int test_seals = (seals | *file_seals) &
> > > > > +                                (F_SEAL_GROW | F_SEAL_SHRINK);
> > > > > +
> > > > > +               if (test_seals != (F_SEAL_GROW | F_SEAL_SHRINK)) {
> > > > > +                       error = -EINVAL;
> > > > > +                       goto unlock;
> > > > > +               }
> > > > > +
> > > > > +               spin_lock(&file->f_lock);
> > > > > +               file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
> > > > > +               spin_unlock(&file->f_lock);
> > > > > +       }
> > > >
> > > > So you're fiddling around with the file, but not the inode? How are
> > > > you preventing code like the following from re-opening the file as
> > > > writable?
> > > >
> > > > $ cat memfd.c
> > > > #define _GNU_SOURCE
> > > > #include <unistd.h>
> > > > #include <sys/syscall.h>
> > > > #include <printf.h>
> > > > #include <fcntl.h>
> > > > #include <err.h>
> > > > #include <stdio.h>
> > > >
> > > > int main(void) {
> > > >   int fd = syscall(__NR_memfd_create, "testfd", 0);
> > > >   if (fd == -1) err(1, "memfd");
> > > >   char path[100];
> > > >   sprintf(path, "/proc/self/fd/%d", fd);
> > > >   int fd2 = open(path, O_RDWR);
> > > >   if (fd2 == -1) err(1, "reopen");
> > > >   printf("reopen successful: %d\n", fd2);
> > > > }
> > > > $ gcc -o memfd memfd.c
> > > > $ ./memfd
> > > > reopen successful: 4
> > > > $
> > > >
> > > > That aside: I wonder whether a better API would be something that
> > > > allows you to create a new readonly file descriptor, instead of
> > > > fiddling with the writability of an existing fd.
> > >
> > > My favorite approach would be to forbid open() on memfds, hope that
> > > nobody notices the tiny API break, and then add an ioctl for "reopen
> > > this memfd with reduced permissions" - but that's just my personal
> > > opinion.
> >
> > I did something along these lines and it fixes the issue, but I forbid open
> > of memfd only when the F_SEAL_FUTURE_WRITE seal is in place. So then its
> > not
> > an ABI break because this is a brand new seal. That seems the least
> > intrusive
> > solution and it works. Do you mind testing it and I'll add your and
> > Tested-by
> > to the new fix? The patch is based on top of this series.
> >
> 
> Please don't forbid reopens entirely. You're taking a feature that works
> generally (reopens) and breaking it in one specific case (memfd write
> sealed files). The open modes are available in .open in the struct file:
> you can deny *only* opens for write instead of denying reopens generally.

Yes, as we discussed over chat already, I will implement it that way.

Also lets continue to discuss Andy's concerns he raised on the other thread.

thanks,

 - Joel

