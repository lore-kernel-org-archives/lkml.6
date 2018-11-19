Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DAFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 00:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9D22086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 00:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="JaQlf0vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9D22086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeKSLCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:02:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41583 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeKSLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:02:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so13014466pgh.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 16:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HIAJ5A44ie0pl/XLi0oyLjmhS1mBYpcr/NQyaM+JtoA=;
        b=JaQlf0viQb4WyMuT0L+WQhPU+Z1JIWKYb8vuzRBkrkJXo+qOzVZB0GDn7t+mf44QeD
         rdXrbdLyRCa9NvGTlhbtiGwlmXJ7CTPPZenl3Q11F5d7r3l9/3CZnLiW9Y+q/vCxilYR
         KEgkFlSto8yFQbO0CGNFGa0dP+Ctz/g5xX4ZwRP3ARQnWMMUbBfwYzz3ry2OLmkd4+YR
         0b+g25UlXV6hisiPCb1wqYXZFWQmvkmdBakCzr6stMaK9k7oJRMzeLNxCv1cabnLjXsn
         64ceQeoii4QB1Is/OHFJqLuOYLp8Pxt9B1A4hybhrjEvtRV5H+mBgMoKLHFf4RoxbplE
         hzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HIAJ5A44ie0pl/XLi0oyLjmhS1mBYpcr/NQyaM+JtoA=;
        b=CIFu45J14Fgci8zH1CBeIqzYO0hL9vjivyD8HR2F5VCupgfOSe8tkMtgap+5APw7AU
         VL4LJoz4uxPUr/p6f+JQdDzMv/kGB0aLFXX11j18HF8sLC+owcKM8IMEESlU0+tdIrMi
         jsKRKH7adt6ixmTF9hyczovAUfcPk7vS82AA0y++l/DLUfaw4ANPWvx24ADCayoZ6538
         Et2YfZtak7HG7PkqjuHkXARQe4b3R8k3xSdpamHHPdw3QPveSNzUK0TruE8y1rr7j9yL
         EsesXbT9XKUiF7SrsSNIZPNvisP4PlwM/UF+tajRI92n1rBiHGGGrNYLbFtkzbEx25RL
         1SEQ==
X-Gm-Message-State: AGRZ1gLagUwuHUSjID/IUNg26JQSHcZCz9s3e8alLLdV3JBy7rUfR+/Q
        Yfaw7/FDZK1UZH5K2Aw2dTpI4w==
X-Google-Smtp-Source: AJdET5dIjewSVf+1w5L64qO9fLI4gSJ/0zZFxPUOfyzWUDIFBY6YIgNyPmKYmMQH/F+30vjQuthB/w==
X-Received: by 2002:aa7:8552:: with SMTP id y18mr21166799pfn.83.1542588048886;
        Sun, 18 Nov 2018 16:40:48 -0800 (PST)
Received: from brauner.io ([130.195.55.139])
        by smtp.gmail.com with ESMTPSA id m17-v6sm42967259pfi.102.2018.11.18.16.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 16:40:48 -0800 (PST)
Date:   Mon, 19 Nov 2018 01:40:39 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
Message-ID: <20181119004037.d4avmjyiooa7ujyf@brauner.io>
References: <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
 <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com>
 <20181118190504.ixglsqbn6mxkcdzu@yavin>
 <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
 <608F2959-800D-46EE-A7CD-8C972ACD2F02@amacapital.net>
 <20181118204317.seaztq7fqmysucns@brauner.io>
 <CAKOZueuWzu2GuJ-w3yb01P9uyO1WniKG+i=BUsweVdA-KgEjhw@mail.gmail.com>
 <20181118212336.53hh3qbjughrtc2l@brauner.io>
 <20181118213021.24asgwkci3do6oby@brauner.io>
 <CAKOZuetT8mzZJR-K_W0VM7Dg1c1SnH8tW-HXxMT77yS0DE453w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZuetT8mzZJR-K_W0VM7Dg1c1SnH8tW-HXxMT77yS0DE453w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 04:31:22PM -0800, Daniel Colascione wrote:
