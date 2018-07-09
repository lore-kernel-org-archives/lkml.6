Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8F3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EAB2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVAYp9xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EAB2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932844AbeGILP2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:15:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51674 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbeGILP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:15:26 -0400
Received: by mail-it0-f65.google.com with SMTP id g4-v6so8801706iti.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2gNdfHn1pk7EbE4r1qAsxSA1rn7GGDXtEkI0w+fObI=;
        b=HVAYp9xhtAcxPpi3F0tymqKDDEFx8Yz4tnrqVlhC2F9pWF7izW7Dnd7mH6lPyRjBLG
         OT9kKKkA+tfbywO9SP7pCZyBylf2xAQJ+L5wjJpzDKh+32Ugsya3HxfzhPl9xZyRtyR5
         J7Mmue++8al75tJAqhSrFeIcgg18FT4vKkQzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2gNdfHn1pk7EbE4r1qAsxSA1rn7GGDXtEkI0w+fObI=;
        b=ncWfJDS6wxNqO4ok5SCIPjwoGHIeoI506PnmG9BMPdAmGbOGdrAjGO+K1ik3Xbawbu
         CsSraM3Eb0H9TiuQ+pE2TPo6jLwET9SdPI5LPXxaYfcJ6axm/isaNTCQGxWXAJupKUkv
         hLGSYjbvGGr1J0nRwNTPZDwRU2pKECljeNGGrMQTpWUGGKDRFCwdVGqbyi3Of51U+ZXg
         oYU58h7xScVy/2LTcWtBszHFNLu9Iwedm9kIPvw+Nb5SemXydkkk72zIX+fXDjocUWo7
         y8LktNfa+Ka3uY9cGiG/KxNTBJ7yHnumK08V8rw8uCRxS6UcyABaUhUvOZELEjJXxRZy
         M1+w==
X-Gm-Message-State: AOUpUlHN9hAIk9/Lh9RhUFZ59IMybKxIsapwL/zjN4T3b0yWgLvYIGvQ
        MhOML7f/r3ADeU+mmDLueWmhZl8Q65qLK/gi27UN+g==
X-Google-Smtp-Source: AAOMgpehY5NxYkTt7yy6apn0H+p1o4CSajl88/V2fhf3/UrnmzSXld0jJNYr2UsogPFTAeIk57sLNT8SuQEPrX1Nisc=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr295979iti.135.1531134926318;
 Mon, 09 Jul 2018 04:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180702225939.109169-1-dianders@chromium.org> <20180702225939.109169-2-dianders@chromium.org>
In-Reply-To: <20180702225939.109169-2-dianders@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 13:15:15 +0200
Message-ID: <CACRpkdbXyBZhKcWH-SVWJmp4jd=fbHRaerzfv0BGHWtgucV-Aw@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: msm: Fix msm_config_group_get() to be compliant
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 1:00 AM Douglas Anderson <dianders@chromium.org> wrote:

> If you do this on an sdm845 board:
>   cat /sys/kernel/debug/pinctrl/3400000.pinctrl/pinconf-groups
>
> ...it looks like nonsense.  For every pin you see listed:
>   input bias bus hold, input bias disabled, input bias pull down, input bias pull up
>
> That's because msm_config_group_get() isn't complying with the rules
> that pinconf_generic_dump_one() expects.  Specifically for boolean
> parameters (anything with a "struct pin_config_item" where has_arg is
> false) the function expects that the function should return its value
> not through the "config" parameter but should return "0" if the value
> is set and "-EINVAL" if the value isn't set.
>
> Let's fix this.
>
> From a quick sample of other pinctrl drivers, it appears to be
> tradition to also return 1 through the config parameter for these
> boolean parameters when they exist.  I'm not one to knock tradition,
> so I'll follow tradition and return 1 in these cases.  While I'm at
> it, I'll also continue searching for four leaf clovers, kocking on
> wood three times, and trying not to break mirrors.
>
> Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Looks solid to me so patch applied, unless Bjorn has objections
it stays in.

Yours,
Linus Walleij
