Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12840C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E2620684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="haHgkvDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E2620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJBPcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:32:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41226 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeJBPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:32:16 -0400
Received: by mail-io1-f65.google.com with SMTP id q4-v6so1453677iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyYUqurOl9rRYbWJ9UixfUVWW2Zle+Y3O+08iXypBFQ=;
        b=haHgkvDvJqCpoOhNhVoA4G7ZiV+5TINC0b7IHP/Sy17bVtfeZ28xD+isvzmRrhV+mI
         HV2i/apJ/nDJ/1oGTxdA+ZgPXpn7cvhw2YZP0aRn5J38udAGhYbq4UEUQSpxxdb4mX66
         3CEj0VRcjoEBWDG5Jha3+Szx9wMLzeu5K5Kqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyYUqurOl9rRYbWJ9UixfUVWW2Zle+Y3O+08iXypBFQ=;
        b=M1zGflxrkuyO5NceYgPdwh6PhpyrnrqYbC5BEjpPvdElfOGqbSfvKij4dJ38fvIsO9
         5PDQTvtS3tBMzLJwGGUSScaZecLBFOLVPV8dyK5pqbJypRERQqDed0iSYOf6hS1YYOx2
         YaxvLTqO9KfTOE1y8TUzALe1YECXjsQ1ld18/Y3d3gXKaiRGTxyM/H7Rp3+8jCSFAeaj
         3bbFg97L09ZQrIxetVnQdEpPt+jRRS0qRSVojp6QZ5Ih3zBiUyVkBG9ovANRFBeR7EP3
         yyjaHcmNP2Q6A26f3QalZisWJA+aofrPM33F4WPFZT52RCTxKdGJjhv9wkeuf/vnG5Wz
         28mQ==
X-Gm-Message-State: ABuFfojxrPYDZNmuPYpO9a9AwdSIGs6+bxgKXhNazdRcM4wRy8Fq37tE
        xF9xJYNbEIjfPQe0TVwcVYphSqao495a0viwHj0lkQ==
X-Google-Smtp-Source: ACcGV63ATKVunGQO/wNG/q2GsI9cinVWghG4C3QAJyj1KrORwdOR1FZ2EhU6NAhGvnbMPyIlQ7ZGFHtkNaj8XnHfvP8=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr9752493iog.175.1538470206239;
 Tue, 02 Oct 2018 01:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181001214905.12149-1-swboyd@chromium.org>
In-Reply-To: <20181001214905.12149-1-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Oct 2018 10:49:53 +0200
Message-ID: <CACRpkdb-VmT4SXWWf_Gj=4U77T1x0+ggRW2-1e0De4eQdrWiDw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: msm: Actually use function 0 for gpio selection
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 11:49 PM Stephen Boyd <swboyd@chromium.org> wrote:

> This code needs to select function #0, which is the first int in the
> array of functions, not the number 0 which may or may not be the
> function for "GPIO mode" per the enum mapping. We were getting lucky on
> SDM845, where this was tested, because the function 0 matched the enum
> value for "GPIO mode". On other platforms, e.g. MSM8996, the gpio enum
> value is the last one in the list so this code doesn't work and we see a
> warning at boot. Fix it by grabbing the first element out of the array
> of functions.
>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Fixes: 1de7ddb3a15c ("pinctrl: msm: Mux out gpio function with gpio_request()")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Patch applied with all the tags.

Yours,
Linus Walleij
