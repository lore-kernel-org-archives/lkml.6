Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03580C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B247820879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BbhHpkA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B247820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeLEXY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:24:26 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:32793 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbeLEXY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:24:26 -0500
Received: by mail-yb1-f195.google.com with SMTP id f125so4907534ybc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jf65af7xdSOwjkNuWszryaSYkno4bbJQs+zPRdAZYNk=;
        b=BbhHpkA+DKp2vIrzPsaDROcJxkvyep+cxzPtk4NohHzsMBR0j5VgSl8KOVAYS81fAG
         1KHcVJ2o3RZLxKPjtUxgAcNlW7HzBWeqLv+aSyyOUC6vi482RtTVGYrRMq0Q3azelSVl
         H6rdRR08UiuhCX7zK9Gsx0vzXcjqWxRNGyHGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jf65af7xdSOwjkNuWszryaSYkno4bbJQs+zPRdAZYNk=;
        b=gqlUVuZY81GlLvhyQ/MLqWEEfcoWVJRrlhCPjkOyVsIwttxq3/u8+rLIPO6nL8469a
         S2jgphC9HCZYWsnH+r0CjCYbqhIYKgMpWD9pbHo5LqiE7228b1Od36NQozpkL3xSRdps
         PqjhS30P7aIx7pNYhx/WB/bTlSJUD9zvQ8WMCy0saPnXHZfKBXDaGm3A5amXomUz6lvk
         HqZeOHtZwnNn0e6n7egz5PpONGO7Cekw/QzwTgptraQiiHhSHOqvykr3Y8nKfaBRWcof
         JA30MA71489q6DZs6/tV5SEYwxstilgXsR8HhA5gJ9UhLS7w6h3v3WDfWBn6DryPVnmK
         fjgg==
X-Gm-Message-State: AA+aEWavVcG/wZADq+Bg+o6Xpj+u9lF0FmALQhoHMrzVQvhUGymW/PgM
        QDmnJBIv9OpUMHTUKYgJvZ6QApOVWI0=
X-Google-Smtp-Source: AFSGD/Vo9qR4hJB/Ck8HpKU7w5S21z5SsCGsK5ROeGyBcMLZ9N2Iyi/E94H7ipEwc0VAoMmvf+BG4g==
X-Received: by 2002:a0d:c045:: with SMTP id b66mr24859593ywd.321.1544052263421;
        Wed, 05 Dec 2018 15:24:23 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id w2sm16192607ywl.10.2018.12.05.15.24.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 15:24:22 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id l126so5687802ybf.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:24:20 -0800 (PST)
X-Received: by 2002:a81:28c7:: with SMTP id o190mr26842086ywo.288.1544052260165;
 Wed, 05 Dec 2018 15:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20181205092203.14105-1-christian@brauner.io> <87zhtjn8ck.fsf@xmission.com>
 <20181205205242.hxgba5opiapinj56@brauner.io>
In-Reply-To: <20181205205242.hxgba5opiapinj56@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Dec 2018 15:24:08 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJgYyhUBgzfkkcHGtu6AcC4MBpfwcEoj3M=Y+8q0FZ_dA@mail.gmail.com>
Message-ID: <CAGXu5jJgYyhUBgzfkkcHGtu6AcC4MBpfwcEoj3M=Y+8q0FZ_dA@mail.gmail.com>
Subject: Re: [PATCH v3] signal: add procfd_send_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 12:53 PM Christian Brauner <christian@brauner.io> wrote:
> On Wed, Dec 05, 2018 at 12:20:43PM -0600, Eric W. Biederman wrote:
> > Christian Brauner <christian@brauner.io> writes:
> > > [1]:  https://lkml.org/lkml/2018/11/18/130
> > > [2]:  https://lore.kernel.org/lkml/874lbtjvtd.fsf@oldenburg2.str.redhat.com/
> > > [3]:  https://lore.kernel.org/lkml/20181204132604.aspfupwjgjx6fhva@brauner.io/
> > > [4]:  https://lore.kernel.org/lkml/20181203180224.fkvw4kajtbvru2ku@brauner.io/
> > > [5]:  https://lore.kernel.org/lkml/20181121213946.GA10795@mail.hallyn.com/
> > > [6]:  https://lore.kernel.org/lkml/20181120103111.etlqp7zop34v6nv4@brauner.io/
> > > [7]:  https://lore.kernel.org/lkml/36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net/
> > > [8]:  https://lore.kernel.org/lkml/87tvjxp8pc.fsf@xmission.com/
> > > [9]:  https://asciinema.org/a/X1J8eGhe3vCfBE2b9TXtTaSJ7
> > > [10]: https://lore.kernel.org/lkml/20181203180224.fkvw4kajtbvru2ku@brauner.io/
> > > [11]: https://lore.kernel.org/lkml/F53D6D38-3521-4C20-9034-5AF447DF62FF@amacapital.net/

I nominate this for 2018's most-well-documented syscall commit log award. ;)

> > > +   /*
> > > +    * Give userspace a way to detect whether /proc/<pid>/task/<tid> fds
> > > +    * are supported.
> > > +    */
> > > +   ret = -EOPNOTSUPP;
> > > +   if (proc_is_tid_procfd(f.file))
> > > +           goto err;
> >
> >       -EBADF is the proper error code.
>
> This is done so that userspace has a way of figuring out that tid fds
> are not yet supported. This has been discussed with Florian (see commit
> message).

Right, we should keep this -EOPNOTSUPP.

> > > +   /* Is this a procfd? */
> > > +   ret = -EINVAL;
> > > +   if (!proc_is_tgid_procfd(f.file))
> > > +           goto err;
> >
> >       -EBADF is the proper error code.

Yeah, EINVAL tends to be used for bad flags... this is more about an
improper fd.

> >
> > > +   /* Without CONFIG_PROC_FS proc_pid() returns NULL. */
> > > +   pid = proc_pid(file_inode(f.file));
> > > +   if (!pid)
> > > +           goto err;
> >
> > Perhaps you want to fold the proc_pid into the proc_is_tgid_procfd
> > call.  That way proc_pid can stay private to proc.
>
> Hm, I guess we can do that for now. My intention was to have reuseable
> helpers but I guess it would be fine for now.
>
> >
> > > +   if (!may_signal_procfd(pid))
> > > +           goto err;
> > > +

Does the ns parent checking in may_signal_procfd need any locking or
RCU? I know pid and current namespaces are "pinned", but I don't know
how parent ns works here. I'm assuming the parents are stuck until all
children go away?

> > > +   ret = kill_pid_info(sig, &kinfo, pid);

Just double-checking for myself: this does not bypass
security_task_kill(), so no problem there AFAIK.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
