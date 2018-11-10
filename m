Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D4CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C06020825
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xq7Vldvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C06020825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeKJNDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 08:03:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37775 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbeKJNDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 08:03:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so1661982pge.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 19:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SwhalELpmKQK1pwDtkb5pSRxXxFuUqJP43YJan5OutI=;
        b=xq7VldvkCZEHJyxch+k3eLF912iD/rTIOqqL8Vfh+Lq4Ww72VftLxnx+hw2pG7ABiw
         Yy8/mSK3jYPIXFpuAmw5rz23WIQxacyH7jJ2UzPAVfFOqogdBcXAIigrNbnFqihC9I4r
         BwgRQPblyifTqihZlim7tpMEWRjiGJCUKvgwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SwhalELpmKQK1pwDtkb5pSRxXxFuUqJP43YJan5OutI=;
        b=mf2qfj8w5d8JTW3CXr0/n/0C9ghT3d1Vter4+KtO+WEVKulhnMV7qJU0turTfsLApo
         jyrLOcT4puKT2zLRSPG0LkeUv6c7M9irFJR9uV5Z9NYEHxStRxVrco7ZHXRg1/QZ7NVQ
         vv6Qnj0mZVIhoH4o+z4Qmhc8cvQ/pir9mAQlOA8P2hJrS9VQFACHP2raj4+Ei2OP0gNH
         oeO/9wnytLix5gwinRlq7smCItk3gkOnnUjcjNt7fH/rsujGnPHANr7rPOL4V1UVdf7f
         M77t4LsMvg2k8No9gluW58pdSAuI6faV5kEWZOLXE8+om+7gT+EhjxybfJ7UuQJwesGE
         mz7g==
X-Gm-Message-State: AGRZ1gJPl6LkSw3YWc0oO8USX92LJlvV0H4gVdujMUstuwE9IqhsQ7Ix
        pmH+MXyBsaK5umV9HRx1EL8wWg==
X-Google-Smtp-Source: AJdET5cwQ092gw+g7OeOb8kqx9zN5Ka7lxMTFIisRhQLNJTFm0Z0lE4aroEyPPStP6ZB3ToGArDL3w==
X-Received: by 2002:a62:682:: with SMTP id 124-v6mr11543056pfg.161.1541820007715;
        Fri, 09 Nov 2018 19:20:07 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q1sm8566556pgs.14.2018.11.09.19.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 19:20:06 -0800 (PST)
Date:   Fri, 9 Nov 2018 19:20:05 -0800
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
Message-ID: <20181110032005.GA22238@google.com>
References: <20181108041537.39694-1-joel@joelfernandes.org>
 <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
 <CAG48ez0kQ4d566bXTFOYANDgii-stL-Qj-oyaBzvfxdV=PU-7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0kQ4d566bXTFOYANDgii-stL-Qj-oyaBzvfxdV=PU-7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:19:03PM +0100, Jann Horn wrote:
