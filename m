Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F84C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6613820865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EdmwPOGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6613820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeILAGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:06:50 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39567 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeILAGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:06:50 -0400
Received: by mail-yw1-f65.google.com with SMTP id m62-v6so9648289ywd.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W7nlcs+/YlS2ee0x1XDkoyJurwqVPPERSnl7mfAGHF4=;
        b=EdmwPOGsMn2BZmNw/llccS+fJMlnQHITQMQ0N/fVeeh5fjlFnBKPauIEoP9keofSLF
         KJWwqF72Ck8svcvkK/51Dtu4opPE34neo8cXJP+bZEvHe2dZhWYO1Y87eMrANOrHVwJs
         3djMng8BOiGoSo3GngxllU7MTeeO0QPl3wmBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W7nlcs+/YlS2ee0x1XDkoyJurwqVPPERSnl7mfAGHF4=;
        b=IXjc99T2UkcxDwe4FhhzfSxIqc2odUMicyVbGGqpzEYOeFaYSBf1F96tBL9Yoew1UE
         JGifz/FR4kWPVvEikJy5Gxy2Vnx7JyxuZi2TgKhDG1VUxRefdpkk4Ycn7ssPyvnJIbgR
         LNsJH43ClO0jGWDN6emlVf4L/sghv9Vl+lonKe0b1boupJbwFkshxha6EqNXg8prwDsv
         NVWuz7Xlc91BCOPC4NW4bBF/NDmjSldy36PfU36/x8DENDaQCtEefWIgxYwgk4f/LrxI
         XpMy+AP5p+KpOHuwQMjxxgcKm+tiYR5EW+slWPB85gvxJEmvknSGkeDGH6IywuS9GUrE
         m/fg==
X-Gm-Message-State: APzg51CG987luFBln9cwrUmXnlVQLwu2XtOx7N6KBNsVBw+fnJokc7tn
        LJdN7EgOaNFnMAxR+RZrPrNqiKHAydw=
X-Google-Smtp-Source: ANB0VdbjKqyPLBmfNkfWSHt1s0XjVrngim9T+p+L8XMgnvROn/IJougdgkK4MuA3JyyUB0Eo3Vc9RA==
X-Received: by 2002:a81:9382:: with SMTP id k124-v6mr13639496ywg.15.1536692768276;
        Tue, 11 Sep 2018 12:06:08 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id c124-v6sm6443165ywe.47.2018.09.11.12.06.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 12:06:06 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id t71-v6so9756778ybi.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:06:06 -0700 (PDT)
X-Received: by 2002:a25:7d44:: with SMTP id y65-v6mr13594258ybc.421.1536692766078;
 Tue, 11 Sep 2018 12:06:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 12:06:05
 -0700 (PDT)
In-Reply-To: <20180911141318.GA30907@redhat.com>
References: <20180910122907.GA23963@redhat.com> <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
 <20180910171822.GA27005@redhat.com> <CAGXu5jLWP4iKwTV3tBcV+nyZAU566qkknhODZdY_7o4p0zWVzQ@mail.gmail.com>
 <20180911141318.GA30907@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Sep 2018 12:06:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLYWUMFNFaWHTmn9qhArtw7rn376rLRjfg6cdrvYNKUTg@mail.gmail.com>
Message-ID: <CAGXu5jLYWUMFNFaWHTmn9qhArtw7rn376rLRjfg6cdrvYNKUTg@mail.gmail.com>
Subject: Re: get_arg_page() && ptr_size accounting
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I like this patch! This is much cleaner. Notes below...

On Tue, Sep 11, 2018 at 7:13 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> diff --git a/fs/exec.c b/fs/exec.c
> index 1ebf6e5..7804a5c 100644
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
> @@ -410,11 +365,6 @@ static int bprm_mm_init(struct linux_binprm *bprm)
>         if (!mm)
>                 goto err;
>
> -       /* Save current stack limit for all calculations made during exec. */
> -       task_lock(current->group_leader);
> -       bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
> -       task_unlock(current->group_leader);
> -

I would prefer this hunk stay here since it will be more robust
against weird arch-specific things happening against rlim_stack. I had
to clean up some of these tests in arch code, so I'm nervous about
moving this further away. Here is before we call arch_bprm_mm_init(),
and I think it's better to do this as early as possible.

