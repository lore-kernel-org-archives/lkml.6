Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0CDECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBED22075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBED22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbeGRMOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:14:46 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:45773 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbeGRMOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:14:46 -0400
Received: by mail-vk0-f65.google.com with SMTP id b78-v6so2287213vka.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqRmTHQ3DgZrPFQXpcmRy8JNMXU5NwGGmyHGd6YVnuU=;
        b=fx3dDddzXlJGLs3OQWev656zJmYn6EaE9JB8so2M+IJYK8K5iYe4i0boA5zDNynRwu
         xZcD0turd+/Xe4FvmspGZPL1IM0/Z8YWdXMe4Y8QlIqah01gMqiZOD3hMWRQ0U5nJCG+
         uvRytew7i277WOMfa72/RhbE/Fw257vvDhvTJLNychSuYaq3ypyiMN5k8O+MyAEqOqZL
         4615Fc6g3YZ0Fr+NMADBBw90yLTxZMJ60+Cf9Lxgk0m02CdQgAEfrj49FCRgY2e39Pp/
         p5aiX8l3lEfDUqiAr1GNajT7NwBurysza9gL2VrUaXunYblmAxE641jqFaONGrn0edVL
         EkAQ==
X-Gm-Message-State: AOUpUlHCevo3Os8NfcKPhlzy/jvJF8fygcstt2B5MnM65vp+h0SpS86x
        UkG1Z0DDGcC2NOmJlG6N4VnGP1X77qM9aHxLagg=
X-Google-Smtp-Source: AAOMgpc08Hq0sLXxv5Yc20WWtKTJ71IHPVfEcn8R6BD9BZqFiTW12jkg5xHWug8DmyGE9YNUrEShJyiVCQg6WjYPnn8=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr3150890vkg.176.1531913837139;
 Wed, 18 Jul 2018 04:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180619140229.3615110-1-arnd@arndb.de> <20180619140229.3615110-3-arnd@arndb.de>
In-Reply-To: <20180619140229.3615110-3-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jul 2018 13:37:05 +0200
Message-ID: <CAMuHMdV2tSqXWgOiUtNjmCnQa2VSVddS9iHKb=5dvV9ChYNxsw@mail.gmail.com>
Subject: Re: [PATCH 3/3] [v2] m68k: remove unused set_clock_mmss() helpers
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
> Commit 397ac99c6cef ("m68k: remove dead timer code") removed set_rtc_mmss()
> because it was unused in 2012. However, this was itself the only user of the
> mach_set_clock_mmss() callback and the many implementations of that callback,
> which are equally unused.
>
> This removes all of those as well.
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied and queued for v4.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
