Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272CCC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B620220854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTvstewE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B620220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeIKJUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 05:20:30 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:43264 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeIKJUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 05:20:30 -0400
Received: by mail-yb1-f174.google.com with SMTP id k5-v6so8829563ybo.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 21:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BYMQ2ySUPiBl9ROCOkcbdqe2+vk8UUmJFidimNKOJMs=;
        b=bTvstewEsIGjQ+qoUhEK3m7LWfFO9n1B55J5y0zS+KI5mAr6cxp2xkKCrBBjV7+Tcw
         nSMzsw4T3p15Wd5he24JFGCFCv0kdBVQHHtzQ89YTJHKXSLAfSEvH3+suoh/9cxIhUBh
         UJ9i/e9PAkY7JA5ydGPoOdO2d1SKgdmO0zcxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BYMQ2ySUPiBl9ROCOkcbdqe2+vk8UUmJFidimNKOJMs=;
        b=cDK2vrT4KEzqFie/BGSVKiv0AP8o1rQFg+hAVLg8FJTPmKk8CZnGoHMWRWLb4/iapY
         k7754AZUosnzg7JQ+m8vt7qYgwQgnbyY5tNSqVQp9JHWHIFIK8X7j4VHTv0lqeFidbIs
         4BHOASB6bYfuXxrrbECwVi2ihfJ3AoxVXjux/d7iRPgFtZOxyuVKHvY/YyRLvER/YfoB
         H7kn4AiV/1DeuKT5lFepCwp+54IHJzcMDUE5XsfkTcWd1BTPjA7eDT1zibKZwLeZUsFR
         Nbk0j2OXNn/sfrwzQ3JBWRMEgb6PbFC7U/ribDvLo79IOwnmeAPrdH+/zmTIY2Oc+TVq
         tgbA==
X-Gm-Message-State: APzg51AV2C8XqPIIjp+7TAX1WE0jI0uI2IvvbH0fPqbu2IUrqZ5XCU7L
        GcAmEyKgw6Qt2JFHOOXkGTmQuuMrv/4=
X-Google-Smtp-Source: ANB0VdbzL9wr4P0XlFN1zNNtkuV1s7HQJmD9ab0X1wuzWHCfxPeCsLF5ebZFwwy1hIbH6gmtVogY8g==
X-Received: by 2002:a25:1c85:: with SMTP id c127-v6mr11347246ybc.148.1536639788093;
        Mon, 10 Sep 2018 21:23:08 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id u8-v6sm7342947ywl.59.2018.09.10.21.23.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 21:23:06 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id f145-v6so8841019ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 21:23:05 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr11671778ybz.410.1536639785464;
 Mon, 10 Sep 2018 21:23:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 21:23:04
 -0700 (PDT)
In-Reply-To: <20180910171822.GA27005@redhat.com>
References: <20180910122907.GA23963@redhat.com> <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
 <20180910171822.GA27005@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Sep 2018 21:23:04 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLWP4iKwTV3tBcV+nyZAU566qkknhODZdY_7o4p0zWVzQ@mail.gmail.com>
Message-ID: <CAGXu5jLWP4iKwTV3tBcV+nyZAU566qkknhODZdY_7o4p0zWVzQ@mail.gmail.com>
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

On Mon, Sep 10, 2018 at 10:18 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 09/10, Kees Cook wrote:
>>
>> > So get_arg_page() does
>> >
>> >                 /*
>> >                  * Since the stack will hold pointers to the strings, we
>> >                  * must account for them as well.
>> >                  *
>> >                  * The size calculation is the entire vma while each arg page is
>> >                  * built, so each time we get here it's calculating how far it
>> >                  * is currently (rather than each call being just the newly
>> >                  * added size from the arg page).  As a result, we need to
>> >                  * always add the entire size of the pointers, so that on the
>> >                  * last call to get_arg_page() we'll actually have the entire
>> >                  * correct size.
>> >                  */
>> >                 ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
>> >                 if (ptr_size > ULONG_MAX - size)
>> >                         goto fail;
>> >                 size += ptr_size;
>> >
>> > OK, but
>> >                 acct_arg_size(bprm, size / PAGE_SIZE);
>> >
>> > after that doesn't look exactly right. This additional space will be used later
>> > when the process already uses bprm->mm, right? so it shouldn't be accounted by
>> > acct_arg_size().
>>
>> My understanding (based on the comment about acct_arg_size()) is that
>> before exec_mmap() happens, the memory used to build the new arguments
>> copy memory area gets accounted to the MM_ANONPAGES resource limit of
>> the execing process.
>
> Yes, because otherwise oom-killer can't account the memory populated by
> get_arg_page() in bprm->mm.
>
>> I couldn't find any place where the argc/envc
>> pointers were being included in the count,
>
> But why??? To clarify,
>
>         size += ptr_size;
>
> after acct_arg_size() is clear and correct, we are going to check rlim_stack
> and thus the size should include the pointers we will add in create_elf_tables().
>
> But acct_arg_size() should only account the pages we allocate for bprm->mm,
> nothing more. create_elf_tables() does not allocate the memory when it populates
> arg_start/arg_end/env_start/env_end. Plus at this time the process has already
> switched to bprm->mm.

I've looked more closely now. So, while I agree with you about
resource limits, there's a corner case that is better handled here:
once we've called flush_old_exec(), we can no longer send errors back
to the parent. We just segfault. So, I think it's better to give a
resource limit error early, since it is able to do the math early.

If we move acct_arg_size() earlier, then the "immediate" resource
utilization is checked, but it means it can just segfault later. If we
leave it as-is, we account for later memory allocations "too early",
but we'll still not be able to run: but we can tell the parent why.

I prefer leave it as-is.

>> > Not to mention that ptr_size/PAGE_SIZE doesn't look right in any case...
>>
>> Hm? acct_arg_size() takes pages, not bytes. I think this is correct?
>> What doesn't look right to you?
>
> Please forget. I meant that _if_ we actually wanted to account this additional
> memory in bprm->pages, than we would probably need something like
> acct_arg_size(size/PAGE_SIZE + DIV_ROUND_UP(ptr_size, PAGE_SIZE)).

I'd need to study that more, but that change seems reasonable. :)

-Kees

-- 
Kees Cook
Pixel Security
