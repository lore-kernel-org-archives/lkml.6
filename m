Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AD9C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D1320892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="apNGFEef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D1320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbeG2V40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:56:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51111 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbeG2V40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:56:26 -0400
Received: by mail-it0-f65.google.com with SMTP id g191-v6so3468987ita.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFysBDe7hVvAvNOE0zvOuyZ7Sh4uRUVmpyVcqh6eXL4=;
        b=apNGFEefTMB+K+gnqetX0Y5zJ8tOOwXgTLIlIqXJOR8zEJJn7oI71ENPlwVQQu19Wz
         6ywG8pJg0hAL6h0ETdKZjZqPDSWPCK2LfUXwXm900eY2cpTBLaN1Ov/XPeSsfte3pjHq
         DPZ8Y0H4VjGtNvE2dWdzRUUhEcqgv1qzehej0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFysBDe7hVvAvNOE0zvOuyZ7Sh4uRUVmpyVcqh6eXL4=;
        b=TxT4AQdrrsaD7RYN4cWOs8zFAL7+JOdOTsCqzkCR03tkCV2KHGM/J5kaQAd0bZ/YQg
         HGkw9y8yPCkfTDR6TOnT4dMpe6aYYM9mLIvX4thj4LpxcFUaQXYOhI/2Io8KJpB8o8hu
         smHMiA2c+MxCaGGtjLXXWW4qc3bTakxwNWiWNht8OB5eC9Qxrep4Ql7dJdVdbxQLF1D/
         VenUrgHXxK+s1VpHISq73QvEC6OropvHy8ceuFuGnYGwGK3T/FUDptionArpgK9DS5EO
         wv3qs1S546j5NwHuOuBrScK4OGAwPo+1CmLVVusc7I/obEepUTj8lT3OPUgbyf/yGH9y
         f+tg==
X-Gm-Message-State: AOUpUlHuc+ESyixnG9mPFRyrxGrdPOEayTdOf7abbLI0fMOlxtpjCYit
        0vCcQObW6F0iepjSKPERWY76bQ+T/u2NJ/yuaGB8rA==
X-Google-Smtp-Source: AAOMgpctfnDP7llOGChgv663u5pHFUSt9350kpWZjlRFjfuS/UNdnxRdyNSp9IrOa+ayogNBXc2S4KRvCKeGwcPZ0M4=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr12076407itb.38.1532895883751;
 Sun, 29 Jul 2018 13:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <1531877132-14280-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1531877132-14280-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:24:32 +0200
Message-ID: <CACRpkda-syvCjO2U9pnZdHKnGSeDB738tcjKG31kevF=hKcKQg@mail.gmail.com>
Subject: Re: [PATCH V3] gpio: mxc: add power management support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 3:30 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> GPIO registers could lose context on i.MX7D, when
> enter LPSR mode, the whole SoC will be powered off
> except LPSR domain, GPIO banks will lose context
> in this case, need to restore the context after
> resume from LPSR mode.
>
> This patch adds new compatible string for i.MX7D
> which supports GPIO power off feature in suspend,
> and adds the GPIO save/restore operations in noirq
> suspend/resume phase, since GPIO is fundamental
> module which could be used by other peripherals'
> resume phase.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Patch applied with Fabio's ACK!

Yours,
Linus Walleij
