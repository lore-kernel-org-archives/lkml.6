Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D0FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD902089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oteXW8gB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD902089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeKKEKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:10:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45021 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeKKEKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:10:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so2218647pgs.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 10:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l/2epkkqG+q6It5//eUSqjzx3AOyzjrDIZiyN62Y10w=;
        b=oteXW8gBBewwHIlURD+x1tb366WdX3pwjSv04CSvRO0XUgJAMrPpZ0iF1kVxHeiI/z
         ZEIr71KR85BVRx+s0Iymf7l35bPjVXL4wU0kodAGJto5r7iZabkzQ+WWnqZvmgfO4eSs
         XJelf/T+JLvYuEKLKCGaXKzgbeCdfJWMpxDG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l/2epkkqG+q6It5//eUSqjzx3AOyzjrDIZiyN62Y10w=;
        b=MSpW0iDkEkbDxwp5XFDyvOuy5ZydiRGlxZ053/2O5g2xRdY1htYRYY3/DbJEpLNdmB
         unJ9knqiCRJEK/XsGgtNQg6vf8MkjDXnzUMhGdoMzoY0md3GsAl/2jKwGeTZD0LzjGcf
         yIwgOBTLNmVePpXso6JNtd/dJi9B8Or0n6hYp0mBalCDDswL5RrsB3B2foyzv9RdOpQx
         9RwPPCHDK8KdorqgaTliXrj/sX2IbfI8Q3AjssQc486I1PW+whEHlGWhBKxOPTM4oLol
         7vMFkPgRqvSDT6zgQJnTXZ0As/Y1U1hFaTToq2+1ptdJ8sSTU8LDaDJvbMcNpoin0+xe
         7f1w==
X-Gm-Message-State: AGRZ1gLBF9zPe5469rIn+TIEJ3sbBd4HWFzGxulplieIgMh+1yfydl4p
        VvwRZUsf0ZZ2Iuc5iLQ1gp2znw==
X-Google-Smtp-Source: AJdET5elVOCs3brwkP+/q9uIWyfNm6rJGWAZkWKLVhdgRa1TJCb4M4m+S0+ma4iJ5yqWz7kgyUULXg==
X-Received: by 2002:a63:1848:: with SMTP id 8mr11686416pgy.81.1541874247113;
        Sat, 10 Nov 2018 10:24:07 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id u9-v6sm11060810pfm.175.2018.11.10.10.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 10:24:06 -0800 (PST)
Date:   Sat, 10 Nov 2018 10:24:05 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>, jreck@google.com,
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
Message-ID: <20181110182405.GB242356@google.com>
References: <20181108041537.39694-1-joel@joelfernandes.org>
 <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
 <CAG48ez0kQ4d566bXTFOYANDgii-stL-Qj-oyaBzvfxdV=PU-7g@mail.gmail.com>
 <20181110032005.GA22238@google.com>
 <69CE06CC-E47C-4992-848A-66EB23EE6C74@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69CE06CC-E47C-4992-848A-66EB23EE6C74@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy for your thoughts, my comments below:

