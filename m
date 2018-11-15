Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95905C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F7C2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErShBYsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F7C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbeKOTd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:33:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32845 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeKOTd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:33:28 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so13649896lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4buUvkS4pG4QDH/7LkxSTlVY7IJKrs1lqA21ftTSIU=;
        b=ErShBYsi1j0nq+DqM8D4sE7h62eK9LGiZEydz9nx8BVzTji1dNChd63BViBHXujO7b
         P8dKiYB6934hZsoe+jIqYZ2qxrN7z0o5iE7DPRtNwSTbd256IDDmaCc3foxSY1Camc4b
         qXK7ssWiJYmntvwBhG4ETI8OAIxhYkXbzESk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4buUvkS4pG4QDH/7LkxSTlVY7IJKrs1lqA21ftTSIU=;
        b=otuXVIj+yIzS5QlOy+tEtKKOUXsGIiwVs6nrJIIJVUO8c1ZWOWHa0QNqXNzx3d05IY
         ad9HjCoU8aBHpFSaPAkxchnuBPCC3dtGxoki2sZcJqtOHSAKHxf5xG+CKhTI9ovdjTm5
         9PO2+v0n5Fp5Y4G+6xO90ejaSuf4/L+ZFZoCaaCZm0ruGNUsJB4c/pGHjmkEoFV33BTS
         PrrGtxR2NEFwmJ8+P/DBF4F4ZsH11tymje3TJK1F0Pv40dPxJaIg3JalW0M5kBrh6bta
         ryDNndcrXj5tXBxI23eUfSBXASCJUI6kO9rtUjl6NKT77wPh2ECcrBRKSInUUUYblzZk
         vKnQ==
X-Gm-Message-State: AGRZ1gL3HWKSb/eAm9kr9IdHLtf1qoBPxs1GMzi1qyTEyn/FERNOQSiE
        Wqmx389aP5UM4zhyAKGgvmUkeTfBmTva6puNLaI3GA==
X-Google-Smtp-Source: AJdET5eYnwq6D8+bVTKaG9mgzs62feqEjnIDYG5rt+uaWd0MoFLNO/2dS6iADoYWHHOxEmbZsIzZesrU+Nf6lpwis5Y=
X-Received: by 2002:a19:c801:: with SMTP id y1mr2868807lff.53.1542273987306;
 Thu, 15 Nov 2018 01:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20181102025728.963-1-olof@lixom.net>
In-Reply-To: <20181102025728.963-1-olof@lixom.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 10:26:15 +0100
Message-ID: <CACRpkdbRZGxQoi7Pe=-unjHC4ToyOR1MJjKQqySs1Hunhs+TYA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Fix dependencies for EINT_MTK
To:     Olof Johansson <olof@lixom.net>
Cc:     sean.wang@kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 3:57 AM Olof Johansson <olof@lixom.net> wrote:

> Fixes the following config-time warning:
>
> WARNING: unmet direct dependencies detected for EINT_MTK
>   Depends on [n]: PINCTRL [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n]) && (PINCTRL_MTK [=n] || PINCTRL_MTK_MOORE [=n] || COMPILE_TEST [=n])
>   Selected by [y]:
>   - PINCTRL_MTK_PARIS [=y] && PINCTRL [=y] && OF [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n])
>
> Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
> Signed-off-by: Olof Johansson <olof@lixom.net>

Patch applied with Sean's ACK!

Yours,
Linus Walleij
