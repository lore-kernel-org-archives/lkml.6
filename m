Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCC8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2890B206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WI1EtuIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2890B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeIJMYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:24:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35945 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeIJMYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:24:38 -0400
Received: by mail-io1-f68.google.com with SMTP id q5-v6so6223089iop.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcTCDjeoCUem5toyhK5qCfScYv91T2CvBNoIT0F5vPU=;
        b=WI1EtuIZOgHoDUBkCuJau/yuSmnFZ8bOS4z4qc8At9R/hjqBKm3EAdgvc0ya9QaJpT
         wvtaWfq6SPHo9tQwdGtAhvr3mJ2OoidixA2UNEcohRH0UkApPlM0w/nLUgvfixuFAESp
         xIy7A0vgcfYm6bAVe/hPPT+EQRysv95N7XzEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcTCDjeoCUem5toyhK5qCfScYv91T2CvBNoIT0F5vPU=;
        b=gnESYYwl9g6TENF8vP/a/ScRDwcmH83RP9s2e1E5cr6ZVAipRy5mBX/DISSSNZOP4W
         I+DendZp8Wi/lQ6IG0xVUxhizfs01L2PdFF8lo8f88oA614MEN26zCS9d93hM8dB8gre
         lP8ymupvJ3LsnD++nxhZIxQV1gK4pUYen8aCBuw/CPlzA37UxkrZAjzkwUOvRhEgwPAX
         xwD7KH1xkDm9GAzpIe1I36jXlctpM2A/edbQC0VftAZIN5ewCfXXEgKtPaqaG5TtvfPW
         0Olptk7lRjXUhnqrfjTUhyTINpFDrSywm3qCvRqe7ynD3YXtI1OLaV5bkz4oChl3wyGt
         aOQQ==
X-Gm-Message-State: APzg51CYLqlhgNpqz0l4/BAiQ1neDqiNOxk0H2VLl2lBr0gY3g1KcfAE
        lf36Jw2Yq7jnk5PN7FXE6YE6C9zFOjkmuDybMEQwUgw2BRs=
X-Google-Smtp-Source: ANB0VdZp+KlPqRZUvSvhxAg09h2bfOvlABMVzcjBZW7n/Tk4mLal1hK4EGxqAKVRtNwhyXq8brNikRRNy/dyAWNNo0g=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr14392045ioa.277.1536564718635;
 Mon, 10 Sep 2018 00:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180831005852.156465-1-swboyd@chromium.org>
In-Reply-To: <20180831005852.156465-1-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Sep 2018 09:31:47 +0200
Message-ID: <CACRpkdY74znEYMsjAWMn_Erj9KZGzy0DAjRm2FJuFJjEr3HBQg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-mpp: Fix drive strength setting
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 2:58 AM Stephen Boyd <swboyd@chromium.org> wrote:

> It looks like we parse the drive strength setting here, but never
> actually write it into the hardware to update it. Parse the setting and
> then write it at the end of the pinconf setting function so that it
> actually sticks in the hardware.
>
> Fixes: 0e948042c420 ("pinctrl: qcom: spmi-mpp: Implement support for sink mode")
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Patch applied with Bjorn's ACK.

Yours,
Linus Walleij
