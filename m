Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C21FA372B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EB820873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EB820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeG2KaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 06:30:12 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45351 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeG2KaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 06:30:11 -0400
Received: by mail-ua0-f194.google.com with SMTP id k8-v6so5991401uaq.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 02:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcc4bazwLcygUb1pYeJka69Bgyq/Ga6+xr4NSWTfOjs=;
        b=aSnVcD8EJ5JnCt07hrxMqoB253FAXV7jMVz7kYuwNV1kASXtkkrI7b8QoQRNIs/suk
         QLMizvzLazTH6w3X+f0KB2cIxl6EMt5BpW7Ody0t2EdOad4cwLCs94ualtZ5Oam/9jIn
         WJFOl332Gu1oQNiIv9onDl4dLlEJFygkkDFdE6vV3xjsfRBZS2tl38zojpPVcSf2kXy9
         H5nAzFxz9rvOAoXL0cWzmAbiduYugAM1aOETmyIO5brt02BtOQBDhof06KBn4wnZT5QW
         xeyXswp0MkUlKWeEyo4R8lvhBLyrmBj+FGUmOvLo36jCJYWO3+/GUHmGtjnYGkV+vpiU
         MO+Q==
X-Gm-Message-State: AOUpUlEfPY0rh5laKEEW89zG9l9ElhzttIYjd2XH+MkiqZE3f8pSlCeh
        YxZwW2/eFC7cWCkPBWxufQqXK7EkEuJy+P06QwMh7A==
X-Google-Smtp-Source: AAOMgpfM2+MELIO6gKNlLTobTNuDIqNjQblSEUXdbyCggXKzXkcoVrzsnEdkRQKAG4I8JaFFBpgcoSiB6rZqSNXND38=
X-Received: by 2002:ab0:72d1:: with SMTP id g17-v6mr9728256uap.33.1532854827677;
 Sun, 29 Jul 2018 02:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <58f371f95c10969bacff4d5bc393ff0f0c6102fb.1532415410.git.fthain@telegraphics.com.au>
In-Reply-To: <58f371f95c10969bacff4d5bc393ff0f0c6102fb.1532415410.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 29 Jul 2018 11:00:15 +0200
Message-ID: <CAMuHMdWaJEEvt_-g7Lp8Wwc=UbT6tSYewGK0YWgDhC=GVX=LyA@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Rework patch "use time64_t in RTC handling"
To:     Finn Thain <fthain@telegraphics.com.au>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn, Arnd,

On Tue, Jul 24, 2018 at 9:07 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> This addresses the issues arising from commit 324caa29cd04
> ("m68k: mac: use time64_t in RTC handling").
>
> Adopt __u32 for the union in via_read_time(), consistent with changes
> to via_write_time().
>
> Use low_32_bits() in via_write_time(), consistent with changes to

lower_32_bits()

> pmu_write_time() and cuda_write_time().
>
> Have via_read_time() return a time64_t, consistent with changes to
> pmu_read_time and cuda_read_time().

pmu_read_time()

> Drop the pointless wraparound conditional in via_read_time().
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks!

Applied to master with the above fixed.
Folded into the original commit on for-v4.19, with:

    [fthain: Adopt __u32 for the union in via_read_time(), consistent with
             changes to via_write_time()]
    [fthain: Use lower_32_bits() in via_write_time(), consistent with changes
             to pmu_write_time() and cuda_write_time()]
    [fthain: Have via_read_time() return a time64_t, consistent with changes
             to pmu_read_time() and cuda_read_time()]
    [fthain: Drop the pointless wraparound conditional in via_read_time()]
    Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
    Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
