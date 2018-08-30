Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6057FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DB020835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DB020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeHaCfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:35:07 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42392 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeHaCfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:35:06 -0400
Received: by mail-ua1-f68.google.com with SMTP id w7-v6so6792408uan.9;
        Thu, 30 Aug 2018 15:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiMeGDtBr+3jgLS+OhfL7lyawdsWkcPIBA9IAccV1C4=;
        b=mdeoiXYFAwn+DbL11AHRVlRC5Kty6+IaRnvCAMFdwIvfmk0ebA9mXT/5L6GoGpJ5j3
         hOX1U2pO+S+Wj144uMBg6v2JeMesQdPx6f5PoUAU67iRmjcuKAm5wZ6zCJKLWV1OWsS2
         r09Vhm9LpTmrMi0zCPIlseuvUGnI9nEgSzhUEhlPIpIgzylvVSnyKib+QoguRqWjTywi
         x7Grwjdx5XvA0xPKVO+XNrofl/3AtZ4/STc3j0KNlEbfdvH9DBLb8UdnBWxAL19k4IOr
         FFWI+N1/yMf6yBqUcYIR7cIUT3u5bvif4i15noed3dlNlqo8PuHRYUOVi2Jscq1w7JjF
         Cwew==
X-Gm-Message-State: APzg51A0To0LpDEeR+xrGDJw/TDvV/ML3c9p5akKV6cgi8w4FKwg7nYI
        PzCKlj2kScNlmba2E2Z0bT8fQL4EWBkkWuP7qpU=
X-Google-Smtp-Source: ANB0VdYhRE3EvOJumGYx/4/61yTOJVD0meXKjRsu2kpKqpXR2OFFyYfFfIBVZvWf/YqjwCo0sGGRVoTzpDvVncMD1AQ=
X-Received: by 2002:ab0:60ae:: with SMTP id f14-v6mr8319701uam.153.1535668243417;
 Thu, 30 Aug 2018 15:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180830125404.21192-1-geert+renesas@glider.be> <TY1PR01MB1562E58C07A892AC7CF7438B8A080@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1562E58C07A892AC7CF7438B8A080@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Aug 2018 00:30:30 +0200
Message-ID: <CAMuHMdVgRQsOiQ-M3CGZZK1wdx3smY6MgkkokdSuw3iBm8zPrQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] serial: sh-sci: Fix earlycon on Renesas ARM platforms
To:     Chris Brandt <Chris.Brandt@renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        uli+renesas@fpond.eu,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Thu, Aug 30, 2018 at 8:52 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Thursday, August 30, 2018, Geert Uytterhoeven wrote:
> > Earlycon for RZ/A2 (which is a new platform) will be fixed later in a
> > separate patch.
>
> I assume something like this:

Exactly!

> (which works for me)

Thanks for checking!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
