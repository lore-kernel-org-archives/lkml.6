Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205A7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA04A2177A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0CRj4g6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA04A2177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeHCSoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:44:44 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41875 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeHCSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:44:44 -0400
Received: by mail-io0-f194.google.com with SMTP id q9-v6so5499583ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUTU2/7glytJn3Cx1GLX+NOCH+9NTXeEUpUdiOlcI8E=;
        b=Q0CRj4g6z4JZF3/GmaEND/Q4gG8fUoSFvC+KHyA2WtxxhHnZsD1ydRyHvw05cf0Mkk
         JtzAkyT+5tpli/QNup/bMBRiFF9CB7DTp17tpNVG4jFbDmTjzrPuL4PBMOsIyQhIzRZj
         lgrnSGSeAlvLM4aE9coYteuiwli5gCCS1LLjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUTU2/7glytJn3Cx1GLX+NOCH+9NTXeEUpUdiOlcI8E=;
        b=cvdtZzmDfsaLbicADkSLIL0iHxHbeiYkYmVB55EBokHB4D4fCoW+dmeWPxIbH4GaIY
         5+b755/9aDWaWZQcuo7m+QDNIQYmlPXgy3CSlM21GP2QZqM+8gnbk/zcsZQ9BIMXEXFs
         wUt08KOVHcgqsRNeqyWQeaXDUL+r1n/Qte1MrB8ziAH16dFb8p6xvYCmke1OzwklyyW4
         s0bEBKpfel9q8SNYWA3QNyRvgMbaKbEEbTAS+AJcioRHxn2Xy0cWb6NQsCm04ONHCoCS
         Pl6sBHxz6RkCPLlnYAg1S6GxWOzIdWOoiR3XQ4T9V4mlRP/EuhoA5g4klCoWnXDpMrz5
         tc3A==
X-Gm-Message-State: AOUpUlGjWTmGUTTXjVfxZqkSB227KbgL2luvENI/XyKVrJEtwzbdaHLV
        Ayn3GXQMyQFqwUfN6/TRIeyhKyu1cVeV3+F4R81vjg==
X-Google-Smtp-Source: AA+uWPyso2vWTU+l4VMHFPv4I8TMSidZy+wNCzxpC83XoOBP8B5usfN0Gf7yk9H5fSgPg1rMk5myhgi0lDKqNXXYVlw=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr6299408ioa.277.1533314858830;
 Fri, 03 Aug 2018 09:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-7-jmkrzyszt@gmail.com>
In-Reply-To: <20180718235710.18242-7-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Aug 2018 18:47:27 +0200
Message-ID: <CACRpkda8AC9Z635SWmit_RiaYbHA2TrwG-DsSg43vJ8E9Dq4GA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] gpio: omap: Add get/set_multiple() callbacks
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
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

Patch applied with Grygorii's ACK.
No reason to delay it, if there are any problems we will just revert it.

Yours,
Linus Walleij
