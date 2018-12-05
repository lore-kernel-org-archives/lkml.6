Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4152C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E6F2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E6F2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeLEVQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:16:59 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43437 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeLEVQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:16:59 -0500
Received: by mail-vk1-f194.google.com with SMTP id o130so5016328vke.10;
        Wed, 05 Dec 2018 13:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nl7XcfIC4sMSc62XFiJfb2fGk4rPANIAbywtAgNoQLY=;
        b=s8kjxW5DfCBFAFpT5RHZLs8uYxSn2BjmxmXv1nGJleDlIkLpfvsFrNQZ4QFsujkWhU
         UY1Bj34ect8Ujsca+sjCkOp8d5rGZfGjRe7xdjdseFKknhH93xxh7JjateVrKdU9aFbk
         NImsCxJPiShlO81IhFiaXM/7fsBQhytY3e/l3LTrYGMMLsaHEet2BXKd3Sozw+dJcgFL
         fNo9zD9vVAeRaeDI/bkOd+vM7fckUNqkyKFNrSrbZHMrcRDkAvO/V3DiO5lQr8YLxNgY
         VM1qmo1LXiyTQ9yE1wFawUrsNc11KvOP2EZlAcgoEmkmzuj8moAxmQbuCE3qaJZrY4N+
         TzkQ==
X-Gm-Message-State: AA+aEWbwr+6DBOl5P10aJqS9d3tH3hnw9w1WSMmO2UwnxhuSt+jR5trc
        Jpkb+yPmxBwKaPRqr+QYXdFOR1NS+p7Mv+t7Xow/NA4J
X-Google-Smtp-Source: AFSGD/UNpaFGrXvfudSYUZpWytqDI5tXModQycfjePV8xl7ilPxyQXqOba1QU35r8mArxbB+p9MUU4rBbuk0bFYtSws=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr11617161vkh.65.1544044618144;
 Wed, 05 Dec 2018 13:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-5-robh@kernel.org>
In-Reply-To: <20181205195050.4759-5-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Dec 2018 22:16:45 +0100
Message-ID: <CAMuHMdXqww7c26SAc52b8Uum5cUfYm9dQEkQ3SYmhgCDOSn_xQ@mail.gmail.com>
Subject: Re: [PATCH] clk: Use of_node_name_eq for node name comparisons
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 8:50 PM Rob Herring <robh@kernel.org> wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/clk/renesas/clk-mstp.c   |  2 +-
>  drivers/clk/ti/clkctrl.c         |  2 +-
>  drivers/clk/ti/dpll.c            |  2 +-
>  drivers/clk/ux500/u8500_of_clk.c | 10 +++++-----
>  4 files changed, 8 insertions(+), 8 deletions(-)

For drivers/clk/renesas/clk-mstp.c :
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
