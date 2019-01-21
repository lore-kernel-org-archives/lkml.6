Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F48C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418A42085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfAUJmT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:42:19 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33054 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfAUJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:42:19 -0500
Received: by mail-vs1-f67.google.com with SMTP id p74so12251383vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C5ic4E2IG2SyNNDklQlj08JgbFz3wtfNUsXeIyZKwtw=;
        b=bpfK2LVTJiLbfDuEAtKf1tSx0zpWK575hDxy37LJYSFLI7xvm7i90L+c7eGEZ7v4Av
         9koyMuT3O1wPxa+/SYIoFNejRXHCrbbMxpuXsVu14tH/E1FjGS9H7L3PDlzdgNclr6NB
         e/14Q/bY0JYLl1pPjyc6wG3DMqeualV2ladEw7E+HY4S76Ny4JstzBZNUcJfN7beFd+u
         XbExDteNRMayQ6ja5mF4hHj7o34mL5MKYr8Fp2lA4OOrubr5tpMeiinYAHSPLFjTXbIY
         Sryv2wG5vGyYg2Kyr+f03d8FvgLZOsHn8nYFjyRQJJ7UIA4z+dEkQHGer+w9u30FM1VQ
         vLGQ==
X-Gm-Message-State: AJcUukeuSo2OwQHkR0L6q6K1GMdfYisIIQQ6j4J778mgifY0CEDk1Oq8
        4kargiZxiw9XZP3Bo7Bjn8cyUCriryJGatsPrX8=
X-Google-Smtp-Source: ALg8bN47wpyETBaqqt/WMsGhl1AYmSa/cGWXj8IDpbrFX0CiqtCgV1Jz5vOeC0HMb0KQ8v8rseFcbIpHN6nbg6CJvKc=
X-Received: by 2002:a67:f43:: with SMTP id 64mr12020221vsp.166.1548063738277;
 Mon, 21 Jan 2019 01:42:18 -0800 (PST)
MIME-Version: 1.0
References: <20190107092952.14691-1-geert@linux-m68k.org> <CAK8P3a35ZwkrE-zxRVbwvNEs4RZTuV+-eu3uRD2OaSnVnBG3EQ@mail.gmail.com>
 <CAMuHMdWG_s3Oc4DH=70CAKRCGn-bLwO+Gq2UsBd1reeqWE7_Cg@mail.gmail.com>
In-Reply-To: <CAMuHMdWG_s3Oc4DH=70CAKRCGn-bLwO+Gq2UsBd1reeqWE7_Cg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 10:42:06 +0100
Message-ID: <CAMuHMdW0v5NuQ4tWZ1PCDT=ze4eSNTf0eG9mKK0SfMrgFs9wiw@mail.gmail.com>
Subject: Re: [PATCH] m68k/atari: Avoid VLA use in atari_switches_setup()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 2:47 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Jan 8, 2019 at 2:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jan 7, 2019 at 10:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > With gcc 7.3.0:
> > >
> > >     arch/m68k/atari/config.c: In function ‘atari_switches_setup’:
> > >     arch/m68k/atari/config.c:151:2: warning: ISO C90 forbids variable length array ‘switches’ [-Wvla]
> > >       char switches[strlen(str) + 1];
> > >       ^~~~
> > >
> > > Replace the variable size by the maximum kernel command line size (512
> > > bytes), which is an upper limit for all suboptions.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Seems fine as long as COMMAND_LINE_SIZE never grows a lot. Some
>
> If that ever happens, it will be caught by -Wframe-larger-than=1024.
>
> > architectures use 1024 or 2048, but m68k currently has 256 (you write
> > 512 here).
>
> Thanks for noticing, will fix!

Thanks, fixed, and applied and queued for v5.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
