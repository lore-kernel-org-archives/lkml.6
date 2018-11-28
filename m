Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AEBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D877E208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D877E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeK1U3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:29:38 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35281 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbeK1U3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:29:37 -0500
Received: by mail-ua1-f68.google.com with SMTP id d2so8665900ual.2;
        Wed, 28 Nov 2018 01:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYAaP/4fD9Qb83tznyfqPwnDk3lPTPLvLdfGLagzl5o=;
        b=jaTdFTHele+aTWLF4PXc5tbXRBGjtJQ/uFiVo1PVWNxsRgQTFkTSyaD0ahYGLjQrPS
         TM5iMUOjajjRzRu+Y7hDjJ0q5/d5DcFHKYRS9jeDPg9ogzoZ01wtb7UXW39WTvKHX7dX
         IM8zdaSecRsRqdon8LWs4EQ0femtJuB0ismyAYq7NcR0xrNmpJrgBfdHGCAwQCPndtXc
         EzgmFBrH0oGo7+j5t5jMjq3hqU6kZfC16dsAWM4mfRbkK+KXRgXxjVJPbA5aOijKvGG4
         Q50xRdNKcOU2f8UEwLMwXUjIuwujkek0R+1Er3BXV1m5TYZ+Api7D27YS31LsAlbQJJm
         p++Q==
X-Gm-Message-State: AA+aEWZ56fwrYzjVJNUCeBvsYqoLN5CF1ntxb8aK834DQc4Es9kPPlSj
        47b13CGSO/QlRF+sbHpfnvwskavFS2TKq8CARb4=
X-Google-Smtp-Source: AFSGD/WOF5kifEo5Myop6f8/8yJrkwycU1KBVQKtXVQElMm6SeFWDzeINd2AfsKsQiHDYTgdjeG4y/LKrVPkSJ/VGEM=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr15145281ual.20.1543397318241;
 Wed, 28 Nov 2018 01:28:38 -0800 (PST)
MIME-Version: 1.0
References: <20181113133520.20889-1-geert+renesas@glider.be>
In-Reply-To: <20181113133520.20889-1-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Nov 2018 10:28:25 +0100
Message-ID: <CAMuHMdX-X6dTJi6WgRKYVs-w+rxO3cJP8kX5AZwOXNO4qpgcqQ@mail.gmail.com>
Subject: Re: [PATCH v3] reset: Exclusive resets must be dedicated to a single
 hardware block
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 2:35 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> In some SoCs multiple hardware blocks may share a reset control.
> The reset control API for shared resets will only assert such a reset
> when the drivers for all hardware blocks agree.
> The exclusive reset control API still allows to assert such a reset, but
> that impacts all other hardware blocks sharing the reset.
>
> While the kernel doc comments clearly state that the API for shared
> resets applies to reset controls which are shared between hardware
> blocks, the exact meaning of exclusive resets is not documented.
> Fix the semantic ambiguity with respect to exclusive access vs.
> exclusive reset lines by:
>   1. Clarifying that exclusive resets really are intended for use with
>      reset controls which are dedicated to a single hardware block,
>   2. Ensuring that obtaining an exclusive reset control will fail if the
>      reset is shared by multiple hardware blocks, for both DT-based and
>      lookup-based reset controls.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Question from Philipp for the DT maintainers:
>
>    "I'd still like to hear the device tree maintainers' opinion on
>     parsing the whole DT for "resets" phandle properties to find shared
>     resets like this."

Mark, Rob: Ping?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
