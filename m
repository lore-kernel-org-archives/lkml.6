Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95459C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EA52146F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="grGLuWGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EA52146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeIMBs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:48:27 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35583 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeIMBs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:48:26 -0400
Received: by mail-yw1-f65.google.com with SMTP id 14-v6so256697ywe.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VsZo/nXj/fiiJNXtYIwYa4N2usOpOAc1d6dcVAbY6o8=;
        b=grGLuWGYD8ENUhJQwsy0BHvs36S8zxhrVIy1++xdOZfqJsvu24vIALMi+2JsJLjSAc
         NelTUNHMxJwnwKE2VEmhscVEQ0kaD7DemIse07zFTQjv0+DOMYzNiz7YaTPOIRxtEiG0
         BFru9iMINnz8Rdw3/0DmysqEVEWwJeHH/XOME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VsZo/nXj/fiiJNXtYIwYa4N2usOpOAc1d6dcVAbY6o8=;
        b=YvfOx22h2vy37UpF3EZdPVmOUjoSm+kL+FnMjP8E4Q1BNwT5Tzxd8RJ83JmoFGh4HL
         DNsxLGZ4s1lLeBVw+S0V0zIZcTuMjFHy/6D5/qBT+Y3yh3FQjQPK9eT/kEeu2OMcRkI3
         E2ue9jU/LvNMfvm/9VA4zFXL/NBZBxrYh1Wud2t5o1yHMTZ/gz9nY2UXKUo5y1FFHoCu
         lrZX17b9zN4MaYTNEZYZD2fkNpTYeykRIm4EfotI7aZLJvz3dA6o9ZJFtW95hr82laNl
         qGD/V9vGGksmii8yGsxhHTtFcw38AYZmChtnt5xuqoCSGZNzNm9kIBufeFNj5FG84OtS
         qLpQ==
X-Gm-Message-State: APzg51Bh18MkPH2SXzVtV0BcHlTRixfT3EpgrmaV02/hFQQTpwY3sny8
        kP0dgeVioq5ne+LyYF0X/9uuQ5k7xb4=
X-Google-Smtp-Source: ANB0Vdbhb1GR90yDebq0ADYe4SIkah73OvXpBD3fSDtBnE0Jf9x7rNuzg5knX9ZZhc+PItYhwglusA==
X-Received: by 2002:a81:a014:: with SMTP id x20-v6mr1897517ywg.468.1536784931046;
        Wed, 12 Sep 2018 13:42:11 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id d10-v6sm1841094ywh.87.2018.09.12.13.42.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 13:42:09 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id j8-v6so2334065ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 13:42:09 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr1882081ybz.410.1536784929117;
 Wed, 12 Sep 2018 13:42:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 13:42:08
 -0700 (PDT)
In-Reply-To: <20180912122702.GA16972@redhat.com>
References: <20180910122907.GA23963@redhat.com> <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
 <20180910171822.GA27005@redhat.com> <CAGXu5jLWP4iKwTV3tBcV+nyZAU566qkknhODZdY_7o4p0zWVzQ@mail.gmail.com>
 <20180911141318.GA30907@redhat.com> <CAGXu5jLYWUMFNFaWHTmn9qhArtw7rn376rLRjfg6cdrvYNKUTg@mail.gmail.com>
 <20180912122702.GA16972@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Sep 2018 13:42:08 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJUO+hQDYHyqO-nPo4A20HURY__RCeiOs7Z1WfNQk2jYw@mail.gmail.com>
Message-ID: <CAGXu5jJUO+hQDYHyqO-nPo4A20HURY__RCeiOs7Z1WfNQk2jYw@mail.gmail.com>
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

On Wed, Sep 12, 2018 at 5:27 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 09/11, Kees Cook wrote:
>>
>> Oh, I like this patch! This is much cleaner.
>
> it's pity. cause this means I will have to actually test this change and
> (worse) write the changelog ;)

Hehe. I know this pain well! :)

>> > @@ -410,11 +365,6 @@ static int bprm_mm_init(struct linux_binprm *bprm)
>> >         if (!mm)
>> >                 goto err;
>> >
>> > -       /* Save current stack limit for all calculations made during exec. */
>> > -       task_lock(current->group_leader);
>> > -       bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
>> > -       task_unlock(current->group_leader);
>> > -
>>
>> I would prefer this hunk stay here since it will be more robust
>> against weird arch-specific things happening against rlim_stack. I had
>> to clean up some of these tests in arch code, so I'm nervous about
>> moving this further away. Here is before we call arch_bprm_mm_init(),
>> and I think it's better to do this as early as possible.
>
> Well, I don't reaally agree but I won't argue, this is cosmetic at least
> right now.

Probably what it deserves is a better comment to capture what I said
above. Maybe:

-    /* Save current stack limit for all calculations made during exec. */
+    /* Do this before any arch-specific calls, like arch_bprm_mm_init(),
+     * so that bprm->rlim_stack is available for the architecture to use
+     * in case it needs it earlier that mm layout time.
+     */

>> BTW, in re-reading create_elf_tables() and its calculation of "items",
>> I realize the above should actually include the trailing NULL pointers
>> and argc, so it should be:
>>
>> ptr_size = (1 + bprm->argc + 1 + bprm->envc + 1) * sizeof(void *);
>
> Yes, I noticed this too. But can we do this later please?

Sure!

>> > -       unsigned long p; /* current top of mem */
>> > +       unsigned long p, p_min; /* current top of mem */
>>
>> Can you split this out to a separate line (with a new comment) to
>> avoid comment-confusion? Something like:
>>
>> unsigned long p; /* current top of mem */
>> unsigned long p_min; /* the minimum allowed mem position */
>
> OK, but "minimum allowed mem position" explains nothing... The comment
> should explain that ->p_min (can you suggest a better name?) is artificial
> marker pre-computed for rlim-like checks in copy_strings()...

How about something like:

... p; /* top of memory array reserved for stack */
... p_min; /* bottom of stack as computed in prepare_arg_pages() */

(Is "p" really only used for stack reservation tracking?)

> BTW. I think we can simply kill count(). But this needs another cleanup
> and dicsussion.

Hm, I think we need count for doing the sanity checking and allowing
the cond_resched() calls.

-Kees

-- 
Kees Cook
Pixel Security
