Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E07DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F49E208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F49E208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbeGPJY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:24:59 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33967 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeGPJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:24:59 -0400
Received: by mail-vk0-f66.google.com with SMTP id l143-v6so13888557vke.1;
        Mon, 16 Jul 2018 01:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNaqStCRiNc5wvIILw0/ytuFcLdx29JQ4v4HvzgqG8M=;
        b=RXbwwB35yublMMgVl5hoYXM3SYEifQ/qz0eQGVNXRsEDDJ04J+jIH+sY4rlGXHRUb+
         fW87NB2Ug7ULe9o5a0lhCdbXd5Xwhkql2oQnU60BcwAFAfegzsRe37VFC5KCBaJtDUh4
         CnWtPPzZXQF2jG4j2HzTlNMVNy84DtuIskc/3Okh5gHSvwhhvaNGxprOntbiBbAqm0r5
         iMxJdK0NiE0jId7ebvcj2jgpihfb2974osABhyJjGlLJ1qxMxbh3kPaVzDlKLzeK0X8N
         H54mhcab1dVqSy0s9OZQpLNuZrKfAuBvD2wFvb+m/YyVWKPCWLS+QgmiW5ILqHmpW2ZC
         xACQ==
X-Gm-Message-State: AOUpUlEpqglkexJav+4lvL/xTaDVtelMfJZSCFrtBpx2EahMrc0IOKgj
        31MsdO2P30yDuE7cLDlO9rb+buTD4WF7xX+tQYU=
X-Google-Smtp-Source: AAOMgpeSQF66A0yM6D17gWDGypiOwmCaavsVq0gGQJeRV+eeesoAvsMkPLhnc6Hle9j4xeiuHfjTrqC6ayvRPCVplE0=
X-Received: by 2002:a1f:3701:: with SMTP id e1-v6mr8846766vka.50.1531731514728;
 Mon, 16 Jul 2018 01:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180713154720.18316-1-geert+renesas@glider.be> <20180715165749.GA10023@amd>
In-Reply-To: <20180715165749.GA10023@amd>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Jul 2018 10:58:22 +0200
Message-ID: <CAMuHMdUqPW8wv=nuvesBDXf7iVeY378oNBXERCzKLrbPZ1SzFg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] regulator: bd9571mwv: Add support for toggle power switches
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Sun, Jul 15, 2018 at 6:57 PM Pavel Machek <pavel@ucw.cz> wrote:
> > The ROHM BD9571MWV PMIC on the Renesas Salvator-X(S) and ULCB
> > development boards supports DDR Backup Power, which means that the DDR
> > power rails can be kept powered while the main SoC is powered down.
> >
> > This patch series extends the support for DDR backup mode (see commit
> > 6eb0bfae6973eb6a ("regulator: bd9571mwv: Add support for backup mode"))
> > to systems with toggle instead of momentary power switches.
> >
> > With a toggle power switch (or level signal), the following steps must
> > be followed exactly:
> >    1. Configure PMIC for backup mode, which changes the role of the
> >       power switch to a wake-up switch,
> >    2. Switch accessory power switch off, to prepare for system suspend,
> >       which is a manual step not controlled by software,
> >    3. Suspend system,
> >    4. Switch accessory power switch on, to resume.
> >
> > Unlike on systems with a momentary toggle switch, an additional step 2
> > must be performed in between step 1 and step 3.  Hence step 1 can no
> > longer be handled in the PMIC's suspend callback.
> >
> > This patch series allows performing step 1 when the user writes
> > "on" to the PMIC's "backup_mode" virtual file in sysfs, e.g.
> >
> >     echo on > /sys/bus/i2c/drivers/bd9571mwv/*/bd9571mwv-regulator*/backup_mode
>
> Do you expect more boards to have similar design?
>
> If so, we may want to have standard place in /sys/ not depending on
> i2c paths and driver names, but I believe such design is so... awkward
> that it is not going to appear anywhere else...?

I have no idea. The BD9571MWV PMIC supports two power switch wirings.
Only one of them is problematic for usability reasons.
The newer Renesas ULCB boards use the good wiring.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
