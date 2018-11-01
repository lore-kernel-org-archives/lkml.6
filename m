Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD52C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 04:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0283F2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 04:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z/3C0xys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0283F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeKANzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 09:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbeKANzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 09:55:24 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6FC320833
        for <linux-kernel@vger.kernel.org>; Thu,  1 Nov 2018 04:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541048044;
        bh=qswDDJzJ+Bk7GpKfMZLA6LpUbWHM7uZqnClApvqgHxE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z/3C0xysryzpJgmw4g7THRZYXhU4GW95o0O3xRxcRogULn56+Vrh2C4UsnDrSf30F
         MBGwXAMyffGNt9aoQo8WrFbYO9TBR3xgJpCySyREZH7ifJ8YzMkdtW24/lQMaV+JpY
         6EeSz4aQ8FXmu3G29JXtOUsKJsFN24Ds+altXWLc=
Received: by mail-wr1-f41.google.com with SMTP id r10-v6so18792069wrv.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 21:54:03 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJcT4svDCYZLcNpPhQWOTpoq8B6qCsQJUMnVpEBZ7IAp9auHoLd
        wIR1aEgL9xMrz6dLRRJ5Oan6rIP0ZwZsDIhucD757A==
X-Google-Smtp-Source: AJdET5dz9gjUUEocbeHw3zArmBEZT3K+nZO+K2DDVnl+wajN3eIrrpOosDLhGUuu93/3h0Kxmnxa5jHTJDmAepBVP5k=
X-Received: by 2002:adf:97d3:: with SMTP id t19-v6mr5462455wrb.283.1541048042165;
 Wed, 31 Oct 2018 21:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181029221037.87724-1-dancol@google.com> <CAG48ez01OWYVqEo+Qf65scG7a-48tDM4Gh3BOUKY+-b9g+9itw@mail.gmail.com>
In-Reply-To: <CAG48ez01OWYVqEo+Qf65scG7a-48tDM4Gh3BOUKY+-b9g+9itw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 31 Oct 2018 21:53:50 -0700
X-Gmail-Original-Message-ID: <CALCETrXYbtVyWE=iKCCyWewVs-sE3i-jHv=6g-s8rV4CDOE6sg@mail.gmail.com>
Message-ID: <CALCETrXYbtVyWE=iKCCyWewVs-sE3i-jHv=6g-s8rV4CDOE6sg@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Jann Horn <jannh@google.com>
Cc:     dancol@google.com, LKML <linux-kernel@vger.kernel.org>,
        timmurray@google.com, Joel Fernandes <joelaf@google.com>,
        surenb@google.com, Andrew Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 9:23 AM Jann Horn <jannh@google.com> wrote:
>
> +linux-api, Andy Lutomirski, Eric Biederman
>
> On Wed, Oct 31, 2018 at 3:12 AM Daniel Colascione <dancol@google.com> wrote:
> > Add a simple proc-based kill interface. To use /proc/pid/kill, just
> > write the signal number in base-10 ASCII to the kill file of the
> > process to be killed: for example, 'echo 9 > /proc/$$/kill'.
>
> This is a kernel API change, you should CC the linux-api list.
>
> I think that getting the semantics of this right might be easier if
> you used an ioctl handler instead of a write handler.
>
> > Semantically, /proc/pid/kill works like kill(2), except that the
> > process ID comes from the proc filesystem context instead of from an
> > explicit system call parameter. This way, it's possible to avoid races
> > between inspecting some aspect of a process and that process's PID
> > being reused for some other process.
> >
> > With /proc/pid/kill, it's possible to write a proper race-free and
> > safe pkill(1). An approximation follows. A real program might use
> > openat(2), having opened a process's /proc/pid directory explicitly,
> > with the directory file descriptor serving as a sort of "process
> > handle".
> >
> >     #!/bin/bash
> >     set -euo pipefail
> >     pat=$1
> >     for proc_status in /proc/*/status; do (
> >         cd $(dirname $proc_status)
> >         readarray proc_argv -d'' < cmdline
> >         if ((${#proc_argv[@]} > 0)) &&
> >                [[ ${proc_argv[0]} = *$pat* ]];
> >         then
> >             echo 15 > kill
> >         fi
> >     ) || true; done
> >
> > Signed-off-by: Daniel Colascione <dancol@google.com>
> > ---
> >  fs/proc/base.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 7e9f07bf260d..923d62b21e67 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -205,6 +205,44 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
> >         return result;
> >  }
> >
> > +static ssize_t proc_pid_kill_write(struct file *file,
> > +                                  const char __user *buf,
> > +                                  size_t count, loff_t *ppos)
> > +{
> > +       ssize_t res;
> > +       int sig;
> > +       char buffer[4];
> > +
> > +       res = -EINVAL;
> > +       if (*ppos != 0)
> > +               goto out;
> > +
> > +       res = -EINVAL;
> > +       if (count > sizeof(buffer) - 1)
> > +               goto out;
> > +
> > +       res = -EFAULT;
> > +       if (copy_from_user(buffer, buf, count))
> > +               goto out;
> > +
> > +       buffer[count] = '\0';
> > +       res = kstrtoint(strstrip(buffer), 10, &sig);
> > +       if (res)
> > +               goto out;
> > +
> > +       res = kill_pid(proc_pid(file_inode(file)), sig, 0);

Indeed, you can't do this from .write unless you manage to pass a cred
struct pointer in.  ioctl or a new syscall would be better.

--Andy
