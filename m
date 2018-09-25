Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25643C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7C52145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="igH4TD2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7C52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeIYQso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:48:44 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53284 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeIYQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:48:43 -0400
Received: by mail-it1-f196.google.com with SMTP id q70-v6so6140235itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAFOoiqw4OgimMrYaEbs1bv1Pp17vjcrwvuFbvmomNQ=;
        b=igH4TD2h3NqUJn87vG46qrHa8fyYBi1u/rvuocwvBr7+G/O+PZDJMmUqkHmY9C1ZJt
         gEJQQe8Qt0/JsxHNpcGa6/oDjdYkr0JyY+IFUtC1NxVNT8mdz4KVA+/B0XMNLbwWjjPZ
         H4wRPxhSZQgG1mfWTsBD/E4DrYNY/FyLGRiYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAFOoiqw4OgimMrYaEbs1bv1Pp17vjcrwvuFbvmomNQ=;
        b=a9ffx7izlq3okM6+kzLqf5RTzdCI85HrOlg5Cu8BZk53c3NDQZhl7D33HmJvZ7Un1u
         sTm4ZWiv820HPJe5Q6uRGwRtk6WdQ8BwevDSmj0ghMv5nlHwzatE0Yf3JjSojdFDaSxF
         JRBooVSp6gzAAsDWkeyZ/h1jj24YK6hw/WPzRwRxhE45dlm85XLvyLYNpesafwphMSRJ
         vXTofzTw90WGGE2+x5kNQ1lDDIzRxNsgL6uqATOxkpe8AeeWZgagg6OAg6L+NRQcUCia
         BKlegVztgWNgx6vw5U6qHyYss81UGpXwwMWzfgv3gsP29MJJUn/OM6dDtagFw3oFSjRO
         8iUw==
X-Gm-Message-State: ABuFfoiOrL19OHOQkrOvVz7r9smUeLRCzAhtx7AOK8TNmkq6Y7GpMhCl
        E9XyBK6ckGihQ0USeBUix6UZm1IDNSVrgGRVRrJow6/+
X-Google-Smtp-Source: ACcGV60ZZpCsrb2wLB/Tw2p9l2Tcs0czXlJt/iJKHSt/FlcuT2TVk2pmsn0lIKCf4pRTBTRttpjBsa6GlUxO3hrHj+I=
X-Received: by 2002:a24:83c1:: with SMTP id d184-v6mr144770ite.16.1537872108039;
 Tue, 25 Sep 2018 03:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180922195826.175628-1-djkurtz@chromium.org>
In-Reply-To: <20180922195826.175628-1-djkurtz@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Sep 2018 12:41:34 +0200
Message-ID: <CACRpkdZrmjjQ4CQFgV9gmCzEJVwoE1850+4iMen2-sCK3xp0Eg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl/amd: poll InterruptEnable bits in amd_gpio_irq_set_type
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     Daniel Drake <drake@endlessm.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Ken Xue <Ken.Xue@amd.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 9:58 PM Daniel Kurtz <djkurtz@chromium.org> wrote:

> From the AMD BKDG, if WAKE_INT_MASTER_REG.MaskStsEn is set, a software
> write to the debounce registers of *any* gpio will block wake/interrupt
> status generation for *all* gpios for a length of time that depends on
> WAKE_INT_MASTER_REG.MaskStsLength[11:0].  During this period the Interrupt
> Delivery bit (INTERRUPT_ENABLE) will read as 0.
>
> In commit 4c1de0414a1340 ("pinctrl/amd: poll InterruptEnable bits in
> enable_irq") we tried to fix this same "gpio Interrupts are blocked
> immediately after writing debounce registers" problem, but incorrectly
> assumed it only affected the gpio whose debounce was being configured
> and not ALL gpios.
>
> To solve this for all gpios, we move the polling loop from
> amd_gpio_irq_enable() to amd_gpio_irq_set_type(), while holding the gpio
> spinlock.  This ensures that another gpio operation (e.g.
> amd_gpio_irq_unmask()) can read a temporarily disabled IRQ and
> incorrectly disable it while trying to modify some other register bits.
>
> Fixes: 4c1de0414a1340 pinctrl/amd: poll InterruptEnable bits in enable_irq
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Patch applied for fixes.

Thanks!
Linus Walleij
