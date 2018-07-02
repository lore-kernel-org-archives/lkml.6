Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDD9C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF1924EE6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF1924EE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbeGBUE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:04:59 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44140 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbeGBUE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:04:56 -0400
Received: by mail-vk0-f65.google.com with SMTP id 125-v6so3206359vke.11;
        Mon, 02 Jul 2018 13:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPbYynUcKc+5efwZ2SI98U9KPIoH2AX0hzFgRKywHUI=;
        b=aJWNoFJcg/yy3BpztHHfBcQhls0RTDtc1Nzpu7y4jD0WCNthmRDA5ksA7OzZ+wMbNh
         guGZ0f3UX20w2hgM+jzvjJlfpu0nrmtabXA/KY+l9Y9XhEEFKOKaYx55gTl6ELC8K7/K
         yjVFYw2PAE7pztmSYy7jPz7P1EpluoRlIPACWHMP/G4qRNo2+pgS82UqAw3ekKl6X4tl
         pyx9iQJEZs/NoFvPBaSsQVIfB8hnTB8U5g2BFcL8ucmhsJ0tR90vmKQZZ2JVREt0tyuC
         HWLnUWTGmLOy0OuSHz2qTxjy3x1MVKhO4HGbhIpl25fWUE9HnerDS6R8TdZW/dF6bIMM
         2C5A==
X-Gm-Message-State: APt69E17kc6ECUIWmDQKFCJhTYzcA9dHj8e0lvoZACITwvC7pq7uyGt2
        /2H6BXlOkrSaO8rvNj744mvRC3crUEnxRIEnmNc=
X-Google-Smtp-Source: AAOMgpfuktD25++g1SW3Xun0H38jki7qjpupRJuNS2b7ToLZ0xkIqaVF10FHMh6Qmd6e4HHgdOZzHWEGr81xyxKesGo=
X-Received: by 2002:a1f:8307:: with SMTP id f7-v6mr15445779vkd.3.1530561895472;
 Mon, 02 Jul 2018 13:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180622110307.31523-1-geert@linux-m68k.org> <20180702161248.GG533219@devbig577.frc2.facebook.com>
In-Reply-To: <20180702161248.GG533219@devbig577.frc2.facebook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Jul 2018 22:04:43 +0200
Message-ID: <CAMuHMdW1JiW=AGeXp+dVVdaLo3JXCR4rn9UC84qQWt7E1BvQ+w@mail.gmail.com>
Subject: Re: [PATCH v4] ata: Remove depends on HAS_DMA in case of platform dependency
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Mon, Jul 2, 2018 at 6:12 PM Tejun Heo <tj@kernel.org> wrote:
> On Fri, Jun 22, 2018 at 01:03:07PM +0200, Geert Uytterhoeven wrote:
> > Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> > symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> > In most cases this other symbol is an architecture or platform specific
> > symbol, or PCI.
> >
> > Generic symbols and drivers without platform dependencies keep their
> > dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> > cannot work anyway.
> >
> > This simplifies the dependencies, and allows to improve compile-testing.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Acked-by: Robin Murphy <robin.murphy@arm.com>
>
> This looks fine to me but how do you wanna route it?  Should I apply
> it to for-4.18-fixes or should it go with arch changes in some other
> tree?

Please queue it in the ata tree. There are no related arch changes.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
