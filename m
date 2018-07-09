Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA06C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9111D2089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hF0ZuknG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9111D2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeGIPh1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:37:27 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40782 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933333AbeGIPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:37:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id t6-v6so6208411plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=nwhb4FawsvxHwW67KDahDEPAMx2iv9rwxoCjONX1IVE=;
        b=hF0ZuknGKBQfmSah4MSIagzEx5MtVr1zUZCLAAh4vh8/MBVia20jN/gUyCsbCn3Wc2
         ptEI8tI6blofVIBhIvg0oNFHfBzEoRogcBp1Wh1Aj3LmisbZqhtymSmchDh1nR9l7/5b
         OK5IuS0fpCzZ3m/aEfyaSAlRMxkGgL5E6SR0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=nwhb4FawsvxHwW67KDahDEPAMx2iv9rwxoCjONX1IVE=;
        b=kA7f9YNCAB3oPU9Wdd6p7Xxmwktylkm2kmoV+lNzNRRGH/kCt4NMgTgkXDZIMPU+2e
         MhFeJPvJWnmdxeHgXO8fevEwM8JPoGGhSFaVglDUIP9iz0UJSjTElK6qIBnpEnNV1Cdi
         qJ8BqTghY81ciErBS2/opvDj9PD+5bGVsbLLRjlM2rI4qPdSL8xPkC5QLE2UCMkTqSwa
         VuqCLMjGFHpKmWy3LP6Oxe5d7gQwkrDf1qbBOf2S4fIQzU5BWa6BfYt4f+b8AdAa//+U
         8+CzpIV7WgZ8lmzBvwdsYAfqD+PIs+uHJSKDjbF2v0pF01fijhjS1dohHeOwvqu2isqt
         wBYw==
X-Gm-Message-State: APt69E0QYkT3y/oLj2ZPPNTcm/n5q7cesM9pE1RekSJL8TINoho33wMY
        Ta/5vyPPMMWvJFR4i8CXAsQAQFpNcTA=
X-Google-Smtp-Source: AAOMgpcgLOpypfALI/XNXi/kfWrCY0koZ3UP/B25IIUky7crphumzoAq/aulzT45Dj+VchVwpUqyjQ==
X-Received: by 2002:a17:902:b583:: with SMTP id a3-v6mr16994059pls.243.1531150644794;
        Mon, 09 Jul 2018 08:37:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id x28-v6sm25176024pfk.55.2018.07.09.08.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:37:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Linus Walleij <linus.walleij@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CACRpkdbNSNzT8tiYDXk1dc447xGqf1bV+O93hgEQdT+GcQtddA@mail.gmail.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-3-swboyd@chromium.org>
 <20180622175836.GC3402@tuxbook-pro> <20180622183129.GD3402@tuxbook-pro>
 <CACRpkdZr5tKCjyO6Eq2vPPE8Lg+m+Ky_f24wYBSiLjdZuQ4WwA@mail.gmail.com>
 <153020606866.143105.1849265284764230975@swboyd.mtv.corp.google.com>
 <CAD=FV=Xmo4p7DbOReO02JVKnykoAOz7PtnkbdwryxvpsgZCgWw@mail.gmail.com>
 <153055420964.143105.3738779882090053054@swboyd.mtv.corp.google.com>
 <CACRpkdbNSNzT8tiYDXk1dc447xGqf1bV+O93hgEQdT+GcQtddA@mail.gmail.com>
Message-ID: <153115064295.143105.5291742668895542720@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
Date:   Mon, 09 Jul 2018 08:37:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Walleij (2018-07-09 06:54:01)
> On Mon, Jul 2, 2018 at 7:56 PM Stephen Boyd <swboyd@chromium.org> wrote:
> =

> > I could do with some more clarity from Linus in the "Drivers needing
> > both pin control and GPIOs" section of
> > Documentation/driver-api/pinctl.rst but I read that section as stating
> > that the GPIO driver needs to mux the pin as a GPIO by requesting the
> > pinctrl backend to do so, unless the hardware overrides the muxed
> > function selection when the GPIO is used, without involving pinctrl
> > software.
> =

> Yeah that text is especially terse :/
> =

> What it says (or what I meant to say) is that there is a choice
> between letting the pin control and GPIO functionality on the
> same pin be handled orthogonally or implementing these
> gpio_*() callbacks into the pin control backend, but in either case
> the two APIs must be used in sequence:
> pin control setting comes first, second the GPIO subsystem can
> request the GPIO line.
> =

> I'll see if I can clarify.
> =


Ok. Is my interpretation correct though? The fundamental question here
is if gpio_request() should remux the GPIO for the GPIO function or if
drivers are expected to have pinmux settings to use their pin as a GPIO.

