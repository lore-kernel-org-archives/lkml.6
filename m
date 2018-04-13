Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbeDMSMA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 14:12:00 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:52949 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeDMSL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 14:11:58 -0400
X-Google-Smtp-Source: AIpwx49HsTKs7bz8GTD81i/feiWnyanZAg2aZ7L/hcaI0spDSgMHwfqgF0zsAT95MZJ2Vph56v18oO8r9DImHesOvsQ=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLt4xoxXTw83-npD4WmumPzSC9WnbOkkDoR=VYa5R4rYw@mail.gmail.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
 <1523595999-27433-22-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jLt4xoxXTw83-npD4WmumPzSC9WnbOkkDoR=VYa5R4rYw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Apr 2018 11:11:56 -0700
X-Google-Sender-Auth: GGiVu5v8GwyAr8hUyJLe1fT6dNI
Message-ID: <CA+55aFyM1uxzvU4SH3c1VYRXBRfGuqKZ4OR-O_pMoxPs7XTFug@mail.gmail.com>
Subject: Re: [PATCH 21/30] stack-protector: test compiler capability in
 Kconfig and drop AUTO mode
To: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 9:41 AM, Kees Cook <keescook@chromium.org> wrote:
>
> How about something like this instead:

I'd rather avoid the ifdef's in the Makefile if at all possible.

I'd rather expose this as a Kconfig rule, and in the Kconfig just have
an entry something like this

    config STACKPROTECTOR_FLAGS
        string
        default "-fstack-protector-strong" if CC_STACKPROTECTOR_STRONG
        default "-fstack-protector" if CC_STACKPROTECTOR
        default "-fno-stack-protector" if CC_HAS_STACKPROTECTOR_NONE
        default ""

which is really simple and straightforward. In the presense of
multiple defaults, the first is picked, so this _automatically_ does
that whole priority ordering.

And then the Makefile can just have

        KBUILD_CFLAGS += $(CONFIG_STACKPROTECTOR_FLAGS)

which seems much simpler.

It also makes more complex conditionals easier (ie different compilers
with different flags, since clang sometimes does the same thing with
another flag name), so I'd rather see this pattern in general.

I'd also *much* rather do as much as possible at Kconfig time compared
to build time. Maybe it's just shifting the costs around, but the less
"clever" things we ask "make" to do, the better.

I find our Makefiles an odd combination of really clean and simply
(the ones that just have "obj-$(CONFIG_X) += xyz.o" are just lovely)
and completely incomprehensible (all of our infrastructure support for
the simple stuff).

I'd rather have more of the simple stuff in Makefiles, less of the
complex conditionals.

                  Linus
