Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2660BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C879B2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbJR5dtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C879B2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbeGMHUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:20:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33452 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeGMHUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:20:22 -0400
Received: by mail-it0-f68.google.com with SMTP id y124-v6so4080075itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2D7J4Cc/bFv9FBrEN5o4rNsJA9UdekeJQiUgg4Wdw6Q=;
        b=MbJR5dtAqqaeKNUzHHIavjeOyUJ67iZwSQodg/2Qswj87xvpmKDkfi+FNyjemFMqB8
         AclU4P6LVXnqWnNnUW/ydEFOQhIgurdGNoo2gh/aO2vDpLV7+HdQ/38KjDWV99kazWcn
         zjSDp/jI0kJkZANfOmifEdvALYaTwVsU9T+3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2D7J4Cc/bFv9FBrEN5o4rNsJA9UdekeJQiUgg4Wdw6Q=;
        b=YIX8gXhiwLrIvNewZaukHUnSpYlJua5qyx5gxIp49jmSYDQPtaa9NvGelRRL4Fl5qd
         1QP2HTyG+V6KIiNMi8ZP24JSxi8pV9TnCILrEMze0KNu1ThxeyxRwl1556Qq0K8xBvcu
         BW30nJ2hvq/FaLfheQu2p2+ynIoj6lHJkqpy4+xqHKY4ufIoTWqr34AAfJOxisWSOACF
         3hTaINaQNwg3De1vV0xRKlGe8DefLFoo4R0Aw0Z6K4Ld1xS5Gv09YKtdBLICwSz+66A8
         +IrV3TbzmHMIhjt89FgK/0xsW/qw1kNnRBRokcWTgriNoxyWoRJ5GePZYAxbSKpofh1v
         HtMg==
X-Gm-Message-State: AOUpUlEDaZccE+qk7z3w1iWfdI+csy/kqYiYGv0lsJapuiF9qFDMbuxz
        FOVcL8f/7PzTXvVuN5tbD1NvxrR7jULlqrrbWsqezw==
X-Google-Smtp-Source: AAOMgpe1kpl4AkA2dWwb0V60s3qsFxykPKxuOU8eT+FNzqgd+IH3sI/dksqBEl+v/Aig5+wF210Txf64zyA2QIBrc1I=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr3781498itb.38.1531465625840;
 Fri, 13 Jul 2018 00:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180709145612.4166409-1-arnd@arndb.de> <34126dddef64a7669946c354d4dd9e2adfb3344f.camel@kernel.crashing.org>
In-Reply-To: <34126dddef64a7669946c354d4dd9e2adfb3344f.camel@kernel.crashing.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 09:06:54 +0200
Message-ID: <CACRpkdaLs6CGGa99kNVvBDxwGHLg==0ygUeDaZo_QTqoKGBQag@mail.gmail.com>
Subject: Re: [PATCH] gpio: aspeed: fix compile testing warning
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Thierry Reding <treding@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 1:53 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> On Mon, 2018-07-09 at 16:56 +0200, Arnd Bergmann wrote:
> > Gcc cannot always see that BUG_ON(1) is guaranteed to not
> > return, so we get a warning message in some configurations:
> >
> > drivers/gpio/gpio-aspeed.c: In function 'bank_reg':
> > drivers/gpio/gpio-aspeed.c:244:1: error: control reaches end of non-void function [-Werror=return-type]
> >
> > Using a plain BUG() is easier here and avoids the problem.
> >
> > Fixes: 44ddf559d579 ("gpio: aspeed: Rework register type accessors")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Linus, can you plonk that on top of the patches in that topic branch
> you created ?

I put it on top of my devel branch where I merged in the topic
branch.

As it's a fringe thing anyways I don't think we need to recreate the
topic branch for this.

Yours,
Linus Walleij
