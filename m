Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E7DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F99524267
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F99524267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbeGCJ1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:27:43 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34935 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754382AbeGCJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:27:39 -0400
Received: by mail-ua0-f194.google.com with SMTP id q12-v6so790243ual.2;
        Tue, 03 Jul 2018 02:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKbYncp/46kWEuDpT8VHn2FFpiIJBI+qraTGOZi3Keg=;
        b=Js2O/w1wAHwi0BdeePEDMl5rEo1KdLZJrIGC+zoRFC+n4kQl2zSLQ0CZmtgs+ickQ8
         0LwynA/EUcRPRBa/6aKdJ385emmnkooBdLqer5g10YnCa4Yx6jvqK+Fs0xUMuqNgqWhQ
         NUYMwYDAO3Mgz4ZePEGUWd4ods0Y2L8jcLREdu4ur7YbUuioVB4+cUK3DVUebGrvtG2l
         dMjcHL8MD0Z34QTKe5wGDHtD81IbbHGhmc4V/E0gjxD6YlbSZ1W8ZG+cwRqfLXEkq35d
         K6FdZQ5r0W+NeFuVCh8fQPbKUqGswe14Yx3MRMuGnsYfvDV2+sTaD4lhlsHhzcDblzrj
         zFsA==
X-Gm-Message-State: APt69E1I6aJanwYa4hCq7+/O1fEVB9EmTuK6A1hc+SCHqMpXA6KBIa3f
        CMFU0iQ+BKHmVA3xXw7plZBR1U2CKOteolZ4c9c=
X-Google-Smtp-Source: AAOMgpdvGhfAxO2b5ESD34lr1cZXpZ2KPDPPIC2RA10W5aX5rGn3fIZH+3tCaVNKw8spkzY5nAJZ7pqKOj6Mesels3M=
X-Received: by 2002:ab0:5b57:: with SMTP id v23-v6mr7543081uae.72.1530610057951;
 Tue, 03 Jul 2018 02:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180619144141.8506-1-jbrunet@baylibre.com>
In-Reply-To: <20180619144141.8506-1-jbrunet@baylibre.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jul 2018 11:27:27 +0200
Message-ID: <CAMuHMdVTZOS91UUK2zqq019xMPfLUVgDPD8EAWSHntza0-ShVw@mail.gmail.com>
Subject: Re: [PATCH v4] clk: add duty cycle support
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Jun 19, 2018 at 4:42 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> Add the possibility to apply and query the clock signal duty cycle ratio.
>
> This is useful when the duty cycle of the clock signal depends on some
> other parameters controlled by the clock framework.
>
> For example, the duty cycle of a divider may depends on the raw divider
> setting (ratio = N / div) , which is controlled by the CCF. In such case,
> going through the pwm framework to control the duty cycle ratio of this
> clock would be a burden.
>
> A clock provider is not required to implement the operation to set and get
> the duty cycle. If it does not implement .get_duty_cycle(), the ratio is
> assumed to be 50%.
>
> This change also adds a new flag, CLK_DUTY_CYCLE_PARENT. This flag should
> be used to indicate that a clock, such as gates and muxes, may inherit
> the duty cycle ratio of its parent clock. If a clock does not provide a
> get_duty_cycle() callback and has CLK_DUTY_CYCLE_PARENT, then the call
> will be directly forwarded to its parent clock, if any. For
> set_duty_cycle(), the clock should also have CLK_SET_RATE_PARENT for the
> call to be forwarded
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Thanks for your patch!

> ---
> The series has been developed to handled the sample clocks provided by
> audio clock controller of amlogic's A113 SoC. To support i2s modes, this
> clock need to have a 50% duty cycle ratio, while it should be just one
> pulse of the parent clock in dsp modes.

"one pulse" means num = 1, den = the clock rate, right?

> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h

> @@ -66,6 +68,17 @@ struct clk_rate_request {
>         struct clk_hw *best_parent_hw;
>  };
>
> +/**
> + * struct clk_duty - Struture encoding the duty cycle ratio of a clock
> + *
> + * @num:       Numerator of the duty cycle ratio
> + * @den:       Denominator of the duty cycle ratio
> + */
> +struct clk_duty {
> +       unsigned int num;
> +       unsigned int den;

So shouldn't both fields be "unsigned long" instead, to match clock rates?
(Yes, I do know we don't support +4.3 GHz clock rates on 32-bit yet ;-)

Also, you may want to have a higher precision than degrees for the
phase property when handling pulses.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
