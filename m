Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7399C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564082089F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K5o1tmJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564082089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbeKNJMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:12:42 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46936 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNJMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:12:42 -0500
Received: by mail-yw1-f68.google.com with SMTP id t13so2342834ywe.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 15:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oNRmVuVrKG20e9jr6EoIZ/cSw2DsSCbLw8t8ZyDKGyw=;
        b=K5o1tmJhleQ4W6S89xWNEW4uyymHrsh87lDxf723VMQkCCvTPH5UDzSIdDaWSnUfVs
         r2wSDr5ms8XpzOB89oRLu/GTdsnkb5d9CrmhDPyMqpMk7N8fSONCfnryW3boHQtsPSDh
         kypkzfCTsnFkN4Ql407ckeWUOVT0Hy4QvGkKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oNRmVuVrKG20e9jr6EoIZ/cSw2DsSCbLw8t8ZyDKGyw=;
        b=gPylAOMvXmcnWcfFBbJ1CFH9dE2SsOPsQZAJ0DQ91ZMQCZKh1nXiMXZDXA+AIEXRcF
         u9IqoDiMqYmP5TZv4XGcYgRAajWvBAsXT46zK3m4YIN98YQ9PmpjlRRc2JaFgZsoJzfy
         IodretMVJ5oXC69neb4UtlHbNFCeP+ZrmCv89Mc0Y8ZdsnsdhTFiXsOadFjQGRwb5dIW
         89qNnZix+tswLOk6pp1b+0Kt49HcYLyJisSQb4qujcTDya1GhZ9iDIyDLsttM2YiGd5B
         mi9BEOEig1xCzdM42BL7VX40sAxNG3aICTPcDAqez9fIobhfTf1p3mcUVFNFW9CJi7Vt
         jPjQ==
X-Gm-Message-State: AGRZ1gI/3lsMnRsTvUumlqU0Fp6qKnDj4Aggxi3I17atXKTrU+JmtSBt
        +Z4vEU7q/BAp41yBmjCQlrV3q6+gm10=
X-Google-Smtp-Source: AJdET5fsCQ0m2shrT0ul6lPqPM/Tv4DXEjqx4aY3rrtOkV70sO2EnWF8PNdefNDdqbcfuZsOMfP7zQ==
X-Received: by 2002:a0d:ec91:: with SMTP id v139-v6mr2624040ywe.384.1542150733343;
        Tue, 13 Nov 2018 15:12:13 -0800 (PST)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id x189-v6sm4135052ywd.76.2018.11.13.15.12.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 15:12:12 -0800 (PST)
Received: by mail-yw1-f46.google.com with SMTP id x2so98739ywc.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 15:12:12 -0800 (PST)
X-Received: by 2002:a0d:cd84:: with SMTP id p126-v6mr7116312ywd.288.1542150731799;
 Tue, 13 Nov 2018 15:12:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 13 Nov 2018 15:12:11
 -0800 (PST)
In-Reply-To: <20181112160910.GA28440@redhat.com>
References: <20181112160910.GA28440@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 13 Nov 2018 17:12:11 -0600
X-Gmail-Original-Message-ID: <CAGXu5jKzwmTV-45cxLPwif9Uc1SyFjyhe+VjG3vK=VTtAbWTgw@mail.gmail.com>
Message-ID: <CAGXu5jKzwmTV-45cxLPwif9Uc1SyFjyhe+VjG3vK=VTtAbWTgw@mail.gmail.com>
Subject: Re: [PATCH] exec: separate MM_ANONPAGES and RLIMIT_STACK accounting
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 10:09 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> get_arg_page() checks bprm->rlim_stack.rlim_cur and re-calculates the
> "extra" size for argv/envp pointers every time, this is a bit ugly and
> even not strictly correct: acct_arg_size() must not account this size.
>
> Remove all the rlimit code in get_arg_page(). Instead, add bprm->argmin
> calculated once at the start of __do_execve_file() and change copy_strings
> to check bprm->p >= bprm->argmin.
>
> The patch adds the new helper, prepare_arg_pages() which initializes
> bprm->argc/envc and bprm->argmin.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

Thanks for nailing this all down. :)

-Kees

