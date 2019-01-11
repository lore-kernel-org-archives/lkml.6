Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA5F2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAdTT9cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbfAKM3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:29:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40281 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731078AbfAKM3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:29:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so10679816lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 04:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0NbfYFrTR37/6yq4EL2AS7FhfEsBLR9KFY2wOv1wW0=;
        b=KAdTT9cZSpG5nliHUcCSdFd/fcU591+9klqp/eepDCmDs2I2D4AfrSLMmnMMliSixd
         22CrmvQz0ACD1++eGBdf8kJsrg3tVQ4jhte9V4xpDPXnRcpbNHLn5Z6qZngZugRxGOuB
         TrgRLAhYNzNrbwOh7zXFVaIkyJZFwsP+QR09c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0NbfYFrTR37/6yq4EL2AS7FhfEsBLR9KFY2wOv1wW0=;
        b=ZclcLYeQvUqx8SxFPFQDyYhBZ0xN9r23xi01KPYofS54p9n33e6BgWNVm8yx+XNc4w
         ttP9RbXAVLTkZgHraUkK/Lr0PxyjETVRuyNw1Vt1cHYhtbG2+8m+jkockFq4D1qTv6Ab
         FZ+Tkpt+NoCEgnLtBYHJ5BPWfXsXPjQdR2ZKg+KgMYurgTvEmVJyEXbKe9l/Z9CCWU3V
         H0hI/pheRts/TKTrQ0ZJItbKcfztdHmqe1M2Pk7cNuNw1jN5R+BSr3fUzBBazVqQ5QRZ
         dDm7u+rLYEFnCWjznBo7xCwT+bzhHC4HTylgij2yeQw9zvQUAzMpGH4MDAFO+HjSaeXD
         d74Q==
X-Gm-Message-State: AJcUukc+vSvBR9NJAkPsdlTsla1f4rViS8ValNOhFsBQywW7XrGjaEkC
        GL9kp5Lq6uCeMjvXcP9Ld4Ebqu49fhWR9GaVhX0Ryw==
X-Google-Smtp-Source: ALg8bN5hrj3g3OHnE6yMhHOY+gBohaFZHFAVU2tb8Y/w5J199hw8S1UEhZGztsfmZ5XJfQ6AyPR1HgZsGH9JmR9p+4Y=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr7607523lfd.149.1547209772422;
 Fri, 11 Jan 2019 04:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20181229114755.8711-1-masneyb@onstation.org> <20181229114755.8711-2-masneyb@onstation.org>
 <154664792383.15366.9346249356552958882@swboyd.mtv.corp.google.com> <20190105014503.GA32383@basecamp>
In-Reply-To: <20190105014503.GA32383@basecamp>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 13:29:21 +0100
Message-ID: <CACRpkda4j6WAS-s1Eo6q64dKwvSDYKsEstbWSG4PBeU9jNiZvQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] spmi: pmic-arb: convert to v2 irq interfaces to
 support hierarchical IRQ chips
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 2:45 AM Brian Masney <masneyb@onstation.org> wrote:
> [Stephen]
> > Otherwise patch looks good to me. Thanks for working on this. Are you
> > going to convert the ssbi master and gpio chip too?
>
> Yes, I will do that work as well once this patch series is accepted.
> I currently don't have the hardware to test it, but I'm willing to pick
> up a cheap device on ebay. Any suggestions for something that boots a
> mainline kernel with the ssbi? It looks like the Sony Xperia Z phone is
> one of the supported devices.

I think my APQ8060 DragonBoard uses SSBI:
https://dflund.se/~triad/krad/dragonboard/
arch/arm/boot/dts/qcom-apq8060-dragonboard.dts

So I can test it. Or even  write the patch once the SSPI is merged and
known working.

Yours,
Linus Walleij
