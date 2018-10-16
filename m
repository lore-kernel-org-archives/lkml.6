Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A7DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A7E20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pynu7SSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A7E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeJPPSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:18:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44471 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeJPPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:18:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id y8-v6so13483272qka.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 00:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YGoyIv8Y7NP1EMmyeHW0ReacWSLXCdpbY7VA2DTm2A=;
        b=Pynu7SSUn7E22hLiF5ahQCV5gVQ2QnFbYWQNPuKhuRE12nnmCXpE/B3hj9A+BuegSV
         ccLBblTce50Wig7VaJfXgYcjQwKh9P74T4j4hUmu9aBzNbUalk09PsPQQPsR3I8/0i2y
         BELlnEAMWYIRDdRlUz/cykcobbk3UkGzOOTJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YGoyIv8Y7NP1EMmyeHW0ReacWSLXCdpbY7VA2DTm2A=;
        b=fFuYyf+a3wqU6iuPl7ExF5CqNrK2/cCZU8zVMmvfcSPjUifF6iiFjLrjNpIuXaeI8I
         K1BfaPQjxro+bU0IyRt2U8cwusmSI1yULiF4TtHad6tf4wHBghi+CtkuuTAWVtcIvWL2
         Hzsu+ws2e4Pss4mx8TO4CmDvi7AloVh92pG2pQqQgllzreum8vrMIWy58YXBYrf7F25J
         clWkednAJw3rjZRdciSvoCnyF4JbzUx76ieNcOChp+8gCNmOOpdENNp4RbyQFbiiGabT
         gMVdEbaC+rBkuWVtsahdEB08ijadJIC/YDWj10Vld5bFSsMSOWPnUqAD9kn4zOeEie/5
         w2vA==
X-Gm-Message-State: ABuFfojxCyq6CX46loONxsczAugtHJRmqSjbPua2EEGIDfEz9YBy8aCI
        WNLzpoFMxHxc403j4Zb6M8sdN8rLxvd6R4yJNYk6yA==
X-Google-Smtp-Source: ACcGV63yr2Z+5z+/ibXD+qm246NSF/QOI0yV6dsVkfCDfGaUGpAH7owq9SkdIAQowD2AdsHmmZFAZXgVflTjzO4M8sE=
X-Received: by 2002:a37:5185:: with SMTP id f127-v6mr19405563qkb.44.1539674941981;
 Tue, 16 Oct 2018 00:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181008163216.97436-1-swboyd@chromium.org> <20181008163216.97436-3-swboyd@chromium.org>
In-Reply-To: <20181008163216.97436-3-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Oct 2018 09:28:50 +0200
Message-ID: <CACRpkdYtZEiTcWs61HSmZjy0rgLbos=7Mo9N=OCpJDvf+Jhw1A@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpio: Drop parent irq assignment during cascade setup
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        evgreen@chromium.org, Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 6:32 PM Stephen Boyd <swboyd@chromium.org> wrote:

> We want to set the irq parent for interrupts that we're setting up to be
> cascaded from another interrupt controller, but we may or may not have
> already mapped the gpiochip irqs into the kernel's virtual irq number
> space at this point. If we have mapped irqs before calling here, then
> we've gone through gpiochip_irq_map() and called irq_set_parent()
> already. If we haven't mapped irqs, then the gpiochip is dynamically
> mapping irqs and we can rely on gpiochip_irq_map() or the gpio driver's
> irqdomain ops to setup the irq parent properly.
>
> Either way, setting the parent here when cascading the gpiochip doesn't
> make much sense because it should be done at irq mapping time. In the
> dynamic mapping case, this code is mapping virq 0 to some parent virq in
> a loop. While that's benign, let's drop this code to simplify.
>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Yep this is some leftover from the past.

Patch applied!

Yours,
Linus Walleij
