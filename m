Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5BAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FFF2156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FFF2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeI0NzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:55:25 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45916 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeI0NzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:55:24 -0400
Received: by mail-vk1-f193.google.com with SMTP id l123-v6so357218vkl.12;
        Thu, 27 Sep 2018 00:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErjOew8XqkXQrrZ+N2D9s0jEiUY1HPJdLELT/zZQHcc=;
        b=GuyPK8fAJRbOWfaSPh3txoQRkdrC+hYEutttDJpj+0DEmolAlG/h9wApJsCFRs+fb9
         1MwsjcwpfAgkVbsX5BFCZ6N/GnID107HvPqJxsrF4LKd3TeXDPj4NFoKFHRUdN3Qum27
         34iEQWSZSkbxnBP9qHgzaTeFu8cU6q6z0PqDd5OxiTxwryak14s7ZHvMyEzx2EYg92xq
         lIa6yMubzPtVDp/Wkhn9DLjkaJGhSYKclnEn5X1ffkHUcN56+pkMYT62mLKmGl6YtprZ
         k1VcR5O1LoHSaRQq6bt+oCvHOgJKH8XDB0EwEEfxR2NBCkmduFbG+rHl/G42NJowz5cM
         V5ww==
X-Gm-Message-State: ABuFfohhi6KcsgMCsR9Bb8lgXzgz4XDzQgJcRQSk22O0zcuk8XahlYR3
        IXfzGdFD2o2CvUEd/I+/FGl+dQnfVgAaUYCvNBU=
X-Google-Smtp-Source: ACcGV63Esp93NnoOiC/Wuu8c2SBX0VY4ZaOJ6upsOcO+9eL/i7SQ4P7zz2C39aXPgp43dD2/Y5UY9F1haNZy7gmqUMw=
X-Received: by 2002:a1f:92c4:: with SMTP id u187-v6mr2999369vkd.72.1538033911197;
 Thu, 27 Sep 2018 00:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180830125404.21192-1-geert+renesas@glider.be>
In-Reply-To: <20180830125404.21192-1-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Sep 2018 09:38:19 +0200
Message-ID: <CAMuHMdWdByKxivbQwWL9yF9_r8XObnZuXEZvf_9ZWKYYLWr1bQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] serial: sh-sci: Fix earlycon on Renesas ARM platforms
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        uli+renesas@fpond.eu,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Aug 30, 2018 at 2:54 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Due to an unfortunate oversight, commit 2d4dd0da45401c7a ("serial: sh-sci:
> Allow for compressed SCIF address") broke earlycon on all Renesas ARM
> platforms using a SCIF port for the serial console (R-Car, RZ/A1, RZ/G1,
> RZ/G2 SoCs), due to an incorrect value of port->regshift.
>
> This patch series fixes that by reverting that commit, and a (reverse)
> dependency.
>
> Earlycon for RZ/A2 (which is a new platform) will be fixed later in a
> separate patch.
>
> Thanks for applying!
>
> Geert Uytterhoeven (2):
>   Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
>   Revert "serial: sh-sci: Allow for compressed SCIF address"
>
>  drivers/tty/serial/sh-sci.c | 56 +++++++++++++++++++++++++++----------
>  include/linux/serial_sci.h  |  1 +
>  2 files changed, 42 insertions(+), 15 deletions(-)

These are now in tty-next:

    10c63443b74d1ef5 Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
    a1c2fd7e1098ea49 Revert "serial: sh-sci: Allow for compressed SCIF address"

Can you please include them in v4.19-rc6, as they fix a regression introduced
in v4.19-rc1?

In addition:

    3d8b43ad9c0cf023 serial: sh-sci: Add earlycon for R7S9210

(also in tty-next) enables earlycon on RZ/A2 again, as it was disabled
by the two
reverts above.

Thanks a lot!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
