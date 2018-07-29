Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7223EC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208AB20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEttzf8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208AB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeG2WIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:08:45 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45142 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbeG2WIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:08:45 -0400
Received: by mail-io0-f193.google.com with SMTP id k16-v6so8213170iom.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8141MThgOpeTTEKNYU/CWkdAWhZqbiCOV4MrQInBy6s=;
        b=MEttzf8n8DkXTf+MM6Vz1XRYHoHxVQodIao3Fy/WyeL0IAxjnYGuJ9ZJA4lJKb4eJA
         z83ZpmTcHWhiCskLme8ep2o7LXukr8zcRlfC0FNnxM2U0Fe1XoC0m75+DBds2U55Y/YW
         R25Rf4LtYdvBuk9kFpxIXSsf733tdRiL6bV6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8141MThgOpeTTEKNYU/CWkdAWhZqbiCOV4MrQInBy6s=;
        b=N8pbYYT3/lOzH6rtqWCd1KemHBLD63l2iTflFtGqzcDhGUpwI2F7t7NLmseb/HyyKR
         CKl6wSwZCKbZ4mWYWRriIkwArdgdM06EBd3uXAkYcdTRYKR4fl5BFBxEkkKtAO+PULO/
         kwPs+K/uyGbtRb24KeaThwZeG01BQChwi8WVC2eD6/DHzAfFupFeQiYyrVQtiSTM9OE9
         3Zi9EHX4FV2JQxsIrCz61KbRHldGabGOZWhcWepaMAtbbculNxkEPSVK2lpS8IUL69dp
         csN3pTgSbFX1X798ysezAkaQPvi31/MVRqOusVYBak7LHtaPrPygp9GJg4xyp/W1eXNt
         QrhQ==
X-Gm-Message-State: AOUpUlH+Tux1Us0lwT5j9gNXzlvvEROgd9wqiyWSfndW7LKjifIMSCeR
        7jNMme75NEfBM5VjmlEycV5PathqpZYhS4u12D+5Eg==
X-Google-Smtp-Source: AAOMgpdU4COpSgnMKgaEQMEcFsLIMzC+qrt5JMRupTJIm/qGgFK9FB3Q/ZARGfxWC92HhiDuZ2xHvoeo5zA6RByXUiU=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr11459244iof.304.1532896620896;
 Sun, 29 Jul 2018 13:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-8-jmkrzyszt@gmail.com>
 <20180719084447.239a1b92@bbrezillon>
In-Reply-To: <20180719084447.239a1b92@bbrezillon>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:36:49 +0200
Message-ID: <CACRpkdZfiCN3U57s-7hGnbO9W-=pOjt0mL0w=Jv_+5WBdkEuig@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data
 GPIO resource
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
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

On Thu, Jul 19, 2018 at 8:44 AM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> I guess you'd prefer to have the pin values in a bitmap instead of an
> array of integers. That's probably something you can discuss with
> Linus, see if he would accept to change the prototype of
> gpiod_get_raw_array_value().

I am not so smart as to see the overall effects but if what
you're saying is that we shouldn't have designed these functions
and callbacks using arrays of integers (or longs) and instead
pass bitmaps, you may be just right. It intuitively sounds better.
But I'm not good with bitmaps.

We would have to refactor the world though.

Yours,
Linus Walleij
