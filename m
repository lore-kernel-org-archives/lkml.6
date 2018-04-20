Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754553AbeDTJ7R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:59:17 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41295 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754513AbeDTJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:59:15 -0400
X-Google-Smtp-Source: AIpwx49HZdraxk+EK24ztU/egdx7HAdeAI8FnquaBUGEuIhk2UCQ5Q6rIuIqj0lE/6S2RQS1/GratXDYIEY0Wf6ykbU=
MIME-Version: 1.0
In-Reply-To: <20180420083147.GC31275@infradead.org>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180418104703.GA12462@infradead.org> <20180418131314.GC3999@w540> <20180420083147.GC31275@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Apr 2018 11:59:13 +0200
X-Google-Sender-Auth: 51nJHTbsL0rlzApckLAsSlsfgfM
Message-ID: <CAMuHMdWwJrUgOjaAX1oUHd+KFUMuUzcH6g29zC2mJX377oAHiA@mail.gmail.com>
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
To: Christoph Hellwig <hch@infradead.org>
Cc: jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Apr 20, 2018 at 10:31 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Apr 18, 2018 at 03:13:14PM +0200, jacopo mondi wrote:
>> As long as it goes for arch/sh, the only user of dma_alloc_coherent()
>> is platform_resource_setup_memory(), and it has been fixed by this
>> patch.
>
> Great!
>
>> Unfortunately, as Thomas pointed out, there are drivers which calls
>> into this with the wrong 'struct device' as the sh_eth one he had fixed.
>
> Yes, we'll need fixes there.  Other DMA ops implementations also look
> at struct device, so they generally are buggy.
>
>> I would then say that as long as it goes for the NULL case, we should be
>> fine now.
>
> Then I'd say skil that part, please.

The major reason for keeping the NULL WARN_ON() checks is to make it
obvious to the developer what is wrong, and fall back to the old behavior.

Without the checks, the kernel will just crash during early startup,
without a clue in the (missing) kernel output, usually leading to a
frustrating bisection experience (if the developer is sufficiently motivated,
at all).

Hence my vote for keeping the checks.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
