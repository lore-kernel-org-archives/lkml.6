Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB58C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9662D20C07
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2P3frIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9662D20C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbeHWOLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:11:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38101 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbeHWOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:11:46 -0400
Received: by mail-it0-f67.google.com with SMTP id p129-v6so5287162ite.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZm9LbAzfak1XHPD0HXhsOZFX9/+qXxcgrDmM+plvqo=;
        b=P2P3frIqnvv9fNID1nHuRnvv57YpHfVCboSegOnk7aPJyUlr1cA/74HYPiNzs0GjKq
         mPkOOROdqIKuvi0pfKfNCqvE3xvGVD3Omypt0A56w8cW01xPweD93eEfVtY+sN6wjAJG
         /ClkMd2wsL8prfvoUCYa7wAw8FERw+BFB3g1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZm9LbAzfak1XHPD0HXhsOZFX9/+qXxcgrDmM+plvqo=;
        b=LGKK9vqdO54eK1PnHcHBz5vavhPR8M0i9ubUGEvWaqe5w4hQ2jF/6f/2wHwYZHm05A
         1PfBRppW6tTl5RR7QJfoCLWS/1K/u2TZ9N7Tx1GfHJMGvcYvacAEa02PrKnUBCUVTy5U
         w8d4bG7U8BSwE28xluCSsZzBuB0slYx1xIN6Mi6VbYe8ZaeUJOsgzmoZUQgbFON5Q8KI
         xLFtp5nUBN6k6nDv9a98RgQQrlCPil+y4nv565gaDVhXaFKQ2tCrBBgLmutFn0QMOWZ6
         AjzeY6DPUJRndHRjhvnd+aInokHpiRRk/0usFfs63t4Ih3EHowKK+jp5FA/kZbdRsj/K
         8+OQ==
X-Gm-Message-State: APzg51BJT/8Z8rOvm7nTu+7vIfL3VF7hUbdIFperDalpOEnk2kA8MbG8
        4R5cg4M/ROWcsHylg6rrbGXt+qu6eHhx66+gjPfqwA==
X-Google-Smtp-Source: ANB0VdabJ0SmThrra1vYGlhWqAsqzk5uj91eOG3jxo6aFWiL/uNEtCT5W3sP52RlcjAAvG6DvO+s/hLmENVcTosjGAM=
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr6664795itc.16.1535020959779;
 Thu, 23 Aug 2018 03:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180820181333.2527-1-jmkrzyszt@gmail.com> <20180820181333.2527-2-jmkrzyszt@gmail.com>
In-Reply-To: <20180820181333.2527-2-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Aug 2018 12:42:27 +0200
Message-ID: <CACRpkdb7E7cjZuYx6Cgxv2sNJmxvwqg0dNh3WpALwtnuCsezuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 8:12 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Don't request MODEM IRQ GPIO by its global number in
> ams_delta_modem_init().  Instead, obtain its GPIO descriptor
> and assign related IRQ to the MODEM.  Do that from
> omap_gpio_deps_init(), where the chip is already looked up.  Then, in
> ams_delta_modem_init(), just check for the IRQ number having been
> already assigned.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It's a bit unorthodox to have the board files intercept and poke
around inside the gpio_chip like the code in this file does,
I prefer to keep it encapsulated inside the GPIO driver.
However this is the lesser evil... if OMAP1 is ever phased
over to device tree it will go away, until then it is just nicely
contained.

Yours,
Linus Walleij
