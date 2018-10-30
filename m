Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DECC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B784920827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlViRAAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B784920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeJ3WQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:16:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36941 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbeJ3WQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:16:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id p17so2384829lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVu8PkhHvK2ia82YJEMgs3xkbYsJg8i5sGiX/0yxUf8=;
        b=RlViRAAPiWeAY1YZoZddoPyhtoUVXyPy1v+aMQb6oOMDSujYXEKlG0NkVI1ytBKSiQ
         Ml7V4RASkex4mgmjA551HJQr+umXsawb/JM/Forfxb42j6sIkLyhKsj6I/HuV0Sgg9r8
         0TsEOaL146v+BHUzD7vc1xOHvfedj6XtIkzG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVu8PkhHvK2ia82YJEMgs3xkbYsJg8i5sGiX/0yxUf8=;
        b=HFZSU+dYVneb0NPOYrgOWZtVP9zDtncWLWiyfiBI/w6N2Rjm/4Kl6wHcDL50TFEs2z
         c/xGZS2ZJqrvaaFaC6oDelqaXFYJs9wXGHZO/VUSmJS3545Ctm8qK1VINbAesOOcDwR7
         xpDN7eGpPH2DxIMxSkqGqsCnjd0ovybFoEbPMEx4UGzLsYqa+MvYsxHEZzL2DFoGfaVg
         21+z9X4rgNQmAjCWHGuI0J2g4o2vWdfL4W7PZhGC829koAQAP/5xFPtZ0PuktxTHeWGX
         VlFfbyGTGcChCp5Pr6Jrq1QXnPQex24Ce2wMFGkrCRQFRnLeV6W/OQWitGxYhnxZnWqt
         yIBg==
X-Gm-Message-State: AGRZ1gKA/fcu0bbMBNzWi4ePa2cZkyLrDhUgaTjUdsw740SqQF8w57Pw
        CMXntkYRr5L9EZR0QVL1i9mdrojuf/++pht2f9T5ow==
X-Google-Smtp-Source: AJdET5ctRM9y02jiTSsEknX2a9sUwhB93BDR8bOin6g1tegPcE7zNXwSQvYnTE6nkQWt6NEa1jfnnnQ9bJ3vOUTgEyM=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr2010002lfa.32.1540905792364;
 Tue, 30 Oct 2018 06:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181021200032.1833-1-wsa+renesas@sang-engineering.com> <20181021200032.1833-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181021200032.1833-2-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 14:22:59 +0100
Message-ID: <CACRpkdai_bEJ8K=Bo0KeARS=KF5BP4C8B0fGGAJQFZ6RMZRRsw@mail.gmail.com>
Subject: Re: [PATCH 1/5] pinctrl: intel: pinctrl-baytrail: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:00 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
for all 3 Intel patches

Andy is collecting Intel pin control patches so he will
pick these 3 up I think, let me know if all works out!

Yours,
Linus Walleij
