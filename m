Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeBLRDK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:03:10 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35603 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbeBLRDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:03:08 -0500
X-Google-Smtp-Source: AH8x225klrf4bkdYaRbMaDRpNEcgyGc96GFw2bdv3UAI29+zyBQ6cL7yDfQCuBlq1Lpjo0TQHwT62410sjTp8vURA5w=
MIME-Version: 1.0
In-Reply-To: <20180212115822.GA4984@avx2>
References: <20180210211110.GA24324@avx2> <CAGXu5jL2xLz88X8in-9GjLZyDQzynYvf3bKDnCPVgL+e3uGFLw@mail.gmail.com>
 <20180212115822.GA4984@avx2>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Feb 2018 09:03:06 -0800
X-Google-Sender-Auth: KccxFifkysxQ0rowvjqOOQqh4fI
Message-ID: <CAGXu5jL8zjn1c0bHDz8SF8fkpt2WZ9-_n1suYi_hJsaOBRK=oA@mail.gmail.com>
Subject: Re: [PATCH] kstrtox: make kstrtobool_from_user() very strict
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 3:58 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Sun, Feb 11, 2018 at 01:27:58PM -0800, Kees Cook wrote:
>> On Sat, Feb 10, 2018 at 1:11 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>> > Once upon a time module parameter parsing code accepted
>> > 0, 1, y, n, Y and N for boolean values. Gratituous but contained
>> > to module code and thus tolerable.
>>
>> And kernel command line.
>
> True that.

The divergence in behavior is what I think is weirdest. Everything
_except_ this change will take generous inputs.

>> > Commit ef951599074ba4fad2d0efa0a977129b41e6d203
>> > ("lib: move strtobool() to kstrtobool()") promoted that ugly wart
>> > to kstrtobool() and, more importantly, kstrtobool_from_user().
>> >
>> > Later set of accepted values was expanded to "on" and "of".
>> > Now there are 6+8=14(!) valid strings for a boolean.
>> >
>> > This patch reduces set of accepted values to "0" and "1"
>> > (with optional newline) in spirit with other kstrto*() functions.
>> >
>> > I'm starting with kstrtobool_from_user() as it is explicitly designed
>> > to be used for interacting with userspace. Currently there are 9 users
>> > all debug code, so there is hope.
>> >
>> > Please send before 4.16 so no real users start to depend on verbose behaviour.
>> >
>> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>>
>> Why bother? What's wrong with generous input parsing? This just
>> creates a divergence where none is needed.
>
> Generous parsing creates more problems and more code than necessary.
> kstrtobool() is very instructive example.
>
> Booleans are 2 values, so 2 strings is enough.
> Add optional newline so shell users don't have to type "echo -n".
> That's all.
>
> In a generous world things are little more complicated:
>
> First, as written code doesn't accept "on" it accepts "on.*" and
> "of.*". Now imagine some parameter gets semantic change from "on/off"

Well, this already accepts the newlines you mentioned, so that matches
the needs there.

> to "on/off/once" (kmemleak-style detectors).

At that point it's no longer a boolean, so it makes sense to have
different parsing rules.

> Second, English centric view of the world. If English speaking users get
> more usability with "on" and "off" why, say, 150 millions of
> Russian-speaking people can't get that too. And if you accept that argument,
> encoding subquestion arises immediately.

The kernel is English-centric. Just look at comments, variables, /sys,
/proc, etc. I don't find this a compelling argument.

> At this point you've adding Merriam Webster and libicu to the kernel.

See above; this won't turn into a slippery slope.

> Third, it is simply more code in ring 0. If anyone wants user-friendly
> parameters, then write wrappers and leave kernel alone.

This is the problem: it was already all kernel code. There were
separate non-compatible boolean parsers scattered around the kernel
and this unified the boolean parsing into one place to avoid code
duplication (which can have bugs) and unexpected results (which
frustrates users). This is attempting to fragment the code again, with
no obvious benefit.

-Kees

-- 
Kees Cook
Pixel Security
