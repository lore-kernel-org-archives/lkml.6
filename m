Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755884AbeEaQmy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:42:54 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36891 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755807AbeEaQmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:42:50 -0400
X-Google-Smtp-Source: ADUXVKLCrtsT2lM/V2B5wkF0WKENqf59C8tQJCEhpeWcdj+Z5gpEw1gMsP6jnt+rlq6L9DA0SwZlByw24BwOQ2tS2JY=
MIME-Version: 1.0
In-Reply-To: <152777998940.144038.2717154952249020053@swboyd.mtv.corp.google.com>
References: <ba98332d-7013-f5cb-7d49-645ee6f49156@gmail.com>
 <20180531100457.fncibp5cxdozvbjh@pathway.suse.cz> <CA+55aFxasUXmLwb9Mj1j8WSJbmfO1oGkcsZ2hxxbkz_p1gkUfQ@mail.gmail.com>
 <152777998940.144038.2717154952249020053@swboyd.mtv.corp.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 31 May 2018 18:42:48 +0200
X-Google-Sender-Auth: WEUYbslTsyQmK5aFeGSumhqvtyo
Message-ID: <CAMuHMdWbwQ3GKovGGjMv+uWdJBoLYgXHAFj53qLcK1PjHg=0Gg@mail.gmail.com>
Subject: Re: Can printk() sleep at runtime?
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, baijiaju1990@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, May 31, 2018 at 5:19 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Linus Torvalds (2018-05-31 07:32:10)
>> On Thu, May 31, 2018 at 5:05 AM Petr Mladek <pmladek@suse.com> wrote:
>> > Anyway, we need to fix or remove this format. vsprintf-like functions
>> > are called in any context and nobody expect that they might sleep.
>>
>> Ack. I guess the argument is that "%pCr" is rare, and none of *those*
>> users may care, but I do think that doing things wrong as-is.
>>
>> It's too subtle to have to know you're in a particular locking context
>> when you use a particular %p modifier.
>
> Agreed. Removing the format seems to be the best approach. It looks like
> only Geert has used it in the last few years and it hasn't been used
> much otherwise.

Indeed, just 3 users (the broadcom one isn't mine):
    drivers/clk/renesas/renesas-cpg-mssr.c
    drivers/thermal/broadcom/bcm2835_thermal.c
    drivers/tty/serial/sh-sci.c

Alternatively, can we have a special version __clk_get_rate() that just
returns clk->core->rate?
Or would that be too inaccurate in the presence of CLK_GET_RATE_NOCACHE?
The function could still return 0 in case the flag is set.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
