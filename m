Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EC1C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D218E20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D218E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeILRbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:31:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbeILRbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:31:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1918040200B3;
        Wed, 12 Sep 2018 12:27:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5921FB300C;
        Wed, 12 Sep 2018 12:27:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 12 Sep 2018 14:27:05 +0200 (CEST)
Date:   Wed, 12 Sep 2018 14:27:02 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: get_arg_page() && ptr_size accounting
Message-ID: <20180912122702.GA16972@redhat.com>
References: <20180910122907.GA23963@redhat.com>
 <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
 <20180910171822.GA27005@redhat.com>
 <CAGXu5jLWP4iKwTV3tBcV+nyZAU566qkknhODZdY_7o4p0zWVzQ@mail.gmail.com>
 <20180911141318.GA30907@redhat.com>
 <CAGXu5jLYWUMFNFaWHTmn9qhArtw7rn376rLRjfg6cdrvYNKUTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLYWUMFNFaWHTmn9qhArtw7rn376rLRjfg6cdrvYNKUTg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 12 Sep 2018 12:27:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 12 Sep 2018 12:27:06 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11, Kees Cook wrote:
>
> Oh, I like this patch! This is much cleaner.

it's pity. cause this means I will have to actually test this change and
(worse) write the changelog ;)

> > @@ -410,11 +365,6 @@ static int bprm_mm_init(struct linux_binprm *bprm)
> >         if (!mm)
> >                 goto err;
> >
> > -       /* Save current stack limit for all calculations made during exec. */
> > -       task_lock(current->group_leader);
> > -       bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
> > -       task_unlock(current->group_leader);
> > -
>
> I would prefer this hunk stay here since it will be more robust
> against weird arch-specific things happening against rlim_stack. I had
> to clean up some of these tests in arch code, so I'm nervous about
> moving this further away. Here is before we call arch_bprm_mm_init(),
> and I think it's better to do this as early as possible.

Well, I don't reaally agree but I won't argue, this is cosmetic at least
right now.

> > +static int prepare_rlim_stack(struct linux_binprm *bprm)
>
> How about collapsing this with:
>
>         bprm->argc = count(argv, MAX_ARG_STRINGS);
>         if ((retval = bprm->argc) < 0)
>                 goto out;
>
>         bprm->envc = count(envp, MAX_ARG_STRINGS);
>         if ((retval = bprm->envc) < 0)
>                 goto out;
>
> and call it prepare_arg_count(struct linux_binprm *bprm,
>                                                 struct user_arg_ptr argv,
>                                                 struct user_arg_ptr envp)

OK, agreed,

> Let's try to retain the comments here:

Yes, sure, I wasn't going to remove the comments,

> > +       /* COMMENT */
>
> This comment should likely be something like:
>
> /*
>  * We must account for the size of all the argv and envp pointers to
>  * the argv and envp strings, since they will also take up space in
>  * the stack. They aren't stored until much later when we can't
>  * signal to the parent that the child has run out of stack space.
>  * Instead, calculate it here so it's possible to fail gracefully.
>  */

Thanks!

> > +       ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
>
> BTW, in re-reading create_elf_tables() and its calculation of "items",
> I realize the above should actually include the trailing NULL pointers
> and argc, so it should be:
>
> ptr_size = (1 + bprm->argc + 1 + bprm->envc + 1) * sizeof(void *);

Yes, I noticed this too. But can we do this later please?

Firstly, this change needs a special note in the changelog, and thus I
think a separate patch makes more sense.

And in fact I am not sure we really care about "small" O(1) errors in
ptr_size calculations.

> > -       unsigned long p; /* current top of mem */
> > +       unsigned long p, p_min; /* current top of mem */
>
> Can you split this out to a separate line (with a new comment) to
> avoid comment-confusion? Something like:
>
> unsigned long p; /* current top of mem */
> unsigned long p_min; /* the minimum allowed mem position */

OK, but "minimum allowed mem position" explains nothing... The comment
should explain that ->p_min (can you suggest a better name?) is artificial
marker pre-computed for rlim-like checks in copy_strings()...

> I've also spent some more time convincing myself again that there
> aren't races between count(), copy_strings(), and create_elf_tables().

Yes, I thought about this too, do not see anything dangerous.

BTW. I think we can simply kill count(). But this needs another cleanup
and dicsussion.

Thanks for review!

Oleg.

