Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753500AbeENMsM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:48:12 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41503 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeENMsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:48:09 -0400
X-Google-Smtp-Source: AB8JxZo9tHe57kC1Tx+8eZUrSdR2065tuETZ+bJiQfKW7la3Fwr4N+vE0NT5uGHw8sF/vfwpXJJ9K7UG0nJu1w2zrac=
MIME-Version: 1.0
In-Reply-To: <20180514141339.43a09786@bbrezillon>
References: <1526294977-32303-1-git-send-email-geert@linux-m68k.org>
 <20180514132324.595b63eb@bbrezillon> <CAMuHMdUSHc2o5zXbZje89jo2dxTYv8pzcVSz-gYWh7KdZKwQeA@mail.gmail.com>
 <20180514134607.5dfb8d51@bbrezillon> <CAMuHMdVhAAGiGjGMCe26kyLAPqrvTfukADhipd8apk8UNBAXiA@mail.gmail.com>
 <20180514141339.43a09786@bbrezillon>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 14:48:08 +0200
X-Google-Sender-Auth: 3hwdzsi5j9oMsScj6kKTye6ReSM
Message-ID: <CAMuHMdVVhuriVvvQqPLmf2ADA1JR=vjNMj8FDjcX0r=D9fPRhA@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: Fix return type of __DIVIDE() when called with 32-bit
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: MTD Maling List <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Mon, May 14, 2018 at 2:13 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Mon, 14 May 2018 14:00:19 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Mon, May 14, 2018 at 1:46 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > On Mon, 14 May 2018 13:32:30 +0200
>> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> >> On Mon, May 14, 2018 at 1:23 PM, Boris Brezillon
>> >> <boris.brezillon@bootlin.com> wrote:
>> >> > On Mon, 14 May 2018 12:49:37 +0200
>> >> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> >> >> The __DIVIDE() macro checks whether it is called with a 32-bit or 64-bit
>> >> >> dividend, to select the appropriate divide-and-round-up routine.
>> >> >> As the check uses the ternary operator, the result will always be
>> >> >> promoted to a type that can hold both results, i.e. unsigned long long.
>> >> >>
>> >> >> When using this result in a division on a 32-bit system, this may lead
>> >> >> to link errors like:
>> >> >>
>> >> >>     ERROR: "__udivdi3" [drivers/mtd/nand/raw/nand.ko] undefined!
>> >> >>
>> >> >> Fix this by casting the result of the 64-bit division to the type of the
>> >> >> dividend.
>> >> >>
>> >> >> Fixes: 8878b126df769831 ("mtd: nand: add ->exec_op() implementation")
>> >> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> >> >> ---
>> >> >> This fixes the root cause of the link failure seen with
>> >> >> m68k/allmodconfig since commit 3057fcef385348fe ("mtd: rawnand: Make
>> >> >> sure we wait tWB before polling the STATUS reg").
>> >> >>
>> >> >> An alternative mitigation was posted as "[PATCH] m68k: Implement
>> >> >> ndelay() as an inline function to force type checking/casting"
>> >> >> (https://lkml.org/lkml/2018/5/13/102).
>> >> >> ---
>> >> >>  include/linux/mtd/rawnand.h | 2 +-
>> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >>
>> >> >> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
>> >> >> index 5dad59b312440a9c..d06dc428ea0102ae 100644
>> >> >> --- a/include/linux/mtd/rawnand.h
>> >> >> +++ b/include/linux/mtd/rawnand.h
>> >> >> @@ -871,7 +871,7 @@ struct nand_op_instr {
>> >> >>  #define __DIVIDE(dividend, divisor) ({                                       \
>> >> >>       sizeof(dividend) == sizeof(u32) ?                               \
>> >> >>               DIV_ROUND_UP(dividend, divisor) :                       \
>> >> >> -             DIV_ROUND_UP_ULL(dividend, divisor);                    \
>> >> >> +             (__typeof__(dividend))DIV_ROUND_UP_ULL(dividend, divisor); \
>> >> >
>> >> > Hm, it's a bit hard to follow when you place the cast here. One could
>> >> > wonder why a cast to (__typeof__(dividend)) is needed since
>> >> > DIV_ROUND_UP_ULL() already returns a (__typeof__(dividend)) type.
>> >>
>> >> DIV_ROUND_UP_ULL() does not return __typeof__(dividend), but
>> >> unsigned long long.
>> >
>> > Except if you entered this branch, that means you passed an unsigned
>> > long long dividend (AKA u64), otherwise you would go in DIV_ROUND_UP().
>> > Am I missing something?
>>
>> Sure, inside that branch, it does.
>> But the compiler considers the whole ternary operator construction, i.e.
>> both branches.
>
> Yes, and that's my point. The (__typeof__(dividend)) when placed like
> you did is ambiguous. It looks like you're doing a useless cast, while
> what you're actually fixing is the case where dividend is an u32 (AKA
> unsigned long), and from the reader PoV, the code you're fixing
> shouldn't even be reached. Hence my suggestion to move the case one
> level up and add a comment ;-).

OK.

>> >> > How about:
>> >> >
>> >> >         /*
>> >> >          * Cast to type of dividend is needed here to guarantee that the
>> >> >          * result won't be an unsigned long long when the dividend is an
>> >> >          * unsigned long, which is what the compiler does when it sees a
>> >>
>> >> s/an unsigned long/32-bit/
>> >>
>> >> >          * ternary operator with 2 different return types.
>> >> >          */
>> >> >         (__typeof__(dividend))(sizeof(dividend) == sizeof(u32) ?        \
>> >
>> > To be completely safe and handle cases where dividend is an unsigned
>> > short or an unsigned, we should probably have:
>> >
>> >         (__typeof__(dividend))(sizeof(dividend) == sizeof(unsigned long long) ? \
>>
>> "> sizeof(u32)"?
>>
>> /me starts to think about uint128_t...
>
>         sizeof(dividend) <= sizeof(unsigned long) ?
>         DIV_ROUND_UP(dividend, divisor) :
>         DIV_ROUND_UP_ULL(dividend, divisor);
>
> Problem solved :-)

BTW, this will still fail (silently) with uint128_t. But we don't care.

And it will do the right thing when passed an unsigned long on 64-bit
systems.

> Is the following version okay?

I think it is.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
