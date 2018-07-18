Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D81CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB6A2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB6A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbeGRMOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:14:33 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:42043 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbeGRMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:14:33 -0400
Received: by mail-ua0-f193.google.com with SMTP id w7-v6so2692014uan.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ea+deI8g3J/0Ga73k71cx3oImqFv2MG9jTbcrWh05/g=;
        b=R69IScSEbXCUqODWJGcF8bE8rIhWYDvNKoTS6zQFSjQ1sSkCmVqKEfC+FwvsMXgzk6
         P7fGhV7iB0XUcF64/MtByiq/oAu9daoYE6W2IGtqB/5vd2nHK/IjxUoMkG0lPCTUa4XZ
         LqloWXaWC/LpWrwapie06vNnz2ZSiadLkBeP3xBKxEu6r27DQbWrKBm2ddx9ug+6DxFF
         qvCyExRB9abbr1889uYQzDclkUNhYJFJuZnmeKO9k75cs1uwuuZ5NRvIYI9mm+fGym/L
         N5P3KQacD2LB+gWWx4MpJDD7VW/UFbBbPaMx44jf7ZMfqGSGn+7kGYH3kFefdldGYOVl
         6KTg==
X-Gm-Message-State: AOUpUlEF08pICS6XcVOu+sl5jrj+jrOBfE5xgD2QxyTa1mcLuu5krPmd
        Y0SeeBcJLHhjEKJx8MqVQDTk5x13JgLrAYJ+1+A=
X-Google-Smtp-Source: AAOMgpfi7YMaDmpDWfdYUGAnmbKxYcHB/GiM4eK3A5LYjgcsQHRBHPOlq9aeIzAj//80Z7rf0ors6f5lpRfAxFa3qx8=
X-Received: by 2002:ab0:80e:: with SMTP id a14-v6mr3873303uaf.114.1531913824170;
 Wed, 18 Jul 2018 04:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180619140229.3615110-1-arnd@arndb.de> <20180619140229.3615110-2-arnd@arndb.de>
In-Reply-To: <20180619140229.3615110-2-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jul 2018 13:36:52 +0200
Message-ID: <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joshua Thompson <funaho@jurai.org>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 4:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
> The real-time clock on m68k (and powerpc) mac systems uses an unsigned
> 32-bit value starting in 1904, which overflows in 2040, about two years
> later than everyone else, but this gets wrapped around in the Linux
> code in 2038 already because of the deprecated usage of time_t and/or
> long in the conversion.
>
> Getting rid of the deprecated interfaces makes it work until 2040 as
> documented, and it could be easily extended by reinterpreting
> the resulting time64_t as a positive number. For the moment, I'm
> adding a WARN_ON() that triggers if we encounter a time before 1970
> or after 2040 (the two are indistinguishable).
>
> This brings it in line with the corresponding code that we have on
> powerpc macintosh.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

Applied and queued for v4.19, with the WARN_ON() dropped.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
