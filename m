Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8985C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A252150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgwWzmot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A252150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeHXAyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbeHXAyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:54:37 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62F42156E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 21:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535059383;
        bh=6iyZlt4KiN+lUjaO4pxddcinI32T/sNk2ItbRWpsmAY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=KgwWzmotNcNSazR9D60oCH0oTiiZkr5gtC/2x4Q7IbZKFGe0S5XAPjsTvQ7TKTElS
         PiHSiZJ5cY6+abQtwBlV/o2Y9QQHt3P6OZhdzBh1KXEqXJ1vy4cRYUYb6dg7Epd6n6
         RP94sOxY3y8N1PuKgO/lSMxhMXPdrCVbW0Qubg3U=
Received: by mail-wm0-f50.google.com with SMTP id n11-v6so7198266wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 14:23:02 -0700 (PDT)
X-Gm-Message-State: APzg51DLN2DyfHQda4mp+Pu769agx0sHi45cB9zXG9PsJXuv8InHm0wC
        DXxUjttZFx8s1VYtXsOlkuRHxRzHr0faU5Ls0SHeNw==
X-Google-Smtp-Source: ANB0VdYIanHlZUbehK8H+ZUbSRnEHi4SVv23o31G3NB+J5KAFNy5NQ4xQpBEYSG5cigvUd+uAOArKrUvDGyXIL/MEFw=
X-Received: by 2002:a1c:3413:: with SMTP id b19-v6mr6677646wma.21.1535059381210;
 Thu, 23 Aug 2018 14:23:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 14:22:40 -0700 (PDT)
In-Reply-To: <CAG48ez1B1pqCdsEtNLpCBHHzNnqnpvkHkxF2TDNqe9fgF6Ozbg@mail.gmail.com>
References: <CAG48ez1B1pqCdsEtNLpCBHHzNnqnpvkHkxF2TDNqe9fgF6Ozbg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 23 Aug 2018 14:22:40 -0700
X-Gmail-Original-Message-ID: <CALCETrWMetDLhrTUk=7eo6R7ZgdKdaDccji3AvuX6K6D1ExTmg@mail.gmail.com>
Message-ID: <CALCETrWMetDLhrTUk=7eo6R7ZgdKdaDccji3AvuX6K6D1ExTmg@mail.gmail.com>
Subject: Re: rewind_stack_do_exit + KASAN incompatibility
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 1:59 PM, Jann Horn <jannh@google.com> wrote:
> Some while back (commit 2deb4be28077 ("x86/dumpstack: When OOPSing,
> rewind the stack before do_exit()")), Andy added
> rewind_stack_do_exit(), which is used in kernel oops handling to
> discard the current stack contents and reset the stack pointer,
> ensuring that the whole kernel stack is available for do_exit().
> However, this code isn't integrated with KASAN.
>
> Sometimes, when ASAN enters a function, it poisons parts of the
> newly-allocated stack frame; on function exit, it un-poisons that
> memory. ASAN does not, in general, unpoison stack memory on function
> entry; instead, it is assumed that unallocated stack memory is not
> poisoned.
>
> This means that after rewind_stack_do_exit() has rewound the stack,
> random parts of the stack are left poisoned, and when you try to
> access those, KASAN spews random false-positives. I'm currently
> working on adding some new kernel code, including an LKDTM testcase,
> and running that testcase generated the following spew - the first
> oops is intended, but the KASAN report after it is, from what I can
> tell, garbage.
>
> I'm not very familiar with KASAN internals, but I think a call to
> kasan_unpoison_task_stack(current) in the right place should solve the
> issue. I'm not entirely sure about where the call should be coming
> from - probably from inside rewind_stack_do_exit()? But I'm not sure
> whether it's possible to do this after rewinding the stack pointer
> (which would require kasan_unpoison_task_stack(), including all
> callees, to be uninstrumented), or whether it would have to happen
> before rewinding the stack pointer.

Looking at the KASAN code, it looks like the whole file full of those
helpers is uninstrumented, so you should be able to do it however you
like.  The easiest way may be to copy this into rewind_stack_do_exit
from wakeup_64.S:

#ifdef CONFIG_KASAN
        /*
         * The suspend path may have poisoned some areas deeper in the stack,
         * which we now need to unpoison.
         */
        movq    %rsp, %rdi
        call    kasan_unpoison_task_stack_below
#endif

except you'd change the comment.

--Andy
