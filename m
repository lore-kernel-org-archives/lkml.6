Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754492AbeBGPsO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:48:14 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37264 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754150AbeBGPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:48:13 -0500
X-Google-Smtp-Source: AH8x226dY6SSWz/PXKxMfVO0tYO1UtR9Cwx9vZD4eZIEZ7yZzgQU6JUG2tQK1IXc5QBS1+4t6khzKtdqE0z8sNQFBgY=
MIME-Version: 1.0
In-Reply-To: <20180207154116.xvojw3bzmnmexkav@pathway.suse.cz>
References: <20180204174521.21383-1-kilobyte@angband.pl> <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
 <CAGXu5j+rWhT7_DH5Z96_7naPou96-6736x4mjq0r_8EG4iiQ_g@mail.gmail.com>
 <20180205201555.GQ29988@eros> <CAGXu5j+KSm3rOK46xiYPx8SRaO9T5LaeaXxOA3PSktJv4F__dg@mail.gmail.com>
 <20180205205817.72dy7e7xzjcnwmhs@angband.pl> <20180207150328.nuk7f76nutq2trcg@pathway.suse.cz>
 <CAMuHMdVJZnbFrLxBZm1m6C+sR1MKuk3=G4RoYVkAgcxYDHgMGw@mail.gmail.com> <20180207154116.xvojw3bzmnmexkav@pathway.suse.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Feb 2018 16:48:11 +0100
X-Google-Sender-Auth: bLyZGH6ttjAWut2B-fu9PxA5BZM
Message-ID: <CAMuHMdWtZMvBwMGtC=eR57W5C3u=pna8O=0UCxeAknP0q8Brbg@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
To: Petr Mladek <pmladek@suse.com>
Cc: Adam Borowski <kilobyte@angband.pl>, Kees Cook <keescook@chromium.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Wed, Feb 7, 2018 at 4:41 PM, Petr Mladek <pmladek@suse.com> wrote:
> On Wed 2018-02-07 16:11:13, Geert Uytterhoeven wrote:
>> On Wed, Feb 7, 2018 at 4:03 PM, Petr Mladek <pmladek@suse.com> wrote:
>> > [*] I made some archaeology:
>> >
>> > The "(null)" string was added by the commit d97106ab53f812910
>> > ("Make %p print '(null)' for NULL pointers").
>> >
>> > It was a generic solution to prevent eventual crashes, see
>> > https://lkml.kernel.org/r/1230979341-23029-1-git-send-email-xyzzy@speakeasy.org
>> >
>> > From this point, printing 00000000 for %px looks perfectly fine because
>> > it does not crash.
>> >
>> > In fact, it would have made perfect sense to print 00000000 for pure
>> > %p because it did not crash. But nobody has cared about the eventual
>> > confusion yet.
>> >
>> > I am not sure if it makes sense to change the pure %p handling
>> > now. Note that printing "(null)" has the advantage that we
>> > get this string instead of the hash ;-)
>>
>> Note that "(null)" is also used for printing strings, where you do dereference
>> the pointer, unlike for printing pointers.
>> In addition, "(null)" for strings is not just printed for real NULL
>> pointers, but
>> also for anything pointing within the first page of virtual memory.
>
> We are on the safe side. "(null)" for "%s" is handled
> separately, see string() function in lib/vsprintf.c.

I know.

> To make it clear. I was talking about "%p" format that is handled
> in the pointer() function in lib/vsprintf.c. The "(null)" makes
> sense only for the many modifiers that do deference of
> the pointer, e.g. "%pa", "%pE", "%ph". It makes less sense
> for the pure "%p" used without any modifier. Well, it actually
> started to makes some sense after we started printing
> the hash instead of the real pointer value.

Sure. I agree with all of that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
