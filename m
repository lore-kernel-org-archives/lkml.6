Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeFABAO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:00:14 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:44675 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeFABAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:00:01 -0400
X-Google-Smtp-Source: ADUXVKKbPdzgeAQbih9NqSHtfRQaoMLxYY37WZPnUVAOUd3ZMcib/xOov7zo37fUOgXFOqgbKEougw==
Subject: Re: Can printk() sleep at runtime?
To: Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
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
References: <ba98332d-7013-f5cb-7d49-645ee6f49156@gmail.com>
 <20180531100457.fncibp5cxdozvbjh@pathway.suse.cz>
 <CA+55aFxasUXmLwb9Mj1j8WSJbmfO1oGkcsZ2hxxbkz_p1gkUfQ@mail.gmail.com>
 <152777998940.144038.2717154952249020053@swboyd.mtv.corp.google.com>
 <CAMuHMdWbwQ3GKovGGjMv+uWdJBoLYgXHAFj53qLcK1PjHg=0Gg@mail.gmail.com>
 <20180531171308.08474a70@vmware.local.home>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <cb01782c-3947-2409-aea2-24f264f3f2ea@gmail.com>
Date: Fri, 1 Jun 2018 08:59:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180531171308.08474a70@vmware.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/1 5:13, Steven Rostedt wrote:
> On Thu, 31 May 2018 18:42:48 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> Hi Stephen,
>>
>> On Thu, May 31, 2018 at 5:19 PM, Stephen Boyd <sboyd@kernel.org> wrote:
>>> Quoting Linus Torvalds (2018-05-31 07:32:10)
>>>> On Thu, May 31, 2018 at 5:05 AM Petr Mladek <pmladek@suse.com> wrote:
>>>>> Anyway, we need to fix or remove this format. vsprintf-like functions
>>>>> are called in any context and nobody expect that they might sleep.
>>>> Ack. I guess the argument is that "%pCr" is rare, and none of *those*
>>>> users may care, but I do think that doing things wrong as-is.
>>>>
>>>> It's too subtle to have to know you're in a particular locking context
>>>> when you use a particular %p modifier.
>>> Agreed. Removing the format seems to be the best approach. It looks like
>>> only Geert has used it in the last few years and it hasn't been used
>>> much otherwise.
>> Indeed, just 3 users (the broadcom one isn't mine):
>>      drivers/clk/renesas/renesas-cpg-mssr.c
>>      drivers/thermal/broadcom/bcm2835_thermal.c
>>      drivers/tty/serial/sh-sci.c
>>
>> Alternatively, can we have a special version __clk_get_rate() that just
>> returns clk->core->rate?
>> Or would that be too inaccurate in the presence of CLK_GET_RATE_NOCACHE?
>> The function could still return 0 in case the flag is set.
> If it's only used in three locations, I think it would be better to
> simply remove it from vsprintf() and have the three callers call
> clk_get_rate() directly.

Agreed.


Best wishes,
Jia-Ju Bai
