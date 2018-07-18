Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D575AECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CF82075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CF82075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbeGRN52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:57:28 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:37862 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbeGRN51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:57:27 -0400
Received: by mail-vk0-f67.google.com with SMTP id h22-v6so2468594vke.4;
        Wed, 18 Jul 2018 06:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYoOIVg64PcNaaNfF3yyFYLBV1F4MsA0goiY2vfv6Oc=;
        b=to61RU+tUXliltFPumXL0ACjrHdvXZgSdnJNltjcynTjjOAGmPdUL+9TlfFJQ+1FwN
         gG9eBbZajyLjYPjbU+P4NKzGt0IfOO285V3xl7oiqv9tzmDlSf8ciZ/HxRmzHaBlMnGj
         Se2hmZ00F0QaiF5uKsAFiEEYCFSSDsX/QiZFwvphOxfUsCchJy9Cq/aHPRsS/PHqdDO/
         cYo+dDGBKzkUelOiFyZGJAe7eGeZIImd2PYVCTVfilixSRabOx7qXEBF0zWWO3SDoGoU
         BqEURawCYOrDasMHqvN/7Xkjvwvqy2mG1eQLsAQD2GoG0/hlnn6u7bjbsMag7myOcqIQ
         iaow==
X-Gm-Message-State: AOUpUlGrR6kx7OVubTrbaHeNCZbGF/yahTqZjM5JOlP+lMNYRo3HWRto
        vTwpW6V5vHA3ONvSen+RpZNC1BTEt6tPOnDQHeZNMg==
X-Google-Smtp-Source: AAOMgpcKtJwNzi42oq5HonQcFxYRbP2n3Clq/7mKheB/kbNsLsPAi6qmWRdsCofPm4gnz8Cq7oe4h24a7XYap3MqN+4=
X-Received: by 2002:a1f:8355:: with SMTP id f82-v6mr3326962vkd.3.1531919973576;
 Wed, 18 Jul 2018 06:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com> <20180718130228.GG17271@n2100.armlinux.org.uk>
In-Reply-To: <20180718130228.GG17271@n2100.armlinux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jul 2018 15:19:21 +0200
Message-ID: <CAMuHMdUjzVBXn-goAwbTBULfo=HrJEY6eBae4w7Z6qA-gScUUw@mail.gmail.com>
Subject: Re: [PATCH] clk: Add functions to get optional clocks
To:     Russell King <linux@armlinux.org.uk>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Wed, Jul 18, 2018 at 3:02 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Jul 18, 2018 at 01:57:38PM +0100, Phil Edworthy wrote:
> > Behaves the same as (devm_)clk_get except where there is no clock
> > producer. In this case, instead of returning -ENOENT, the function
> > returns NULL. This makes error checking simpler and allows
> > clk_prepare_enable, etc to be called on the returned reference
> > without additional checks.
>
> How does this work with non-DT systems, where looking a clock up which
> isn't yet registered with clkdev returns -ENOENT ?
>
> (clkdev doesn't know when all clocks are registered with it.)

Good question.

I guess all drivers trying to handle optional clocks this way are already broken
on non-DT systems where clocks may be registered late...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
