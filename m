Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22472C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FCF2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vZ+ZWZ7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FCF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbeKTCJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbeKTCJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:09:17 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A56D02086A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542642318;
        bh=Tcw/Wo+m3ueEd6NFGRGwrQwdl9NMGltANmuS+G5q8ak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vZ+ZWZ7SLRauoYx7RIv9A6G+lE60jWXTVX1zPgT/vJcinyvVoSUGPnJl20qMR5Vps
         IPrn0oQK4dieRYQYkwjF1sD1peH+TDOJ5d8DHQEnq/jqMN6VGalZNdOTW/eQCZv3PY
         lbu9FpF9E7CGYi2EXNnIzcnFmUiM7y930Ruvo2B4=
Received: by mail-wm1-f43.google.com with SMTP id 125so3805447wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 07:45:18 -0800 (PST)
X-Gm-Message-State: AA+aEWbCz9k/K997Rh4xcVge1/8wUXM8/GwMu7uIr4TYi8Q86niyb+N6
        bPM1ToAODVzB58d8hZBZMKUayBmCpe7O6yMoUv5Byg==
X-Google-Smtp-Source: AJdET5dNcsTeEWeqcBxC4Goi3HrHQ13lIvie1Zw7k89BhmfznqJA2b2hIgcJW99v028kM3OIu3gbMlblkGor6qcPy4E=
X-Received: by 2002:a1c:110b:: with SMTP id 11mr4827999wmr.83.1542642317128;
 Mon, 19 Nov 2018 07:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-3-christian@brauner.io>
In-Reply-To: <20181119103241.5229-3-christian@brauner.io>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 19 Nov 2018 07:45:04 -0800
X-Gmail-Original-Message-ID: <CALCETrUY=Hk6=BjgPuDBgj5J1T_b5Q5u1uVOWHjGWXwmHoZBEQ@mail.gmail.com>
Message-ID: <CALCETrUY=Hk6=BjgPuDBgj5J1T_b5Q5u1uVOWHjGWXwmHoZBEQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 2:33 AM Christian Brauner <christian@brauner.io> wrote:
>
> The kill() syscall operates on process identifiers. After a process has
> exited its pid can be reused by another process. If a caller sends a signal
> to a reused pid it will end up signaling the wrong process. This issue has
> often surfaced and there has been a push [1] to address this problem.
>
> A prior patch has introduced the ability to get a file descriptor
> referencing struct pid by opening /proc/<pid>. This guarantees a stable
> handle on a process which can be used to send signals to the referenced
> process. Discussion has shown that a dedicated syscall is preferable over
> ioctl()s. Thus, the  new syscall procfd_signal() is introduced to solve
> this problem. It operates on a process file descriptor.
> The syscall takes an additional siginfo_t and flags argument. If siginfo_t
> is NULL then procfd_signal() behaves like kill() if it is not NULL it
> behaves like rt_sigqueueinfo.
> The flags argument is added to allow for future extensions of this syscall.
> It currently needs to be passed as 0.

A few questions.  First: you've made this work on /proc/PID, but
should it also work on /proc/PID/task/TID to send signals to a
specific thread?

> +bool proc_is_procfd(const struct file *file)
> +{
> +       return d_is_dir(file->f_path.dentry) &&
> +              (file->f_op == &proc_tgid_base_operations);
> +}

Maybe rename to proc_is_tgid_procfd() to leave room for proc_is_tid_procfd()?

> +       if (info) {
> +               ret = __copy_siginfo_from_user(sig, &kinfo, info);
> +               if (unlikely(ret))
> +                       goto err;
> +               /*
> +                * Not even root can pretend to send signals from the kernel.
> +                * Nor can they impersonate a kill()/tgkill(), which adds
> +                * source info.
> +                */
> +               ret = -EPERM;
> +               if ((kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL) &&
> +                   (task_pid(current) != pid))
> +                       goto err;

Is the exception for signaling yourself actually useful here?