> ---
>  fs/exec.c               | 103 +++++++++++++++++++++++-------------------------
>  include/linux/binfmts.h |   1 +
>  2 files changed, 51 insertions(+), 53 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index fc281b7..61a5460 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -218,55 +218,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
>         if (ret <= 0)
>                 return NULL;
>
> -       if (write) {
> -               unsigned long size = bprm->vma->vm_end - bprm->vma->vm_start;
> -               unsigned long ptr_size, limit;
> -
> -               /*
> -                * Since the stack will hold pointers to the strings, we
> -                * must account for them as well.
> -                *
> -                * The size calculation is the entire vma while each arg page is
> -                * built, so each time we get here it's calculating how far it
> -                * is currently (rather than each call being just the newly
> -                * added size from the arg page).  As a result, we need to
> -                * always add the entire size of the pointers, so that on the
> -                * last call to get_arg_page() we'll actually have the entire
> -                * correct size.
> -                */
> -               ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
> -               if (ptr_size > ULONG_MAX - size)
> -                       goto fail;
> -               size += ptr_size;
> -
> -               acct_arg_size(bprm, size / PAGE_SIZE);
> -
> -               /*
> -                * We've historically supported up to 32 pages (ARG_MAX)
> -                * of argument strings even with small stacks
> -                */
> -               if (size <= ARG_MAX)
> -                       return page;
> -
> -               /*
> -                * Limit to 1/4 of the max stack size or 3/4 of _STK_LIM
> -                * (whichever is smaller) for the argv+env strings.
> -                * This ensures that:
> -                *  - the remaining binfmt code will not run out of stack space,
> -                *  - the program will have a reasonable amount of stack left
> -                *    to work from.
> -                */
> -               limit = _STK_LIM / 4 * 3;
> -               limit = min(limit, bprm->rlim_stack.rlim_cur / 4);
> -               if (size > limit)
> -                       goto fail;
> -       }
> +       if (write)
> +               acct_arg_size(bprm, vma_pages(bprm->vma));
>
>         return page;
> -
> -fail:
> -       put_page(page);
> -       return NULL;
>  }
>
>  static void put_arg_page(struct page *page)
> @@ -492,6 +447,50 @@ static int count(struct user_arg_ptr argv, int max)
>         return i;
>  }
>
> +static int prepare_arg_pages(struct linux_binprm *bprm,
> +                       struct user_arg_ptr argv, struct user_arg_ptr envp)
> +{
> +       unsigned long limit, ptr_size;
> +
> +       bprm->argc = count(argv, MAX_ARG_STRINGS);
> +       if (bprm->argc < 0)
> +               return bprm->argc;
> +
> +       bprm->envc = count(envp, MAX_ARG_STRINGS);
> +       if (bprm->envc < 0)
> +               return bprm->envc;
> +
> +       /*
> +        * Limit to 1/4 of the max stack size or 3/4 of _STK_LIM
> +        * (whichever is smaller) for the argv+env strings.
> +        * This ensures that:
> +        *  - the remaining binfmt code will not run out of stack space,
> +        *  - the program will have a reasonable amount of stack left
> +        *    to work from.
> +        */
> +       limit = _STK_LIM / 4 * 3;
> +       limit = min(limit, bprm->rlim_stack.rlim_cur / 4);
> +       /*
> +        * We've historically supported up to 32 pages (ARG_MAX)
> +        * of argument strings even with small stacks
> +        */
> +       limit = max(limit, (unsigned long)ARG_MAX);
> +       /*
> +        * We must account for the size of all the argv and envp pointers to
> +        * the argv and envp strings, since they will also take up space in
> +        * the stack. They aren't stored until much later when we can't
> +        * signal to the parent that the child has run out of stack space.
> +        * Instead, calculate it here so it's possible to fail gracefully.
> +        */
> +       ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
> +       if (limit <= ptr_size)
> +               return -E2BIG;
> +       limit -= ptr_size;
> +
> +       bprm->argmin = bprm->p - limit;
> +       return 0;
> +}
> +
>  /*
>   * 'copy_strings()' copies argument/environment strings from the old
>   * processes's memory to the new process's stack.  The call to get_user_pages()
> @@ -527,6 +526,8 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>                 pos = bprm->p;
>                 str += len;
>                 bprm->p -= len;
> +               if (bprm->p < bprm->argmin)
> +                       goto out;
>
>                 while (len > 0) {
>                         int offset, bytes_to_copy;
> @@ -1789,12 +1790,8 @@ static int __do_execve_file(int fd, struct filename *filename,
>         if (retval)
>                 goto out_unmark;
>
> -       bprm->argc = count(argv, MAX_ARG_STRINGS);
> -       if ((retval = bprm->argc) < 0)
> -               goto out;
> -
> -       bprm->envc = count(envp, MAX_ARG_STRINGS);
> -       if ((retval = bprm->envc) < 0)
> +       retval = prepare_arg_pages(bprm, argv, envp);
> +       if (retval < 0)
>                 goto out;
>
>         retval = prepare_binprm(bprm);
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index e9f5fe6..03200a8 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -25,6 +25,7 @@ struct linux_binprm {
>  #endif
>         struct mm_struct *mm;
>         unsigned long p; /* current top of mem */
> +       unsigned long argmin; /* rlimit marker for copy_strings() */
>         unsigned int
>                 /*
>                  * True after the bprm_set_creds hook has been called once
> --
> 2.5.0
>
>



-- 
Kees Cook
