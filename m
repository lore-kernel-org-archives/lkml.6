Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E69C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A28C2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUZ/dDUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A28C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeJARGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:06:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33224 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbeJARGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:06:39 -0400
Received: by mail-io1-f65.google.com with SMTP id l25-v6so8981222ioj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcebD9MAUjhQIkE8Q3iXLZu8cF75WfUROtJjqV8fCMA=;
        b=UUZ/dDUXiiKIFX0RU2mCHEi5XK7WIywrDi9Nh6SQLbYHwNKkg9jwqybvoj575Nkb27
         4bCP8QFb/PiqbsRIiqBbb1N1gAO2iOq2J5knPv31sl12eI6CM49ltbh20xFXyY5mr8CZ
         eJsPgBosV7AnSdnofDeXvloAmC9U2JjZX1PKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcebD9MAUjhQIkE8Q3iXLZu8cF75WfUROtJjqV8fCMA=;
        b=fYJzIbq5EmF4g9GZ2bzaVxrXKSop9R+mgOELIlFL4bWlb017MJaB8dKMBxWB8sHSdS
         H/tjNUpyVpRqBxpY7IDRWF/oRxp3EsF/myOdZTzdt6PS/GrwM0suE7KBBct7QTxFnef5
         nbiOPivBd2If04UTcLXmnMWNNH1rpPw7ygcwwx4wE4jy+aCYd0SIPB7y+GhDPbrj2LHf
         8nfG/ebvgIMLDZMJg2K1vyCb/xAuXtgDbdatnNSZCmVM1fOZ0sjyW35MqvEksz/hkPqB
         jzydmqALNcnoHNpHEovlZ77zeTr2icFkI7KAHckScixQi+77luQyKtzmmC1GO9Eyp7Xh
         CzRA==
X-Gm-Message-State: ABuFfojmizedyk7/W3VSP0wuIu0gIZttxD1w65qKi2TKH1rvuyAj7bxN
        K1e9sggmUXblCSH2CRXSxpaqULqOSDt+cg5U+iZiBw==
X-Google-Smtp-Source: ACcGV61/mqkyqpz1uwszrGWA5DfISJVMVvYdP82N3H6GvQ0M9q4P+GAfi2CC79wkCIzcivEPuqlM3Sm6nr6wR2MjbpE=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr6337621iof.304.1538389772679;
 Mon, 01 Oct 2018 03:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180928213950.27415-1-grygorii.strashko@ti.com>
In-Reply-To: <20180928213950.27415-1-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Oct 2018 12:29:20 +0200
Message-ID: <CACRpkdZ-WOGqSThAPHw8LykriTnSEKZcZaL+iB5-jmaVKmN4bg@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: get rid of the conditional PM runtime calls
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     ext Tony Lindgren <tony@atomide.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:39 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> OMAP GPIO driver is checking !BANK_USED() used condition before calling PM
> runtime API, because of PM runtime calls in
> omap2_gpio_prepare/resume_for_idle(). It's not required any more since
> "omap gpio add level idle, cpu_pm and drop runtime_irq_safe" series [1]
> from Tony Lindgren was accepted and PM runtime management was enabled in
> IRQ chip core by commit be45beb2df69 ("genirq: Add runtime power management
> support for IRQ chips") .
>
> As result safely drop !BANK_USED() checks from omap_gpio_request/free(),
> omap_gpio_irq_bus_lock/unlock() and enable PM runtime management for OMAP
> GPIO IRQ chip.
>
> [1] https://www.spinics.net/lists/arm-kernel/msg677583.html
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
