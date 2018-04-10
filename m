Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeDJCiX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:38:23 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43311 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeDJCiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:38:21 -0400
X-Google-Smtp-Source: AIpwx48pYVsk1woJuJoS37Yu2jidkQHdLhq6sr4Wjzi3kC3qaqClyn2fMOYVvXuPsJK9n5p+wJMBMJ6wPcDwpL2GIUA=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUy6C4OoGF44e_34+XjsQHe6RwfoesfBzcM8baEHUwzXw@mail.gmail.com>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
 <cdba869f704b457bc617007738870b9e1bdef9d3.1522546571.git.fthain@telegraphics.com.au>
 <CAMuHMdUy6C4OoGF44e_34+XjsQHe6RwfoesfBzcM8baEHUwzXw@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Tue, 10 Apr 2018 14:38:21 +1200
Message-ID: <CAOmrzkL4BCoKZ64-scfqcF5XsyeQLhC+XdG3V--3YWzq7WSfoA@mail.gmail.com>
Subject: Re: [PATCH 03/12] m68k/mac: Don't remap SWIM MMIO region
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>,
        Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

I haven't seen that weird behaviour in quite some time - we discussed
changing the arch_initcall to some later priority at that time but I
never got around to trying that. No change to mappings in head.S
either as far as I could see.

Was there any rearrangement of MM init relative to arch init since?

Cheers,

  Michael


On Tue, Apr 10, 2018 at 12:54 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Finn,
>
> On Sun, Apr 1, 2018 at 3:41 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
>> For reasons I don't understand, calling ioremap() then iounmap() on
>> the SWIM MMIO region causes a hang on 68030 (but not on 68040).
>
> Michael Schmitz also notices strange things with ioremap() on '030.
>
>> There's no need to call ioremap() for the SWIM address range, as it lies
>> within the usual IO device region at 0x5000 0000, which is already mapped.
>
> by head.S, right?
>
>> --- a/drivers/block/swim.c
>> +++ b/drivers/block/swim.c
>> @@ -911,7 +911,7 @@ static int swim_probe(struct platform_device *dev)
>>                 goto out;
>>         }
>>
>> -       swim_base = ioremap(res->start, resource_size(res));
>> +       swim_base = (struct swim __iomem *)res->start;
>
> I guess you need a __force to please sparse?
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
