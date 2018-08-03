Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F8BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD502177A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2f8+mwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD502177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeHCTKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:10:44 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:47028 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeHCTKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:10:44 -0400
Received: by mail-io0-f195.google.com with SMTP id i18-v6so5540062ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+/eiTIAMUNTiYRP7GLVg75gn/7q3FAq6YKOFQ1sgLA=;
        b=E2f8+mwpZbiZBJYz80fNNKEgiwJDsvdnY+cGi+tWz76Zv5QCUir43p3HHqs9gtBuOR
         H4fja+CiTunmHPkTkUxexg42yGWzx5TZn/35Yv66Wkcx6KtNesu/lRRX+QKpaarv/IeS
         zSED/vPhryMcCrMDKpfkE6V+QZFbWaxezCzdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+/eiTIAMUNTiYRP7GLVg75gn/7q3FAq6YKOFQ1sgLA=;
        b=AvGKOWFCKXP2pR34tO5OQXRH9wTEhMelPtD+I8nYM/8a/a6jgPI1RE6Nz3KFGvL2UX
         n/mgjklB3dYhuYhxfNgpeUuKjFyA5Tnjp5DKaWOdfqqI6QsiGVx7hTfeVYAhG/R1tcR2
         7ntamq4eVrI3NUnUL8LAFcIOyk1FMWmREQ3Laj6Y0YGRNTJ8MKL44m5iHUeiRchlpg0I
         729pWfR/bPR9aYpKS+NWUzVoWXTf614BB52mvX8+1oXDSEmB9VcDryBWviYXAvDIM04m
         bIVGLo+SYAyiovuBkfCCTXJ3pUhggBq947NmRAomtgKV/OBLu2Fbrbyv3YJLRfdci8b3
         aRNw==
X-Gm-Message-State: AOUpUlEr0IEGO1l4lpalF1vSm6PKnd/cJRFUQ9P/9c37h944EwBaJvjd
        OHUiDod9VMNjeZU3veeKAPs9Ep1L8AcJyhORd3WWjA==
X-Google-Smtp-Source: AA+uWPy3lcQgc9zSP1X9r8rPJifMCFk3SQrmAW9WheoMfZbPkZis1hfhMz0y/oRpkZms8FRbaaGCLwSTfTs+zm+xg9Y=
X-Received: by 2002:a6b:6306:: with SMTP id p6-v6mr6764510iog.175.1533316412802;
 Fri, 03 Aug 2018 10:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn> <1533016762-5268-2-git-send-email-djw@t-chip.com.cn>
In-Reply-To: <1533016762-5268-2-git-send-email-djw@t-chip.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Aug 2018 19:13:21 +0200
Message-ID: <CACRpkdZapWq6t772Hy0COSZ0n4+qR5sd26E9QuQ6_exNeupEXA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] gpio: syscon: rockchip: add GRF GPIO support for rk3328
To:     Levin Du <djw@t-chip.com.cn>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wayne Chou <zxf@t-chip.com.cn>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 8:00 AM <djw@t-chip.com.cn> wrote:

> From: Levin Du <djw@t-chip.com.cn>
>
> In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec
> mute control, can also be used for general purpose. It is manipulated by
> the GRF_SOC_CON10 register in GRF. Aside from the GPIO_MUTE pin, the HDMI
> pins can also be set in the same way.
>
> Currently this GRF GPIO controller only supports the mute pin. If needed
> in the future, the HDMI pins support can also be added.
>
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

Patch applied with Rob's and Heiko's ACKs.

Yours,
Linus Walleij