> On Sun, Nov 18, 2018 at 1:30 PM, Christian Brauner <christian@brauner.io> wrote:
> > On Sun, Nov 18, 2018 at 10:23:36PM +0100, Christian Brauner wrote:
> >> On Sun, Nov 18, 2018 at 12:54:10PM -0800, Daniel Colascione wrote:
> >> > On Sun, Nov 18, 2018 at 12:43 PM, Christian Brauner
> >> > <christian@brauner.io> wrote:
> >> > > On Sun, Nov 18, 2018 at 01:28:41PM -0700, Andy Lutomirski wrote:
> >> > >>
> >> > >>
> >> > >> > On Nov 18, 2018, at 12:44 PM, Daniel Colascione <dancol@google.com> wrote:
> >> > >> >
> >> > >>
> >> > >> >
> >> > >> > That is, I'm proposing an API that looks like this:
> >> > >> >
> >> > >> > int process_kill(int procfs_dfd, int signo, const union sigval value)
> >> > >> >
> >> > >> > If, later, process_kill were to *also* accept process-capability FDs,
> >> > >> > nothing would break.
> >> > >>
> >> > >> Except that this makes it ambiguous to the caller as to whether their current creds are considered.  So it would need to be a different syscall or at least a flag.  Otherwise a lot of those nice theoretical properties go away.
> >> > >
> >> > > I can add a flag argument
> >> > > int process_signal(int procfs_dfd, int signo, siginfo_t *info, int flags)
> >> > > The way I see it process_signal() should be equivalent to kill(pid, signal) for now.
> >> > > That is siginfo_t is cleared and set to:
> >> > >
> >> > > info.si_signo = sig;
> >> > > info.si_errno = 0;
> >> > > info.si_code = SI_USER;
> >> > > info.si_pid = task_tgid_vnr(current);
> >> > > info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
> >> >
> >> > That makes sense. I just don't want to get into a situation where
> >> > callers feel that they *have* to use the PID-based APIs to send a
> >> > signal because process_kill doesn't offer some bit of functionality.
> >>
> >> Yeah.
> >>
> >> >
> >> > Are you imagining something like requiring info t be NULL unless flags
> >> > contains some "I have a siginfo_t" value?
> >>
> >> Well, I was actually thinking about something like:
> >>
> >> /**
> >>  *  sys_process_signal - send a signal to a process trough a process file descriptor
> >>  *  @fd: the file descriptor of the process
> >>  *  @sig: signal to be sent
> >>  *  @info: the signal info
> >>  *  @flags: future flags to be passed
> >>  */
> >> SYSCALL_DEFINE4(process_signal, int, fd, int, sig, siginfo_t __user *, info,
> >>               int, flags)
> >> {
> >>       struct pid *pid;
> >>       struct fd *f;
> >>       kernel_siginfo_t kinfo;
> >>
> >>       /* Do not allow users to pass garbage. */
> >>       if (flags)
> >>               return -EINVAL;
> >>
> >>       int ret = __copy_siginfo_from_user(sig, &kinfo, info);
> >>       if (unlikely(ret))
> >>               return ret;
> >>
> >>       /* For now, enforce that caller's creds are used. */
> >>       kinfo.si_pid = task_tgid_vnr(current);
> >>       kinfo.si_uid = from_kuid_munged(current_user_ns(), current_uid());
> 
> How about doing it this way? If info is NULL, act like kill(2);
> otherwise, act like rt_sigqueueinfo(2).
> 
> (Not actual working or compiled code.)
> 
> SYSCALL_DEFINE4(process_signal, int, fd, int, sig, siginfo_t __user *, info,
>               int, flags)
> {
>         struct fd f = { 0 };
>         kernel_siginfo_t kinfo;
>         int ret;
> 
>         /* Make API extension possible.  */
>         ret = -EINVAL;
>         if (flags)
>                 goto out;
> 
>         ret = -EBADF;
>         f = fdget(fd);
>         if (!f.file)
>                 goto out;
> 
>         ret = mumble_mumble_check_real_proc_file(f.file);
>         if (ret)
>                 goto out;
> 
>         /* Act like kill(2) or rt_sigqueueinfo(2) depending on whether
>          * the user gave us a siginfo structure.
>          */
>         if (info) {
>                 ret = __copy_siginfo_from_user(sig, &kinfo, info);
>                 if (ret)
>                         goto out;
>                 /* Combine this logic with rt_sigqueueinfo(2) */
>                 ret = -EPERM;
>                 if ((info->si_code >= 0 || info->si_code == SI_TKILL) &&
>                     (task_pid_vnr(current) != pid))
>                         goto out;
> 
>         } else {
>                 /* Combine this logic with kill(2) */
>                 clear_siginfo(&kinfo);
>                 kinfo.si_signo = sig;
>                 kinfo.si_errno = 0;
>                 kinfo.si_code = SI_USER;
>                 kinfo.si_pid = task_tgid_vnr(current);
>                 kinfo.si_uid = from_kuid_munged(current_user_ns(),
> current_uid());
>         }
> 
>         ret = kill_pid_info(sig, &kinfo, proc_pid(file_inode(f.file)));
> 
> out:
>         if (f.file)
>                 fput(f);
>         return ret;
> }

Right, allowing to ass NULL might make sense. I had:

/**
 *  sys_process_signal - send a signal to a process trough a process file descriptor
 *  @fd: the file descriptor of the process
 *  @sig: signal to be sent
 *  @info: the signal info
 *  @flags: future flags to be passed
 */
SYSCALL_DEFINE4(procfd_kill, int, fd, int, sig, siginfo_t __user *, info, int, flags)
{
       int ret;
       struct pid *pid;
       kernel_siginfo_t kinfo;
       struct fd f;

       /* Do not allow users to pass garbage. */
       if (flags)
               return -EINVAL;

       ret = __copy_siginfo_from_user(sig, &kinfo, info);
       if (unlikely(ret))
               return ret;

       /* For now, enforce that caller's creds are used. */
       kinfo.si_pid = task_tgid_vnr(current);
       kinfo.si_uid = from_kuid_munged(current_user_ns(), current_uid());

       f = fdget_raw(fd);
       if (!f.file)
               return -EBADF;

       ret = -EINVAL;
       /* Is this a process file descriptor? */
       if (!proc_is_procfd(f.file) || !d_is_dir(f.file->f_path.dentry))
               goto err;

       pid = f.file->private_data;
       if (!pid)
               goto err;

       ret = -EPERM;
       /*
        * Not even root can pretend to send signals from the kernel.
        * Nor can they impersonate a kill()/tgkill(), which adds source info.
        */
       if ((kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL) &&
           (task_pid(current) != pid))
               goto err;

       ret = kill_pid_info(sig, &kinfo, pid);

err:
       fdput(f);
       return ret;
}
