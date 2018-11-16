Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE82C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F07320883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSblK4le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F07320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbeKQIKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:10:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36881 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbeKQIKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:10:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id p17so17528753lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kpl1QNOwDw+EaFS3A0s2bTT1ac23DrKPiZncwt46yBI=;
        b=MSblK4leRzHIZOu8JXankqc4ao3qQTqXLNrDwFn8twPwHEmArbM3WaUGF4mCNq40Cj
         QDeODz/lV7W2wg141UTuT3nQVF9bL8vK07r0SGtPhBdREWPnlRoQM0oH4tFmxGS+bLBX
         F+7SvLDaWhD+qAIfo11xCaR3l34HXxWyeNlPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kpl1QNOwDw+EaFS3A0s2bTT1ac23DrKPiZncwt46yBI=;
        b=msvPmsrkFfXvbvfQtk+SROkQ6mjYn0xxMboiFRKQkG6vd9kS/rDA2G7MtZZmiNcDVI
         hU2EZzXwqfAZ75cS5Y6K8IVHioCI6LijBFFMqwgQW3iTcUmIqPEk0wpjiBjQp5IYAeKh
         6lh6RRY2LyvJ5LCcv1NMwcNDY+gUYxVDvb/Kgx0C+cNBnsKZPthaS7aoeOhh7KfaYzJ0
         0QEP3RnMfJ+56fcFcGzGydgB7Twf+zukrK0IND85huD1K8PNv8JLLQ1essN4G9+nVKv9
         X0i+4Xi0sex1hXRekRT1CawniBOrnv9HgoU/8Gu31kmwpl9vErDchVoSGucEcZhavITE
         SXjA==
X-Gm-Message-State: AGRZ1gLSj+sW9ob9bQ+wUU+lrU7WrN/KJX/YyzdA9Bj/1QbCTUEPrJD7
        LmP8Sria7Xlmv2JXw/vtUDrtQWyYOoOAy/+MKTLqLg==
X-Google-Smtp-Source: AJdET5d42t1mDw+TP8Q8PqN0muPo81oFoboa21akz/N9JpE/eIf34WNHHw36668siqTWkrP/W21+lBs1iuPemAX2a34=
X-Received: by 2002:a19:c801:: with SMTP id y1mr6172018lff.53.1542405393838;
 Fri, 16 Nov 2018 13:56:33 -0800 (PST)
MIME-Version: 1.0
References: <1541739112-383-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1541739112-383-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Nov 2018 22:56:22 +0100
Message-ID: <CACRpkdY8j0kohUxRAtcfvK865EVDQXGXrB7d5+crXM4AMK1Dxg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: move gpio noirq suspend/resume to syscore phase
To:     Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 5:56 AM Anson Huang <anson.huang@nxp.com> wrote:

> During noirq suspend/resume phase, GPIO irq could arrive
> and its registers like IMR will be changed by irq handle
> process, to make the GPIO registers exactly when it is
> powered ON after resume, move the GPIO noirq suspend/resume
> callback to syscore suspend/resume phase, local irq is
> disabled at this phase so GPIO registers are atomic.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Patch applied. Cc Fabio so he knows it happens.

Yours,
Linus Walleij