On Fri, Nov 09, 2018 at 10:05:14PM -0800, Andy Lutomirski wrote:
> 
> 
> > On Nov 9, 2018, at 7:20 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> >> On Fri, Nov 09, 2018 at 10:19:03PM +0100, Jann Horn wrote:
> >>> On Fri, Nov 9, 2018 at 10:06 PM Jann Horn <jannh@google.com> wrote:
> >>> On Fri, Nov 9, 2018 at 9:46 PM Joel Fernandes (Google)
> >>> <joel@joelfernandes.org> wrote:
> >>>> Android uses ashmem for sharing memory regions. We are looking forward
> >>>> to migrating all usecases of ashmem to memfd so that we can possibly
> >>>> remove the ashmem driver in the future from staging while also
> >>>> benefiting from using memfd and contributing to it. Note staging drivers
> >>>> are also not ABI and generally can be removed at anytime.
> >>>> 
> >>>> One of the main usecases Android has is the ability to create a region
> >>>> and mmap it as writeable, then add protection against making any
> >>>> "future" writes while keeping the existing already mmap'ed
> >>>> writeable-region active.  This allows us to implement a usecase where
> >>>> receivers of the shared memory buffer can get a read-only view, while
> >>>> the sender continues to write to the buffer.
> >>>> See CursorWindow documentation in Android for more details:
> >>>> https://developer.android.com/reference/android/database/CursorWindow
> >>>> 
> >>>> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> >>>> To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
> >>>> which prevents any future mmap and write syscalls from succeeding while
> >>>> keeping the existing mmap active.
> >>> 
> >>> Please CC linux-api@ on patches like this. If you had done that, I
> >>> might have criticized your v1 patch instead of your v3 patch...
> >>> 
> >>>> The following program shows the seal
> >>>> working in action:
> >>> [...]
> >>>> Cc: jreck@google.com
> >>>> Cc: john.stultz@linaro.org
> >>>> Cc: tkjos@google.com
> >>>> Cc: gregkh@linuxfoundation.org
> >>>> Cc: hch@infradead.org
> >>>> Reviewed-by: John Stultz <john.stultz@linaro.org>
> >>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>> ---
> >>> [...]
> >>>> diff --git a/mm/memfd.c b/mm/memfd.c
> >>>> index 2bb5e257080e..5ba9804e9515 100644
> >>>> --- a/mm/memfd.c
> >>>> +++ b/mm/memfd.c
> >>> [...]
> >>>> @@ -219,6 +220,25 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
> >>>>                }
> >>>>        }
> >>>> 
> >>>> +       if ((seals & F_SEAL_FUTURE_WRITE) &&
> >>>> +           !(*file_seals & F_SEAL_FUTURE_WRITE)) {
> >>>> +               /*
> >>>> +                * The FUTURE_WRITE seal also prevents growing and shrinking
> >>>> +                * so we need them to be already set, or requested now.
> >>>> +                */
> >>>> +               int test_seals = (seals | *file_seals) &
> >>>> +                                (F_SEAL_GROW | F_SEAL_SHRINK);
> >>>> +
> >>>> +               if (test_seals != (F_SEAL_GROW | F_SEAL_SHRINK)) {
> >>>> +                       error = -EINVAL;
> >>>> +                       goto unlock;
> >>>> +               }
> >>>> +
> >>>> +               spin_lock(&file->f_lock);
> >>>> +               file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
> >>>> +               spin_unlock(&file->f_lock);
> >>>> +       }
> >>> 
> >>> So you're fiddling around with the file, but not the inode? How are
> >>> you preventing code like the following from re-opening the file as
> >>> writable?
> >>> 
> >>> $ cat memfd.c
> >>> #define _GNU_SOURCE
> >>> #include <unistd.h>
> >>> #include <sys/syscall.h>
> >>> #include <printf.h>
> >>> #include <fcntl.h>
> >>> #include <err.h>
> >>> #include <stdio.h>
> >>> 
> >>> int main(void) {
> >>>  int fd = syscall(__NR_memfd_create, "testfd", 0);
> >>>  if (fd == -1) err(1, "memfd");
> >>>  char path[100];
> >>>  sprintf(path, "/proc/self/fd/%d", fd);
> >>>  int fd2 = open(path, O_RDWR);
> >>>  if (fd2 == -1) err(1, "reopen");
> >>>  printf("reopen successful: %d\n", fd2);
> >>> }
> >>> $ gcc -o memfd memfd.c
> >>> $ ./memfd
> >>> reopen successful: 4
> >>> $
> >>> 
> >>> That aside: I wonder whether a better API would be something that
> >>> allows you to create a new readonly file descriptor, instead of
> >>> fiddling with the writability of an existing fd.
> >> 
> >> My favorite approach would be to forbid open() on memfds, hope that
> >> nobody notices the tiny API break, and then add an ioctl for "reopen
> >> this memfd with reduced permissions" - but that's just my personal
> >> opinion.
> > 
> > I did something along these lines and it fixes the issue, but I forbid open
> > of memfd only when the F_SEAL_FUTURE_WRITE seal is in place. So then its not
> > an ABI break because this is a brand new seal. That seems the least intrusive
> > solution and it works. Do you mind testing it and I'll add your and Tested-by
> > to the new fix? The patch is based on top of this series.
> > 
> > ---8<-----------
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Subject: [PATCH] mm/memfd: Fix possible promotion to writeable of sealed memfd
> > 
> > Jann Horn found that reopening an F_SEAL_FUTURE_WRITE sealed memfd
> > through /proc/self/fd/N symlink as writeable succeeds. The simplest fix
> > without causing ABI breakages and ugly VFS hacks is to simply deny all
> > opens on F_SEAL_FUTURE_WRITE sealed fds.
> > 
> > Reported-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > mm/shmem.c | 18 ++++++++++++++++++
> > 1 file changed, 18 insertions(+)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 446942677cd4..5b378c486b8f 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -3611,7 +3611,25 @@ static const struct address_space_operations shmem_aops = {
> >    .error_remove_page = generic_error_remove_page,
> > };
> > 
> > +/* Could arrive here for memfds opened through /proc/ */
> > +int shmem_open(struct inode *inode, struct file *file)
> > +{
> > +    struct shmem_inode_info *info = SHMEM_I(inode);
> > +
> > +    /*
> > +     * memfds for which future writes have been prevented
> > +     * should not be reopened, say, through /proc/pid/fd/N
> > +     * symlinks otherwise it can cause a sealed memfd to be
> > +     * promoted to writable.
> > +     */
> > +    if (info->seals & F_SEAL_FUTURE_WRITE)
> > +        return -EACCES;
> > +
> > +    return 0;
> > +}
> 
> The result of this series is very warty. We have a concept of seals, and they all work similarly, except the new future write seal. That one:
> 