>         err = __bprm_mm_init(bprm);
>         if (err)
>                 goto err;
> @@ -492,6 +442,27 @@ static int count(struct user_arg_ptr argv, int max)
>         return i;
>  }
>
> +static int prepare_rlim_stack(struct linux_binprm *bprm)

How about collapsing this with:

        bprm->argc = count(argv, MAX_ARG_STRINGS);
        if ((retval = bprm->argc) < 0)
                goto out;

        bprm->envc = count(envp, MAX_ARG_STRINGS);
        if ((retval = bprm->envc) < 0)
                goto out;

and call it prepare_arg_count(struct linux_binprm *bprm,
                                                struct user_arg_ptr argv,
                                                struct user_arg_ptr envp)

> +{
> +       unsigned long limit, ptr_size;
> +
> +       task_lock(current->group_leader);
> +       bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
> +       task_unlock(current->group_leader);
> +

Let's try to retain the comments here:

               /*
                * Limit to 1/4 of the max stack size or 3/4 of _STK_LIM
                * (whichever is smaller) for the argv+env strings.
                * This ensures that:
                *  - the remaining binfmt code will not run out of stack space,
                *  - the program will have a reasonable amount of stack left
                *    to work from.
                */
> +       limit = _STK_LIM / 4 * 3;
> +       limit = min(limit, bprm->rlim_stack.rlim_cur / 4);

and here:

               /*
                * We've historically supported up to 32 pages (ARG_MAX)
                * of argument strings even with small stacks
                */
> +       limit = max(limit, (unsigned long)ARG_MAX);
> +       /* COMMENT */

This comment should likely be something like:

/*
 * We must account for the size of all the argv and envp pointers to
 * the argv and envp strings, since they will also take up space in
 * the stack. They aren't stored until much later when we can't
 * signal to the parent that the child has run out of stack space.
 * Instead, calculate it here so it's possible to fail gracefully.
 */

> +       ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);

BTW, in re-reading create_elf_tables() and its calculation of "items",
I realize the above should actually include the trailing NULL pointers
and argc, so it should be:

ptr_size = (1 + bprm->argc + 1 + bprm->envc + 1) * sizeof(void *);

> +       if (limit <= ptr_size)
> +               return -E2BIG;
> +       limit -= ptr_size;
> +
> +       bprm->p_min = bprm->p - limit;
> +       return 0;
> +}
> +
>  /*
>   * 'copy_strings()' copies argument/environment strings from the old
>   * processes's memory to the new process's stack.  The call to get_user_pages()
> @@ -527,6 +498,8 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>                 pos = bprm->p;
>                 str += len;
>                 bprm->p -= len;
> +               if (bprm->p <= bprm->p_min)
> +                       goto out;
>
>                 while (len > 0) {
>                         int offset, bytes_to_copy;
> @@ -1801,6 +1774,10 @@ static int __do_execve_file(int fd, struct filename *filename,
>         if (retval < 0)
>                 goto out;
>
> +       retval = prepare_rlim_stack(bprm);
> +       if (retval < 0)
> +               goto out;
> +
>         retval = copy_strings_kernel(1, &bprm->filename, bprm);
>         if (retval < 0)
>                 goto out;
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index c05f24f..423e8c1 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -24,7 +24,7 @@ struct linux_binprm {
>         struct page *page[MAX_ARG_PAGES];
>  #endif
>         struct mm_struct *mm;
> -       unsigned long p; /* current top of mem */
> +       unsigned long p, p_min; /* current top of mem */

Can you split this out to a separate line (with a new comment) to
avoid comment-confusion? Something like:

unsigned long p; /* current top of mem */
unsigned long p_min; /* the minimum allowed mem position */

>         unsigned int
>                 /*
>                  * True after the bprm_set_creds hook has been called once
>

I've also spent some more time convincing myself again that there
aren't races between count(), copy_strings(), and create_elf_tables().
A malicious parent would only be able to zero-fill the stack of the
child, but not escape the counts that I can see.

-Kees

-- 
Kees Cook
Pixel Security