> On Fri, Nov 9, 2018 at 10:06 PM Jann Horn <jannh@google.com> wrote:
> > On Fri, Nov 9, 2018 at 9:46 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > > Android uses ashmem for sharing memory regions. We are looking forward
> > > to migrating all usecases of ashmem to memfd so that we can possibly
> > > remove the ashmem driver in the future from staging while also
> > > benefiting from using memfd and contributing to it. Note staging drivers
> > > are also not ABI and generally can be removed at anytime.
> > >
> > > One of the main usecases Android has is the ability to create a region
> > > and mmap it as writeable, then add protection against making any
> > > "future" writes while keeping the existing already mmap'ed
> > > writeable-region active.  This allows us to implement a usecase where
> > > receivers of the shared memory buffer can get a read-only view, while
> > > the sender continues to write to the buffer.
> > > See CursorWindow documentation in Android for more details:
> > > https://developer.android.com/reference/android/database/CursorWindow
> > >
> > > This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> > > To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
> > > which prevents any future mmap and write syscalls from succeeding while
> > > keeping the existing mmap active.
> >
> > Please CC linux-api@ on patches like this. If you had done that, I
> > might have criticized your v1 patch instead of your v3 patch...
> >
> > > The following program shows the seal
> > > working in action:
> > [...]
> > > Cc: jreck@google.com
> > > Cc: john.stultz@linaro.org
> > > Cc: tkjos@google.com
> > > Cc: gregkh@linuxfoundation.org
> > > Cc: hch@infradead.org
> > > Reviewed-by: John Stultz <john.stultz@linaro.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > [...]
> > > diff --git a/mm/memfd.c b/mm/memfd.c
> > > index 2bb5e257080e..5ba9804e9515 100644
> > > --- a/mm/memfd.c
> > > +++ b/mm/memfd.c
> > [...]
> > > @@ -219,6 +220,25 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
> > >                 }
> > >         }
> > >
> > > +       if ((seals & F_SEAL_FUTURE_WRITE) &&
> > > +           !(*file_seals & F_SEAL_FUTURE_WRITE)) {
> > > +               /*
> > > +                * The FUTURE_WRITE seal also prevents growing and shrinking
> > > +                * so we need them to be already set, or requested now.
> > > +                */
> > > +               int test_seals = (seals | *file_seals) &
> > > +                                (F_SEAL_GROW | F_SEAL_SHRINK);
> > > +
> > > +               if (test_seals != (F_SEAL_GROW | F_SEAL_SHRINK)) {
> > > +                       error = -EINVAL;
> > > +                       goto unlock;
> > > +               }
> > > +
> > > +               spin_lock(&file->f_lock);
> > > +               file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
> > > +               spin_unlock(&file->f_lock);
> > > +       }
> >
> > So you're fiddling around with the file, but not the inode? How are
> > you preventing code like the following from re-opening the file as
> > writable?
> >
> > $ cat memfd.c
> > #define _GNU_SOURCE
> > #include <unistd.h>
> > #include <sys/syscall.h>
> > #include <printf.h>
> > #include <fcntl.h>
> > #include <err.h>
> > #include <stdio.h>
> >
> > int main(void) {
> >   int fd = syscall(__NR_memfd_create, "testfd", 0);
> >   if (fd == -1) err(1, "memfd");
> >   char path[100];
> >   sprintf(path, "/proc/self/fd/%d", fd);
> >   int fd2 = open(path, O_RDWR);
> >   if (fd2 == -1) err(1, "reopen");
> >   printf("reopen successful: %d\n", fd2);
> > }
> > $ gcc -o memfd memfd.c
> > $ ./memfd
> > reopen successful: 4
> > $
> >
> > That aside: I wonder whether a better API would be something that
> > allows you to create a new readonly file descriptor, instead of
> > fiddling with the writability of an existing fd.
> 
> My favorite approach would be to forbid open() on memfds, hope that
> nobody notices the tiny API break, and then add an ioctl for "reopen
> this memfd with reduced permissions" - but that's just my personal
> opinion.

I did something along these lines and it fixes the issue, but I forbid open
of memfd only when the F_SEAL_FUTURE_WRITE seal is in place. So then its not
an ABI break because this is a brand new seal. That seems the least intrusive
solution and it works. Do you mind testing it and I'll add your and Tested-by
to the new fix? The patch is based on top of this series.

---8<-----------
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] mm/memfd: Fix possible promotion to writeable of sealed memfd

Jann Horn found that reopening an F_SEAL_FUTURE_WRITE sealed memfd
through /proc/self/fd/N symlink as writeable succeeds. The simplest fix
without causing ABI breakages and ugly VFS hacks is to simply deny all
opens on F_SEAL_FUTURE_WRITE sealed fds.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/shmem.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 446942677cd4..5b378c486b8f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3611,7 +3611,25 @@ static const struct address_space_operations shmem_aops = {
 	.error_remove_page = generic_error_remove_page,
 };
 
+/* Could arrive here for memfds opened through /proc/ */
+int shmem_open(struct inode *inode, struct file *file)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	/*
+	 * memfds for which future writes have been prevented
+	 * should not be reopened, say, through /proc/pid/fd/N
+	 * symlinks otherwise it can cause a sealed memfd to be
+	 * promoted to writable.
+	 */
+	if (info->seals & F_SEAL_FUTURE_WRITE)
+		return -EACCES;
+
+	return 0;
+}
+
 static const struct file_operations shmem_file_operations = {
+	.open		= shmem_open,
 	.mmap		= shmem_mmap,
 	.get_unmapped_area = shmem_get_unmapped_area,
 #ifdef CONFIG_TMPFS
-- 
2.19.1.930.g4563a0d9d0-goog

