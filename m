Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A5BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B5C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKsoExOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B5C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeI2C72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:59:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44953 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeI2C70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:59:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id u74-v6so6508811oia.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHt/lgWncVAGygXgvQGfbpA+OiIHfFrsG9ps7/f+uLg=;
        b=NKsoExOpLzZVXtlBecfOnVeqXm17JgA8VeQUNdT2mYpWlveui2jEewWmFhbMyVHO9u
         Ivzll9n54GYuqSAuDiTHk9WI82sjvZHrR92uSYkA78HuFIelOmSWJJw70VNPjO8qZcML
         VKh3D99YoR6NY3muv5NL9p9TqkzbUniL/n8nlSMx1QjwAhqzubuVZPJvI0A4x0Dh9gjb
         9TO5OBUm/4dPq6ccvRYcxmROPF1vAIM3GJBRthetySw3NVl+j6ibLHuSuN0PwJTzg+Q+
         B7O55OdnekG4CTumubzUuEg8EAwFW2iXuGR3aTCd5EB5yYmnGdNVLV0KRI48r+zxiZwd
         HryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHt/lgWncVAGygXgvQGfbpA+OiIHfFrsG9ps7/f+uLg=;
        b=ro/zcaLyxYUN3SLz3++TFrRkuygJhhmMJO5a46BfPb6XvK8aNrjQuy5fPZNSAHsvKE
         iSi2NFDZC3ACImh2bVsCulH2XtdeP9GYvm5D7pdoTySB/cwQrwfz2mtDfPVWps1JB87b
         wy45FCzAz1tAevtGffeoCBQxt3NcWuhhzCEptgf3X3Z+sMnOXoXNvqyJq4Oy+KH/af+O
         sg5YDscy9o5zY3dsn7OdymMFpIByTfoPKSaczzj2Y04Q/B89k3pFeTLbkB8senAY//v4
         DSxmzdxT55zwyqyntw7GAzBWFUBIDWsZWs96jdXzExCvE+UjNbOG5eYKt9Qvgvji+KA+
         sxdw==
X-Gm-Message-State: ABuFfoiqbQjCv2KyhpEv8RCpMnXfpkKXSXpIxJ+ej9XKi4uH2hVOe/JX
        MZbAXb3AY6YDh38t5wecvNhl/iuyCvOVdNETRXbtZQ==
X-Google-Smtp-Source: ACcGV615EJU8uXvlxFHFbiY0Bl1xFevAU67L3XYXosIuQOFv+kUWMST2/PrloYr+D5EWy3c682BIckzGdpY1XFvbEpU=
X-Received: by 2002:aca:aa4f:: with SMTP id t76-v6mr150543oie.253.1538166840525;
 Fri, 28 Sep 2018 13:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180928154648.6320-1-tycho@tycho.ws> <20180928154648.6320-3-tycho@tycho.ws>
In-Reply-To: <20180928154648.6320-3-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Sep 2018 22:33:34 +0200
Message-ID: <CAG48ez2h51s1VG8hf1ASHHq88r5b+6rS4nSkgvre77jgsJLbhg@mail.gmail.com>
Subject: Re: [PATCH 3/3] seccomp: introduce read protection for struct seccomp
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 5:47 PM Tycho Andersen <tycho@tycho.ws> wrote:
> As Jann pointed out, there is a race between SECCOMP_FILTER_FLAG_TSYNC and
> the ptrace code that can inspect a filter of another process. Let's
> introduce read locking into the two ptrace accesses so that we don't race.

Hmm. Is that true? The ptrace code uses get_nth_filter(), which holds
the siglock while grabbing the seccomp filter and bumping its
refcount. And TSYNC happens from seccomp_set_mode_filter(), which
takes the siglock. So this looks okay to me?

> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> Reported-by: Jann Horn <jannh@google.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> ---
>  include/linux/seccomp.h |  4 ++--
>  kernel/seccomp.c        | 10 ++++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 8429bdda947a..30b27e898162 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -22,8 +22,8 @@ struct seccomp_filter;
>   * @filter: must always point to a valid seccomp-filter or NULL as it is
>   *          accessed without locking during system call entry.
>   *
> - *          @filter must only be accessed from the context of current as there
> - *          is no read locking.
> + *          @filter is read-protected by task->signal->cred_guard_mutex when
> + *          outside of current context.
>   */
>  struct seccomp {
>         int mode;
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index ef80dd19f268..f65d47650ac1 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1042,7 +1042,12 @@ int seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
>                 return -EACCES;
>         }
>
> +       ret = mutex_lock_killable(&task->signal->cred_guard_mutex);
> +       if (ret < 0)
> +               return ret;
> +
>         filter = get_nth_filter(task, filter_off);
> +       mutex_unlock(&task->signal->cred_guard_mutex);
>         if (IS_ERR(filter))
>                 return PTR_ERR(filter);
>
> @@ -1088,7 +1093,12 @@ int seccomp_get_metadata(struct task_struct *task,
>         if (copy_from_user(&kmd.filter_off, data, sizeof(kmd.filter_off)))
>                 return -EFAULT;
>
> +       ret = mutex_lock_killable(&task->signal->cred_guard_mutex);
> +       if (ret < 0)
> +               return ret;
> +
>         filter = get_nth_filter(task, kmd.filter_off);
> +       mutex_unlock(&task->signal->cred_guard_mutex);
>         if (IS_ERR(filter))
>                 return PTR_ERR(filter);
>
> --
> 2.17.1
>
