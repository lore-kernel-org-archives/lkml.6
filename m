Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751766AbeFAJaI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:30:08 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:41654 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeFAJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:30:02 -0400
X-Google-Smtp-Source: ADUXVKIfgwDJQLOTyyPlEgfGBUcw7SABPhnREarROSs3sqH5rqc1y9YZHKpF+qu8XmzH0VtAoEObe+F6RWRh5XabZ1U=
MIME-Version: 1.0
In-Reply-To: <cb01782c-3947-2409-aea2-24f264f3f2ea@gmail.com>
References: <ba98332d-7013-f5cb-7d49-645ee6f49156@gmail.com>
 <20180531100457.fncibp5cxdozvbjh@pathway.suse.cz> <CA+55aFxasUXmLwb9Mj1j8WSJbmfO1oGkcsZ2hxxbkz_p1gkUfQ@mail.gmail.com>
 <152777998940.144038.2717154952249020053@swboyd.mtv.corp.google.com>
 <CAMuHMdWbwQ3GKovGGjMv+uWdJBoLYgXHAFj53qLcK1PjHg=0Gg@mail.gmail.com>
 <20180531171308.08474a70@vmware.local.home> <cb01782c-3947-2409-aea2-24f264f3f2ea@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Jun 2018 11:30:01 +0200
X-Google-Sender-Auth: NVPT1KVeOF5JcO1KEm25MqBKO8I
Message-ID: <CAMuHMdVH7Gp5U84X86fg8kkspbn5VeLByuWe1g15VxxDbFM9pg@mail.gmail.com>
Subject: Re: Can printk() sleep at runtime?
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Stephen Boyd <sboyd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Bjorn Helgaas <bhelgaas@google.com>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
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

Hi Jia-Ju,

On Fri, Jun 1, 2018 at 2:59 AM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> On 2018/6/1 5:13, Steven Rostedt wrote:
>> On Thu, 31 May 2018 18:42:48 +0200
>> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> On Thu, May 31, 2018 at 5:19 PM, Stephen Boyd <sboyd@kernel.org> wrote:
>>>> Quoting Linus Torvalds (2018-05-31 07:32:10)
>>>>> On Thu, May 31, 2018 at 5:05 AM Petr Mladek <pmladek@suse.com> wrote:
>>>>>>
>>>>>> Anyway, we need to fix or remove this format. vsprintf-like functions
>>>>>> are called in any context and nobody expect that they might sleep.
>>>>>
>>>>> Ack. I guess the argument is that "%pCr" is rare, and none of *those*
>>>>> users may care, but I do think that doing things wrong as-is.
>>>>>
>>>>> It's too subtle to have to know you're in a particular locking context
>>>>> when you use a particular %p modifier.
>>>>
>>>> Agreed. Removing the format seems to be the best approach. It looks like
>>>> only Geert has used it in the last few years and it hasn't been used
>>>> much otherwise.
>>>
>>> Indeed, just 3 users (the broadcom one isn't mine):
>>>      drivers/clk/renesas/renesas-cpg-mssr.c
>>>      drivers/thermal/broadcom/bcm2835_thermal.c
>>>      drivers/tty/serial/sh-sci.c
>>>
>>> Alternatively, can we have a special version __clk_get_rate() that just
>>> returns clk->core->rate?
>>> Or would that be too inaccurate in the presence of CLK_GET_RATE_NOCACHE?
>>> The function could still return 0 in case the flag is set.
>>
>> If it's only used in three locations, I think it would be better to
>> simply remove it from vsprintf() and have the three callers call
>> clk_get_rate() directly.

OK, patches sent.

Thanks for reporting!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