I don't see it as warty, different seals will work differently. It works
quite well for our usecase, and since Linux is all about solving real
problems in the real work, it would be useful to have it.

> - causes a probably-observable effect in the file mode in F_GETFL.

Wouldn't that be the right thing to observe anyway?

> - causes reopen to fail.

So this concern isn't true anymore if we make reopen fail only for WRITE
opens as Daniel suggested. I will make this change so that the security fix
is a clean one.

> - does *not* affect other struct files that may already exist on the same inode.

TBH if you really want to block all writes to the file, then you want
F_SEAL_WRITE, not this seal. The usecase we have is the fd is sent over IPC
to another process and we want to prevent any new writes in the receiver
side. There is no way this other receiving process can have an existing fd
unless it was already sent one without the seal applied.  The proposed seal
could be renamed to F_SEAL_FD_WRITE if that is preferred.

> - mysteriously malfunctions if you try to set it again on another struct
> file that already exists
> 

I didn't follow this, could you explain more?

> - probably is insecure when used on hugetlbfs.

The usecase is not expected to prevent all writes, indeed the usecase
requires existing mmaps to continue to be able to write into the memory map.
So would you call that a security issue too? The use of the seal wants to
allow existing mmap regions to be continue to be written into (I mentioned
more details in the cover letter).

> I see two reasonable solutions:
> 
> 1. Don’t fiddle with the struct file at all. Instead make the inode flag
> work by itself.

Currently, the various VFS paths check only the struct file's f_mode to deny
writes of already opened files. This would mean more checking in all those
paths (and modification of all those paths).

Anyway going with that idea, we could
1. call deny_write_access(file) from the memfd's seal path which decrements
the inode::i_writecount.
2. call get_write_access(inode) in the various VFS paths in addition to
checking for FMODE_*WRITE and deny the write (incase i_writecount is negative)

That will prevent both reopens, and writes from succeeding. However I worry a
bit about 2 not being too familiar with VFS internals, about what the
consequences of doing that may be.

> 2. Don’t call it a “seal”.  Instead fix the /proc hole and add an API to
> drop write access on an existing struct file.
> 
> I personally prefer #2.

So I don't think proc has a hole looking at the code yesterday. As I was
saying in other thread, its just how symlinks work. If we were to apply this
API to files in general, and we had symlinks to files and we tried to reopen the
file, we would run into the same issue - that's why I believe it has nothing
to do with proc, and the fix has to be in the underlying inode being pointed
to. Does that make sense or did I miss something?

thanks,

 - Joel
