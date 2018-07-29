Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1BEC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972DE20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mnktm6FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972DE20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeG2WBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:01:01 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35603 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbeG2WBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:01:01 -0400
Received: by mail-it0-f67.google.com with SMTP id q20-v6so14150551ith.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23K1/86xlmZVqzd8v2b81GxT8R66KfoT1vrcVVMrQaU=;
        b=Mnktm6FNEQzzGL5cM5ypzfUOSnAZy5xKc0HeRlfrVuzGUieyB+WmOn+p5Udqtt/quB
         s4zu4SEg7rGqL5/ZfOZXGgFjjDH8u9lWPGyFY6bYAA9+pxKsyOKcrV8QTqjd+1IXMcXf
         +/UhwqHLDQ4OTRFvZ+Tk9aiTN8H31sb4Z1QlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23K1/86xlmZVqzd8v2b81GxT8R66KfoT1vrcVVMrQaU=;
        b=W87WX0uJf1eBX0HwtF48VFJVQdvpBb4U1MHvEMJWx41gPRaOXQGwvc7DRMTDrL9suy
         6WQoCZAZvrJObkTuVfY2+MOIUMvTDZKdU7fbHOUsLpqi1Y3OX4VyC+pIs6lyZJG8Iz8S
         dBlAik5KRoMSjdXglSstDxiRDZoqJZyjTqm8R3pPJce+lnJ6fOesTTKTa2HqJjVs/RWW
         FVUoUZ/ErkN2F/44lzI+fy6/aV7t1lupffGVyz8yeyGTBHmu3H4MKzCjXwVWdM85xCwi
         umC9aZ2Ylx4+uoOV/USs36ZhRtHPcsIP1jQA7ilju02pp6mlaJWjqwZCTEv05ibRQIM/
         vXSw==
X-Gm-Message-State: AOUpUlFV9VPXhRiubAT/xvn1hXzyuYa5uCaBg6m9e+F+3dEjM9I3KZV2
        iVGDKQbDStGhoUvfNUy7AMdUzHPuj7izO+mHtt+NlQ==
X-Google-Smtp-Source: AAOMgpcH21saGeBzqPIH8j3RYxPq4o6e0/62aDn60wL0SNnfwFjyp4RAgL1GXNGhcqchSJpyQ1sCWy/IQlFer18OJjs=
X-Received: by 2002:a24:7503:: with SMTP id y3-v6mr12113461itc.70.1532896158292;
 Sun, 29 Jul 2018 13:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-7-jmkrzyszt@gmail.com>
In-Reply-To: <20180718235710.18242-7-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:29:05 +0200
Message-ID: <CACRpkdbH9Vu12RckQPKhGgyJnyxaQ04d5qa9srHwneP3SS6FAA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] gpio: omap: Add get/set_multiple() callbacks
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 1:56 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> This should make applications utilizing whole banks work faster.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

This patch looks good to me and I have an urge to just apply it.

Can we get some feedback from the maintainers?

Yours,
Linus Walleij
